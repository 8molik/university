#lang racket
(list (list 'car (cons 'a  'b)) (list '* 2) )

(list ',(car '(a . b)) ',(* 2) )

(list (list '+ 1 2 3) (list 'cons) (list 'cons 'a 'b))

` (,(car '(a . b)) ,(* 2))
