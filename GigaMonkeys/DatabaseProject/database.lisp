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
    (dump-cd cd)))

(defun dump-cd(cd)
  (format t "~{~a:~10t~a~%~}~%" cd))

(defun save-db(filename)
  (with-open-file (out filename :direction :output :if-exists :supersede)
    (with-standard-io-syntax (print *db* out))))

(defun load-db(filename)
  (if (probe-file filename)
      (with-open-file (in filename :direction :input)
	(with-standard-io-syntax (setf *db* (read in))))))

(defun select-cd-by-artist(artist)
  (select (where :artist artist)))

(defun select (select-fn)
  (remove-if-not select-fn *db*))

(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
  (setf *db*
	(mapcar
	 #'(lambda (row)
	     (when (funcall selector-fn row)
	       (if title (setf (getf row :title) title))
	       (if artist (setf (getf row :artist) artist))
	       (if rating (setf (getf row :rating) rating))
	       (if ripped-p (setf (getf row :ripped) ripped)))
	     row) *db*)))

(defun delete-rows (selector-fn)
  (setf *db* (remove-if selector-fn *db*)))

(defun where (&key title artist rating (ripped nil ripped-p))
  #'(lambda (cd)
      (and
       (if title (equal (getf cd :title) title) t)
       (if artist (equal (getf cd :artist) artist) t)
       (if rating (equal (getf cd :rating) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))
