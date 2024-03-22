#lang racket

(define (foldr-reverse xs)
   (foldr (lambda (y ys) (append ys (list y))) null xs))

(length (foldr-reverse (build-list 10000 identity)))

;powstaje 10000 consów, z czego 9999 to nieużytki,
;za każdym razem append tworzy nową listę
