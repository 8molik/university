#lang racket

((lambda (x y) (+ x (* x y))) 1 2)

; (lambda (1 2) (+ 1 (* 1 2)))
; -> (+ 1 (* 1 2))
; -> (+ 1 2)
; -> 3

((lambda (x) x) (lambda (x) x))

; ((lambda (x) x) (lambda (x) x))
; -> ((lambda (x) x) x)
; -> (lambda (x) x) funkcja identycznościowa

((lambda (x) (x x)) (lambda (x) x))

; ((lambda (x) (x x)) (lambda (x) x))
; -> ((lambda (x) (x x)) x)
; -> (lambda (x) (x x))

((lambda (x) (x x)) (lambda (x) (x x)))

; nieskończona rekurencja i błąd, tak samo w 3