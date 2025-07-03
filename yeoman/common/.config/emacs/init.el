;; install straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

;; source config
(load-file (concat (file-name-as-directory "~") ".config/emacs/core.el"))
(load-file (concat (file-name-as-directory "~") ".config/emacs/packages.el"))
(load-file (concat (file-name-as-directory "~") ".config/emacs/package-conf.el"))
(load-file (concat (file-name-as-directory "~") ".config/emacs/remaps.el"))

;; source local config
(defvar local-init (concat (file-name-as-directory "~") ".config/emacs/local.el"))
(if (file-readable-p local-init)
    (load-file local-init))
