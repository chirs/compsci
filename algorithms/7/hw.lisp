;constants.
(defvar *formulas*
  '((= s (* 0.5 (* a (expt t 2))))
    (= s (+ s0 (* v t)))
    (= a (/ f m))
    (= v (* a t))
    (= f (/ (* m v) t))
    (= f (/ (* m (expt v 2)) r))
    (= h (- h0 (* 4.94 (expt t 2))))
    (= c (sqrt (+ (expt a 2) (expt b 2))))
    (= v (* v0 (- 1.0 (exp (/ (- t) (* r c))))))
    ))

(defvar *vars*
  '((s a t)
    (s s0 v t)
    (a f m)
    (v a 't)
    (f m v t)
    (f m v r)
    ( h0 t)
    (c a b)
    (v v0 t r c)
    )
  )


(defvar *opposites*
  '((+ -) (- +) (* /) (/ *) (sqrt expt) (expt sqrt) (log exp) (exp log) ) )


;1. 
(defun findpath (item cave)
  (cond
    ((eq item cave) (cons 'done '()))
    ((atom cave) nil)
    ((findpath item (first cave)) (cons 'first (findpath item (first cave))))
    ((findpath item (rest cave)) (cons 'rest (findpath item (rest cave))))))

(defun follow (path cave)
  (let 
      ((instruction (car path)))
    (cond ((eq instruction 'done) cave)
	  ((eq instruction 'first) (follow (rest path) (first cave)))
	  ((eq instruction 'rest) (follow (rest path) (rest cave))))))

(defun corresp (item tree1 tree2)
  (follow (findpath item tree1) tree2))

;2.

(defun op (e) (car e))
(defun lhs (e) (cadr e))
(defun rhs (e) (caddr e))

(defun solve (e v)
  (cond
    ((eq (lhs e) v) e)
    ((eq (rhs e) v) (list (op e) (rhs e) (lhs e)))
    ((not (consp (rhs e))) nil)
    ((solve (ltransform e) v) (solve (ltransform e) v))
    ((solve (rtransform e) v) (solve (rtransform e) v))))

(defun ltransform (e)
  (let
      ((l (lhs e))
       (opr (op (rhs e)))
       (lr (lhs (rhs e)))
       (rr (rhs (rhs e))))
    (cond
      ((and (eq opr '-) (= (length (rhs e)) 2)) (list (op e)  (list '- (lhs e)) lr))
      ((eq opr 'expt) (list (op e) (list 'sqrt (lhs e)) lr))
      ((eq opr 'sqrt) (list (op e) (list 'expt (lhs e) 2) lr))
      ((eq opr 'log) (list (op e) (list 'exp (lhs e)) lr))
      ((eq opr 'exp) (list (op e) (list 'log (lhs e)) lr))
      ((eq opr '+) (list (op e) (list '- l lr) rr))
      ((eq opr '*) (list (op e) (list '/ l lr) rr))      
      ((eq opr '/) (list (op e) (list '/ lr l) rr))      
      ((eq opr '-) (list (op e) (list '- lr l) rr))      
      )))

(defun rtransform (e)
  (let
      ((l (lhs e))
       (opr (op (rhs e)))
       (lr (lhs (rhs e)))
       (rr (rhs (rhs e))))
    (cond
      ((eq opr '+) (list (op e) (list '- l rr) lr))
      ((eq opr '*) (list (op e) (list '/ l rr) lr))      
      ((eq opr '/) (list (op e) (list '* l rr) lr))      
      ((eq opr '-) (list (op e) (list '+ l rr) lr))      
      )))

;3.
(defun eval3 (tree bindings)
  (cond
    ((numberp tree) tree)
    ((consp tree)
     (let
	 ((op (car tree))
	  (lhs (eval3 (cadr tree) bindings))
	  (rhs (eval3 (caddr tree) bindings)))
	  (progn
	    (cond
	      ((eq op 'QUOTE) lhs)
	      ((eq op 'sqrt) (sqrt lhs))
	      ((eq op 'exp) (exp lhs))
	      ((eq op 'log) (log lhs))
	      ((eq op '+) (+ lhs rhs))
	      ((eq op '*) (* lhs rhs))
	      ((eq op '/) (/ lhs rhs))
	      ((eq op 'expt) (expt lhs rhs))
	      ((and (eq op '-) (= (length tree) 2)) (- lhs))
	      ((and (eq op '-) (= (length tree) 3)) (- lhs rhs))))))
    (t (cadr (assoc tree bindings)))))

;4.
(defun solveit (equations var values)
  (if (null equations)
      nil
      (let ((result (ignore-errors (solve (car equations) var))))
	(if result
	    (let ((solved (ignore-errors (eval3 (rhs result) values))))
	      (if solved 
		  solved
		  (solveit (cdr equations) var values)))
	      (solveit (cdr equations) var values)))))


;testing
(defun test-func (f show-args &rest args)
  (if show-args
      (format t  "~(~a~) ~a = ~d~%" f args (apply f args))
      (format t  "~(~a~) = ~d~%" f (apply f args))))

(defun test-solve (e v) (test-func 'solve t e v))

(defun test-solutions (formula-list var-list)
  (dolist (formula formula-list)
    (dolist (vars var-list)
      (dolist (var vars)
	(progn 
	  (format t "formula: ~a~%" formula)
	  (format t "variable: ~a~%" var)
	  (format t "solution: ~a~%~%" (solve formula var))
	  )))))


(defun test ()

#|  (setq cave '(rocks gold '(monster)))
  (test-func 'findpath t 'gold cave)
  (setq path (findpath 'gold cave))
  (test-func 'follow t path cave)

  (setq treea '((my eyes) (have seen (the light))))
  (setq treeb '((my eyes) (have heard (the music))))
  (test-func 'corresp t 'light treea treeb)
|#
  (test-solutions *formulas* *vars*)
#|
  (test-func 'solveit nil *formulas* 'h0 '((h 0.0) (t 4.0)))
  (test-func 'solveit nil *formulas* 'a '((v 88.0) (t 8.0)))
  (test-func 'solveit nil *formulas* 'c '((v 3.0) (v0 6.0) (r 10000.0) (t 5.0)))
  (test-func 'solveit nil *formulas* 'b '((c 10.0) (a 6.0)))|#
)
(test)

