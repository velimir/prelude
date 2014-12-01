;; Custom
(setq custom-file (concat user-emacs-directory "custom.el"))
(load custom-file)

;; Imports
(add-to-list 'load-path (concat user-emacs-directory "lisp"))
(add-to-list 'load-path (concat user-emacs-directory "plug"))

;; Custom functions
(load "aux.el")

;; Packages
(load "emacs-rc-network.el")
(load "emacs-rc-package.el")

;; Projectile
(projectile-global-mode)
(add-hook 'projectile-mode-hook 'projectile-rails-on)

;; Ido
(require 'ido)
(require 'flx-ido)

(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-use-faces nil)

(require 'smex)
(smex-initialize)

(eval-after-load 'smex
  `(defun smex-prepare-ido-bindings ()
     (define-key ido-completion-map (kbd "M-h") 'backward-kill-word)
     (define-key ido-completion-map (kbd "C-h") 'delete-backward-char)
     (define-key ido-completion-map (kbd "TAB") 'minibuffer-complete)
     (define-key ido-completion-map (kbd "C-? f") 'smex-describe-function)
     (define-key ido-completion-map (kbd "C-? w") 'smex-where-is)
     (define-key ido-completion-map (kbd "C-.") 'smex-find-function)
     (define-key ido-completion-map (kbd "C-a") 'move-beginning-of-line)))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; Buffers
(require 'uniquify)

(setq uniquify-buffer-name-style 'post-forward)

;; EDiff
(require 'ediff)

(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; CMake
(require 'cmake-mode)

(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                ("\\.cmake\\'" . cmake-mode))
              auto-mode-alist))

;; Html
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)))

(add-hook 'nxml-mode-hook
	  (lambda()
	    (setq nxml-child-indent 4)
	    (setq indent-tabs-mode nil)))

;; Erlang
;; TODO: move to separate module
(setq erlang-root-dir
      (let ((otp-path (getenv "OTP_PATH")))
			(if (null otp-path)
			    "/usr/lib/erlang"
			  otp-path)))
(add-to-list 'load-path
	     (car (file-expand-wildcards
		   (expand-file-name "lib/tools-*/emacs" erlang-root-dir))))
(add-to-list 'exec-path (expand-file-name "bin" erlang-root-dir))
(setq erlang-man-root-dir (expand-file-name "man" erlang-root-dir))
(require 'erlang-start)

;; Elixir
(require 'elixir-mix)
(global-elixir-mix-mode)

(add-to-list 'load-path "~/.emacs.d/plug/edts")
(require 'edts-start)

;; Erlang-compile
(require 'compile)

(defun albuild-compile ()
  ;; set compile-command
  (unless (or (file-exists-p "Makefile")
              (file-exists-p "makefile"))
    (let ((config-file (find-file-upward "albuild.config")))
      (when config-file
        (set (make-local-variable 'compile-command)
             (concat (concat "cd " (file-name-directory config-file) " && ")
                     "albuild clean && albuild build && albuild test-oldunit"))))))

(defun find-file-upward (filename &optional dir stop)
  (let*
      ((dir-path (if dir dir default-directory))
       (target-file (expand-file-name filename dir-path))
       (stop-path (if stop stop (expand-file-name "~"))))
    (if (file-exists-p target-file)
        target-file
      (unless (or (file-equal-p dir-path stop-path)
                  (file-equal-p dir-path "/"))
        (find-file-upward filename (expand-file-name ".." dir-path))))))

;; Erlang hooks
(add-hook 'erlang-mode-hook 'albuild-compile)
(add-hook 'erlang-mode-hook
          (lambda()
            (setq indent-tabs-mode nil)
            (column-enforce-mode 1)
            (local-set-key (kbd "C-c i")
                           'insert-first-avalible-log-id)))

;; Markdown
;; (add-to-list 'load-path (concat user-emacs-directory "plug/markdown-mode"))
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; Python
(add-hook 'python-mode-hook
          (lambda()
            (column-enforce-mode 1)
            (setq jedi:use-shortcuts t)
            (jedi:setup)))

;; yasnippet
(require 'yasnippet)
(yas-reload-all)

;; Ruby
(require 'ruby-tools)
(require 'company)
(add-hook 'ruby-mode-hook 'yas-minor-mode-on)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'company-mode)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)
(push 'company-robe company-backends)

;; Yaml
(add-hook 'yaml-mode-hook
    '(lambda ()
       (define-key yaml-mode-map "\C-m" 'newline-and-indent)
       (flymake-yaml-load)))

;; Haml
(add-hook 'haml-mode-hook 'flymake-haml-load)


;; Appearance and behaviour
(setq confirm-kill-emacs 'yes-or-no-p)

(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(column-number-mode 1)
(tool-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode 1)
(delete-selection-mode 1)

(server-start)

(load-theme 'solarized-dark t)
(set-frame-font "Ubuntu Mono-12:antialias=1")

;; Window number
(require 'window-number)
(window-number-meta-mode 1)

;; Key binding
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "M-h") 'backward-kill-word)
(global-set-key (kbd "C-h") 'delete-backward-char)
(define-key isearch-mode-map (kbd "C-h") 'isearch-delete-char)

;; Maximaze window on startup
(when (eq system-type 'windows-nt)
  (defun w32-maximize-frame ()
    "maximize the current frame"
    (interactive)
    (w32-send-sys-command 61488))
  (add-hook 'window-setup-hook 'w32-maximize-frame t))


;; Enable functions
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
