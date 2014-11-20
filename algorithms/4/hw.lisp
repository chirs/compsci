;1.

(defun dmerjr (x y)
  (cond 
    ((null x) y)
    ((null y) x)
    (t
     (if (string< (first x) (first y))
	 (progn (setf (rest x)
		      (dmerjr (rest x) y))
		x)
	 (progn (setf (rest y)
		      (dmerjr x (rest y)))
		y)))))

(defun midpoint (lst)
  (let (prev current)
    (setq current lst)
    (setq prev lst)
    (loop 
       (when (or (null lst) (null (rest lst))) (return prev))
       (setq lst (rest (rest lst)))
       (setq prev current)
       (setq current (rest current)))))

(defun llmergesort (lst)
  (let (mid half)
    (if (or (null lst) (null (rest lst)))
	lst
	(progn (setq mid (midpoint lst))
	       (setq half (rest mid))
	       (setf (rest mid) nil)
	       (dmerjr (llmergesort lst)
		      (llmergesort half))))))


(defun remove-duplicates2 (lst)
  (if 
   (null (cdr lst))
   lst
   (if (eq (car lst) (cadr lst))
       (remove-duplicates2 (cdr lst))
       (cons (car lst) (remove-duplicates2 (cdr lst))))))


;skipping last element...

(defun union2 (m n)
  (remove-duplicates2 (union-helper (llmergesort m) (llmergesort n))))

(defun union-helper (m n)
  (cond
    ((null n) m)
    ((null m) n)
    ((string= (car m) (car n)) (cons (car m) (union-helper (cdr m) (cdr n))))
    ((string< (car m) (car n)) (cons (car m) (union-helper (cdr m) n)))
    (t (cons (car n) (union-helper m (cdr n))))))

(defun setDifference (m n)
  (sd-helper (llmergesort m) (llmergesort n)))

(defun sd-helper (m n)
  (cond
    ((null m) '())
    ((null n) m)
    ((string= (car m) (car n)) (sd-helper (cdr m) (cdr n)))
    ((string< (car m) (car n)) (cons (car m) (sd-helper (cdr m) n)))
    ((string> (car m) (car n)) (sd-helper m (cdr n)))))

;3.

(defun mergearr (a1 a2)
  (cond
    ((and (null a1) (null a2)) '())
    ((null a1) a2)
    ((null a2) a1)
    ((string> (car a1) (car a2))
	(cons (car a2) (mergearr a1 (cdr a2))))
    (t
     (cons (car a1) (mergearr (cdr a1) a2)))))

;4. still doesn't work.
(defun markup (lst)
  (defun is-tag (s)
    (if (string= s "")
	nil
	(eq (char s 0) #\<)))
  (defun is-open-tag (s)
    (if (is-tag s)
	(not (eq (char s 1) #\/))
	nil))
  (defun matches (s1 s2)
    (string= s1 (remove #\/ s2 :count 1)))

  (defun markup-helper (lst tag-list n)
    (let (
	  (cur (car lst))
	  (cur-tag (car tag-list)))
      (cond
	((null lst)
	 (if (null tag-list)
	     t
	     (progn
	       (format t "Failed on hanging tag ~a at end of list~%" cur-tag)
	       nil)))
	((is-open-tag cur) (markup-helper (cdr lst) (cons cur tag-list) (+ n 1)))
	((is-tag cur)
	 (if (matches cur-tag cur)
	     (markup-helper (cdr lst) (cdr tag-list) (+ n 1))
	     (progn
	       (format t "Failed on tag ~a at ~d~%" cur n)
	       nil)))
	(t (markup-helper (cdr lst) tag-list (+ n 1))))))
  (markup-helper lst '() 0))
    
	     
;testing
(defun test-func (f show-args &rest args)
  (if show-args
      (format t  "~(~a~) ~a = ~d~%" f args (apply f args))
      (format t  "~(~a~) = ~d~%" f (apply f args))))

(defun test ()
        (setq set1 '("d" "b" "c" "a"))
        (setq set2 '("f" "d" "b" "g" "h"))
	(format t "set1 = ~d~%" set1)
	(format t "set2 = ~d~%" set2)
	(test-func 'union2 nil set1 set2)

        (setq set3 '("d" "b" "c" "a"))
        (setq set4 '("f" "d" "b" "g" "h"))
	(format t "set3 = ~d~%" set3)
	(format t "set4 = ~d~%" set4)
	(test-func 'setDifference nil set3 set4)

        (setq arra '("a" "big" "dog" "hippo"))
        (setq arrb '("canary" "cat" "fox" "turtle"))
	(setq resarr (mergearr arra arrb))
	
	(setq i 0)
	(loop 
	   (when (= i (length resarr)) (return))
	   (format t "~d~%" (elt resarr i))
	   (setq i (+ i 1)))
	
	(setq xmla '("<TT>" "foo" "</TT>"))
        (setq xmlb '("<TABLE>" "<TR>" "<TD>" "foo" "</TD>"
                          "<TD>" "bar" "</TD>" "</TR>"
                          "<TR>" "<TD>" "fum" "</TD>" "<TD>"
                          "baz" "</TD>" "</TR>" "</TABLE>" ))
        (setq xmlc '("<TABLE>" "<TR>" "<TD>" "foo" "</TD>"
                          "<TD>" "bar" "</TD>" "</TR>"
                          "<TR>" "<TD>" "fum" "</TD>" "<TD>"
                          "baz" "</TD>" "</WHAT>" "</TABLE>"))
        (setq xmld '("<TABLE>" "<TR>" "<TD>" "foo" "</TD>"
                          "<TD>" "bar" "</TD>" "" "</TR>"
                          "</TABLE>" "</NOW>"))
        (setq xmle '("<THIS>" "<CANT>" "<BE>" "foo" "<RIGHT>"))
	(setq xmlf '("<CATALOG>"
		     "<CD>"
		     "<TITLE>" "Empire" "Burlesque" "</TITLE>"
		     "<ARTIST>" "Bob" "Dylan" "</ARTIST>"
		     "<COUNTRY>" "USA" "</COUNTRY>"
		     "<COMPANY>" "Columbia" "</COMPANY>"
		     "<PRICE>" "10.90" "</PRICE>"
		     "<YEAR>" "1985" "</YEAR>"
		     "</CD>"
		     "<CD>"
		     "<TITLE>" "Hide" "your" "heart" "</TITLE>"
		     "<ARTIST>" "Bonnie" "Tyler" "</ARTIST>"
		     "<COUNTRY>" "UK" "</COUNTRY>"
		     "<COMPANY>" "CBS" "Records" "</COMPANY>"
		     "<PRICE>" "9.90" "</PRICE>"
		     "<YEAR>" "1988" "</YEAR>"
		     "</CD>" "</CATALOG>"))
	(format t "xmla = ~d~%" xmla)
	(test-func 'markup nil xmla)
	(format t "xmlb = ~d~%" xmlb)
	(test-func 'markup nil xmlb)
	(format t "xmlc = ~d~%" xmlc)
	(test-func 'markup nil xmlc)
	(format t "xmld = ~d~%" xmld)
	(test-func 'markup nil xmld)
	(format t "xmle = ~d~%" xmle)
	(test-func 'markup nil xmle)
	(format t "xmlf = ~d~%" xmlf)
	(test-func 'markup nil xmlf)
)
(test)