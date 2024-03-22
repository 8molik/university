#lang plait

(define-type RacketExpr
  (racket-var [sym : Symbol])
  (racket-number [num : Number])
  (racket-lambda [args : (Listof Symbol)] [body : RacketExpr])
  (racket-app [func : RacketExpr] [args : (Listof RacketExpr)])
  (racket-let [bindings :  (Listof (Symbol * RacketExpr))] [body : RacketExpr])
  (racket-if [condition : RacketExpr] [if-true : RacketExpr] [if-false : RacketExpr])
  (racket-cond [condtition : (Listof (RacketExpr * RacketExpr))] [else : RacketExpr]))

;zamiana na liste s-symboli potem na zwykle symbole
(define (parse-lambda e)
  (let* ((xs (s-exp->list e)))
    (map (lambda (x) (s-exp->symbol x)) xs)))

(define (parse-lambda1 e)
  (cond
    [(not (s-exp-list? e)) (error "Invalid lambda expression")]
    [(not (eq? (first (s-exp->list e)) 'lambda)) (error "Invalid lambda expression")]
    [else
     (let* ([args-list (second (s-exp->list e))]
            [args (map s-exp->symbol args-list)]
            [body-expr (third (s-exp->list e))]
            [body (parse-racket-expr body-expr)])
       (cons args body))]))

    