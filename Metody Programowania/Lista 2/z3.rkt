#lang racket

(define-struct matrix (a b c d))

(define (display-matrix m)
  (display (matrix-a m))
  (display " ")
  (display (matrix-b m))
  (newline)
  (display (matrix-c m))
  (display " ")
  (display (matrix-d m))
  (newline))

; Schemat mnożenia
; [a b] * [e f] = [a*e + b*g, a*f + b*h]
; [c d]   [g h]   [c*e + d*g, c*f + d*h]

(define (matrix-mult m n)
  (define a (matrix-a m))
  (define b (matrix-b m))
  (define c (matrix-c m))
  (define d (matrix-d m))
  (define e (matrix-a n))
  (define f (matrix-b n))
  (define g (matrix-c n))
  (define h (matrix-d n))
  (make-matrix (+ (* a e) (* b g))
               (+ (* a f) (* b h))
               (+ (* c e) (* d g))
               (+ (* c f) (* d h))))

(define matrix-id
  (make-matrix 1 0 0 1))

(define (matrix-expt m k)
  (if (= k 0)
      1
      (if (= k 1)
           m
          (matrix-mult m (matrix-expt m (- k 1))))))

; Zwraca 2 element 1 wiersza matrycy zgodnie ze wzorem
(define (fib-matrix k)
  (matrix-b (matrix-expt (make-matrix 1 1 1 0) k)))

; Przykładowe wywołanie
(define m (make-matrix 1 3 2 0))
(define n (make-matrix 2 4 4 5))

(display-matrix matrix-id)

(display-matrix (matrix-mult m n))
(display-matrix (matrix-expt m 2))

(fib-matrix 9)