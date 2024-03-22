#lang plait

; Typ danych definiujący formuły rachunku zdań
(define-type Prop
  (var [v : String])
  (conj [l : Prop] [r : Prop])
  (disj [l : Prop] [r : Prop])
  (neg [f : Prop]))

(define (free-vars formula)
  (cond [(var? formula) (list (var-v formula))]
        [(conj? formula) (append (free-vars (conj-l formula))
                                 (free-vars (conj-r formula)))]
        [(disj? formula) (append (free-vars (disj-l formula))
                                 (free-vars (disj-r formula)))]
        [(neg? formula) (free-vars (neg-f formula))]
        [else '()]))

(free-vars (var "p"))
(free-vars (conj (var "p") (neg (var "p"))))