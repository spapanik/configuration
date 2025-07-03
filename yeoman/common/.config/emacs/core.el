;; clean init
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message t
      initial-scratch-message nil)

;; display
(display-time-mode 1)
(setq display-time-24hr-format t)
(unless window-system
  (menu-bar-mode -1)
  (if (functionp 'scroll-bar-mode)
      (scroll-bar-mode 0)))
(if (functionp 'tool-bar-mode)
    (tool-bar-mode 0))

;; backup and autosave in /tmp
(setq backup-directory-alist
    `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
    `((".*" ,temporary-file-directory t)))

;; whitespace
(setq-default show-trailing-whitespace t)
(setq require-final-newline t)

;; modes
(auto-fill-mode -1)  ;; turn off automatic line breaks
(column-number-mode t)
(delete-selection-mode 1)  ;; delete selection when typing
(electric-pair-mode 1)
(global-display-line-numbers-mode 1)
(setq-default indent-tabs-mode nil)  ;; use space for indentation
(repeat-mode 1)
(xterm-mouse-mode 1)
(mouse-wheel-mode 1)
