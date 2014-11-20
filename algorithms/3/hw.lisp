;8. legacy
(defun binomial (n)
  (if (= n 0) 
      '(1)
      (sumparts (binomial (- n 1)))))

(defun sumparts (lst)
  (defun sumparts-helper (lst)
    (if (null (cdr lst))
	'(1)
	(cons 
	 (+ (car lst) (car (cdr lst)))
	 (sumparts-helper (cdr lst)))))
    (cons 1 (sumparts-helper lst)))

;1.

(defun square (n)
  (* n n))

(defun sum (lst)
  (if (null lst)
      0
     (+ (car lst) (sum (cdr lst)))))

(defun sumsq (lst)
  (if (null lst)
      0
      (+ (square (car lst)) (sum (cdr lst)))))

(defun len (lst)
  (if (null lst)
      0
      (+ 1 (len (cdr lst)))))

(defun mean (lst)
  (/ (sum lst) (len lst)))

(defun meansq (lst)
  (/ (sumsq lst) (len lst)))

(defun variance (lst)
  (abs (- (meansq lst) (square (mean lst)))))

(defun stdev (lst)
  (sqrt (variance lst)))

;2.

(defun raise (x n)
  (defun raise-helper (x n i)
    (if (= n 0)
	i
	(raise-helper x (- n 1) (* i x))))
  (raise-helper x n 1))


(defun sine (x)
  (defun taylor (n)
    (if (= n 0) 
	x
	(/ (* (- 1) x x (taylor (- n 1)))
	   (* (+ 1 (* 2 n)) (* 2 n)))))
  (defun sine-helper (n)
    (if (= n 0)
	(taylor n)
	(+ (taylor n)
	   (sine-helper (- n 1)))))
  (sine-helper 13))
    

		
(defun nthcdr2 (n lst)
  (cond
    ((null lst) nil)
    ((= n 0) lst)
    (t
     (nthcdr2 (- n 1) (cdr lst)))))


;4.
(defun elt2 (lst n)
  (cond
    ((null lst) nil)
    ((= n 0) (car lst))
    (t
     (elt2 (cdr lst) (- n 1)))))

;5.
(defun interpolate (lst x)
  (cond
    ((null lst) nil)
    ((= x 0) (car lst))
    ((> x 1) (interpolate (cdr lst) (- x 1)))
    (t
     (let ((end (cond
		((null (cdr lst)) 0)
		(t (car (cdr lst))))))
       (+
	(* (- 1 x) (car lst))
	(* x end))))))

; Need to do 2nd half

;6. 

(defun sumtr (lst)   
  (cond 
    ((null lst) 0)
    ((not (consp (car lst)))
     (+ (car lst) (sumtr (cdr lst))))
    (t
     (+
      (sumtr (car lst))
      (sumtr (cdr lst))))))


;7. 
(defun subseq2 (lst start end)
  (cond
    ((not (= start 0)) (subseq2 (cdr lst) (- start 1) (- end 1)))
    ((= end 0) '())
    (t
     (cons (car lst) (subseq2 (cdr lst) start (- end 1))))))

;8.
(defun posfilter (lst)
  (cond 
    ((null lst) '())
    ((< (car lst) 0)
     (posfilter (cdr lst)))
    (t
     (cons (car lst) (posfilter (cdr lst))))))

;9. doesn't work.
(defun subset (f lst)
  (cond
    ((null lst) '() )
    ((funcall f (car lst))
     (cons (car lst) (subset f (cdr lst))))
    (t
     (subset f (cdr lst)))))

;10. 
(defun mapcar2 (f lst)
  (if (null lst) 
      '()
      (cons (funcall f (car lst)) (mapcar2 f (cdr lst)))))

;11.
(defun some2 (f lst)
  (cond 
    ((null lst) nil)
    ((funcall f (car lst)) (car lst))
    (t
     (some2 f (cdr lst)))))
     

;12.
(defun every2 (f lst)
  (cond
    ((null lst) t)
    ((funcall f (car lst)) (every f (cdr lst)))
    (t nil)))

;testing
(defun test-func (f show-args &rest args)
  (if show-args
      (format t  "~(~a~) ~a = ~d~%" f args (apply f args))
      (format t  "~(~a~) = ~d~%" f (apply f args))))
      
(defun test ()
  (setq mylist '(95 72 86 70 97 72 52 88 77 94 91 79 61 77 99 70 91))
  (format t "mylist = ~d" mylist)
  (test-func 'sum nil mylist)
  (test-func 'mean nil mylist)
  (test-func 'meansq nil mylist)
  (test-func 'variance nil mylist)
  (test-func 'stdev nil mylist)
  (test-func 'sine nil 0.5) ; 0.47942553860420301
  (test-func 'nthcdr2 t 5 mylist)
  (test-func 'nthcdr2 t 18 mylist)
  (test-func 'elt2 t mylist 5)

  (setq mylistb '(0 30 56 78 96))
  (setq binom (binomial 12))
  (format t "mylistb = ~d~%" mylistb)
  (test-func 'interpolate nil mylistb 3.4)
  (format t "binom = ~d~%" binom)
  (test-func 'interpolate t binom 3.4)

  (setq mylistc  '(1 2 3 4 5 6))
  (format t "mylistc = ~d~%" mylistc)
  (test-func 'sumtr nil mylistc)

  (setq mylistd '(0 1 2 3 4 5 6))
  (format t "mylistd = ~d~%" mylistd)
  (test-func 'subseq2 t mylistd 2 5)

  (setq myliste '( 3 17 -2 0 -3 4 -5 12))

  (format t "myliste = ~d~%" myliste)

  (defun myp (x) (> x 3))
  (defun myf (x) (+ x 2))

  (test-func 'posfilter nil myliste)
  (test-func 'subset nil 'myp myliste)
  (test-func 'mapcar2 nil 'myf mylistd)
  (test-func 'some2 nil 'myp myliste)
  (test-func 'every2 nil 'myp myliste)
)
(test)
