#lang racket

(require rackunit)

(define (square x) (* x x))

(define (square-sum a b c)
(cond [(and (> a c) (> b c)) (+ (square a) (square b))]
      [(and (> c b) (> a b)) (+ (square c) (square a))]
      [(and (> b a) (> c a)) (+ (square b) (square c))]
      [else -1]))

(check-equal? (square-sum 2 2 4) 25)
(check-equal? (square-sum 2 3 4) 25)
(check-equal? (square-sum 4 5 -11) 41)
(check-equal? (square-sum 0.00000000001 0.00000000004 -0.000000000007) (+ (square 0.00000000001) (square 0.00000000004)))
;(check-true (number? (square-sum 1 2 "a")))
