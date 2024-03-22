#lang racket

(define xs (mcons 1 (mcons 2 (mcons 3 null))))

(define (mreverse! xs)
  (let loop ((current xs) (prev null))
    (cond [(null? current) prev]
          [else (let ((next (mcdr current)))
                  (set-mcdr! current prev)
                  (loop next current))])))
(mreverse! xs)

