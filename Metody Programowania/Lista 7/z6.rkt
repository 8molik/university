;#lang racket

;(( 'a 'b - > 'b) 'b ( Listof 'a) -> 'b)

#;(define (fold-right f acc xs)
  (if (empty? xs)
      acc
      (f (first xs) (fold-right f (first xs) (rest xs)))))

;Zamieniam b na a
#;(define/contract (fold-right f acc xs)
  ;( parametric->/c [a b] (-> (-> a b b) b ( listof a) b))
  ( parametric->/c [a] (-> (-> a a a) a ( listof a) a))
  (if (empty? xs)
      acc
      (f (first xs) (fold-right f (first xs) (rest xs)))))

;_a istnieje taki typ spełniający
; a dla każdego



;(fold-right cons '() (list 1 2 3))



;RACKET
;(fold-right cons '() (list 1 2 3))
;(foldr cons '() (list 1 2 3))
;dla procedury cons wynik nie jest taki sam

;PLAIT
;tu zmieniono typowanie
#lang plait 
(define (fold-right f acc xs)
  (if (empty? xs)
      acc
      (f (first xs) (fold-right f (first xs) (rest xs)))))


(define (create-pair x y)
  (pair x y))

(define my-list (list 1 2 3 4 5))

;(define pairs (fold-right create-pair (list) my-list))
(define ap (fold-right + 1 my-list))

;(fold-right cons (list (list 1) (list (list 1 2 3)))


;(( ' a 'a - > 'a) 'a ( Listof 'a) -> 'a)
; zmiana typu powoduje błąd, ponieważ funkcja f musiałaby być, taką która bierze
; 'a i 'a oraz zwraca 'a, ograniczamy się tylko do tego typu

