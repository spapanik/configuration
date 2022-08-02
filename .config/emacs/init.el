;; install packages
(require 'package)
(setq package-archives
      '(("GNU ELPA"     . "https://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/"))
      package-archive-priorities
      '(("MELPA Stable" . 10)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 0)))
(package-initialize)

(unless (package-installed-p 'use-package)
  (progn
    (package-refresh-contents)
    (package-install 'use-package)))

(require 'use-package)
(setq use-package-always-ensure t)
(use-package multiple-cursors)
(use-package editorconfig)
(use-package tramp)
(use-package popwin)
(use-package neotree)
(use-package magit)
(use-package drag-stuff)
(use-package auto-complete)
(use-package whole-line-or-region)
(use-package smart-tab)
(use-package solarized-theme)

;; source config
(load-file (concat (file-name-as-directory "~") ".config/emacs/core.el"))
(load-file (concat (file-name-as-directory "~") ".config/emacs/modes.el"))
(load-file (concat (file-name-as-directory "~") ".config/emacs/remaps.el"))

;; source local config
(defvar local-init (concat (file-name-as-directory "~") ".config/emacs/local.el"))
(if (file-readable-p local-init)
    (load-file local-init))
