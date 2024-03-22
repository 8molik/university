#lang racket

(define (append-map f xs)
  (if (empty? xs)
      '()
      (append (f (first xs)) (append-map f (rest xs)))))
                              
;jeżeli pusta zwracamy pustą listę
;w przeciwnym wypadku nakładam funkcję na 1 element
;i wywoluje sie rekurencyjnie na ogonie

(define (remove x xs)
  (cond [(empty? xs) '()]
        [(equal? x (first xs)) (rest xs)]
        [else (cons (first xs) (remove x (rest xs)))]))

(define (perms xs)
  (if (empty? xs)
      '(())
      (append-map (lambda (x) (map (lambda (p) (cons x p))
                                   (perms (remove x xs))))
                  xs)))

(define (remove-duplicates xs)
  (cond [(empty? xs) empty]
        [(member (first xs) (rest xs)) (remove-duplicates (rest xs))]
        [else (cons (first xs) (remove-duplicates (rest xs)))]))

(remove-duplicates (perms '(1 3 3)))

