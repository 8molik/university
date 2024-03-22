#lang plait

(define-type (RoseTree 'a)
  (leaf [elem : 'a])
  (node [children : (Listof (RoseTree 'a))]))


(define example-rose
  (node (list (leaf 1)
              (node (list (leaf 2)
                          (leaf 3)))
              (leaf 4)
              (node (list (node (list (leaf 5)
                                      (leaf 6))))))))

(define (append-map f xs)
  (if (empty? xs)
      '()
      (append (f (first xs)) (append-map f (rest xs)))))

(define (rose-traversal r)
  (cond [(leaf? r) (list (leaf-elem r))]
        [else (append-map rose-traversal (node-children r))]))

(rose-traversal example-rose)


