;;; 30-completion.el --- Minibuffer and in-buffer completion -*- lexical-binding: t; -*-

(setq completion-ignore-case t
      read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t)

(use-package vertico
  :init (vertico-mode 1))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia
  :init (marginalia-mode 1))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)))

(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)))
(use-package embark-consult :after (embark consult))

(use-package corfu
  :init
  (setq corfu-auto t
        corfu-cycle t)
  (global-corfu-mode 1))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev))

(use-package avy
  :bind ("C-:" . avy-goto-char-timer))
(use-package ace-window
  :bind ("M-o" . ace-window))

;;; 30-completion.el ends here
