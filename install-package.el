#!/usr/bin/emacs --script
;; Install new package
(setq command-switch-alist '(("--pkg" . on-install-package)))

(defun on-install-package (arg)
  (let ((package (intern (pop command-line-args-left))))
    (load "~/.emacs.d/lisp/emacs-rc-package.el")
    ;; Fix HTTP1/1.1 problems
    (setq url-http-attempt-keepalives nil)
    ;; fetch the list of packages available
    (when (not package-archive-contents)
      (package-refresh-contents))

    ;; install the missing packages
    (when (not (package-installed-p package))
      (package-install package))
    ))
