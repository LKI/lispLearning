;;; 10 * 10 Rectangle
(dotimes (x 10)
  (dotimes (y 10)
    (format t "~3d" (* (+ 1 x) (+ 1 y))))
  (format t "~%"))

;;; Calculate 10th Fibonacci number
(do ((n 0 (+ n 1))
     (cur 0 next)
     (next 1 (+ cur next)))
    ((= n 10) cur))
