(load "./cd-class.lisp")

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

(defun save-db(filename)
  (with-open-file (out filename :direction :output :if-exists :supersede)
    (with-standard-io-syntax (print *db* out))))

(defun load-db(filename)
  (with-open-file (in filename :direction :input)
    (with-standard-io-syntax (setf *db* (read in)))))

(defun select-cd-by-artist(artist)
  (remove-if-not #'(lambda(cd) (equal (get-cd-artist cd) artist)) *db*))
