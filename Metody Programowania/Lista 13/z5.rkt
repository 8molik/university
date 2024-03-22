#lang racket

(require "streams.rkt")

(define (scale n s)
  (stream-cons (* n (stream-car s)) (scale n (stream-cdr s))))

(define (merge s1 s2)
  (cond [(stream-null? s1) s2]
        [(stream-null? s2) s1]
        [(< (stream-car s1) (stream-car s2)) (stream-cons (stream-car s1) (merge (stream-cdr s1) s2))]
        [(= (stream-car s1) (stream-car s2)) (stream-cons (stream-car s1) (merge (stream-cdr s1) (stream-cdr s2)))]
        [(> (stream-car s1) (stream-car s2)) (stream-cons (stream-car s2) (merge s1 (stream-cdr s2)))]))

(define hamming-stream
  (letrec ([s2 (stream-cons 2 (merge (scale 2 s2) (merge (scale 3 s2) (scale 5 s2))))]
           [s3 (stream-cons 3 (merge (scale 2 s3) (merge (scale 3 s3) (scale 5 s3))))]
           [s5 (stream-cons 5 (merge (scale 2 s5) (merge (scale 3 s5) (scale 5 s5))))])
    (merge s2 (merge s3 s5))))

(define hamming
  (stream-cons 1 (merge (scale 2 hamming) (merge (scale 3 hamming) (scale 5 hamming)))))

(stream-ref hamming-stream 0)
(stream-ref hamming-stream 1)
(stream-ref hamming-stream 2)
(stream-ref hamming-stream 30)

(stream-ref hamming 30)