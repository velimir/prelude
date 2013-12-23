(defun int-w-format (num width)
  (let ((fmt-str (format "%%0%dd" width)))
    (format fmt-str num)))

(defun string-integer-p (string)
  (save-match-data
    (if (string-match "\\`[-+]?[0-9]+\\'" string)
        t
      nil)))

(defun get-log-max ()
  (save-excursion
    (goto-char (point-min))
    (search-forward-regexp
     "errors?:?\\s-?[[:digit:]]+\\s-?-\\s-?\\([[:digit:]]+\\)\\s-*")
    (match-string 1)))

(defun next-available (first-avl log-max)
  (if (string-integer-p first-avl)
      (let ((next-free (1+ (string-to-number first-avl))))
        (if (> next-free (string-to-number log-max))
            "none"
          (int-w-format next-free (length log-max))))
    (error "no available id")))

(defun insert-first-avalible-log-id ()
  (interactive)
  (insert (save-excursion
    (let ((log-max (get-log-max)))
      (goto-char (point-min))
      (search-forward-regexp "first available:\\s-?\\(.+\\)\\s-*")
      (let ((first-avl (match-string 1)))
        (replace-match (next-available first-avl log-max)
                       nil nil nil 1)
        (number-to-string (string-to-number first-avl)))))))
