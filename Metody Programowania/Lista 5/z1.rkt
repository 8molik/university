#lang plait

(define (f1 a b) a)

(define (f2 [f : ('a 'b -> 'c)] [g : ('a -> 'b)] x)
  (f x (g x)))
  
(define (f3 [f : (('a -> 'a) -> 'a)])
  (f (lambda (x) x)))

(define (f4 [f :('a -> 'b)] [g : ('a -> 'c)])
  (lambda (x) (pair (f x) (g x))))

(define (f5 [f : ('a -> (Optionof ('a * 'b)))] [a : 'a]) 
    (list (snd (some-v (f a)))))

;Inne wersje
;Analogia do naturalnej dedukcji
;(('a 'b -> 'c) ('a -> 'b) 'a -> 'c)
;
; e: (a i b => c)
; f: (a => b)
; g: a
;               Zał: a  Zał: a => b  Zał: a
; ((a i b)=> c) a       b

(define (f2_2 e f g)
  (e g (f g)))

(define (f3_2 f)
  (f (lambda (x) (f (lambda (x) x)))))

(define (f4_2 f g)
  (lambda (x) (pair (f x) (g x))))