;;; 20-editing.el --- Editing, undo and snippets -*- lexical-binding: t; -*-

(use-package clipetty
  :if (not (display-graphic-p))
  :hook (after-init . global-clipetty-mode))

(use-package kkp
  :if (not (display-graphic-p))
  :hook (tty-setup . global-kkp-mode))

(when (display-graphic-p)
  (setq select-enable-clipboard t))

(defun emacs-config-without-mouse-motion (sequences)
  "Remove all-motion tracking from terminal enable SEQUENCES."
  (delete "\e[?1003h" sequences))

(when (and (not noninteractive) (not (display-graphic-p)))
  ;; Emacs 31 enables all-motion reporting (1003), which can flood some
  ;; terminals with SGR mouse sequences.  Click and wheel events only need
  ;; the basic (1000) and SGR (1006) modes.
  (require 'xt-mouse)
  (require 'term/xterm)
  (advice-add 'xterm-mouse--tracking-sequence :filter-return
              #'emacs-config-without-mouse-motion)
  (xterm-mouse-mode 1)
  ;; Register SGR decoding on the active terminal even if its TERM name is
  ;; not among the terminal types Emacs recognizes during early startup.
  (define-key input-decode-map "\e[M" #'xterm-mouse-translate)
  (define-key input-decode-map "\e[<" #'xterm-mouse-translate-extended)
  ;; Ghostty also sends CSI I/O when the window gains or loses focus.
  (define-key input-decode-map "\e[I" #'xterm-translate-focus-in)
  (define-key input-decode-map "\e[O" #'xterm-translate-focus-out)
  ;; Ghostty treats tracking modes as exclusive: disabling all-motion can
  ;; also clear button tracking, so re-enable clicks after that reset.
  (send-string-to-terminal "\e[?1003l\e[?1000h\e[?1006h")
  (mouse-wheel-mode 1))

(use-package undo-fu-session
  :init
  (setq undo-fu-session-directory (emacs-config-state-path "undo/"))
  (undo-fu-session-global-mode 1))

(use-package vundo
  :bind ("C-c u" . vundo))

(use-package yasnippet
  :init
  (setq yas-snippet-dirs (list (emacs-config-state-path "snippets/")))
  (yas-global-mode 1))
(use-package yasnippet-snippets
  :after yasnippet
  :config
  (add-to-list 'yas-snippet-dirs
               (expand-file-name "snippets" (file-name-directory
                                              (locate-library "yasnippet-snippets"))) t))

(use-package surround
  :vc (:url "https://github.com/mkleehammer/surround" :rev :newest)
  :bind-keymap ("C-c s" . surround-keymap))

(use-package expreg
  :bind (("C-c =" . expreg-expand)
         ("C-c -" . expreg-contract)))

;; Keep whole-line commenting on the shorter terminal-friendly key.
(global-set-key (kbd "M-;") #'comment-line)
(global-set-key (kbd "C-c ;") #'comment-dwim)

(defun emacs-config-change-number (amount)
  "Add AMOUNT to the decimal integer at or after point on this line."
  (let ((origin (point))
        (end (line-end-position))
        found)
    (save-excursion
      (goto-char (line-beginning-position))
      (while (and (not found) (re-search-forward "-?[0-9]+" end t))
        (when (> (match-end 0) origin)
          (setq found (list (match-beginning 0) (match-end 0)
                            (string-to-number (match-string 0)))))))
    (unless found
      (user-error "No number at or after point on this line"))
    (goto-char (car found))
    (delete-region (car found) (cadr found))
    (insert (number-to-string (+ (nth 2 found) amount)))
    (backward-char 1)))

(defun emacs-config-increment-number (amount)
  "Increment the integer at or after point by AMOUNT, defaulting to one."
  (interactive "*p")
  (emacs-config-change-number amount))

(defun emacs-config-decrement-number (amount)
  "Decrement the integer at or after point by AMOUNT, defaulting to one."
  (interactive "*p")
  (emacs-config-change-number (- amount)))

(global-set-key (kbd "C-c a") #'emacs-config-increment-number)
(global-set-key (kbd "C-c x") #'emacs-config-decrement-number)

(defun emacs-config-move-line-up ()
  "Move the current line up."
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun emacs-config-move-line-down ()
  "Move the current line down."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") #'emacs-config-move-line-up)
(global-set-key (kbd "M-<down>") #'emacs-config-move-line-down)

;;; 20-editing.el ends here
