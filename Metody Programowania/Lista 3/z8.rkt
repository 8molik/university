#lang racket

;przyjmuje listę xs. Następnie zwraca funkcję, która dodaje listę xs do innej listy x.
(define (list->llist xs)
  (lambda (x) (append xs x)))

;przyjmuje funkcję f i zwraca nową listę po modyfikacji, którą ta funkcja reprezentuje
(define (llist->list f)
  (f '()))
;null to początkowa wartość akumulatora

;zwraca pustą listę, ponieważ nie przyjmuje argumentów, jeżeli takie dostanie zwraca identyczność.
(define (llist-null)
  (lambda (x) (append `() x)))

;funkcja składa się z wywołania funkcji append, która połączy listę (list x) z kolejnym elementem y
(define (llist-singleton x)
  (lambda (y) (append (list x) y)))

;łączy dwie funkcje reprezentujące listy w jedną
(define (llist-append f g)
  (lambda (x) (f (g x))))

;schodzi do końca, aż do nulla, potem łączy elementy od końca w nową listę
(define (foldr-llist-reverse xs)
  (llist->list (foldr (lambda (x y) (llist-append y (llist-singleton x))) (llist-null) xs)))
;y to dotychczasowy wynik

((list->llist `(1 2 3)) '(1 2 3))
((llist->list list->llist) '(1 2 3))
((llist-null) '())
(llist->list (llist-singleton 1))
(llist->list (list->llist (list 1 2 3)))
(foldr-llist-reverse '(1 2 3 4))

;Dzięki zastosowaniu leniwych list oraz funkcji llist-append i llist-singleton
;unikamy tworzenia dużych list tymczasowych,
;co może być kosztowne pod względem pamięciowym i czasowym
