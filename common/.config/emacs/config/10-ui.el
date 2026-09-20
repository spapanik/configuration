;;; 10-ui.el --- Appearance and display -*- lexical-binding: t; -*-

(menu-bar-mode -1)
(global-set-key (kbd "C-c m") #'menu-bar-mode)
(tool-bar-mode -1)
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(when (display-graphic-p)
  (set-face-attribute 'default nil :family "MesloLGS Nerd Font Mono" :height 180))

(use-package tokyo-night
  :config (load-theme 'tokyo-night-storm t))

;; Use a continuous box-drawing glyph between terminal windows.
(unless (display-graphic-p)
  (unless standard-display-table
    (setq standard-display-table (make-display-table)))
  (set-display-table-slot standard-display-table 'vertical-border ?│))

;; Text-terminal menus use separate faces that Tokyo Night does not style.
(unless (display-graphic-p)
  (set-face-attribute 'tty-menu-enabled-face nil
                      :foreground "#c0caf5" :background "#1f2335" :weight 'normal)
  (set-face-attribute 'tty-menu-disabled-face nil
                      :foreground "#9aa5ce" :background "#1f2335")
  (set-face-attribute 'tty-menu-selected-face nil
                      :foreground "#1f2335" :background "#7aa2f7" :weight 'bold))

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
                    :background "#1f2335" :foreground "#565f89" :box nil)
(set-face-attribute 'tab-line-tab nil
                    :background "#24283b" :foreground "#c0caf5"
                    :box nil :inverse-video nil)
(set-face-attribute 'tab-line-tab-inactive nil
                    :background "#1f2335" :foreground "#565f89"
                    :weight 'normal :slant 'normal :box nil :inverse-video nil)
(set-face-attribute 'tab-line-tab-current nil
                    :background "#24283b" :foreground "#e0af68"
                    :weight 'bold :slant 'italic :box nil :inverse-video nil)
(set-face-attribute 'tab-line-highlight nil
                    :background "#2f334d" :foreground "#c0caf5"
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
