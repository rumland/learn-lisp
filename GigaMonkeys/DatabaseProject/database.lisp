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

;; Shows how to explicitly build where clause
(defun where-explicit (&key title artist rating (ripped nil ripped-p))
  #'(lambda (cd)
      (and
       (if title (equal (getf cd :title) title) t)
       (if artist (equal (getf cd :artist) artist) t)
       (if rating (equal (getf cd :rating) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))

;; Shows how to dynamically build where clause through use of macro
;; The ,@ "splices" the value of the following expression--which must evaluate to a list--into
;; the enclosing list. You can see the difference between , and ,@ in the following two expressions:
;; 
;;   `(and ,(list 1 2 3))   ==> (AND (1 2 3))
;;   `(and ,@(list 1 2 3))  ==> (AND 1 2 3)
(defmacro where (&rest clauses)
  `#'(lambda (cd) (and ,@(make-comparisons-list clauses))))

(defun make-comparison-expr-not-clear (field value)
  (list 'equal (list 'getf 'cd field) value))

;; Clear by use of `. Only subexpression preceded by , are evaluated.
(defun make-comparison-expr (field value)
  `(equal (getf cd ,field) ,value))

(defun make-comparisons-list (fields)
  (loop while fields
       collecting (make-comparison-expr (pop fields) (pop fields))))
