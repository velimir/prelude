(setq ctags-update-prompt-create-tags nil)

(defvar erlang-ctags-options
  (list
   "--fields=+iaSt"
   "--extra=+q"
   "--exclude='*.elc'"
   "--exclude='*.class'"
   "--exclude='.git'"
   "--exclude='.svn'"
   "--exclude='SCCS'"
   "--exclude='RCS'"
   "--exclude='CVS'"
   "--exclude='EIFGEN'"
   "--exclude=logs"
   "--exclude=.eunit"
   "--etags-include=/Users/gstarinkin/otp/21.1/TAGS"
   "--links=no"))

(defun my-erlang-ctags ()
  (setq ctags-update-other-options erlang-ctags-options)
  (turn-on-ctags-auto-update-mode))
(add-hook 'erlang-mode-hook 'my-erlang-ctags)
