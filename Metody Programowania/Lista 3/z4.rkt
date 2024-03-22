#lang racket

(define (my-compose f g)
  (lambda (x) (f (g x))))

((my-compose sqr add1) 5)

; ((lambda (x) (sqr (add1 x)) 5)
; (sqr (add1 5)
; (sqr 6)
; 36

((my-compose add1 sqr) 5)

; ((lambda (x) (add1 (sqr x)) 5)
; (add1 (sqr 5)
; (add1 25)
; 26
