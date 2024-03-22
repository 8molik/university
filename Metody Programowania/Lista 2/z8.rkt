#lang racket

(define (sorted? lista)
  (cond [(null? lista) #f]
        [(null? (cdr lista)) #t]
        [else (and (<= (car lista) (car (cdr lista)))
              (sorted? (cdr lista)))]))

(sorted? (list 1 2 3 4 5))
(sorted? (list 1 1 1 1 1))
(sorted? (list))
(sorted? (list 2 5 6 3))
(sorted? (list 1 2 -1 5 6))