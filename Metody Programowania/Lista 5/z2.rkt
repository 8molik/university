#lang plait

(define (apply f x) (f x))
(define (compose f g) (lambda (x) (f (g x))))
(define (flip f) (lambda (x y) (f y x)))
(define (curry f) (lambda (x) (lambda (y) (f x y))))
