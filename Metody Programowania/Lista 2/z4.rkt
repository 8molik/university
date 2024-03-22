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

(define matrix-id
  (make-matrix 1 0 0 1))

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

(define (matrix-expt-fast m k)
  (cond [(= k 0) matrix-id]
        [(= (modulo k 2) 0) (matrix-expt-fast (matrix-mult m m) (/ k 2))]
        [else (matrix-mult m (matrix-expt-fast (matrix-mult m m) (/ (- k 1) 2)))]
  ))

(define (fib-matrix k)
  (matrix-b (matrix-expt-fast (make-matrix 1 1 1 0) k)))

(fib-matrix 1)