; Chris Edgemon cse357

; Dijkstra's algorithm starting from s.  Returns nodes.

(load "graph.lsp")

(defun dist (a b) (distanceto a b))
(defun halfass (a b) (* .5 (dist a b)))
(defun zip (a b) 0)
(defun randombs (a b) (* (random 1.0) (dist a b)))
(defun randomlies (a b) (random 5001))


(defun pathto (node)
  (defun pt (node)
    (if (null (parent node))
	(list node)
	(cons node (pathto (parent node)))))
  (pt node))


(defun totalcost ()
  (let ((total 0))
    (dolist (city *txcities*)
      (dolist (e (edges (first city)))
	(setq total (+ total (second e)))))
    (* total 2)))

(defun edgecost (start goal)
  (if (eq start goal)
      0
      (if (null (parent goal))
	  nil
	  (+ (cost goal) (edgecost start (parent goal))))))

  

(defun pathcost (v)
  (if (null (parent v))
      0
      (+ (cost v) (pathcost (parent v)))))


;(defun higher-order (f)
;  (funcall f 'ABILENE 'ELPASO))
;(higher-order 'halfass)


(defun dijkstra (start)
  (let (pq removed)
    (setq pq (priorityqueue))

    (dolist (item *txcities*)
      (let ((name (first item)))
	(setf (parent name) nil)
	(setf (cost name) 999999)
	(setf (visited name) nil)))

    (setf (cost start) 0)
    (setf removed 0)
    (heap-add pq start)

    (loop
       (let ((n (heap-remove pq)))
	 (if (null n)
	     (return removed)
	     (if (not (visited n))
		 (progn
		   (setq removed (1+ removed))
		   (setf (visited n) T)
		   (dolist (e (edges n))
		     (if (not (null e))
			 (let ((name (first e))
			       (new-cost (+ (cost n) (second e))))
			   (if (not (visited name))
			       (progn
				 (if (< new-cost (cost name))
				     (progn
				       (setf (parent name) n)
				       (setf (cost name) new-cost)))
				 (heap-add pq name)))))))))))))

(defun prim (start)
  (let (pq removed)
    (setq pq (priorityqueue))

    (dolist (item *txcities*)
      (let ((name (first item)))
	(setf (parent name) nil)
	(setf (cost name) 999999)
	(setf (visited name) nil)))

    (setf (cost start) 0)
    (setf total 0)
    (heap-add pq start)

    (loop
       (let ((n (heap-remove pq)))
	 (if (null n)
	     (return total)
	     (if (not (visited n))
		 (progn
		   (setf total (+ total (cost n)))
		   (setf (visited n) T)
		   (dolist (e (edges n))
		     (if (not (null e))
			 (let ((name (first e))
			       (new-cost (second e)))
			   (if (not (visited name))
			       (progn
				 (if (< new-cost (cost name))
				     (progn
				       (setf (parent name) n)
				       (setf (cost name) new-cost)))
				 (heap-add pq name)))))))))))))


(defun astar (start goal h)
  (let (pq removed)
    (setq pq (priorityqueue))

    (dolist (item *txcities*)
      (let ((name (first item)))
	(setf (parent name) nil)
	(setf (cost name) 999999)
	(setf (visited name) nil)))

    (setf (cost start) 0)
    (setf removed 0)
    (astar-heap-add pq start)

    (loop
       (let ((n (astar-heap-remove pq)))
	 (if (eq goal n)
	     (return removed)
	     (if (not (visited n))
		 (progn
		   (setq removed (1+ removed))
		   (setf (visited n) T)
		   (dolist (e (edges n))
		     (if (not (null e))
			 (let ((name (first e))
			       (new-cost (+ (cost n) (second e))))
			   (if (not (visited name))
			       (progn
				 (if (< new-cost (cost name))
				     (progn
				       (setf (parent name) n)
				       (setf (cost name) new-cost)
				       (setf (estimate name) (+ new-cost (funcall h start name)))))
				 (astar-heap-add pq name)))))))))))))



      
(defun dtest (start goal)
  (progn
    (format t  "start Dijkstra~%")
    (let ((dijknodes (dijkstra start)))
      (progn
	(format t "end Dijkstra, nodes = ~a~%" dijknodes)
	(format t "Length from ~a to ~a = ~a~%" start goal (cost goal))
	(format t "Route to ~a = ~a~%" goal (pathto goal))))))


(defun atest (start goal heuristic)
  (progn
    (format t "~%~%start A ~a~%" heuristic)
    (let ((nodes (astar start goal heuristic)))
      (progn
	(format t "end A, ~a~%" nodes)
	(format t "Road Distance ~a to ~a = ~a~%" start goal (cost goal))
	(format t "Route to ~a = ~a~%" goal (pathto goal))
	))))

(defun test ()
  
  (format t  "start~%")
  (format t "Great-Circle Distance Austin to Muleshoe = ~a~%" (distanceto 'austin 'muleshoe))
  (dtest 'austin 'muleshoe)

  (format t "~%Graph after running Dijkstra ~%~a~%" *txcities*)
  (dtest 'laredo 'haskell)
  (dtest 'dumas 'corsicana)


  (atest 'austin 'muleshoe #'dist)

  (atest 'laredo 'haskell #'dist)
  (atest 'dumas 'corsicana #'dist)


  (atest 'austin 'muleshoe #'halfass)
  (atest 'laredo 'haskell #'halfass)
  (atest 'dumas 'corsicana #'halfass)

  (atest 'austin 'muleshoe #'zip)
  (atest 'laredo 'haskell #'zip)
  (atest 'dumas 'corsicana #'zip)


  (atest 'austin 'muleshoe #'randombs)
  (atest 'laredo 'haskell #'randombs)
  (atest 'dumas 'corsicana #'randombs)

  (atest 'austin 'muleshoe #'randomlies)
  (atest 'laredo 'haskell #'randomlies)
  (atest 'dumas 'corsicana #'randomlies)

  (format t "starting Prim~%")
  (format t "end Prim, total cost = ~a~%" (prim 'austin))
  (format t "edgecost austin to temple = ~a~%" (edgecost 'austin 'temple))
  (format t "Route Austin to Muleshoe = ~a~%" (pathto 'muleshoe))
  (format t "pathcost austin to muleshoe = ~a~%" (pathcost 'muleshoe))
  (format t "total cost of all roads ~a~%" (totalcost))
  (format t "Graph after running Prim:~a~%" *txcities*)
  (format t "~%Graph after running Dijkstra ~%~a~%" *txcities*)


)
(test)