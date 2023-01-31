;; multiple selection
(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this)

;; move lines
(global-set-key (kbd "C-S-<up>") 'drag-stuff-up)
(global-set-key (kbd "C-S-<down>") 'drag-stuff-down)

;; move between windows
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

;; comment line or region
(global-set-key (kbd "C-x C-_") 'comment-line)
(global-set-key (kbd "C-x C-/") 'comment-line)

;; project structure
(global-set-key [f3] 'neotree-toggle)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)
