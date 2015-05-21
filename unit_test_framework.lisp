;; (defun test-+ ()
;;   (and
;;    (= (+ 1 2) 3)
;;    (= (+ 1 2 3) 6)
;;    (= (+ -1 -3) -4)))

(defvar *test-name* nil)

(defun report-result (result form)
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form)
  result)

(defmacro with-gensyms (syms &body body)
  `(let ,(loop for s in syms collect `(,s (gensym)))
     ,@body))

(defmacro check (form)
  `(report-result ,form ',form))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check-all (&body forms)
  `(combine-results
    ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

(deftest test-+ ()
  (check-all
    (= (+ 1 2) 3)
    (= (+ 4 5 6) 15)
    (= (+ -3 -6) -9)))

(deftest test-* ()
  (check-all
    (= (* 2 2) 4)
    (= (* 3 2 1) 6)
    (= (* 3 4) 12)))

(deftest test-arithmetic ()
  (combine-results
    (test-+)
    (test-*)))

