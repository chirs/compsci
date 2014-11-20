(load 'patmatch)
(load 'patm)
(load 'patterns)


;1.
;2.

(defun op (e) (car e))
(defun lhs (e) (cadr e))
(defun rhs (e) (caddr e))

(defun solve (e v)

  (cond
    ((eq (lhs e) v) e)
    ((eq (rhs e) v) (list (op e) (rhs e) (lhs e)))
    ((not (consp (rhs e))) nil)
    ((let ((solution (solve (ltransform e) v)))
       solution solution))
    ((let ((solution (solve (rtransform e) v)))
       solution solution))
    (t nil)))

       
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

(defun eval3 (tree bindings)
  (cond
    ((numberp tree) tree)
    ((consp tree)
     (let
	 ((op (car tree))
	  (lhs (eval3 (cadr tree) bindings))
	  (rhs (eval3 (caddr tree) bindings)))
	    (cond
	      ;((eq op 'QUOTE) lhs)
	      ((eq op 'sqrt) (sqrt lhs))
	      ((eq op 'exp) (exp lhs))
	      ((eq op 'log) (log lhs))
	      ((eq op '+) (+ lhs rhs))
	      ((eq op '*) (* lhs rhs))
	      ((eq op '/) (/ lhs rhs))
	      ((eq op 'expt) (expt lhs rhs))
	      ((and (eq op '-) (= (length tree) 2)) (- lhs))
	      ((and (eq op '-) (= (length tree) 3)) (- lhs rhs)))))
    (t (cadr (assoc tree bindings)))))


(defun vars (tree)
  (defun vars-helper (tree)
    (if (consp tree)
	(union (vars (cadr tree))
	       (vars (caddr tree)))
	(if (null tree)
	    '()
	    (list tree))))
  (defun filter-helper (l)
    (if (null l)
	'()
	(if (numberp (car l))
	    (filter-helper (cdr l))
	    (cons (car l) (filter-helper (cdr l))))))
  (filter-helper (vars-helper tree)))
    


(defun keys-from-bindings (binding)
  (if (null binding)
      '()
      (cons (caar binding) (keys-from-bindings (cdr binding)))))

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


(defun solveqns (eqns vals v)
  (defun improve-vals (eqns vals)
    (if (null eqns)
	vals
    (let ((free-vars (set-difference
		      (vars (car eqns))
		      (keys-from-bindings vals))))
      (if (= (length free-vars) 1)
	  (let ((new-val (solveit eqns (car free-vars) vals)))
	    (if new-val
		(improve-vals eqns (cons (list (car free-vars) new-val) vals))
		(improve-vals (cdr eqns) vals)))
	  (improve-vals (cdr eqns) vals)))))

  (let ((solution (solveit eqns v vals)))
    (if solution
	solution
	(let ((improved (improve-vals eqns vals)))
	  (if (= (length vals) (length improved))
	      nil
	      (solveqns eqns improved v))))))


;testing

(defun test ()
  ;(print (solveqns eqnsbat databat 'terminal_voltage))
  ;(print (solveqns eqnscirc datacirc 'angular_momentum))
  ;(print (solveqns eqnslens datalens 'magnification))
  ;(print (solveqns eqnslift datalift 'power))


  ;(print (solveit eqnslens 'image_distance datalens))
  ;(print (solveit eqnsbat 'loss_voltage databat))

  ;(print (solve '(= work (* charge terminal_voltage)) 'charge))
  ;(print (solve '((= focal_length (+ subject_distance image_distance))) 'subject_distance))

  ;(with-open-file (*standard-output* "Lisp.java" :direction :output) 
  ;  (dolist (javatest javatests)
  ;    (print (trans (trans javatest 'javarestructpats) 'javapats))))

  ;(dolist (opttest opttests)
  ;  (print (trans opttest 'optpats)))

  (dolist (derivtest derivtests)
    (print (trans (trans derivtest 'derivpats) 'optpats)))

)
(test)