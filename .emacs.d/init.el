(setq backup-inhibited t)
(setq make-backup-files nil)
(setq kill-whole-line t)
(setq inhibit-startup-message t)
(setq-default column-number-mode t)
(setq display-time-24hr-format t)
(display-time-mode 1)
(setq-default show-trailing-whitespace t)
(setq require-final-newline t)
(unless window-system
  (menu-bar-mode -1)
  (if (functionp 'scroll-bar-mode)
      (scroll-bar-mode 0)))
(if (functionp 'tool-bar-mode)
    (tool-bar-mode 0))
(global-linum-mode 1)
(auto-fill-mode -1)
(electric-pair-mode t)
(global-auto-revert-mode t)
(setq-default indent-tabs-mode nil)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)
(setq use-package-always-ensure t)
(use-package multiple-cursors)
(use-package tramp)
(use-package popwin)
(use-package direx)
(use-package magit)
(use-package material-theme)
(use-package auto-complete)
(use-package whole-line-or-region)
(use-package smart-tab)

;; theme
(if (file-exists-p "~/.light")
    (setq-default frame-background-mode 'light)
  (setq-default frame-background-mode 'dark))
(if (file-exists-p "~/.light")
    (load-theme 'material-light t)
  (load-theme 'material t))

(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this)

;; popwin
(popwin-mode 1)

;; direx
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

;; move lines
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-S-<up>") 'move-line-up)
(global-set-key (kbd "M-S-<down>") 'move-line-down)

;; move between windows
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

;; comment line or region
(whole-line-or-region-mode t)
(global-set-key (kbd "C-x C-/") 'whole-line-or-region-comment-dwim)
(global-set-key (kbd "C-x C-_") 'whole-line-or-region-comment-dwim)

;; tab-complete
(global-auto-complete-mode t)
(setq ac-auto-start 3)

;; source local file
(defvar local-init (concat (file-name-as-directory "~") ".emacs.d/init.local.el"))
(if (file-readable-p local-init)
    (load-file local-init))
