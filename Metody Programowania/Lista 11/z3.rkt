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
  (letE [bindings : (Listof (Symbol * Exp))] [body : Exp])   ;nowe typy wyrażeń
  (letE* [bindings : (Listof (Symbol * Exp))] [body : Exp])) ;

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
    [(s-exp-match? `{let* ANY ANY} s)                               ;
     (letE* (parse-bindings (s-exp->list (second (s-exp->list s)))) ;parsujemy drugi element let'a zamieniając na listę
            (parse (third (s-exp->list s))))]                       ;
    [(s-exp-match? `{let ANY ANY} s)                                ;
     (letE (parse-bindings (s-exp->list (second (s-exp->list s))))  ;
           (parse (third (s-exp->list s))))]                        ;
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

(define (parse-bindings [bindings : (Listof S-Exp)]) : (Listof (Symbol * Exp));pomocnicza funckja parsująca listę wiązań
  (type-case (Listof S-Exp) bindings                                          ;
    [empty empty]                                                             ;jeżeli lista jest pusta (nie ma wiązań) zwracamy empty
    [(cons binding rst)                                                       ;jeżeli lista jest postaci: (wiązanie ogon-listy)
     (if (s-exp-match? `{SYMBOL ANY} binding)                                 ;patrzymy na pierwsze wiązanie
         (cons (pair (s-exp->symbol (first (s-exp->list binding)))            ;zamieniamy nazwę zmiennej na symbol, oraz parsujemy jej wartość
                     (parse (second (s-exp->list binding))))                  ;tworzymy listę par, ze sparsowanymi wiązaniami
               (parse-bindings rst))                                          ;rekurencyjnie parsujemy ogon listy
         (error 'parse "invalid input: let"))]))                              ;
                

;; eval --------------------------------------

;; values

(define-type Value
  (numV [n : Number])
  (boolV [b : Boolean]))

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

;; environments

(define-type Binding
  (bind [name : Symbol]
        [val : Value]))

(define-type-alias Env (Listof Binding))

(define mt-env empty)

(define (extend-env [env : Env] [x : Symbol] [v : Value]) : Env
  (cons (bind x v) env))

(define (lookup-env [n : Symbol] [env : Env]) : Value  ;wyszukiwanie zmiennej, zwraca jej wartość
  (type-case (Listof Binding) env
    [empty (error 'lookup "unbound variable")]
    [(cons b rst-env) (cond
                        [(eq? n (bind-name b))
                         (bind-val b)]
                        [else (lookup-env n rst-env)])]))

(define (help-let* [env : Env] [bindings : (Listof (Symbol * Exp))]) : Env   ;
  (if (empty? bindings)                                                      ;
       env                                                                   ;jeżeli lista wiązań jest pusta zwracamy aktualne środowisko
      (help-let* (extend-env env                                             ;
                            (fst (first bindings))                           ;dla pierwszego elementu pary - zmiennej
                            (eval (snd (first bindings)) env))               ;obliczamy wartość
                 (rest bindings)))) 

;; evaluation function

(define (eval [e : Exp] [env : Env]) : Value
  (type-case Exp e
    [(numE n) (numV n)]
    [(opE o l r) ((op->proc o) (eval l env) (eval r env))]
    [(ifE b l r)
     (type-case Value (eval b env)
       [(boolV v)
        (if v (eval l env) (eval r env))]
       [else
        (error 'eval "type error")])]
    [(varE x)
     (lookup-env x env)]
    [(letE bindings body)
     (eval body
          (foldl (lambda (x e) (extend-env e                   ;srodowisko
                                          (fst x)              ;nazwa zmiennej
                                          (eval (snd x) env))) ;jej wartosc
                  env
                  bindings))] ;foldl f acc list
    [(letE* bindings body)
     (eval body (help-let* env bindings))]))  


(define (run [e : S-Exp]) : Value
  (eval (parse e) mt-env))

;; printer ———————————————————————————————————-

(define (value->string [v : Value]) : String
  (type-case Value v
    [(numV n) (to-string n)]
    [(boolV b) (if b "true" "false")]))

(define (print-value [v : Value]) : Void
  (display (value->string v)))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e) mt-env)))

(module+ test
  (test
   (eval (parse `{let {{x {+ 1 2}} {z 1}} {+ x 1}}) mt-env)
   (numV 4))
  (test
   (eval (parse `{let* {{x {+ 3 2}} {z x}} {+ x z}}) mt-env)
   (numV 10)))

;(eval (parse `{let {{x {+ 1 2}} {z x}} {+ x 1}}) mt-env)
