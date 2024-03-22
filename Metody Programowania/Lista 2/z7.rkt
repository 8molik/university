#lang racket

(define (suffixies lista)
  (define (helper result xs)
    (cond [(null? xs) result]
          [else (helper (cons xs result) (cdr xs))]
    )
  )
  (helper '(()) lista)
)
(suffixies (list 1 2 3))
(suffixies (list))