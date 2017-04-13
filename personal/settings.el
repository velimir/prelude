;; ediff horizontally
(setq ediff-split-window-function 'split-window-horizontally)

;; Disable scroll bars
(scroll-bar-mode -1)

;; Always ask before closing emacs
(setq confirm-kill-emacs 'yes-or-no-p)

;; set beacon colour to match zenburn theme
(setq beacon-color "#5f5f5f")

;; do not highlit current line
(global-hl-line-mode -1)

;; do not auto cleanup trailing whitespaces
(setq prelude-clean-whitespace-on-save nil)

;; set custom font
(set-default-font "Input Mono 13")
