;1.

(defun maxbt (tree)
  (if (consp tree)
      (max (maxbt (car tree))
	   (maxbt (cdr tree)))
      (if (numberp tree)
	  tree
	  0)))

(defun vars (tree)
  (if (consp tree)
       (union (vars (cadr tree))
	      (vars (caddr tree)))
       (if (null tree)
	   '()
	   (list tree))))

(defun occurs (symbol tree)
  (if (consp tree)
      (or (occurs symbol (cadr tree))
	  (occurs symbol (caddr tree)))
      (eq symbol tree)))

(defun eval2 (tree)
  (cond
    ((atom tree) tree)
    ((consp tree)
     (let
	 ((op (car tree))
	  (lhs (eval2 (cadr tree)))
	  (rhs (eval2 (caddr tree))))
	  (progn
	    (cond
	      ((eq op 'QUOTE) lhs)
	      ((eq op '+) (+ lhs rhs))
	      ((eq op '*) (* lhs rhs))
	      ((eq op '/) (/ lhs rhs))
	      ((eq op 'expt) (expt lhs rhs))
	      ((and (eq op '-) (= (length tree) 2)) (- lhs))
	      ((and (eq op '-) (= (length tree) 3)) (- lhs rhs))))))))
	       
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
	      ((eq op '+) (+ lhs rhs))
	      ((eq op '*) (* lhs rhs))
	      ((eq op '/) (/ lhs rhs))
	      ((eq op 'expt) (expt lhs rhs))
	      ((and (eq op '-) (= (length tree) 2)) (- lhs))
	      ((and (eq op '-) (= (length tree) 3)) (- lhs rhs))))))
    (t (cadr (assoc tree bindings)))))


(defun english (tree)
  (format nil "~a~%" (english-helper tree)))

(defun english-helper (tree)
  (cond
    ((atom tree) tree)
    ((consp tree)
     (let
	 ((op (car tree))
	  (lhs (english-helper (cadr tree)))
	  (rhs (english-helper (caddr tree))))
       (cond
	 ((eq op 'QUOTE) lhs)
	 ((eq op '+) (format nil "(the sum of ~a and ~a)" lhs rhs))
	 ((eq op '*) (format nil "(the product of ~a and ~a)" lhs rhs))
	 ((eq op '/) (format nil "(the quotient of ~a and ~a)" lhs rhs))
	 ((eq op 'expt) (format nil "(the exponent of ~a and ~a)" lhs rhs))
	 ((and (eq op '-) (= (length tree) 2)) (format nil "the negative of ~a" lhs))
	 ((and (eq op '-) (= (length tree) 3)) (format nil "(the difference of ~a and ~a)" lhs rhs)))))))

(defun tojava (tree)
  (format nil "~a;~%" (tojava-helper tree)))

(defun tojava-helper (tree)
  (cond
    ((atom tree) tree)
    ((consp tree)
     (let
	 ((op (car tree))
	  (lhs (tojava-helper (cadr tree)))
	  (rhs (tojava-helper (caddr tree))))
       (cond
	 ((eq op 'QUOTE) lhs)
	 ((eq op '=) (format nil "~a = ~a" lhs rhs))
	 ((eq op '+) (format nil "( ~a + ~a)" lhs rhs))
	 ((eq op '*) (format nil "(~a * ~a)" lhs rhs))
	 ((eq op '/) (format nil "(~a / ~a)" lhs rhs))
	 ((eq op 'expt) (format nil "(Math.expt(~a,~a)" lhs rhs))
	 ((and (eq op '-) (= (length tree) 2)) (format nil "(-~a)" lhs))
	 ((and (eq op '-) (= (length tree) 3)) (format nil "(~a - ~a)" lhs rhs))
	 ((= (length tree) 2) (format nil "Math.~a(~a)" op lhs))
	 ((= (length tree) 3) (format nil "Math.~a(~a,~b)" op lhs)))))))


;testing
(defun test-func (f show-args &rest args)
  (if show-args
      (format t  "~(~a~) ~a = ~d~%" f args (apply f args))
      (format t  "~(~a~) = ~d~%" f (apply f args))))

(defun test ()
  (setq bt1 (list 
	     (list (list 23 77) -3 88)
	     (list (list 99 7) 15 -1)))

  (format t "bt1 = ~a~%" bt1)
  (test-func 'maxbt t bt1)

  (setq expr1 '(= f '(* m a)))
  (format t "expr1 = ~a~%" expr1)
  (test-func 'vars t expr1)

  (setq expr2 '(= f '(/ * m '(expt v 2))))
  (format t "expr2 = ~a~%" expr2)
  (test-func 'vars t expr2)

  (test-func 'occurs t 'm expr2)
  (test-func 'occurs t 7 expr2)

  (setq expr3 '(+ 3 '(* 5 7)))
  (format t "expr3 = ~a~%" expr3)
  (test-func 'eval2 t expr3)

  (setq expr4 '(+ '( - 3) '(expt '(- 7 '(/ 4 2)) 3)))
  (format t "expr4 = ~a~%" expr4)

  (test-func 'eval2 t expr4)
  (test-func 'eval3 t 'b '((b 7)))

  (setq expr5 '(+ 3 '(* 5 b)))
  (format t "expr5 = ~a~%" expr5)  
  (test-func 'eval3 t expr5 '((b 7)))


  (setq expr6 '(+'(- c) '(expt '(- b '(/ z w)) 3)))
  (setq alist '((c 3) (b 7) (z 4) (w 2) (fred 5)))
  (format t "expr6 = ~a~%" expr6)  
  (format t "alist = ~a~%" alist)  

  (test-func 'eval3 t expr6 alist)
  (test-func 'english t expr5)
  (test-func 'english t expr6)

  (test-func 'tojava t expr1)
  (setq expr7 '(=  x '(* '(+ a b) c)))
  (format t "expr7 = ~a~%" expr7)
  (test-func 'tojava t expr7)

  (setq expr8 '(= x '(* r '(sin theta))))
  (format t "expr8 = ~a~%" expr8)
  (test-func 'tojava t expr8)

)(test)