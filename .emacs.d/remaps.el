;; multiple selection
(global-set-key (kbd "M-n") 'mc/mark-next-like-this)
(global-set-key (kbd "M-p") 'mc/mark-previous-like-this)

;; move lines
(global-set-key (kbd "M-S-<up>") 'move-line-up)
(global-set-key (kbd "M-S-<down>") 'move-line-down)

;; move between windows
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

;; comment line or region
(whole-line-or-region-mode t)
(global-set-key (kbd "C-x C-/") 'comment-line)
(global-set-key (kbd "C-x C-_") 'comment-line)

;; project structure
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)
