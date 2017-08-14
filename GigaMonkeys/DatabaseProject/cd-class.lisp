(defun get-cd-title(cd)
  (getf cd :title))

(defun get-cd-artist(cd)
  (getf cd :artist))

(defun get-cd-rating(cd)
  (getf cd :rating))

(defun get-cd-ripped(cd)
  (getf cd :ripped)) 
