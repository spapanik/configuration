(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
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
(use-package moe-theme)
(use-package auto-complete)
(use-package whole-line-or-region)
(use-package smart-tab)

;; theme
(if (file-exists-p "~/.light")
    (setq-default frame-background-mode 'light)
  (setq-default frame-background-mode 'dark))
(if (file-exists-p "~/.light")
    (load-theme 'moe-light t)
  (load-theme 'moe-dark t))

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
(global-set-key (kbd "C-x C-/") 'comment-line)
(global-set-key (kbd "C-x C-_") 'comment-line)

;; tab-complete
(global-auto-complete-mode t)
(setq ac-auto-start 3)
