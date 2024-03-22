#lang racket

(require "streams.rkt")


(define (partial-sums s)
  (stream-cons (stream-car s) (map2 + (partial-sums s) (stream-cdr s))))

(define p (partial-sums (integers-from 0)))

(stream-car (stream-cdr (stream-cdr (stream-cdr (partial-sums p))))) ;10