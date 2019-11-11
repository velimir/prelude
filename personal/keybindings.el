;; Key bindings
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-h") 'delete-backward-char)
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)
;; (define-key org-mode-map (kbd "M-h") 'backward-kill-word)

(with-eval-after-load 'helm
  (define-key helm-map (kbd "M-h") 'backward-kill-word)
  (define-key helm-map (kbd "C-h") 'delete-backward-char))

(with-eval-after-load 'company
  (define-key company-active-map (kbd "C-h") 'delete-backward-char)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  ;; (define-key company-search-map (kbd "C-n") 'company-select-next)
  ;; (define-key company-search-map (kbd "C-p") 'company-select-previous)
  )



;; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'shell)

;; Start a new shell even if one is active.
(global-set-key (kbd "C-x M")
                (lambda ()
                  (interactive)
                  (let ((current-prefix-arg 4)) ;; emulate C-u
                    (call-interactively 'shell) ;; invoke shell interactively
                    )))

;; Start a eshell if you prefer that.
(global-set-key (kbd "C-x M-m") 'eshell)


(global-set-key [remap move-beginning-of-line]
                'move-beginning-of-line)
