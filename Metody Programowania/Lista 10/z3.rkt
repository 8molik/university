#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div)
  (eql) ;equal
  (leq)) ;less or equal

(define-type Exp
  (numE [n : Number])
  (boolE [b : Boolean]) ;dodajemy wyrażenie typu Bool
  (opE [op : Op]
       [l : Exp]
       [r : Exp])
  (ifE [b : Exp]
       [l : Exp]
       [r : Exp])
  )


;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    ;dodanie stałych prawdy i fałszu
    [(s-exp-match? `{#t} s)
     (boolE #t)
     ]
    [(s-exp-match? `{#f} s)
     (boolE #f)
     ]
    [(s-exp-match? `{if ANY ANY ANY} s)
     (ifE (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s)))
          (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s))))]
    [else (error 'parse "invalid input")]))



(define (parse-op [op : Symbol]) : Op
  (cond
    [(eq? op '+) (add)]
    [(eq? op '-) (sub)]
    [(eq? op '*) (mul)]
    [(eq? op '/) (div)]
    [(eq? op '=) (eql)]
    [(eq? op '<=) (leq)]
    [else (error 'parse "unknown operator")]))
                
(module+ test
  (test (parse `2)
        (numE 2))
  (test (parse `{+ 2 1})
        (opE (add) (numE 2) (numE 1)))
  (test (parse `{* 3 4})
        (opE (mul) (numE 3) (numE 4)))
  (test (parse `{+ {* 3 4} 8})
        (opE (add)
             (opE (mul) (numE 3) (numE 4))
             (numE 8)))
  (test (parse `{if {= 0 1} {* 3 4} 8})
        (ifE (opE (eql) (numE 0) (numE 1))
             (opE (mul) (numE 3) (numE 4))
             (numE 8)))
   (test/exn (parse `{{+ 1 2}})
            "invalid input")
  (test/exn (parse `{+ 1})
            "invalid input")
  (test/exn (parse `{^ 1 2})
            "unknown operator")
)
  
;; eval --------------------------------------

(define-type Value
  (numV [n : Number])
  (boolV [b : Boolean]))

(define (op-num-num->proc [f : (Number Number -> Number)]) : (Value Value -> Value)
  (λ (v1 v2)
    (type-case Value v1
      [(numV n1)
       (type-case Value v2
         [(numV n2)
          (numV (f n1 n2))]
         [else
          (error 'eval "type error")])]
      [else
       (error 'eval "type error")])))

(define (op-num-bool->proc [f : (Number Number -> Boolean)]) : (Value Value -> Value)
  (λ (v1 v2)
    (type-case Value v1
      [(numV n1)
       (type-case Value v2
         [(numV n2)
          (boolV (f n1 n2))]
         [else
          (error 'eval "type error")])]
      [else
       (error 'eval "type error")])))

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) (op-num-num->proc +)]
    [(sub) (op-num-num->proc -)]
    [(mul) (op-num-num->proc *)]
    [(div) (op-num-num->proc /)]
    [(eql) (op-num-bool->proc =)]
    [(leq) (op-num-bool->proc <=)]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) (numV n)]
    [(opE o l r) ((op->proc o) (eval l) (eval r))]
    [(boolE c) (boolV c)]
    [(ifE b l r)
     (type-case Value (eval b)
       [(boolV v)
        (if v (eval l) (eval r))]
       [else
        (error 'eval "type error")])]))


;==========================================
;Abstract Machine

; NOWY STOS
(define-type Stack
  (emptyS)
  (rightOpS [op : Op] [exp : Exp] [s : Stack])
  (rightIfS [exp1 : Exp] [exp2 : Exp] [s : Stack])
  ; obliczanie wartości if'a
  (leftOpS [op : Op] [val : Value] [s : Stack]))


(define (evalAM [e : Exp] [s : Stack]) : Value
  (type-case Exp e
    [(numE n)
     (continueAM s (numV n))]
    [(boolE b)
     (continueAM s (boolV b))]
    [(ifE c e1 e2)
     (evalAM c (rightIfS e1 e2 s))]
    [(opE o e1 e2)
     (evalAM e1 (rightOpS o e2 s))]))

(define (continueAM [s : Stack] [v : Value]) : Value
  (type-case Stack s
    [(emptyS)
     v]
    [(rightOpS op e s)
     (evalAM e (leftOpS op v s))]
    [(leftOpS op u s)
     (continueAM s ((op->proc op) v u))]
    [(rightIfS e1 e2 s)
     (type-case Value v
       [(boolV c)
        (if c
            (evalAM e1 s)
            (evalAM e2 s))] ;ewaluujemy formuły, które mogą być dowolnych rodzajów
       [else
        (error 'if-eval "type error")])]))


(define (runAM [e : S-Exp]) : Value
  (evalAM (parse e) (emptyS)))


(module+ test
  (test (runAM `2)
        (run `2))
  (test (runAM `{+ 2 1})
        (run `{+ 2 1}))
  (test (runAM `{* 2 1})
        (run `{* 2 1}))
  (test (runAM `{+ {* 2 3} {+ 5 8}})
        (run `{+ {* 2 3} {+ 5 8}}))
  (test (runAM `{= 0 1})
        (run `{= 0 1}))
  (test (runAM `{if {= 0 1} {* 3 4} 8})
        (run `{if {= 0 1} {* 3 4} 8})))



(define (run [e : S-Exp]) : Value
  (eval (parse e)))

(module+ test
  (test (run `2)
        (numV 2))
  (test (run `{+ 2 1})
        (numV 3))
  (test (run `{* 2 1})
        (numV 2))
  (test (run `{+ {* 2 3} {+ 5 8}})
        (numV 19))
  (test (run `{= 0 1})
        (boolV #f))
  (test (run `{if {= 0 1} {* 3 4} 8})
        (numV 8))
)

;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]))

(define (print-value [v : Value]) : Void
  (display (value->string v)))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))
