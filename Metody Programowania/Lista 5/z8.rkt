#lang plait

; Typ danych definiujący formuły rachunku zdań
(define-type Prop
  (var [v : String])
  (conj [l : Prop] [r : Prop])
  (disj [l : Prop] [r : Prop])
  (neg [f : Prop]))

(define x (var "x"))
(define y (var "y"))
  
(define (var_fun key dic)
  (some-v (hash-ref dic key)))

(define (neg_fun x)
  (if (equal? x #t) #f #t))

(define (conj_fun x y)
  (cond [(and (equal? x #t) (equal? y #t)) #t]
        [else #f]))

(define (disj_fun x y)
  (cond [(and (equal? x #f) (equal? y #f)) #f]
        [else #t]))

(define (evaluate formula slownik)
  (cond [(var? formula) (var_fun (var-v formula) slownik)]
        [(conj? formula) (conj_fun (evaluate (conj-l formula) slownik)
                                   (evaluate (conj-r formula) slownik))]
        [(disj? formula) (disj_fun (evaluate (disj-l formula) slownik)
                                   (evaluate (disj-r formula) slownik))]
        [(neg? formula) (neg_fun (evaluate (neg-f formula) slownik))]))


(define slownik (make-hash (list (pair "x" #t) (pair "y" #f))))

(define p1 (conj x (neg y))) ;jakas formula
(define p2 (conj x (disj (neg x) y)))

(evaluate p1 slownik)
(evaluate p2 slownik)