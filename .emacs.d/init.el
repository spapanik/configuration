(setq backup-inhibited t)
(setq make-backup-files nil)
(setq inhibit-startup-message t)
(setq-default column-number-mode t)
(setq display-time-24hr-format t)
(display-time)
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
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)
(use-package darcula-theme
  :ensure t)
