#lang racket

(require "streams.rkt")

(define (prime? n s)
  (cond [(stream-null? s) #t]
        [(divides? (stream-car s) n) #f]
        [else (prime? n (stream-cdr s))]))

(define (prime-stream n s)
  (if (prime? n s)
      (stream-cons n (prime-stream (+ n 1) (stream-cons n s)))
      (prime-stream (+ n 1) s)))
                   

(define p (prime-stream 2 stream-null))

(stream-ref p 0) ; 2
(stream-ref p 1) ; 3
(stream-ref p 2) ; 5
(stream-ref p 3) ; 7
(stream-ref p 4) ; 11
(stream-ref p 42) ; 191

