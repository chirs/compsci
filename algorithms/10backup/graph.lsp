; graph.lsp             Gordon S. Novak Jr.         ; 20 Apr 09

; Lisp code for graph assignment

; A city node is represented as a symbol

; properties of a node
; These can be used with setf, e.g. (setf (cost node) 99999)
(defmacro edges      (x) `(get ,x 'edges ))  ; ((target cost) ...)
(defmacro cost       (x) `(get ,x 'cost))
(defmacro estimate   (x) `(get ,x 'estimate))
(defmacro parent     (x) `(get ,x 'parent))
(defmacro visited    (x) `(get ,x 'visited))
(defmacro latitude   (x) `(get ,x 'latitude))
(defmacro longitude  (x) `(get ,x 'longitude))

(defun edge-target (edge) (first edge))
(defun edge-cost (edge) (second edge))

; Get all properties of a node: (symbol-plist 'austin)

(defvar *txcities*)

(setq *txcities* '(
(abilene   32.449  -99.732 ((roscoe 47) (haskell 54) (san-angelo 88) (brownwood 85) (fort-worth 158)))
(alice   27.752  -98.068 ((corpus-christi 39)))
(amarillo   35.222 -101.830 ((dumas 47) (plainview 76) (hereford 43) (pampa 54) (childress 116)))
(austin   30.267  -97.742 ((san-antonio 76) (temple 62) (bryan 86) (lampasas 61) (junction 122)))
(bay-city   28.983  -95.968 ((houston 88)))
(beaumont   30.086  -94.101 ((port-arthur 18)))
(beeville   28.401  -97.747 ((corpus-christi 60) (san-antonio 93)))
(big-spring   32.250 -101.477 ((roscoe 59) (san-angelo 86)))
(brownsville   25.901  -97.496 ())
(brownwood   31.709  -98.990 ((lampasas 71) (san-angelo 96)))
(bryan   30.674  -96.369 ())
(childress   34.426 -100.203 ())
(columbus   29.706  -96.538 ())
(corpus-christi   27.800  -97.395 ((laredo 140) (harlingen 107) (san-antonio 141)))
(corsicana   32.095  -96.468 ((huntsville 117) (tyler 71) (waco 55)))
(dallas   32.794  -96.799 ((corsicana 57) (tyler 96) (denton 39) (hillsboro 58)))
(del-rio   29.363 -100.895 ((sonora 90) (san-antonio 151)))
(denton   33.215  -97.132 ())
(dumas   35.866 -101.972 ())
(eagle-pass   28.709 -100.498 ((del-rio 56) (laredo 126)))
(el-paso   31.759 -106.485 ())
(fort-worth   32.725  -97.320 ((dallas 31) (hillsboro 51)))
(galveston   29.301  -94.797 ())
(greenville   33.138  -96.110 ((dallas 47)))
(harlingen   26.190  -97.695 ((mcallen 31) (brownsville 24)))
(haskell   33.158  -99.743 ((wichita-falls 95)))
(hereford   34.815 -102.396 ((muleshoe 45)))
(hillsboro   32.011  -97.129 ())
(houston   29.763  -95.362 ((galveston 47) (beaumont 85) (victoria 124) (columbus 74) (huntsville 70) (bryan 99)))
(huntsville   30.723  -95.550 ())
(junction   30.489  -99.771 ((san-antonio 116)))
(killeen   31.117  -97.727 ((temple 30)))
(lamesa   32.737 -101.950 ((midland 52) (big-spring 44)))
(lampasas   31.064  -98.180 ())
(laredo   27.506  -99.506 ())
(longview   32.501  -94.739 ())
(lubbock   33.578 -101.854 ((plainview 46) (muleshoe 70) (seminole 79) (lamesa 64) (snyder 88)))
(lufkin   31.338  -94.728 ((nacogdoches 19) (houston 123) (beaumont 108)))
(mcallen   26.203  -98.229 ((brownsville 55) (laredo 146)))
(midland   31.997 -102.077 ())
(mineral-wells   32.808  -98.112 ((fort-worth 60) (abilene 130)))
(muleshoe   34.226 -102.722 ())
(nacogdoches   31.603  -94.654 ())
(odessa   31.846 -102.366 ((midland 20) (pecos 76)))
(palestine   31.762  -95.630 ((corsicana 54) (tyler 50) (nacogdoches 56)))
(pampa   35.536 -100.958 ())
(pecos   31.423 -103.492 ((van-horn 88)))
(plainview   34.185 -101.705 ())
(port-arthur   29.899  -93.928 ())
(roscoe   32.446 -100.537 ())
(san-angelo   31.464 -100.436 ())
(san-antonio   29.424  -98.492 ((laredo 154)))
(seminole   32.719 -102.643 ((odessa 64) (lamesa 40)))
(sherman   33.636  -96.608 ((dallas 65)))
(snyder   32.718 -100.916 ((lamesa 67) (roscoe 30)))
(sonora   30.578 -100.642 ((junction 59) (san-angelo 68)))
(temple   31.098  -97.342 ((waco 37) (lampasas 50)))
(tyler   32.351  -95.300 ((longview 34) (lufkin 86)))
(van-horn   31.040 -104.829 ((el-paso 156) (sonora 254)))
(vernon   34.154  -99.264 ((childress 68)))
(victoria   28.805  -97.002 ())
(waco   31.549  -97.145 ((hillsboro 32) (bryan 87)))
(wichita-falls   33.914  -98.492 ((vernon 42) (fort-worth 106) (abilene 150)))
))

(defun readcities (lst)
  (let (c)
    (dolist (item lst)
      (setq c (first item))
      (setf (latitude c) (second item))
      (setf (longitude c) (third item))
      (dolist (dest (fourth item))
        (pushnew dest (edges c) :test #'equal)
        (pushnew (list c (second dest)) (edges (first dest))
                 :test #'equal) ))
    ))

(readcities *txcities*)

; Great-circle distance.  Args in degrees, result in kilometers
(defun gcdist (lata longa latb longb)
  (let (clata clatb d psi dist)
    (setq clata (cos (* 0.017453292519943292 lata)))
    (setq clatb (cos (* 0.017453292519943292 latb)))
    (setq d
          (sqrt (+ (expt (- (* clata
                               (sin (* 0.017453292519943292 longa)))
                            (* clatb
                               (sin (* 0.017453292519943292 longb))))
                         2)
                   (expt (- (* clata
                               (cos (* 0.017453292519943292 longa)))
                            (* clatb
                               (cos (* 0.017453292519943292 longb))))
                         2)
                   (expt (- (sin (* 0.017453292519943292 lata))
                            (sin (* 0.017453292519943292 latb)))
                         2))))
    (setq psi (* 2.0 (asin (* 0.5 d))))
    (setq dist (* 6372.6401120538467 psi))
    dist))

; distance between cities, integer miles
; (distanceto 'austin 'muleshoe)
(defun distanceto (citya cityb)
  (truncate (* 0.624 (gcdist (latitude citya) (longitude citya)
                             (latitude cityb) (longitude cityb)))))

; (vertices *txcities*)
(defun vertices (graph) (mapcar #'first graph))


(defun heap-heapify (heap i)
  (let (l r largest)
    (setq l (* 2 i))
    (setq r (1+ (* 2 i)))
    (if (and (<= l (aref heap 0))
             (sort-before (aref heap l) (aref heap i)))
        (setq largest l) (setq largest i))
    (if (and (<= r (aref heap 0))
             (sort-before (aref heap r) (aref heap largest)))
        (setq largest r))
    (when (/= largest i)
      (let (tmp)
        (setq tmp (aref heap i))
        (setf (aref heap i) (aref heap largest))
        (setf (aref heap largest) tmp))
      (heap-heapify heap largest))))

; add an item to priority queue
(defun heap-add (heap new)
  (let (i)
    (incf (aref heap 0))
    (setq i (aref heap 0))
    (while (and (> i 1) (sort-before new (aref heap (truncate i 2))))
           (setf (aref heap i) (aref heap (truncate i 2)))
           (setq i (truncate i 2)))
    (setf (aref heap i) new)
    heap))

; remove min item from priority queue
(defun heap-remove (heap)
  (let (themax i)
    (when (plusp (aref heap 0))
      (setq themax (aref heap 1))
      (setf (aref heap 1) (aref heap (aref heap 0)))
      (setf (aref heap (aref heap 0)) nil)
      (decf (aref heap 0))
      (setq i 1)
      (heap-heapify heap 1)
      themax)))

; test a priority queue for empty
(defun isempty (pq) (<= (aref pq 0) 0))

; make a new priority queue
(defun priorityqueue (&optional (size 1000))
  (let (arr)
    (setq arr (make-array size))
    (setf (aref arr 0) 0)
    arr))

(defun sort-before (citya cityb) (< (cost citya) (cost cityb)))

; priority queue for astar
(defun astar-heap-heapify (heap i)
  (let (l r largest)
    (setq l (* 2 i))
    (setq r (1+ (* 2 i)))
    (if (and (<= l (aref heap 0))
             (astar-sort-before (aref heap l) (aref heap i)))
        (setq largest l) (setq largest i))
    (if (and (<= r (aref heap 0))
             (astar-sort-before (aref heap r) (aref heap largest)))
        (setq largest r))
    (when (/= largest i)
      (let (tmp)
        (setq tmp (aref heap i))
        (setf (aref heap i) (aref heap largest))
        (setf (aref heap largest) tmp))
      (astar-heap-heapify heap largest))))

; add an item to priority queue
(defun astar-heap-add (heap new)
  (let (i)
    (incf (aref heap 0))
    (setq i (aref heap 0))
    (while (and (> i 1) (astar-sort-before new (aref heap (truncate i 2))))
           (setf (aref heap i) (aref heap (truncate i 2)))
           (setq i (truncate i 2)))
    (setf (aref heap i) new)
    heap))

(defun astar-heap-remove (heap)
  (let (themax i)
    (when (plusp (aref heap 0))
      (setq themax (aref heap 1))
      (setf (aref heap 1) (aref heap (aref heap 0)))
      (setf (aref heap (aref heap 0)) nil)
      (decf (aref heap 0))
      (setq i 1)
      (astar-heap-heapify heap 1)
      themax)))

(defun astar-sort-before (citya cityb) (< (estimate citya) (estimate cityb)))


