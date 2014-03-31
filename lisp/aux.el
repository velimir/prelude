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
     "[errors?\\|range]:?\\s-?[[:digit:]]+\\s-?-\\s-?\\([[:digit:]]+\\)\\s-*")
    (match-string 1)))

(defun next-available (first-avl log-max)
  (if (string-integer-p first-avl)
      (let ((next-free (1+ (string-to-number first-avl))))
        (if (> next-free (string-to-number log-max))
            "none"
          (int-w-format next-free (length log-max))))
    (error "no available id")))

(defun next-id (last-used log-max)
  (if (string-integer-p last-used)
      (let ((next-log-id (1+ (string-to-number last-used))))
        (if (> next-log-id (string-to-number log-max))
            (error "max log id exceeded")
          (int-w-format next-log-id (length last-used))))
    (error "last id not found")))


(defun insert-first-avalible-log-id ()
  (interactive)
  (insert (save-excursion
    (let ((log-max (get-log-max)))
      (goto-char (point-min))
      (cond ((search-forward-regexp "first available:\\s-?\\(.+\\)\\s-*" nil t)
             (let ((first-avl (match-string 1)))
               (replace-match (next-available first-avl log-max)
                              nil nil nil 1)
               (number-to-string (string-to-number first-avl))))
            ((search-forward-regexp "last:?\\s-\\(.+\\)\\s-*" nil t)
             (let* ((last-used (match-string 1))
                    (next-log-id (next-id last-used log-max)))
               (replace-match next-log-id nil nil nil 1)
               (number-to-string (string-to-number next-log-id)))))))))
