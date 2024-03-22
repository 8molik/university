#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Exp
  (numE [n : Number])
  (ifE [b : Exp] [l : Exp] [r : Exp])
  (varE [x : Symbol])
  (letE [x : Symbol] [e1 : Exp] [e2 : Exp])
  (lamE [x : Symbol] [e : Exp])
  (appE [e1 : Exp] [e2 : Exp])
  (recE [f : Symbol] [x : Symbol] [e : Exp])) ; nowe - dodajemy funkcję rekurencyjną

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
    [(s-exp-match? `{rec SYMBOL {SYMBOL} ANY} s) ; parsowanie rec
     (recE (s-exp->symbol (second (s-exp->list s)))
           (s-exp->symbol (first (s-exp->list (third (s-exp->list s)))))
           (parse (fourth (s-exp->list s))))]
    [(s-exp-match? `{SYMBOL ANY ANY} s)
     (appE (appE (varE (parse-op (s-exp->symbol (first (s-exp->list s)))))
                 (parse (second (s-exp->list s))))
           (parse (third (s-exp->list s))))]
    [(s-exp-match? `{ANY ANY} s)
     (appE (parse (first (s-exp->list s)))
           (parse (second (s-exp->list s))))]
    [else (error 'parse "invalid input")]))

(define prim-ops '(+ - * / = <=))

(define (parse-op [op : Symbol]) : Symbol
  (if (member op prim-ops)
      op 
      (error 'parse "unknown operator")))

;; eval --------------------------------------

;; values

(define-type Value
  (numV [n : Number])
  (boolV [b : Boolean])
  (funV [x : Symbol] [e : Exp] [env : Env])
  (primopV [f : (Value -> Value)])
  (recV [f : Symbol] [x : Symbol] [e : Exp] [env : Env])) ; dodajemy konstruktor do rekurencyjnych domknięć

(define-type Binding
  (bind [name : Symbol]
        [val : Value]))

;; environments

(define-type-alias Env (Listof Binding))

(define mt-env empty)

(define (extend-env [env : Env] [x : Symbol] [v : Value]) : Env
  (cons (bind x v) env))

(define (lookup-env [n : Symbol] [env : Env]) : Value
  (type-case (Listof Binding) env
    [empty (error 'lookup "unbound variable")]
    [(cons b rst-env) (cond
                        [(eq? n (bind-name b))
                         (bind-val b)]
                        [else (lookup-env n rst-env)])]))

;; primitive operations and the initial environment

(define (op-num-num->value [f : (Number Number -> Number)]) : Value 
  (primopV
   (λ (v1)
     (type-case Value v1
       [(numV n1)
        (primopV
         (λ (v2)
           (type-case Value v2
             [(numV n2)
              (numV (f n1 n2))]
             [else
              (error 'eval "type error")])))]
       [else
        (error 'eval "type error")]))))

(define (op-num-bool->value [f : (Number Number -> Boolean)]) : Value 
  (primopV
   (λ (v1)
     (type-case Value v1
       [(numV n1)
        (primopV
         (λ (v2)
           (type-case Value v2
             [(numV n2)
              (boolV (f n1 n2))]
             [else
              (error 'eval "type error")])))]
       [else
        (error 'eval "type error")]))))

(define init-env 
  (foldr (λ (b env) (extend-env env (fst b) (snd b)))
         mt-env 
         (list (pair '+ (op-num-num->value +))
               (pair '- (op-num-num->value -))
               (pair '* (op-num-num->value *))
               (pair '/ (op-num-num->value /))
               (pair '= (op-num-bool->value =))
               (pair '<= (op-num-bool->value <=)))))

;; evaluation function (eval/apply)

(define (eval [e : Exp] [env : Env]) : Value
  (type-case Exp e
    [(numE n) (numV n)]
    [(ifE b l r)
     (type-case Value (eval b env)
       [(boolV v)
        (if v (eval l env) (eval r env))]
       [else
        (error 'eval "type error")])]
    [(varE x)
     (lookup-env x env)]
    [(letE x e1 e2)
     (let ([v1 (eval e1 env)])
       (eval e2 (extend-env env x v1)))]
    [(lamE x b)
     (funV x b env)]
    [(appE e1 e2)
     (apply (eval e1 env) (eval e2 env))]
    [(recE f x e)
     (recV f x e env)]))

(define (apply [v1 : Value] [v2 : Value]) : Value
  (type-case Value v1
    [(funV x body env)
     (eval body (extend-env env x v2))]
    [(primopV f)
     (f v2)]
    [(recV f x body env)
     (eval body (extend-env (extend-env env f (recV f x body env)) x v2))]
    ; rozszerzamy środowisko o nazwę funkcji f, która reprezentuje samą rekrurencyjną funkcję
    ; następnie rozszerzamy środowisko o zmienną x, przypisując jej wartość apply v2 
    [else (error 'apply "not a function")]))

(define (run [e : S-Exp]) : Value
  (eval (parse e) init-env))

(module+ test
  (test (run `{{rec fact {n} {if {= n 0} 1 {* n {fact {- n 1}}}}} 5})
        (numV 120)))




; W interpretacji letrec wymagane jest rozszerzenie środowiska przed ewaluacją ciała letrec
; o związania dla wszystkich zmiennych z ich odpowiadającymi wartościami.

; rec pozwala na tworzenie funkcji rekurencyjnych poprzez wprowadzenie związania dla samej funkcji przed ewaluacją jej ciała.
