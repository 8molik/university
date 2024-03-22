#lang plait

(define-type (NNF 'v)
  (nnf-lit [polarity : Boolean] [var : 'v])
  (nnf-conj [l : (NNF 'v)] [r : (NNF 'v)])
  (nnf-disj [l : (NNF 'v)] [r : (NNF 'v)]))

(define-type (Formula 'v)
  (var [var : 'v])
  (neg [f : (Formula 'v)])
  (conj [l : (Formula 'v)] [r : (Formula 'v)])
  (disj [l : (Formula 'v)] [r : (Formula 'v)]))

(define (neg-nnf x)
  (cond [(nnf-lit? x)
         (if (nnf-lit-polarity x) ;(equal? (nnf-lit-polarity x) #t)
             (nnf-lit #f (nnf-lit-var x))
             (nnf-lit #t (nnf-lit-var x)))]
        [(nnf-conj? x) (nnf-disj (neg-nnf (nnf-conj-l x))
                                 (neg-nnf (nnf-conj-r x)))]
        [(nnf-disj? x) (nnf-conj (neg-nnf (nnf-disj-l x))
                                 (neg-nnf (nnf-disj-r x)))]))

(define (to-nnf x)
  (cond [(var? x) (nnf-lit #t (var-var x))]
        [(conj? x) (nnf-conj (to-nnf (conj-l x))
                             (to-nnf (conj-r x)))]
        [(disj? x) (nnf-disj (to-nnf (disj-l x))
                             (to-nnf (disj-r x)))]
        [else (neg-nnf (to-nnf (neg-f x)))])) ;rekurencyjnie wywołujemy się na formule

(define formula (neg (conj (neg (var 'x)) (var 'y))))
(to-nnf formula)