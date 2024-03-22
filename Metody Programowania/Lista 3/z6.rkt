#lang racket

(require rackunit)

(define empty-set?
  (lambda (x) #f))

(define (singleton a)
  (lambda (x) (equal? x a)))

; (in a s): (lambda (x) (ormap (lambda (y) (equal? x y)) s)))

(define (in a s)
  (s a))

(define (funkcja x)
  (if (> x 5)
      #t
      #f))

(define (union s t)
  (lambda (x) (or (s x) (t x))))

(define (intersect s t)
  (lambda (x) (and (in x s) (in x t))))

(empty-set? `())
((singleton 1) 1)
(in 3 funkcja)
((union (singleton 1) (singleton 2)) 5)
((intersect (singleton 1) (singleton 1)) 1)