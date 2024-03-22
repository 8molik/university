#lang racket

(require "streams.rkt")

(define fact-stream
  (stream-cons 1 (map2 * (integers-from 1) fact-stream)))

(stream-car  (stream-cdr (stream-cdr (stream-cdr (stream-cdr (stream-cdr fact-stream))))))

(define fib
  (stream-cons 0 (stream-cons 1 
    (map2 + fib (stream-cdr fib)))))

(stream-ref fib 10)
