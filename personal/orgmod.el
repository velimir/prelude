(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "/usr/local/Cellar/plantuml/8034/plantuml.8034.jar"))

(global-set-key (kbd "C-c C-x C-j") #'org-clock-goto)
(global-set-key (kbd "C-c C-x C-x") #'org-clock-in-last)
(global-set-key (kbd "C-c C-x C-i") #'org-clock-in)
(global-set-key (kbd "C-c C-x C-o") #'org-clock-out)

;; HTML export
(let* ((style-filename "org-custom-style.css")
       (style-path (expand-file-name style-filename prelude-personal-dir))
       (style-str (concat
                   "<link rel=\"stylesheet\" href=\"" style-path "\" />")))
  (setq org-html-head style-str))

;; LaTeX export
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq org-latex-minted-options '(("breaklines" "true")
                                 ("breakanywhere" "true")))

(setq org-latex-toc-command "\\tableofcontents \\clearpage")
