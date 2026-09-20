;;; init.el --- Load the Emacs configuration -*- lexical-binding: t; -*-

;; Keep this entry point small.  Modules in config/ load in filename order.
(let* ((root (file-name-directory (or load-file-name user-init-file)))
       (modules (expand-file-name "config/" root)))
  (unless (boundp 'emacs-config-data-directory)
    (load (expand-file-name "early-init.el" root) nil 'nomessage))
  (setq user-emacs-directory emacs-config-data-directory)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize)
  (require 'use-package)
  (setq use-package-always-ensure t)
  (dolist (file (directory-files modules t "^[0-9][0-9]-.*\\.el$"))
    (load file nil 'nomessage))
  (when (file-exists-p custom-file)
    (load custom-file nil 'nomessage)))

;;; init.el ends here
