#lang racket

(define (minimum lista)
  (define (helper lista min)
     (cond [(null? lista) min]
           [else
            (if (< (car lista) min)
                (helper (cdr lista) (car lista))
                (helper (cdr lista) min))
           ]
     )
   )
  (helper lista +inf.0)
)

(define (select lista)
  (define min (minimum lista))
    (cons min (remove min lista)))

(define (selection-sort xs)
  (define a (select xs))
  (if (null? (cdr a))
      a
      (cons (car a) (selection-sort (cdr a)))
  )
)

(selection-sort (list 1 2 6 5 -10 0))