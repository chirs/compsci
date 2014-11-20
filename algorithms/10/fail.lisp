(defun dijkstra (start)
  (let (pq removed)
    (setq pq (priorityqueue))

    (dolist (item *txcities*)
      (let ((name (first item)))
	(setf (cost name) 999999)
	(setf (visited name) nil)))

    (setf (cost start) 0)
    (setf removed 0)

    (loop
       (let ((n (heap-remove pq)))
	 (if (not (visited n))
	     (format t "Doing node ~a~%" n)
	     (setq removed (1+ removed))
	     (setf (visited n) T)
	     (if (null n)
		 (return removed)
		 (dolist (e (edges n))
		   (if (not (null e))
		       (let ((name (first e))
			     (new-cost (+ (cost n) (second e))))
			 (progn (format t "Has ~a been visited: ~a~%" name (visited name)) 
				(format t "new-cost ~a, old cost ~a" new-cost (cost name))
				(if (not (visited name))
				(if (< new-cost (cost name))
				    (setf (parent name) n)
				    (setf (cost name) new-cost)))))))))))))
			 
			 



(defun pendijkstra (start)
  (let (pq removed)
    (setq pq (priorityqueue))

    (dolist (item *txcities*)
      (let ((name (first item)))
	(setf (cost name) 999999)
	(setf (visited name) nil)
	(heap-add pq name)))

    (setf (cost start) 0)
    (setf (visited start) T)
    (setf removed 0)

    (loop
       (let ((n (heap-remove pq)))
	 (setq removed (1+ removed))
	 (setf (visited n) T)
	 (if (null n)
	     (return removed) ; if n is null, we have explored all nodes.
	     (dolist (e (edges n)) ; process neighbors
	       (if (not (null e))
		   (let ((name (first e))
			 (new-cost (+ (cost n) (second e))))
		     (if (and (not (visited name))
			      (< new-cost (cost name)))
			 (progn
			   (setf (parent name) n)
			   (setf (cost name) new-cost)))))))))))


