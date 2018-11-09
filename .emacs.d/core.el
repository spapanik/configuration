(setq inhibit-startup-message t)

;; theme
(if (file-exists-p "~/.light")
    (setq-default frame-background-mode 'light)
  (setq-default frame-background-mode 'dark))
(if (file-exists-p "~/.light")
    (load-theme 'moe-light t)
  (load-theme 'moe-dark t))

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

;; whitespace
(setq-default show-trailing-whitespace t)
(setq require-final-newline t)
