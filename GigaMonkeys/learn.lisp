(defun hello-world(name)
  (format t "Hello, ~A!~%" name))

(hello-world "Robert")

;; To compile a lisp file for faster loading you can do the following:
;;   (load (compile-file "<relative or full path>"))
