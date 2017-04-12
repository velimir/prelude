;; Key bindings
(setq help-char nil)

(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-h") 'delete-backward-char)
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

(with-eval-after-load 'helm
  (define-key helm-map (kbd "M-h") 'backward-kill-word)
  (define-key helm-map (kbd "C-h") 'delete-backward-char))
