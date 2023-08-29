(setq inhibit-startup-message t)

;; theme
(setq-default frame-background-mode 'dark)
(load-theme 'gruvbox-dark-medium t)

;; display
(setq display-time-24hr-format t)
(unless window-system
  (menu-bar-mode -1)
  (if (functionp 'scroll-bar-mode)
      (scroll-bar-mode 0)))
(if (functionp 'tool-bar-mode)
    (tool-bar-mode 0))

;; backup
(setq backup-directory-alist
    `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))

;; tab-complete
(setq ac-auto-start 3)

;; whitespace
(setq-default show-trailing-whitespace t)
(setq require-final-newline t)
