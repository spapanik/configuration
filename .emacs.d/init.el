(setq backup-inhibited t)
(setq make-backup-files nil)
(setq inhibit-startup-message t)
(setq-default column-number-mode t)
(setq display-time-24hr-format t)
(display-time-mode 1)
(setq require-final-newline t)
(unless window-system
  (menu-bar-mode -1)
  (if (functionp 'scroll-bar-mode)
      (scroll-bar-mode 0)))
(if (functionp 'tool-bar-mode)
    (tool-bar-mode 0))
(global-linum-mode 1)
(auto-fill-mode -1)
(global-auto-revert-mode t)
(setq-default indent-tabs-mode nil)
(display-time-mode -1)

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)
(unless
    (file-exists-p "~/.light")
    (use-package darcula-theme
      :ensure t))
(use-package multiple-cursors
  :ensure t)
(use-package tramp
  :ensure t)
(use-package direx
  :ensure t)

(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this)

(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)

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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (direx yasnippet use-package smart-tab multiple-cursors darcula-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
