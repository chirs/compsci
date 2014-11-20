;1.
(defun sumsq (n)
  (if (<= n 0)
      0
      (+ (* n n) (sumsq (- n 1)))))

;2.
(defun peanoplus (x y)
  (if (= x 0)
      y
      (peanoplus (1- x) (1+ y))))

; invariant: x + y remains constant; 
; O(peanoplus) = n

;3.
(defun peanotimes (x y)
  (if (= x 1)
      y
      (peanoplus y (peanotimes (1- x) y))))

; O(peanotimes) = n^2

;4. 
(defun choose (n k)
  (defun choose-helper (n k i)
    (if (= k 0)
	i
	(choose-helper (- n 1) (- k 1) (* (/ n k) i))))
  (choose-helper n k 1))

;5.
(defun sumlistb (lst)
  (setq sum 0)
  (loop 
     (when (null lst) (return sum))
     (setq sum (+ sum (car lst)))
     (setq lst (cdr lst))))

(defun sumlistr (lst)
  (if (null lst)
      0
      (+ (car lst) (sumlistr (cdr lst)))))

(defun sumlisttr (lst)
  (defun sumlisttr-helper (lst val)
    (if (null lst)
	val
	(sumlisttr-helper (cdr lst) (+ (car lst) val))))
  (sumlisttr-helper lst 0))

;6.
(defun sqdiff (x y) (* (- x y) (- x y)))

(defun sumsqdiff (l1 l2)
  (setq sum 0)
  (loop
     (when (or (null l1) (null l2))
       (return sum))
     (setq sum (+ sum (sqdiff (car l1) (car l2))))
     (setq l1 (cdr l1))
     (setq l2 (cdr l2))))

(defun sumsqdiffr (l1 l2)
  (if (or (null l1) (null l2))
      0
      (+ 
       (sqdiff (car l1) (car l2))
       (sumsqdiff (cdr l1) (cdr l2)))))

(defun sumsqdifftr (l1 l2)
  (defun sumsqdifftr-helper (l1 l2 val)
    (if (or (null l1) (null l2))
	val
	(sumsqdifftr-helper (cdr l1) 
			    (cdr l2)
			    (+ val (sqdiff (car l1) (car l2))))))
  (sumsqdifftr-helper l1 l2 0))

;7.
(defun maxlist (lst)
  (setq m nil)
  (loop
     (when (null lst) (return m))
     (if (eq m nil)
	 (setq m (car lst))
	 (setq m (max (car lst) m)))
     (setq lst (cdr lst))))

(defun maxlistr (lst)
  (cond
    ((null lst) nil)
    ((null (cdr lst)) (car lst))
    (t
     (max (car lst)
	  (maxlist (cdr lst))))))

(defun maxlisttr (lst)
  (defun maxlisttr-helper (lst val)
    (if (null (cdr lst))
	val
	(maxlisttr-helper (cdr lst) (max (car lst) val))))
  (if (null lst)
      nil
      (maxlisttr-helper lst (car lst))))

;8.
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

;testing
(defun test-func (f show-args &rest args)
  (if show-args
      (format t  "~(~a~) ~a = ~d~%" f args (apply f args))
      (format t  "~(~a~) = ~d~%" f (apply f args))))

(defun test ()
  (test-func 'sumsq t 5)
  (test-func 'peanoplus t 3 5)
  (test-func 'peanotimes t 3 5)
  (test-func 'choose t 5 3)
  (loop for i in '(0 1 2 3 4) do 
       (test-func 'choose t 4 i))

  (setq mylist '(3 4 8 2))
  (setq mylistb '(2 1 6 5))
  (format t "mylist = ~a~%" mylist)
  (format t "mylistb = ~a~%" mylistb)

  (test-func 'sumlistb nil mylist)
  (test-func 'sumlistr nil mylist)
  (test-func 'sumlisttr nil mylist)

  (test-func 'sumsqdiff nil mylist mylistb)
  (test-func 'sumsqdiffr nil mylist mylistb)
  (test-func 'sumsqdifftr nil mylist mylistb)

  (test-func 'maxlist nil mylist)
  (test-func 'maxlistr nil mylist)
  (test-func 'maxlisttr nil mylist)

  (test-func 'binomial t 4)
)
(test)
	
	