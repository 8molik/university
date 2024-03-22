#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add) (sub) (mul) (div) (eql) (leq))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op] [l : Exp] [r : Exp])
  (ifE [b : Exp] [l : Exp] [r : Exp])
  (varE [x : Symbol])
  (letE [x : Symbol] [e1 : Exp] [e2 : Exp])
  (lamE [x : Symbol] [e : Exp])
  (appE [e1 : Exp] [e2 : Exp]))

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{lambda {SYMBOL} ANY} s)
     (lamE (s-exp->symbol
            (first (s-exp->list 
                    (second (s-exp->list s)))))
           (parse (third (s-exp->list s))))]
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (opE (parse-op (s-exp->symbol (first (s-exp->list s))))
          (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s))))]
    [(s-exp-match? `{if ANY ANY ANY} s)
     (ifE (parse (second (s-exp->list s)))
          (parse (third (s-exp->list s)))
          (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `SYMBOL s)
     (varE (s-exp->symbol s))]
    [(s-exp-match? `{let SYMBOL ANY ANY} s)
     (letE (s-exp->symbol (second (s-exp->list s)))
           (parse (third (s-exp->list s)))
           (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `{ANY ANY} s)
     (appE (parse (first (s-exp->list s)))
           (parse (second (s-exp->list s))))]
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

;; eval --------------------------------------

;; values

(define-type Value
  (numV [n : Number])
  (boolV [b : Boolean])
  (funV [e : ExpA] [env : (EnvA Value)])) ; EnvA może przyjąć dowolny typ, tutaj przyjmuje Value
                                          ; usuwamy nazwę zmiennej

;; primitive operations

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


;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]
    [(funV e env) "#<procedure>"]))

(define (print-value [v : Value]) : Void
  (display (value->string v)))

(define (main [e : S-Exp]) : Void
  (print-value (runA e)))


;=======================================================
;; lexical addressing ————————————————————————————————--
;=======================================================
;; target

(define-type ExpA	
  (numA [n : Number])	
  (opA [op : Op] [l : ExpA] [r : ExpA])	
  (ifA [b : ExpA] [l : ExpA] [r : ExpA])	
  (varA [n : Number])	
  (letA [a1 : ExpA] [a2 : ExpA])
  (lamA [a : ExpA])               ; nowe
  (appA [a1 : ExpA] [a2 : ExpA])) ; nowe

;; environments (lists of entities)

(define-type-alias (EnvA 'a) (Listof 'a))

(define mt-envA empty)

(define (extend-envA [env : (EnvA 'a)] [x : 'a]) : (EnvA 'a)
  (cons x env))

(define (lookup-envA [n : Number] [env : (EnvA 'a)]) : 'a
  (list-ref env n))

;; evaluation function

(define (evalA [a : ExpA] [env : (EnvA Value)]) : Value
  (type-case ExpA a
    [(numA n)
     (numV n)]
    [(opA o l r)
     ((op->proc o) (evalA l env) (evalA r env))]
    [(ifA b l r)
     (type-case Value (evalA b env)
       [(boolV v)
        (if v (evalA l env) (evalA r env))]
       [else
        (error 'eval "type error")])]
    [(varA n)
     (lookup-envA n env)]
    [(letA e1 e2)                          ;
     (let ([v (evalA e1 env)])             ;
       (evalA e2 (extend-envA env v)))]    ; rozszerzamy środowisko o wiązania leta i ewaluujemy ciało leta
    [(lamA a)                              ;
     (funV a env)]                         ;
    [(appA a1 a2)
     (apply (evalA a1 env) (evalA a2 env))]))

(define (apply [v1 : Value] [v2 : Value]) : Value
  (type-case Value v1
    [(funV b env)                          ; znika nazwa zmiennej
     (evalA b (extend-envA env v2))]       ;
    [else (error 'apply "not a function")]))

(define (runA [s : S-Exp]) : Value
  (evalA (translate (parse s) mt-envA) mt-envA))

;; translation function

(define (address-of [x : Symbol] [env : (EnvA Symbol)]) : Number
  (type-case (EnvA Symbol) env
    [empty
     (error 'address-of "unbound variable")]
    [(cons y rst-env)
     (if (eq? x y)
         0
         (+ 1 (address-of x rst-env)))]))

(define (translate [e : Exp] [env : (EnvA Symbol)]) : ExpA
  (type-case Exp e
    [(numE n)
     (numA n)]
    [(opE o l r)
     (opA o (translate l env) (translate r env))]
    [(ifE b l r)
     (ifA (translate b env)
          (translate l env)
          (translate r env))]
    [(varE x)
     (varA (address-of x env))]
    [(letE x e1 e2)
     (letA (translate e1 env)
           (translate e2 (extend-envA env x)))]
    [(lamE x b)
     (lamA (translate b (extend-envA env x)))] ; tłumaczę wyrażenie b, rozszerzam środowisko o zmienną x
    [(appE e1 e2)
     (appA (translate e1 env)
           (translate e2 env))]))

(translate (parse `(lambda {x} (let y (* x x) (+ x y)))) mt-envA)



; (lambda {x} (let y (* x x) (+ x y)))
; sparsuje się do:
; (lamA (letA (opA (mul) (varA 0) (varA 0))
;             (opA (add) (varA 0) (varA 1))))


; Dzięki temu, przy ocenie wyrażeń, możemy odwoływać się do odpowiednich wartości zmiennych poprzez ich indeksy w środowisku.
; Dzięki reprezentacji z indeksami, środowisko jest zachowywane jako lista wartości zmiennych,
; a indeksy wewnątrz funkcji odnoszą się do odpowiednich pozycji w tej liście.
; W ten sposób, nawet jeśli funkcja jest wywoływana w innym kontekście, nadal ma dostęp do swojego oryginalnego środowiska.
