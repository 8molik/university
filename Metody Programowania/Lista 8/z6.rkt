#lang plait

(define-type RacketExpr
  (racket-var [sym : Symbol]) ;zmienna
  (racket-number [num : Number]) ;numer
  (racket-lambda [args : (Listof Symbol)] [body : RacketExpr]) ;lista argumentów, ciało funkcji
  (racket-app [func : RacketExpr] [args : (Listof RacketExpr)]) ;funkcja na liście argumentów
  (racket-let [bindings :  (Listof (Symbol * RacketExpr))] [body : RacketExpr]) ;lista definicji w let, ciało let'a
  (racket-if [condition : RacketExpr] [if-true : RacketExpr] [if-false : RacketExpr]) ;warunek, jezeli prawda, wpp.
  (racket-cond [condtition : (Listof (RacketExpr * RacketExpr))] [else : RacketExpr])) ;lista wrunków i else
