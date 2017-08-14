(load "./database.lisp")
(load "./cd-class.lisp")
(load "./prompt.lisp")

(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(add-record (make-cd "Home" "Dixie Chicks" 9 t))

(dump-db)

(add-cds)

(dump-db)

;; Need to start at 'Saving and Loading the Database' from
;;  http://www.gigamonkeys.com/book/practical-a-simple-database.html
