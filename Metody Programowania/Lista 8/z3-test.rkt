#lang racket

(require "z3.rkt")

(define q (new-dequeue))
(dequeue-push-back q 2137)
(dequeue-push-back q 213)
(dequeue-push-back q 21)
(dequeue-push-back q 2)