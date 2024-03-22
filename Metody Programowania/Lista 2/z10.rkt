#lang racket

(define lista_1 (list 7 2 2 3 5 5))

(define (split xs)
  (define index (floor(/(length xs) 2)))
  (cons (take xs index) (drop xs index)))


(define (merge list_1 list_2)
  (cond [(null? list_1) (append list_1 list_2)]
        [(null? list_2) (append list_1 list_2)]
        [(<= (car list_1) (car list_2))
         (cons (car list_1) (merge (cdr list_1) list_2))]
        [(> (car list_1) (car list_2))
         (cons (car list_2) (merge list_1 (cdr list_2)))]))

(define (merge-sort xs)
  (cond [(null? xs) xs]
        [(null? (cdr xs)) xs]
        [else (merge (merge-sort (car (split xs)))
              (merge-sort (cdr (split xs))))]))

(merge-sort (list 2 1 3 7 -10))