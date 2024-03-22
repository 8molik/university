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

 (define (flat-append t xs)
    (cond [(leaf? t) xs]
          [(node? t)
           (flat-append (node-l t)
                        (cons (node-elem t)
                              (flat-append (node-r t) xs)))]))

(define (flatten-tree t)
  (flat-append t '()))

;(flatten-tree t1)


