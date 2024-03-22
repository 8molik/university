#lang racket

(require "z4.rkt")

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

(define t
  (node
    (node (leaf) 2 (leaf))
    5
    (node (node (leaf) 6 (leaf))
          8
          (node (leaf) 9 (leaf)))))

 (define (flat-append t xs)
    (cond [(leaf? t) xs]
          [(node? t)
           (flat-append (node-l t)
                        (cons (node-elem t)
                              (flat-append (node-r t) xs)))]))

(define (flatten-tree t)
  (flat-append t '()))

; usunąłem warunek w cond
(define (insert-bst x t)
  (cond [(leaf? t) (node (leaf) x (leaf))]
        [(node? t)
         (cond [(< x (node-elem t))
                 (node (insert-bst x (node-l t))
                       (node-elem t)
                       (node-r t))]
                [else
                 (node (node-l t)
                       (node-elem t)
                       (insert-bst x (node-r t)))])]))

(define (tree-sort xs)
  (define (helper xs t)
    (cond [(null? xs) t]
          [else
           (helper (cdr xs) (insert-bst (car xs) t))]))
  (flatten-tree (helper xs (leaf))))

(tree-sort '(3 2 12 34 5 3))

