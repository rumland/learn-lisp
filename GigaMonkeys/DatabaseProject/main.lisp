(load "./database.lisp")
(load "./cd-class.lisp")
(load "./prompt.lisp")

(load-db "C:/Temp/my-cds.db")

(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(add-record (make-cd "Home" "Dixie Chicks" 9 t))

(if (y-or-n-p "Add CDs? [y\n]: ") (add-cds))

(dump-db)

(save-db "C:/Temp/my-cds.db")

(defparameter artist "Dixie Chicks")
(print (format t "CDs with artist: ~a~%~a~%" artist (select-cd-by-artist artist)))

(update (where :artist "Dixie Chicks") :rating 11)
(select (where :artist "Dixie Chicks"))
(print (format t "CDs with artist: ~a~%~a~%" artist (select-cd-by-artist artist)))

(delete-rows (where :artist "Dixie Chicks"))
(print "All Dixie Chicks rows should have been deleted")
(dump-db)

;; Need to start chapter 5 functions & 'Mixing Different Parameter Types':
;;  http://www.gigamonkeys.com/book/functions.html
