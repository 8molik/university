#lang plait

(define-type (NNF 'v)
  (nnf-lit [polarity : Boolean] [var : 'v])
  (nnf-conj [l : (NNF 'v)] [r : (NNF 'v)])
  (nnf-disj [l : (NNF 'v)] [r : (NNF 'v)]))

(define (neg-nnf x)
  (cond [(nnf-lit? x) (if (nnf-lit-polarity x)
                          (nnf-lit #f (nnf-lit-var x))
                          (nnf-lit #t (nnf-lit-var x)))]
        [(nnf-conj? x) (nnf-disj (neg-nnf (nnf-conj-l x))
                                 (neg-nnf (nnf-conj-r x)))]
        [(nnf-disj? x) (nnf-conj (neg-nnf (nnf-disj-l x))
                                 (neg-nnf (nnf-disj-r x)))]))

(define (eval-nnf sigma x)
  (cond [(nnf-lit? x) (if (nnf-lit-polarity x)
                      (sigma (nnf-lit-var x))
                      (not (sigma (nnf-lit-var x))))]
        [(nnf-conj? x) (and (eval-nnf sigma (nnf-conj-l x))
                            (eval-nnf sigma (nnf-conj-r x)))]
        [(nnf-disj? x) (or (eval-nnf sigma (nnf-disj-l x))
                           (eval-nnf sigma (nnf-disj-r x)))]))

(define sigma
  (lambda (x) (cond [(eq? x 'a) #t]
                    [(eq? x 'b) #f]
                    [(eq? x 'c) #t]
                    [(eq? x 'd) #f])))

;jeżeli jest fałsz to negujemy zmienną
(define phi1 (nnf-lit #f 'a))
(define phi11 (neg-nnf (nnf-lit #t 'a)))
(define phi2 (nnf-lit #f 'b))
(define phi3 (nnf-conj (nnf-lit #t 'c) (nnf-lit #f 'd)))
(define phi4 (nnf-disj (nnf-lit #f 'c) (nnf-lit #t 'd)))
(define phi5 (nnf-disj (nnf-conj (nnf-lit #t 'a) (nnf-lit #f 'b)) (nnf-lit #t 'c)))
(define phi6 (nnf-conj (nnf-disj (nnf-lit #t 'a) (nnf-lit #f 'b)) (nnf-lit #f 'c)))

(equal? (eval-nnf sigma phi1) (eval-nnf sigma phi11))
(equal? (eval-nnf sigma phi3) #f)
(equal? (eval-nnf sigma phi4) #t)
(equal? (eval-nnf sigma phi5) #t)
(equal? (eval-nnf sigma phi6) #f)