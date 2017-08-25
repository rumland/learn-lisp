(defun foo (a b &optional (c "default c value" c-supplied-p) (d "default d value" d-supplied-p))
  "Show: optional parameter, default value for optional parameter and caller supplied argument."
  (list a b c d e c-supplied-p d-supplied-p e-supplied-p))

(defun foo-key (&key ((:apple a) 0) ((:box b) 0 b-supplied-p) ((:cart c) (+ a b)))
  "Show: how to use optional named parameters with name different between caller and function implementation" 
  (list a b c b-supplied-p))

(defun make-rectangle (width &optional (height width))
  "Show: how to use default value for optional parameter based on required parameter."
  (format t "make rectangle ~ax~a" width height))

(defun rob-add (&rest numbers)
  "Show function that uses &rest for variable parameter list. This function does not work because numbers is of type (values list &optional) and the '+' function requires type number. Need to research how to deal with types to make this function functional ;-)"
  (+ numbers))
