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

(defun next-available (first-avl &optional log-max)
  (if (string-integer-p first-avl)
      (let ((next-free (1+ (string-to-number first-avl))))
        (if (and log-max (> next-free (string-to-number log-max)))
            "none"
          (int-w-format next-free (length first-avl))))
    (error "no available id")))

(defun next-id (last-used &optional log-max)
  (if (string-integer-p last-used)
      (let ((next-log-id (1+ (string-to-number last-used))))
        (if (or
             (not log-max)
             (assert (> next-log-id (string-to-number log-max)) "max log id exceeded"))
            (int-w-format next-log-id (length last-used))))
    (error "last id not found")))

(defun handle-first-available-code ()
    (if (search-forward-regexp "first available:\\s-?\\(.+\\)\\s-*" nil t)
        (let ((log-max (get-log-max))
              (first-avl (match-string 1)))
          (replace-match (next-available first-avl log-max) nil nil nil 1)
          (number-to-string (string-to-number first-avl)))))

(defun handle-last-code ()
    (if (search-forward-regexp "last:?\\s-\\(.+\\)\\s-*" nil t)
        (let* ((log-max (get-log-max))
               (last-used (match-string 1))
               (next-log-id (next-id last-used log-max)))
          (replace-match next-log-id nil nil nil 1)
          (number-to-string (string-to-number next-log-id)))))

(defun handle-latest-used-code ()
    (if (search-forward-regexp "latest used error code\\s-?:\\s-?\\([[:alpha:]]+\\)\\([0-9]+\\)\\s-*" nil t)
        (let* ((last-used (match-string 2))
               (next-log-id (next-id last-used)))
          (replace-match next-log-id nil nil nil 2)
          (concat (match-string 1) next-log-id))))

(defun safe-run-until (func-list)
  (goto-char (point-min))
  (if func-list
      (let* ((fun (car func-list))
             (val (apply fun '())))
        (if val val
          (safe-run-until (cdr func-list))))))

(defun insert-first-available-log-id ()
  (interactive)
  (insert (save-excursion
            (safe-run-until '(handle-first-available-code
                              handle-latest-used-code
                              handle-last-code)))))
