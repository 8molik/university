#lang racket

(define xs (mcons 1 (mcons 2 (mcons 3 null))))

(define (cycle! xs)
  (let loop ((head xs))
    (cond [(null? head) '()]
          [(null? (mcdr head)) (set-mcdr! head xs)]
          [else (loop (mcdr head))])))
