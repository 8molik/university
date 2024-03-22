#lang plait

(define-type (Formula 'v)
  (var [var : 'v])
  (neg [f : (Formula 'v)])
  (conj [l : (Formula 'v)] [r : (Formula 'v)])
  (disj [l : (Formula 'v)] [r : (Formula 'v)]))

(define sigma
  (lambda (x) (cond [(eq? x 'a) #t]
                    [(eq? x 'b) #f]
                    [(eq? x 'c) #t]
                    [(eq? x 'd) #f])))

;(define (eval-nnf sigma x)
;  (cond
;    [(nnf-lit? x) (if (nnf-lit-polarity x)
;                      (sigma (nnf-lit-var x))
;                      (not (sigma (nnf-lit-var x))))]
;    [(nnf-conj? x) (and (eval-nnf sigma (nnf-conj-l x))
;                        (eval-nnf sigma (nnf-conj-r x)))]
;    [(nnf-disj? x) (or (eval-nnf sigma (nnf-disj-l x))
;                       (eval-nnf sigma (nnf-disj-r x)))]))
;(define (eval-formula x)
;  (eval-nnf sigma (to-nnf x)))

(define (eval-formula sigma x)
  (cond [(var? x) (sigma (var-var x))]
        [(conj? x) (and (eval-formula sigma (conj-l x))
                        (eval-formula sigma (conj-r x)))]
        [(disj? x) (or (eval-formula sigma (disj-l x))
                       (eval-formula sigma (disj-r x)))]
        [(neg? x) (not (eval-formula sigma (neg-f x)))]))

;(eval-formula sigma (neg x))
;(not (eval-formula sigma (neg-f x)

(define f1 (neg (conj (neg (var 'a)) (var 'b))))

; ~(~#t i #f) = #t
(eval-formula sigma f1)