#lang plait

;(struct leaf () #:transparent)
;(struct node2 (elem l r) #:transparent)
;(struct node3 (elem1 elem2 l mid r) #:transparent)

(define-type (2-3-tree 'a)
  (leaf)
  (node2 [elem : 'a] [l : (2-3-tree 'a)] [r : (2-3-tree 'a)])
  (node3 [elem1 : 'a] [elem2 : 'a] [l : (2-3-tree 'a)] [mid : (2-3-tree 'a)] [r : (2-3-tree 'a)]))

(define (tree-height t)
  (cond [(leaf? t) 0]
        [(node2? t)
         (max (+ 1 (tree-height (node2-l t)))
              (+ 1 (tree-height (node2-r t))))]
        [(node3? t)
         (max (+ 1 (tree-height (node3-l t)))
         (max (+ 1 (tree-height (node3-mid t)))
              (+ 1 (tree-height (node3-r t)))))]))

(define (balanced? t)
  (cond
    ;sam liść jest zbalansowany
    [(leaf? t) #t]
    ;jeżeli główny węzeł jest zbalansowany oraz wszystkie podwęzły
    [(node2? t) (and (= (tree-height (node2-l t)) (tree-height (node2-r t)))
                     (balanced? (node2-l t))
                     (balanced? (node2-r t)))]
    ;jeżeli główny węzeł jest zbalansowany oraz wszystkie podwęzły
    [(node3? t) (and (= (tree-height (node3-l t)) (tree-height (node3-mid t))) (= (tree-height (node3-r t)) (tree-height (node3-mid t)))
                     (balanced? (node3-l t))
                     (balanced? (node3-mid t))
                     (balanced? (node3-r t)))]
    [else #f]))

(define (ordered? t top bot)
  (cond [(leaf? t) #t]
        [(node2? t)
         (and (> (node2-elem t) bot)
              (< (node2-elem t) top)
              (ordered? (node2-l t) (node2-elem t) bot)
              (ordered? (node2-r t) top (node2-elem t)))]
        [(node3? t)
         (and (> (node3-elem1 t) bot)
              (< (node3-elem1 t) top)
              (> (node3-elem2 t) bot)
              (< (node3-elem2 t) top)
              (< (node3-elem1 t) (node3-elem2 t))
              (ordered? (node3-l t) (node3-elem1 t) bot)
              (ordered? (node3-r t) top (node3-elem2 t))
              (ordered? (node3-mid t) (node3-elem1 t) (node3-elem2 t)))]
        [else #f]))
              
(define testowe 
  (node2 5
         (node3 2 4
                (leaf) (leaf) (leaf))
         (node2 7
                (leaf) (node2 2 (leaf) (leaf)))))

(define t2
  (node2 5 (node3 2 4 (leaf) (leaf) (leaf)) (node2 7 (leaf) (leaf))))

;(tree-height testowe)
;(balanced testowe +inf.0 -inf.0
