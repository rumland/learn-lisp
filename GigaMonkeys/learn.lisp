(defun hello-world(name)
  (format t "Hello, ~A!~%" name))

(hello-world "Robert")

;; To compile a lisp file for faster loading you can do the following:
;;   (load (compile-file "<relative or full path>"))

;; Conventions:
;;  * global variables start and end with '*'
;;  * constants start and end with '+'
;;  * low-level functions start with '%' or '%%'
;;  * language standard symbols use only alphabetic characters (A-Z) plus *, +, -, 1, 2, <, =, > and &
;;  * file header comment should use ';;;;'
;;  * paragraph comment should use ';;;'
;;  * following line of code comment should use ';;'
;;  * use '->' in function name to indicate convertion. For example, string->widget, says convert string to widget

;; Macro example
(defmacro backwards (expr) (reverse expr))
(backwards ("hello, world" t format))
