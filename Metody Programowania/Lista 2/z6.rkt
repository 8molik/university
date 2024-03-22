#lang racket

(require rackunit)

(define (maximum lista)
  (define (helper lista max)
    (cond [(null? lista) max]
          [else
           (if (> (car lista) max)
               (helper (rest lista) (car lista))
               (helper (rest lista) max))
          ]
     )
   )
  (helper lista -inf.0)
)

(maximum (list 123 23 23 12 0 -12 2137))
(maximum (list))
(maximum (list -10 -14 -23 -1))