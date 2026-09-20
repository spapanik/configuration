;;; 50-development.el --- Git, diagnostics and language tools -*- lexical-binding: t; -*-

(use-package magit
  :bind ("C-c g" . magit-status))

(use-package diff-hl
  :init
  (global-diff-hl-mode 1)
  (diff-hl-flydiff-mode 1))

(use-package hl-todo
  :init (global-hl-todo-mode 1))

(use-package eglot
  :ensure nil
  :config
  (add-to-list 'eglot-server-programs
               '((fortran-mode f90-mode) . ("fortls")))
  (add-to-list 'eglot-server-programs
               '((lua-mode lua-ts-mode) . ("lua-language-server")))
  ;; npm install -g typescript@6 typescript-language-server vscode-langservers-extracted
  (add-to-list 'eglot-server-programs
               '((typescript-mode typescript-ts-mode tsx-ts-mode)
                 . ("typescript-language-server" "--stdio")))
  (add-to-list 'eglot-server-programs
               '((css-mode css-ts-mode)
                 . ("vscode-css-language-server" "--stdio"))))

(global-set-key (kbd "C-c l d") #'flymake-show-buffer-diagnostics)

;; Suppress secondary selection on press, then follow the clicked symbol.
(global-set-key [M-down-mouse-1] #'ignore)
(global-set-key [M-mouse-1] #'xref-find-definitions-at-mouse)

(defun emacs-config-maybe-start-eglot ()
  "Start Eglot for a supported buffer when its server is installed."
  (let ((server
         (cond
          ((derived-mode-p 'c-mode 'c++-mode 'c-ts-mode 'c++-ts-mode) "clangd")
          ((derived-mode-p 'python-mode 'python-ts-mode)
           (car (emacs-config-python-server)))
          ((derived-mode-p 'rust-mode 'rust-ts-mode) "rust-analyzer")
          ((derived-mode-p 'fortran-mode 'f90-mode) "fortls")
          ((derived-mode-p 'lua-mode 'lua-ts-mode) "lua-language-server")
          ((derived-mode-p 'typescript-mode 'typescript-ts-mode 'tsx-ts-mode)
           "typescript-language-server")
          ((derived-mode-p 'css-mode 'css-ts-mode) "vscode-css-language-server"))))
    (when (and buffer-file-name server (executable-find server))
      (eglot-ensure))))

;; Wait until project-local settings have been applied.
(add-hook 'hack-local-variables-hook #'emacs-config-maybe-start-eglot 90)

(use-package treesit-auto
  :if (and (fboundp 'treesit-available-p) (treesit-available-p))
  :config
  (setq treesit-auto-install t
        treesit-auto-langs
        '(bash c cpp css go html javascript json lua markdown python rust
          toml tsx typescript yaml))
  ;; Emacs 31's ts modes call this before the treesit-auto hook runs.
  (when (boundp 'treesit-auto-install-grammar)
    (setq treesit-auto-install-grammar 'always))
  ;; Register built-in ts modes before their grammars are installed so
  ;; visiting these files triggers automatic installation.
  (when (locate-library "typescript-ts-mode")
    (require 'typescript-ts-mode)
    (treesit-auto-add-to-auto-mode-alist '(typescript tsx)))
  (when (locate-library "markdown-ts-mode")
    (require 'markdown-ts-mode)
    (treesit-auto-add-to-auto-mode-alist '(markdown)))
  (when (locate-library "yaml-ts-mode")
    (require 'yaml-ts-mode)
    (treesit-auto-add-to-auto-mode-alist '(yaml)))
  (global-treesit-auto-mode 1))

;;; 50-development.el ends here
