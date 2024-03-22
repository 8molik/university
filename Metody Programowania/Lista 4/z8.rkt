#lang racket

(define-struct ord (val priority) #:transparent)

(define-struct hleaf ())
(define-struct hnode (elem rank l r) #:transparent)

; elementami heap, są ord
;;;
(define (make-node elem heap-a heap-b)
  (let [(rank-a (rank heap-a))
        (rank-b (rank heap-b))]
    (if (>= rank-a rank-b)
        (hnode elem (+ 1 rank-b) heap-a heap-b)
        (hnode elem (+ 1 rank-a) heap-b heap-a))))

; w l-kopcu ranga lewego drzewa jest wieksza równa randze prawego
; ranga to ranga prawego poddrzewa + 1

(define (hord? p h)
  (or (hleaf? h)
      (<= p (ord-priority (hnode-elem h)))))

(define (rank h)
  (if (hleaf? h)
      0
      (hnode-rank h)))

(define (heap? h)
  (or (hleaf? h)
      (and (hnode? h)
           (heap? (hnode-l h))
           (heap? (hnode-r h))
           (<= (rank (hnode-r h))
               (rank (hnode-l h)))
           (= (hnode-rank h) (+ 1 (hnode-rank (hnode-r h))))
           (hord? (ord-priority (hnode-elem h))
                  (hnode-l h))
           (hord? (ord-priority (hnode-elem h))
                  (hnode-r h)))))

(define (heap-merge h1 h2)
  (cond [(hleaf? h1) h2]
        [(hleaf? h2) h1]
        [(< (ord-priority (hnode-elem h1))
            (ord-priority (hnode-elem h2)))
         (make-node (hnode-elem h1)
                    (hnode-l h1)
                    (heap-merge (hnode-r h1) h2))] ; prawe poddrzewo to wynik rekurencyjnego scalania
        [else
         (make-node (hnode-elem h2)
                    (hnode-l h2)
                    (heap-merge h1 (hnode-r h2)))]))

(define heap1
  (make-node (ord 1 10)
             (make-node (ord 2 20)
                        (hleaf)
                        (hleaf))
             (make-node (ord 3 30)
                        (hleaf)
                        (hleaf))))

(define heap2
  (make-node (ord 4 40)
             (make-node (ord 5 50)
                        (hleaf)
                        (hleaf))
             (make-node (ord 6 60)
                        (hleaf)
                        (hleaf))))


(heap-merge heap1 heap2)
         