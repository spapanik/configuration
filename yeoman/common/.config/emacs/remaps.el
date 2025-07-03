;; expand region
(global-set-key (kbd "C-=") 'er/expand-region)

;; embrace
(global-set-key (kbd "C-,") #'embrace-commander)
(add-hook 'org-mode-hook #'embrace-org-mode-hook)

;; multiple selection
(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-S-p") (lambda () (interactive) (mc/mark-next-lines 1)))
(global-set-key (kbd "M-S-n") (lambda () (interactive) (mc/mark-previous-lines 1)))

;; better undo
(global-set-key (kbd "C-_") 'undo-fu-only-undo)
(global-set-key (kbd "C-/") 'undo-fu-only-undo)
(global-set-key (kbd "C-?") 'undo-fu-only-redo)

;; move lines
(global-set-key (kbd "M-S-<up>") 'drag-stuff-up)
(global-set-key (kbd "M-S-<down>") 'drag-stuff-down)

;; move between windows
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <down>") 'windmove-down)

;; comment line or region
(global-set-key (kbd "C-x C-_") 'comment-line)
(global-set-key (kbd "C-x C-/") 'comment-line)
