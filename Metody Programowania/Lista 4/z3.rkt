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

(define (bst->list t)
  (define (helper t acc)
    (if (leaf? t)
        acc
        (cons (helper (node-l t) acc)
              (cons (node-elem t) (helper (node-r t) acc)))))
  (helper t '()))


#;(define (bst? t)
  (define (helper t min max)
    (cond [(leaf? t) #t]
          [(or (< (node-elem t) min) (> (node-elem t) max)) #f]
          [else
           (and (helper (node-l t) min (node-elem t))
                (helper (node-r t) (node-elem t) max))]))
  (helper t -inf.0 +inf.0))


#;(define (sum-paths t)
  (define (helper t acc)
    (cond [(leaf? t) t]
          [(node? t)
           (node (helper (node-l t) (+ acc (node-elem t)))
                 (+ acc (node-elem t))
                 (helper (node-r t) (+ acc (node-elem t))))]))
  (helper t 0))

