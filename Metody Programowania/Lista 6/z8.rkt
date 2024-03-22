#lang plait

(define (sorted? xs)
  (cond [(empty? xs) #t]
        [(empty? (rest xs)) #t]
        [else (if (<= (first xs) (second xs))
                  (sorted? (rest xs))
                   #f)]))

(define (insert x xs)
  (cond [(empty? xs) (list x)]
        [else (if (< x (first xs))
                  (cons x xs)
                  (cons (first xs) (insert x (rest xs))))]))

(sorted? '()) ; => #t
(sorted? '(1 2 3 4 5)) ; => #t
(sorted? '(1 2 3 5 4)) ; => #f
(sorted? '(5 4 3 2 1)) ; => #f

(define lista (list 1 2 3 4))
(insert 2 lista)


