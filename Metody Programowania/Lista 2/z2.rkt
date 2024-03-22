#lang racket

(define (fib n)
  (cond [(= n 0) 0]
        [(= n 1) 1]
        [else (+ (fib (- n 1)) (fib (- n 2)))]))

;szybsza
(define (fib-iter n)
  (define (it n a b)
    (if (= n 0)
        a ;a = 0, b = 1
        (it (- n 1) b (+ b a))))
     (it n 0 1))

        
; (fib 4) -> (fib 3) + (fib 2)
; -> [(fib 2) + (fib 1)] + [(fib 1) + (fib 0)]
; -> [(fib 1) + (fib 0)] + 1 + 1 + 0
; -> 1 + 0 + 2 = 3

; (fib-iter 4) (it 0 1)
; -> (fib-iter 3) (it 1 1)
; -> (fib-iter 2) (it 1 2)
; -> (fib-iter 1) (it 2 3)
; -> (fib-iter 0) (it 3 5) -> zwraca 3

(fib 1)
(fib 8)
(fib 10)
(fib-iter 2)
(fib-iter 5)
(fib-iter 10)

  