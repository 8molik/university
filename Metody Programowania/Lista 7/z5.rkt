#lang racket

(define/contract (foldl-map f a xs)
 ;biorę element i akumulator - elem to jest typ elementu i acc - akumulator 
 (parametric->/c [elem acc x] (-> (-> elem acc (cons/c elem acc)) acc (listof elem) (cons/c (listof elem) acc)))
  (define (it a xs ys)
    (if (null? xs)
        (cons (reverse ys) a)
        (let [(p (f (car xs) a))]
          (it (cdr p)
              (cdr xs)
              (cons (car p) ys)))))
  (it a xs null))

(foldl-map (lambda (x a) (cons a (+ a x))) 0 '(1 2 3))