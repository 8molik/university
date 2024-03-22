#lang racket

(define (suffixes xs)
  (if (null? xs) '()
      (cons xs (suffixes (cdr xs)))))

(time (suffixes (range 1000)) (void))
; czas bez kontraktu cpu time: 0 real time: 0 gc time: 0

(define/contract (suffixes-contract xs)
  (parametric->/c [a] ((listof a) . -> . (listof (listof a)))) ; alternatywnie (-> (listof a) (listof (listof a)))
  (if (null? xs) '()
      (cons xs (suffixes (cdr xs)))))

(time (suffixes-contract (range 1000)) (void))
; czas z kontraktem cpu time: 15 real time: 17 gc time: 15
