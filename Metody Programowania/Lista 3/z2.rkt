#lang racket

(require rackunit)

(define (product lista)
  (define (helper lista iloczyn)
    (if (null? lista)
        iloczyn
        (helper (cdr lista) (* (car lista) iloczyn))))
  (helper lista 1))

(define (product2 lista)
  (foldl (lambda (x y) (* x y)) 1 lista))

(define (product3 lst)
  (foldl * 1` lst))
;1 poniewaz to element neutralny mnozenia

(check-equal? (product `(2 2 4)) 16)
(check-equal? (product `()) 1)
(check-equal? (product `(1 2 3 4 5)) 120)

(check-equal? (product2 `(2 2 4)) 16)
(check-equal? (product2 `()) 1)
(check-equal? (product2 `(1 2 3 4 5)) 120)
