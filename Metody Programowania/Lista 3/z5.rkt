#lang racket

(define (negatives n)
  (build-list n (lambda (x) (- -1 x))))

(define (reciprocals n)
  (build-list n (lambda (x) (/ 1 (add1 x)))))

(define (evens n)
  (build-list n (lambda (x) (* x 2))))

(define (identityM n)
  (build-list n (lambda (x) (build-list n (lambda (y) (if (= x y) 1 0))))))

(negatives 6)
(reciprocals 6)
(evens 6)
(identityM 3)