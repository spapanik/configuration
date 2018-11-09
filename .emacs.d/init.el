;; startup
(setq inhibit-startup-message t)

;; default modes
(column-number-mode t)
(display-time-mode 1)
(electric-pair-mode t)
(auto-fill-mode -1)
(global-linum-mode 1)
(setq-default indent-tabs-mode nil)

;; backup
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

;; display
(setq display-time-24hr-format t)
(unless window-system
  (menu-bar-mode -1)
  (if (functionp 'scroll-bar-mode)
      (scroll-bar-mode 0)))
(if (functionp 'tool-bar-mode)
    (tool-bar-mode 0))

;; whitespace
(setq-default show-trailing-whitespace t)
(setq require-final-newline t)

;; packages
(load-file (concat (file-name-as-directory "~") ".emacs.d/packages.el"))

;; source local file
(defvar local-init (concat (file-name-as-directory "~") ".emacs.d/init.local.el"))
(if (file-readable-p local-init)
    (load-file local-init))
