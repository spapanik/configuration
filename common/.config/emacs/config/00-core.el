;;; 00-core.el --- State and basic editing defaults -*- lexical-binding: t; -*-

(defun emacs-config-state-path (name)
  "Return NAME under the XDG Emacs state directory, creating parents."
  (let ((path (expand-file-name name emacs-config-state-directory)))
    (make-directory (file-name-directory path) t)
    (when (string-suffix-p "/" name)
      (make-directory path t))
    path))

(setq inhibit-startup-screen t
      initial-scratch-message nil)

(setq-default indent-tabs-mode nil
              tab-width 4
              fill-column 80
              require-final-newline t)

(setq backup-directory-alist `(("." . ,(emacs-config-state-path "backups/")))
      auto-save-file-name-transforms
      `((".*" ,(emacs-config-state-path "auto-save/") t)))

(use-package savehist
  :ensure nil
  :init
  (setq savehist-file (emacs-config-state-path "history"))
  (savehist-mode 1))

(use-package recentf
  :ensure nil
  :init
  (setq recentf-save-file (emacs-config-state-path "recentf"))
  (recentf-mode 1))

(use-package saveplace
  :ensure nil
  :init
  (setq save-place-file (emacs-config-state-path "places"))
  (save-place-mode 1))

(use-package autorevert :ensure nil :init (global-auto-revert-mode 1))
(use-package delsel :ensure nil :init (delete-selection-mode 1))
(use-package elec-pair :ensure nil :init (electric-pair-mode 1))
(use-package paren :ensure nil :init (show-paren-mode 1))
(use-package repeat :ensure nil :init (repeat-mode 1))
(use-package winner :ensure nil :init (winner-mode 1))
(use-package so-long :ensure nil :init (global-so-long-mode 1))
(use-package editorconfig :ensure nil :init (editorconfig-mode 1))
(use-package which-key :ensure nil :init (which-key-mode 1))

;;; 00-core.el ends here
