;; install packages
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
(use-package neotree)
(use-package magit)
(use-package moe-theme)
(use-package drag-stuff)
(use-package auto-complete)
(use-package whole-line-or-region)
(use-package smart-tab)

;; source config
(load-file (concat (file-name-as-directory "~") ".emacs.d/core.el"))
(load-file (concat (file-name-as-directory "~") ".emacs.d/modes.el"))
(load-file (concat (file-name-as-directory "~") ".emacs.d/remaps.el"))

;; source local config
(defvar local-init (concat (file-name-as-directory "~") ".emacs.d/local.el"))
(if (file-readable-p local-init)
    (load-file local-init))
