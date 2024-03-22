#lang racket

(define (elem? x lista)
  (cond [(null? lista) #f]
        [(= (car lista) x) #t]
        [else (elem? x (rest lista))]))

(elem? 3 (list 1 2 3 6 7))
(elem? 3 (list 1 2 0 -21))
