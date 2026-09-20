;;; 60-languages.el --- File types, writing and commits -*- lexical-binding: t; -*-

(use-package graphql-mode :mode "\\.graphql\\'")
(use-package nim-mode :mode "\\.nim\\'")
(use-package csv-mode
  :mode (("\\.csv\\'" . csv-mode)
         ("\\.tsv\\'" . csv-mode)))

(dolist (entry '(("\\.ssh\\'" . conf-mode)
                 ("\\.git\\'" . conf-mode)
                 ("\\.tmux\\'" . conf-mode)
                 ("\\.cron\\'" . conf-mode)))
  (add-to-list 'auto-mode-alist entry))

(defun emacs-config-fortran-settings ()
  "Set local Fortran indentation and line guides."
  (setq-local indent-tabs-mode t
              fill-column 80)
  (setq-local display-fill-column-indicator-column 73)
  (display-fill-column-indicator-mode 1))

(add-hook 'fortran-mode-hook #'emacs-config-fortran-settings)
(add-hook 'f90-mode-hook #'emacs-config-fortran-settings)

(when (or (executable-find "aspell") (executable-find "hunspell"))
  (setq ispell-dictionary "en_GB")
  (add-hook 'text-mode-hook #'flyspell-mode))

(use-package git-commit
  :ensure nil
  :demand t
  :init (setq git-commit-summary-max-length 50)
  :hook (git-commit-setup . emacs-config-git-commit-settings)
  :config (global-git-commit-mode 1))

(defun emacs-config-git-commit-settings ()
  "Enable spelling and guides for a 50-character summary and 72-column body."
  (setq-local fill-column 72)
  (setq-local display-fill-column-indicator-column 73)
  (display-fill-column-indicator-mode 1)
  (when (or (executable-find "aspell") (executable-find "hunspell"))
    (flyspell-mode 1)))

;;; 60-languages.el ends here
