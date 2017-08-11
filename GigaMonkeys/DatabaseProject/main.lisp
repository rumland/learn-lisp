(load "./database.lisp")
(load "./cd-class.lisp")

(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(add-record (make-cd "Home" "Dixie Chicks" 9 t))

(dump-db)

;; Need to start at 'Improving the User Interaction' from
;;  http://www.gigamonkeys.com/book/practical-a-simple-database.html
