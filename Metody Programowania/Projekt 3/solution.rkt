#lang plait

(define-type Op
  (add) (sub) (mul) (leq))

(define-type Program
  (defineE [d : (Listof Fun)] [e : Exp]))

(define-type Fun
  (funE [name : Symbol] [args : (Listof Symbol)] [body : Exp]))

(define-type Exp
  (numE [n : Number])
  (varE [x : Symbol])
  (opE [e1 : Exp] [op : Op] [e2 : Exp])
  (ifE [b : Exp] [l : Exp] [r : Exp])
  (letE [x : Symbol] [e1 : Exp] [e2 : Exp])
  (appE [f : Symbol] [args : (Listof Exp)]))

(define (unique? xs)
  (cond [(empty? xs) #t]
        [(member (first xs) (rest xs)) #f]
        [else (unique? (rest xs))]))


; ========== PARSER ==========

(define (parse [s : S-Exp]) : Program
  (cond [(s-exp-match? `{define {ANY ...} for ANY} s)
         (let [(functions (map parse-fun (s-exp->list (second (s-exp->list s)))))]
         (defineE (if (unique? (map funE-name functions))
                      functions
                      (error 'parse "Functions names must be unique"))                   
                  (parse-exp (fourth (s-exp->list s)))))]
        [else (error 'parse "Syntax error")]))
           
(define (parse-fun [s : S-Exp]) : Fun
  (cond [(s-exp-match? `{fun SYMBOL {SYMBOL ...} = ANY} s)
         (funE (s-exp->symbol (second (s-exp->list s)))
               (if (unique? (s-exp->list (third (s-exp->list s))))
                   (map s-exp->symbol (s-exp->list (third (s-exp->list s))))
                   (error 'parse-funcion "Function arguments must be unique"))
               (parse-exp (list-ref (s-exp->list s) 4)))]
        [else (error 'parse-fun "Syntax error")]))

(define (parse-exp [s : S-Exp]) : Exp
  (cond [(s-exp-match? `NUMBER s)
         (numE (s-exp->number s))]
        [(s-exp-match? `SYMBOL s)
         (varE (s-exp->symbol s))]
        [(s-exp-match? `{ANY SYMBOL ANY} s)
         (opE (parse-exp (first (s-exp->list s)))
              (parse-op (s-exp->symbol (second (s-exp->list s))))
              (parse-exp (third (s-exp->list s))))]
        [(s-exp-match? `{ifz ANY then ANY else ANY} s)
         (ifE (parse-exp (second (s-exp->list s)))
              (parse-exp (fourth (s-exp->list s)))
              (parse-exp (list-ref (s-exp->list s) 5)))]
        [(s-exp-match? `{let SYMBOL be ANY in ANY} s)
         (letE (s-exp->symbol (second (s-exp->list s)))
               (parse-exp (fourth (s-exp->list s)))
               (parse-exp (list-ref (s-exp->list s) 5)))]
        [(s-exp-match? `{SYMBOL ANY ...} s)
         (appE (s-exp->symbol (first (s-exp->list s)))
               (map parse-exp (s-exp->list (second (s-exp->list s)))))]
        [else (error 'parse-exp "Syntax error")]))

(define (parse-op [op : Symbol]) : Op
  (cond [(eq? op '+) (add)]
        [(eq? op '-) (sub)]
        [(eq? op '*) (mul)]
        [(eq? op '<=) (leq)]
        [else (error 'parse-op (string-append "Undefined operator: " (symbol->string op)))]))

; ========== ENVIROMENT ==========

(define-type-alias Value Number)

(define-type FunClo
  (funclo [args : (Listof Symbol)] [e : Exp] [env : Env]))

(define-type Storable
  (valS [v : Value])
  (funS [f : FunClo])
  (undefS))

(define-type Binding
  (bind [name : Symbol]
        [ref : (Boxof Storable)]))

(define-type-alias Env (Listof Binding))

(define mt-env empty)

(define (extend-env-undef [env : Env] [x : Symbol]) : Env
  (cons (bind x (box (undefS))) env))

(define (extend-env [env : Env] [x : Symbol] [v : Value]) : Env
  (cons (bind x (box (valS v))) env))

(define (find-name [env : Env] [x : Symbol]) : (Boxof Storable)
  (type-case (Listof Binding) env
    [empty (error 'lookup "unbound variable")]
    [(cons b rst-env) (cond
                        [(eq? x (bind-name b))
                         (bind-ref b)]
                        [else
                         (find-name rst-env x)])]))
  
(define (lookup-env-var [x : Symbol] [env : Env]) : Value
  (type-case Storable (unbox (find-name env x))
    [(valS v) v]
    [(funS f) (error 'lookup-env-var "function, not variable")]
    [(undefS) (error 'lookup-env "undefined variable")]))

 (define (lookup-env-fun [x : Symbol] [env : Env]) : FunClo
  (type-case Storable (unbox (find-name env x))
    [(valS v) (error 'lookup-env-fun "variable, not function")]
    [(funS f) f]
    [(undefS) (error 'lookup-env-fun "undefined variable")]))

(define (update-env-fun [env : Env] [x : Symbol] [f : FunClo]) : Void
  (set-box! (find-name env x) (funS f)))

(define (update-env [functions : (Listof Fun)] [env : Env]) : Void
  (if (empty? functions)
      (void)
      (begin
        (update-env-fun env (funE-name (first functions))
                         (funclo (funE-args (first functions))
                                 (funE-body (first functions))
                                 env))
        (update-env (rest functions) env))))

  (define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) +]
    [(sub) -] 
    [(mul) *]
    [(leq) (lambda (x y) (if (<= x y) 0 42))]))

; ========== EVALUATION ==========

(define (eval-exp [e : Exp] [env : Env]) : Value
  (type-case Exp e
    [(numE n) n]
    [(varE x) (lookup-env-var x env)]
    [(opE e1 op e2) ((op->proc op)
                     (eval-exp e1 env)
                     (eval-exp e2 env))]
    [(ifE b l r) (if (eq? 0 (eval-exp b env))
                     (eval-exp l env)
                     (eval-exp r env))]
    [(letE x e1 e2)
     (eval-exp e2 (extend-env env x (eval-exp e1 env)))]
    [(appE f args)
     (apply (lookup-env-fun f env) (map (lambda (x) (eval-exp x env)) args))]))

(define (extend-env-args [env : Env] [args : (Listof Symbol)] [vals : (Listof Value)]) : Env
    (cond [(empty? args) env]
          [(empty? vals) (error 'apply "Not enough arguments")]
          [else (extend-env-args (extend-env env (first args) (first vals)) (rest args) (rest vals))]))

(define (apply [f : FunClo] [args : (Listof Value)]) : Value
  (type-case FunClo f
    [(funclo xs e env)
     (eval-exp e (extend-env-args env xs args))]))

(define (create-new-env [functions : (Listof Fun)] [env : Env]) : Env
  (if (empty? functions)
      env
      (create-new-env (rest functions)
                      (extend-env-undef env (funE-name (first functions))))))

(define (eval [p : Program]) : Value
  (type-case Program p
    [(defineE functions e)
     (let ([new-env (create-new-env functions mt-env)])
       (begin
         (update-env functions new-env)
         (eval-exp e new-env)))]))


(define (run [s : S-Exp]) : Value
  (eval (parse s)))