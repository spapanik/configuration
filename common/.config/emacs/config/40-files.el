;;; 40-files.el --- File and window navigation -*- lexical-binding: t; -*-

(use-package project
  :ensure nil
  :bind-keymap ("C-c p" . project-prefix-map))

(use-package windmove
  :ensure nil
  :init (windmove-default-keybindings))

;; BSD ls cannot group directories first; use Emacs's sorter for Dired/Dirvish.
(require 'ls-lisp)
(setq ls-lisp-use-insert-directory-program nil
      ls-lisp-dirs-first t
      ls-lisp-ignore-case nil
      ls-lisp-use-string-collate nil)

(require 'dired-x)
(setq dired-omit-files "\\`\\.\\.?\\'"
      dired-omit-extensions nil)
(add-hook 'dired-mode-hook #'dired-omit-mode)

(defun emacs-config-dired-hide-editor-chrome ()
  "Hide editor tabs and line numbers in directory listings."
  (setq-local tab-line-exclude t)
  (tab-line-mode -1)
  (display-line-numbers-mode -1))

(add-hook 'dired-mode-hook #'emacs-config-dired-hide-editor-chrome)

(defun emacs-config-dirvish-side-background (buffer)
  "Give sidebar BUFFER a darker background than editing windows."
  (with-current-buffer buffer
    (face-remap-set-base 'default '(:background "#1f2335") 'default)
    (face-remap-set-base 'header-line '(:background "#1f2335") 'header-line)))

(with-eval-after-load 'dirvish-side
  (advice-add 'dirvish-side-root-conf :after
              #'emacs-config-dirvish-side-background))

(defun emacs-config-dirvish-return ()
  "Toggle a directory subtree or open the file at point."
  (interactive)
  (if (file-directory-p (dired-get-filename nil t))
      (dirvish-subtree-toggle)
    (dired-find-file)))

(defun emacs-config-dirvish-click (event)
  "Move to the clicked entry in EVENT and perform the RET action."
  (interactive "e")
  (mouse-set-point event)
  (when (dired-get-filename nil t)
    (emacs-config-dirvish-return)))

(use-package dirvish
  :bind ("C-c e" . dirvish-side)
  :config
  (dirvish-override-dired-mode 1)
  (dirvish-side-follow-mode 1)
  (setq dirvish-side-auto-expand t
        dirvish-side-width 30
        dirvish-attributes '(nerd-icons file-time file-size)
        dirvish-side-attributes '(nerd-icons))
  (define-key dirvish-mode-map (kbd "RET") #'emacs-config-dirvish-return)
  ;; Dired's follow-link binding can translate left clicks to mouse-2,
  ;; whose inherited command opens files in another window.
  (define-key dirvish-mode-map [follow-link] 'ignore)
  (define-key dirvish-mode-map [mouse-1] #'emacs-config-dirvish-click)
  (define-key dirvish-mode-map [mouse-2] #'emacs-config-dirvish-click))

(use-package popper
  :bind (("C-`" . popper-toggle)
         ("M-`" . popper-cycle))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*" "\\*Warnings\\*" "\\*Help\\*"
          "\\*compilation\\*" "\\*eshell\\*"))
  (popper-mode 1)
  (popper-echo-mode 1))

;;; 40-files.el ends here
