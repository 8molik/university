#lang racket

(define (new-if ifCond ifTrue ifFalse)
  (or (and ifCond ifTrue) (and (not ifCond) ifFalse)))

(define (new-if.2 ifCond ifTrue ifFalse)
  (or (and ifCond ifTrue) ifFalse))
  
;and jezeli oba są spełnione zwraca ostatnią wartość
(new-if.2 (> 1 0) 23 34)
(new-if (> -1 0) 23 34)