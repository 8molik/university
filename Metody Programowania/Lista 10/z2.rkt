#lang plait

(module+ test
  (print-only-errors #t))

;; abstract syntax -------------------------------

(define-type Op
  (add)
  (sub)
  (mul)
  (div))

(define-type Exp
  (numE [n : Number])
  (opE [op : Op]
       [l : Exp]
       [r : Exp]))

;; parse ----------------------------------------

(define (parse [s : S-Exp]) : Exp
  (cond
    [(s-exp-match? `NUMBER s)
     (numE (s-exp->number s))]
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
  (test/exn (parse `{{+ 1 2}})
            "invalid input")
  (test/exn (parse `{+ 1})
            "invalid input")
  (test/exn (parse `{^ 1 2})
            "unknown operator"))
  
;; eval --------------------------------------

(define-type-alias Value Number)

(define (op->proc [op : Op]) : (Value Value -> Value)
  (type-case Op op
    [(add) +]
    [(sub) -]
    [(mul) *]
    [(div) /]))

(define (eval [e : Exp]) : Value
  (type-case Exp e
    [(numE n) n]
    [(opE o l r) ((op->proc o) (eval l) (eval r))]))

; ....
; (trace eval)

(define (run [e : S-Exp]) : Value
  (eval (parse e)))

(module+ test
  (test (run `2)
        2)
  (test (run `{+ 2 1})
        3)
  (test (run `{* 2 1})
        2)
  (test (run `{+ {* 2 3} {+ 5 8}})
        19))

;; printer ———————————————————————————————————-

(define (print-value [v : Value]) : Void
  (display v))

(define (main [e : S-Exp]) : Void
  (print-value (eval (parse e))))

;; abstract machine ---------------------------

(define-type Stack
  (emptyS)
  (rightS [op : Op] [exp : Exp] [s : Stack])
  (leftS [op : Op] [val : Value] [s : Stack]))

(define (evalAM [e : Exp] [s : Stack]) : Value
  (type-case Exp e
    [(numE n)
     (continueAM s n)]
    [(opE op e1 e2)
     (evalAM e1 (rightS op e2 s))]))

(define (continueAM [s : Stack] [v : Value]) : Value
  (type-case Stack s
    [(emptyS)
     v]
    [(rightS op e s)
     (evalAM e (leftS op v s))]
    [(leftS op u s)
     (continueAM s ((op->proc op) v u))]))
  
(define (runAM [e : S-Exp]) : Value
  (evalAM (parse e) (emptyS)))

(module+ test
  (test (run `2)
        (runAM `2))
  (test (run `{+ 2 1})
        (runAM `{+ 2 1}))
  (test (run `{* 2 1})
        (runAM `{* 2 1}))
  (test (run `{+ {* 2 3} {+ 5 8}})
        (runAM `{+ {* 2 3} {+ 5 8}})))

;; virtual machine and compiler ----------------

;; byte code

;instrukcje naszego kodu składają się z push i op
(define-type Instr
  (pushI [n : Value])
  (opI [op : Op]))
 
(define-type-alias Code (Listof Instr)) ;mamy listę instrukcji

;; stack

(define-type-alias StackVM (Listof Value))



(define mtS : StackVM empty)

(define (pushS [v : Value] [s : StackVM]) : StackVM
  (cons v s)) ;dodawanie do stosu

(define (popS [s : StackVM]) : (Value * StackVM)
  (type-case StackVM s
    [empty
     (error 'popS "empty stack")]
    [(cons v s)
     (pair v s)])) ;zwracamy parę górny element i reszta stosu



(define (evalVM [c : Code] [s : StackVM]) : Value
  (type-case Code c
    [empty
     (fst (popS s))] ;jak nie mamy już instrukcji to zwracamy górę Stosu, tj. obliczoną wartość
    [(cons i c) ;mamy jedną instrukcję i resztę instrukcji
     (type-case Instr i
       [(pushI n)
        (evalVM c (pushS n s))] ;jak mamy instrukcję push dodajemy instrukcję n na stos
       [(opI op) ;jak mamy operator
        (let* ([n2-s2 (popS s)] ;n2-s2 - para góra stosu i reszta stosu
               [n2 (fst n2-s2)] ;n2 góra
               [s2 (snd n2-s2)] ;s2 reszta stosu
               [n1-s1 (popS s2)];n1-s1 - para góra stosu i reszta stosu, poprzedniej reszty
               [n1 (fst n1-s1)] ;szczyt
               [s1 (snd n1-s1)] ;reszta stosu
               [s0 (pushS ((op->proc op) n1 n2) s1)]) ;na stos s0 wrzucam wynik operacji na dwóch pierwszych elementach stosu
          (evalVM c s0))])])) ;ewaluacja reszty elementów

(module+ test
  (test/exn (evalVM (list (opI (add))) mtS)
            "empty stack"))

;; compiler
; kompilujemy na listę instrukcji i operatorów
;robimy to po sparsowaniu
(define (compile [e : Exp]) : Code
  (type-case Exp e
    [(numE n)
     (list (pushI n))] ;dodajemy instrukcję wrzucającą liczbę na stos 
    [(opE op e1 e2)
     (append (compile e1)
             (append (compile e2)
                     (list (opI op))))]))


;; decompiler
;robimy sobie stos, który będzie zwykłą listą typu Exp i będziemy do niej wrzucać nowo tworzone Exp
;c - ciąg instrukcji, stos wyrażeń, jako pusta lista
(define (help-decompile [c : Code] [exp-stack : (Listof Exp)]) : (Listof Exp)
  (type-case Code c
    [empty (if (empty? exp-stack)
               (error 'help-decompile "No Code and Stack")
                exp-stack)] ;zwracamy wyrazenie z dolu stosu jako wynik
    [(cons i c)
     (type-case Instr i
       ; jeśli i jest insturkcją pushI, wartość n jest przekształcana na wyrażenie numE i umieszczana na szczycie stosu
       [(pushI n) (help-decompile c (cons (numE n) exp-stack))]
       ; jeśli i jest instrukcją opI, pobieramy 2 podwyrażenia ze stosu i tworzymy nowe wyrażenie opE
       [(opI op)
        (let* ([e2 (first exp-stack)] ;expression
               [e1 (second exp-stack)] ;expression
               [s1 (rest (rest exp-stack))] ;stos
               [s0 (cons (opE op e1 e2) s1)]) ;robię nowe wyrażenie S-exp
          (help-decompile c s0))])])) ;rekurencyjne wywołanie dla pozostałych instrukcji

; zwraca pierwsze wyrażenie z otrzymanego wyniku.
(define (decompile [c : Code]) : Exp
  (first (help-decompile c '())))

(module+ test
  (test (compile (parse `2))
        (list (pushI 2)))
  (test (compile (parse `{+ {* 2 3} {+ 5 8}}))
        (list (pushI 2) (pushI 3) (opI (mul)) (pushI 5) (pushI 8) (opI (add)) (opI (add)))))

(module+ equality
  (test (decompile (compile (parse `2)))
        (parse `2))
  (test (decompile (compile (parse `{+ {* 2 3} {+ 3 2}})))
        (parse `{+ {* 2 3} {+ 3 2}}))
    (test (decompile (compile (parse `{- 5 1})))
        (parse `{- 5 1}))
  (test (decompile (compile (parse `{* {- 4 2} {/ 6 3}})))
        (parse `{* {- 4 2} {/ 6 3}}))
  (test (decompile (compile (parse `{/ {* 2 2} {+ 1 3}})))
        (parse `{/ {* 2 2} {+ 1 3}})))

(define (runVM [e : S-Exp]) : Value
  (evalVM (compile (parse e)) mtS))

(module+ test
  (test (run `2)
        (runVM `2))
  (test (run `{+ 2 1})
        (runVM `{+ 2 1}))
  (test (run `{* 2 1})
        (runVM `{* 2 1}))
  (test (run `{- {* 2 3} {+ 5 8}})
        (runVM `{- {* 2 3} {+ 5 8}})))
