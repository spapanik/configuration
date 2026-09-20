;;; 61-linting.el --- Project checkers and manual formatting -*- lexical-binding: t; -*-

;; C-c f formats the buffer; C-u C-c f chooses a formatter for this invocation.
;; C-c l d lists diagnostics; C-c l r restarts checking (also after tool errors).
;; No formatting or lint fixes are performed on save.
;;
;; Select tools in a project's .dir-locals.el, for example:
;; ((python-base-mode
;;   . ((emacs-config-python-type-checker . mypy)
;;      (emacs-config-python-linter . flake8)
;;      (apheleia-formatter . black))))
;; Defaults are ty, ruff and ruff formatting.  Either checker may be nil.
;; Tools read their normal project configuration.  Install the tools separately.

(require 'cl-lib)
(require 'flymake)
(require 'project)
(require 'eglot)

(defvar-local emacs-config-python-type-checker 'ty
  "Python type checker for this project: ty, mypy, or nil.
ty runs through Eglot so it sees unsaved buffers and their original filenames.
With mypy or nil, pylsp is used for language services, without its diagnostics.")
(defvar-local emacs-config-python-linter 'ruff
  "Python linter for this project: ruff, flake8, or nil.")

(put 'emacs-config-python-type-checker 'safe-local-variable
     (lambda (value) (memq value '(ty mypy nil))))
(put 'emacs-config-python-linter 'safe-local-variable
     (lambda (value) (memq value '(ruff flake8 nil))))

(defun emacs-config-python-server (&rest _)
  "Return the configured Python language server contact, if installed."
  (let ((server (if (eq emacs-config-python-type-checker 'ty) "ty" "pylsp")))
    (when-let* ((program (executable-find server)))
      (if (equal server "ty") (list program "server") (list program)))))

;; Eglot resolves this contact in the buffer, after .dir-locals.el is read.
(add-to-list 'eglot-server-programs
             '((python-mode python-ts-mode) . emacs-config-python-server))

(defvar-local emacs-config-lint-processes nil)

(defun emacs-config-lint-root ()
  "Find a working directory for project config and import resolution."
  (or (locate-dominating-file default-directory "pyproject.toml")
      (when-let* ((project (project-current nil))) (project-root project))
      default-directory))

(defun emacs-config-lint-cleanup (process)
  "Remove PROCESS's temporary source and output buffer."
  (when-let* ((file (process-get process 'source)))
    (when (file-exists-p file) (delete-file file)))
  (when (buffer-live-p (process-buffer process))
    (kill-buffer (process-buffer process))))

(defun emacs-config-lint-stop ()
  "Stop all pending checks in this buffer."
  (dolist (entry emacs-config-lint-processes)
    (let ((process (cdr entry)))
      (process-put process 'obsolete t)
      (when (process-live-p process) (delete-process process))
      (emacs-config-lint-cleanup process)))
  (setq emacs-config-lint-processes nil))

(defun emacs-config-lint-diagnostics (output source tool directory)
  "Parse OUTPUT from TOOL for SOURCE, resolving paths against DIRECTORY."
  (let (diagnostics)
    (with-temp-buffer
      (insert output)
      (goto-char (point-min))
      (while (re-search-forward
              "^\\(.+?\\):\\([0-9]+\\):\\([0-9]+\\): \\(.+\\)$" nil t)
        (let ((file (match-string 1))
              (line (string-to-number (match-string 2)))
              (column (string-to-number (match-string 3)))
              (message (match-string 4)))
          ;; mypy can also report problems in imported modules.
          (when (equal (expand-file-name file directory)
                       (buffer-local-value 'buffer-file-name source))
            (with-current-buffer source
              (let ((region (flymake-diag-region source line column))
                    (type (cond
                           ((string-prefix-p "note:" message) :note)
                           ((or (string-prefix-p "error:" message)
                                (string-match-p "\\`\\(?:E9\\|F[678]\\)" message))
                            :error)
                           (t :warning))))
                (when region
                  (push (flymake-make-diagnostic
                         source (car region) (cdr region) type
                         (format "%s: %s" tool message))
                        diagnostics))))))))
    (nreverse diagnostics)))

(defun emacs-config-lint-run (tool report-fn)
  "Check the unsaved buffer with TOOL and deliver results to REPORT-FN."
  (when-let* ((old (alist-get tool emacs-config-lint-processes)))
    (process-put old 'obsolete t)
    (when (process-live-p old) (delete-process old))
    (emacs-config-lint-cleanup old))
  (cond
   ((or (not buffer-file-name) (file-remote-p buffer-file-name))
    (funcall report-fn nil))
   ((not (executable-find (symbol-name tool)))
    (funcall report-fn :panic :explanation (format "%s is not installed/on PATH" tool)))
   (t
    (let* ((source (current-buffer))
           (tick (buffer-chars-modified-tick))
           (default-directory (emacs-config-lint-root))
           (directory default-directory)
           (file buffer-file-name)
           (temporary (when (eq tool 'mypy) (make-temp-file "emacs-mypy-" nil ".py")))
           (output (generate-new-buffer (format " *%s diagnostics*" tool)))
           (python (or (executable-find "python") (executable-find "python3")))
           (command
            (append
             (list (executable-find (symbol-name tool)))
             (pcase tool
               ('ruff (list "check" "--no-fix" "--no-fix-only" "--output-format" "concise"
                            "--stdin-filename" file "-"))
               ('flake8 (list "--color" "never" "--stdin-display-name" file
                              "--format=%(path)s:%(row)d:%(col)d: %(code)s %(text)s" "-"))
               ('mypy (append (list "--shadow-file" file temporary
                                    "--show-column-numbers" "--no-error-summary"
                                    "--no-pretty" "--hide-error-context")
                              (when python (list "--python-executable" python))
                              (list file)))))))
      (condition-case err
          (progn
            (when temporary
              (save-restriction
                (widen)
                (let ((coding-system-for-write 'utf-8-unix))
                  (write-region (point-min) (point-max) temporary nil 'silent))))
            (let ((process
                   (make-process
                    :name (format "emacs-%s" tool) :buffer output
                    :command command :connection-type 'pipe :noquery t
                    :coding 'utf-8-unix
                    :sentinel
                    (lambda (process _event)
                      (when (memq (process-status process) '(exit signal))
                        (unwind-protect
                            (when (and (not (process-get process 'obsolete))
                                       (buffer-live-p source))
                              (with-current-buffer source
                                (let ((text (with-current-buffer output (buffer-string))))
                                  (if (and (eq (process-status process) 'exit)
                                           (memq (process-exit-status process) '(0 1)))
                                      (when (= tick (buffer-chars-modified-tick))
                                        (funcall report-fn
                                                 (emacs-config-lint-diagnostics
                                                  text source tool directory)))
                                    (flymake-log :error "%s failed: %s" tool text)
                                    (funcall report-fn :panic :explanation
                                             (format "%s failed; see *Flymake log*" tool))))))
                          (emacs-config-lint-cleanup process)))))))
              (process-put process 'source temporary)
              (setf (alist-get tool emacs-config-lint-processes) process)
              (unless temporary
                (save-restriction
                  (widen)
                  (process-send-region process (point-min) (point-max))))
              (process-send-eof process)))
        (error
         (when temporary (delete-file temporary))
         (when (buffer-live-p output) (kill-buffer output))
         (funcall report-fn :panic :explanation (error-message-string err))))))))

(defun emacs-config-python-lint (report-fn &rest _)
  "Run the project-selected Python linter with REPORT-FN."
  (if emacs-config-python-linter
      (emacs-config-lint-run emacs-config-python-linter report-fn)
    (funcall report-fn nil)))

(defun emacs-config-python-mypy (report-fn &rest _)
  "Run mypy with REPORT-FN using an unsaved shadow copy."
  (emacs-config-lint-run 'mypy report-fn))

(defun emacs-config-python-environment ()
  "Use the active or project virtualenv for buffer-local tool discovery."
  ;; Scope tool discovery to this buffer; don't change the editor's global PATH.
  (let* ((root (emacs-config-lint-root))
         (venv (or (getenv "VIRTUAL_ENV")
                   (let ((dir (expand-file-name ".venv" root)))
                     (when (file-directory-p dir) dir)))))
    (when venv
      (let ((bin (expand-file-name "bin" venv)))
        (setq-local exec-path (cons bin (delete bin (copy-sequence exec-path))))
        (setq-local process-environment (copy-sequence process-environment))
        (setenv "PATH" (concat bin path-separator (getenv "PATH")))))))

(defvar emacs-config-eglot-base-configuration eglot-workspace-configuration
  "Eglot configuration to preserve when adding the ty Python environment.")

(defun emacs-config-eglot-configuration (server)
  "Return SERVER's configuration with ty's interpreter selected per project.
Eglot calls this in a temporary buffer with the project's directory locals;
setting the workspace configuration only in a visited file would be ignored."
  (let ((config (copy-tree
                 (if (functionp emacs-config-eglot-base-configuration)
                     (funcall emacs-config-eglot-base-configuration server)
                   emacs-config-eglot-base-configuration))))
    (when (and (derived-mode-p 'python-mode 'python-ts-mode)
               (eq emacs-config-python-type-checker 'ty))
      (emacs-config-python-environment)
      (when-let* ((python (or (executable-find "python") (executable-find "python3"))))
        (let* ((ty (copy-tree (plist-get config :ty)))
               (settings (copy-tree (plist-get ty :configuration)))
               (environment (copy-tree (plist-get settings :environment))))
          (setq environment (plist-put environment :python python)
                settings (plist-put settings :environment environment)
                ty (plist-put ty :configuration settings)
                config (plist-put config :ty ty)))))
    config))

(setq eglot-workspace-configuration #'emacs-config-eglot-configuration)

(defun emacs-config-python-checking ()
  "Apply project settings before connecting Eglot or starting Flymake."
  (when (and buffer-file-name (not (file-remote-p buffer-file-name))
             (derived-mode-p 'python-mode 'python-ts-mode))
    (emacs-config-python-environment)
    (setq-local eglot-stay-out-of
                (cons 'flymake (copy-sequence eglot-stay-out-of)))
    (setq-local flymake-diagnostic-functions '(emacs-config-python-lint)
                flymake-no-changes-timeout 1.0
                flymake-start-on-save-buffer nil)
    (pcase emacs-config-python-type-checker
      ('ty (add-hook 'flymake-diagnostic-functions #'eglot-flymake-backend nil t))
      ('mypy (add-hook 'flymake-diagnostic-functions #'emacs-config-python-mypy nil t)))
    (add-hook 'kill-buffer-hook #'emacs-config-lint-stop nil t)
    (add-hook 'change-major-mode-hook #'emacs-config-lint-stop nil t)
    (flymake-mode 1)))

(add-hook 'hack-local-variables-hook #'emacs-config-python-checking)

;; Start/restart the LSP backend when the asynchronous connection is ready.
(add-hook 'eglot-managed-mode-hook
          (lambda ()
            (when (and (eglot-managed-p)
                       (derived-mode-p 'python-mode 'python-ts-mode))
              (flymake-start nil t))))

(global-set-key (kbd "C-c l r") (lambda () (interactive) (flymake-start nil t)))

(use-package apheleia
  :demand t
  :bind ("C-c f" . apheleia-format-buffer)
  :config
  (apheleia-global-mode -1)
  (dolist (entry '((markdown-mode . prettier-markdown)
                   (gfm-mode . prettier-markdown)
                   (markdown-ts-mode . prettier-markdown)
                   (python-mode . ruff)
                   (python-ts-mode . ruff)
                   (conf-toml-mode . taplo)
                   (toml-ts-mode . taplo)
                   (css-mode . prettier-css)
                   (css-ts-mode . prettier-css)
                   (html-mode . prettier-html)
                   (html-ts-mode . prettier-html)
                   (js-mode . prettier-javascript)
                   (js-ts-mode . prettier-javascript)
                   (typescript-mode . prettier-typescript)
                   (typescript-ts-mode . prettier-typescript)
                   (tsx-ts-mode . prettier-typescript)
                   (json-mode . prettier-json)
                   (json-ts-mode . prettier-json)
                   (rust-mode . rustfmt)
                   (rust-ts-mode . rustfmt)
                   (yaml-mode . prettier-yaml)
                   (yaml-ts-mode . prettier-yaml)))
    (setf (alist-get (car entry) apheleia-mode-alist) (cdr entry))))

;;; 61-linting.el ends here
