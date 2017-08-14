(defvar *db* nil)

(defun add-cds()
  (loop (add-record (prompt-for-cd))
     (if (not (y-or-n-p "Another? [y\n]: ")) (return))))

(defun prompt-for-cd()
  (make-cd
   (prompt "Title")
   (prompt "Artist")
   (or (parse-integer (prompt "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]: ")))

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(defun add-record(cd)
  (push cd *db*))

(defun dump-db()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))
