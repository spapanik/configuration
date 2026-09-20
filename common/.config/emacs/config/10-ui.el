;;; 10-ui.el --- Appearance and display -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(global-set-key (kbd "C-c m") #'menu-bar-mode)
(tool-bar-mode -1)
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(when (display-graphic-p)
  (set-face-attribute 'default nil :family "MesloLGS Nerd Font Mono" :height 180))

(use-package catppuccin-theme
  :init (setq catppuccin-flavor 'mocha)
  :config (load-theme 'catppuccin t))

;; Terminal cursor shapes use DECSCUSR rather than `cursor-type'.
(defun emacs-config-terminal-cursor (window)
  "Use a bar in WINDOW, or a block when its buffer uses overwrite mode."
  (when (and (eq window (selected-window))
             (not (display-graphic-p (window-frame window))))
    (let* ((terminal (frame-terminal (window-frame window)))
           (shape (if (buffer-local-value 'overwrite-mode (window-buffer window))
                      2 6)))
      (unless (eq shape (terminal-parameter terminal 'emacs-config-cursor-shape))
        (send-string-to-terminal (format "\e[%d q" shape) terminal)
        (set-terminal-parameter terminal 'emacs-config-cursor-shape shape)))))

(defun emacs-config-reset-terminal-cursors ()
  "Restore terminal cursor defaults when Emacs exits or suspends."
  (dolist (terminal (terminal-list))
    (when (terminal-parameter terminal 'emacs-config-cursor-shape)
      (send-string-to-terminal "\e[0 q" terminal)
      (set-terminal-parameter terminal 'emacs-config-cursor-shape nil))))

(add-hook 'pre-redisplay-functions #'emacs-config-terminal-cursor)
(add-hook 'kill-emacs-hook #'emacs-config-reset-terminal-cursors)
(add-hook 'suspend-hook #'emacs-config-reset-terminal-cursors)

;; Use a continuous box-drawing glyph between terminal windows.
(unless (display-graphic-p)
  (unless standard-display-table
    (setq standard-display-table (make-display-table)))
  (set-display-table-slot standard-display-table 'vertical-border ?│))

;; Keep text-terminal menus consistent with the Mocha palette.
(unless (display-graphic-p)
  (set-face-attribute 'tty-menu-enabled-face nil
                      :foreground "#cdd6f4" :background "#181825" :weight 'normal)
  (set-face-attribute 'tty-menu-disabled-face nil
                      :foreground "#a6adc8" :background "#181825")
  (set-face-attribute 'tty-menu-selected-face nil
                      :foreground "#181825" :background "#89b4fa" :weight 'bold))

(use-package nerd-icons)
(use-package doom-modeline
  :after nerd-icons
  :init (doom-modeline-mode 1))
(use-package pulsar
  :init (pulsar-global-mode 1))

(defun emacs-config-tab-line-buffers ()
  "Show window buffers except the scratch buffer in the tab line."
  (seq-remove (lambda (buffer) (eq buffer (get-buffer "*scratch*")))
              (tab-line-tabs-fixed-window-buffers)))

(require 'tab-line)

(defun emacs-config-tab-line-format (tab tabs)
  "Format TAB with a file icon and comfortable spacing, preserving buttons."
  (let* ((label (tab-line-tab-name-format-default tab tabs))
         (buffer (if (bufferp tab) tab (alist-get 'buffer tab)))
         (icon (when (buffer-live-p buffer)
                 (with-current-buffer buffer
                   (if buffer-file-name
                       (nerd-icons-icon-for-file buffer-file-name)
                     (nerd-icons-icon-for-mode major-mode)))))
         (icon-face (when (stringp icon) (get-text-property 0 'face icon)))
         (properties (text-properties-at 0 label))
         (prefix (apply #'propertize
                        (concat "  " (when (stringp icon) (concat icon "  ")))
                        properties)))
    (when icon-face
      (add-face-text-property 2 (+ 2 (length icon)) icon-face nil prefix))
    (concat prefix label (apply #'propertize "  " properties))))

(setq tab-line-separator " "
      tab-line-new-button-show nil
      tab-line-tab-name-format-function #'emacs-config-tab-line-format
      tab-line-tab-face-functions '(tab-line-tab-face-special))
(setq tab-line-close-button
      (propertize "  ×" 'keymap tab-line-tab-close-map
                  'mouse-face 'tab-line-close-highlight
                  'help-echo "Click to close tab")
      tab-line-close-modified-button
      (propertize "  ●" 'keymap tab-line-tab-close-map
                  'mouse-face 'tab-line-close-highlight
                  'help-echo "Modified buffer; click to close tab"))

(set-face-attribute 'tab-line nil
                    :background "#181825" :foreground "#6c7086" :box nil)
(set-face-attribute 'tab-line-tab nil
                    :background "#1e1e2e" :foreground "#cdd6f4"
                    :box nil :inverse-video nil)
(set-face-attribute 'tab-line-tab-inactive nil
                    :background "#181825" :foreground "#6c7086"
                    :weight 'normal :slant 'normal :box nil :inverse-video nil)
(set-face-attribute 'tab-line-tab-current nil
                    :background "#1e1e2e" :foreground "#f9e2af"
                    :weight 'bold :slant 'italic :box nil :inverse-video nil)
(set-face-attribute 'tab-line-highlight nil
                    :background "#313244" :foreground "#cdd6f4"
                    :box nil :inverse-video nil)

(setq-default tab-line-tabs-function #'emacs-config-tab-line-buffers)
(global-tab-line-mode 1)

(global-display-line-numbers-mode 1)
(dolist (hook '(prog-mode-hook text-mode-hook conf-mode-hook))
  (add-hook hook #'hl-line-mode))
(setq whitespace-style '(face trailing tabs tab-mark))
(setq whitespace-display-mappings '((tab-mark 9 [187 9] [92 9])))
(global-whitespace-mode 1)

;;; 10-ui.el ends here
