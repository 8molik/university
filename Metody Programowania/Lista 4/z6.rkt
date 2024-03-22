#lang racket

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

(define t
  (node
    (node (leaf) 2 (leaf))
    5
    (node (node (leaf) 6 (leaf))
          8
          (node (leaf) 9 (leaf)))))

(define (find-successor tree)
  (if (leaf? (node-l tree))
      tree
      (find-successor (node-l tree))))

(define (delete val tree)
  (cond [(leaf? tree) tree]
        [(< val (node-elem tree))
         (node (delete val (node-l tree))
               (node-elem tree)
               (node-r tree))]
        [(> val (node-elem tree))
         (node (node-l tree)
               (node-elem tree)
               (delete val (node-r tree)))]
        [(= val (node-elem tree))
         (cond [(leaf? (node-l tree)) (node-r tree)] ; jeżeli lewe poddrzewo to liść, zwracamy prawe
               [(leaf? (node-r tree)) (node-l tree)]
               [else (let* [(successor (find-successor (node-r tree))) ; szukamy poprzednika w prawym poddrzewie
                            (new-right (delete (node-elem successor) (node-r tree)))]
          (node (node-l tree) (node-elem successor) new-right))])]))

(delete 5 t)
         
  