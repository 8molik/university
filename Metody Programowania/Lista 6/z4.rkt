#lang plait

(define-type (NNF 'v)
  (nnf-lit [polarity : Boolean] [var : 'v])
  (nnf-conj [l : (NNF 'v)] [r : (NNF 'v)])
  (nnf-disj [l : (NNF 'v)] [r : (NNF 'v)]))

(define (neg-nnf x)
  (cond [(nnf-lit? x)
         (if (nnf-lit-polarity x) ;(equal? (nnf-lit-polarity x) #t)
             (nnf-lit #f (nnf-lit-var x))
             (nnf-lit #t (nnf-lit-var x)))]
        [(nnf-conj? x) (nnf-disj (neg-nnf (nnf-conj-l x))
                                 (neg-nnf (nnf-conj-r x)))]
        [(nnf-disj? x) (nnf-conj (neg-nnf (nnf-disj-l x))
                                 (neg-nnf (nnf-disj-r x)))]))

;(define (neg x)
;  (cond [(nnf-lit? x) (if (x-polarity #t) (pair #f x) (pair #t x))]
;        [(nnf-conj? x) (neg (nnf-conj-l))
;                       (neg (nnf-conj-r))]
;        [(nnf-disj? x) (neg (nnf-disj-l))
;                       (neg (nnf-disj-r))]))

(neg-nnf (nnf-disj (nnf-lit #t 'p) (nnf-conj (nnf-lit #f 'q) (nnf-lit #t 'r))))

