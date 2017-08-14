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

;; Need to start at 'Saving and Loading the Database' from
;;  http://www.gigamonkeys.com/book/practical-a-simple-database.html

(defparameter artist "Dixie Chicks")
(print (format t "CDs with artist: ~a" artist))
(select-cd-by-artist "Dixie Chicks")
