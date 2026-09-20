;;; early-init.el --- Startup paths and frame settings -*- lexical-binding: t; -*-

(setq package-enable-at-startup nil)

(defvar emacs-config-data-directory
  (expand-file-name "emacs/"
                    (or (getenv "XDG_DATA_HOME")
                        (expand-file-name "~/.local/share/"))))
(defvar emacs-config-state-directory
  (expand-file-name "emacs/"
                    (or (getenv "XDG_STATE_HOME")
                        (expand-file-name "~/.local/state/"))))

(setq package-user-dir (expand-file-name "elpa/" emacs-config-data-directory)
      custom-file (expand-file-name "custom.el" emacs-config-state-directory))

(dolist (directory (list emacs-config-data-directory emacs-config-state-directory))
  (make-directory directory t))

(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

;;; early-init.el ends here
