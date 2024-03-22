#lang plait

(define-type BinaryOp
  (op-add)
  (op-mul)
  (op-sub)
  (op-div)
  (op-pow))

(define-type UnaryOp
  (op-neg)
  (op-fac))

(define-type Exp
  (exp-number [n : Number])
  (exp-op2 [op : BinaryOp] [e1 : Exp] [e2 : Exp])
  (exp-op1 [op : UnaryOp] [e : Exp]))

(define (parse-Op2 s)
  (let ([sym (s-exp->symbol s)])
  (cond [(equal? sym '+) (op-add)]
        [(equal? sym '-) (op-sub)]
        [(equal? sym '*) (op-mul)]
        [(equal? sym '/) (op-div)]
        [(equal? sym '^) (op-pow)])))

(define (parse-Op1 s)
  (let ([sym (s-exp->symbol s)])
    (cond [(equal? sym '!) (op-fac)]
          [(equal? sym '~) (op-neg)])))

(define (parse-Exp s)
  (cond [(s-exp-number? s) (exp-number (s-exp->number s))]
        [(s-exp-list? s)
         (let ([xs (s-exp->list s)])
           (if (= 2 (length xs))
               (exp-op1 (parse-Op1 (first xs))
                        (parse-Exp (second xs)))
               (exp-op2 (parse-Op2  (first  xs))
                        (parse-Exp (second xs))
                        (parse-Exp (third  xs)))))]))

(define (! x)
  (cond [(equal? 0 x) 1]
        [else (* x (! (- x 1)))]))

(define (^ x y)
  (local [(define (helper x y acc)
    (if (= y 0)
      acc
      (helper x (- y 1) (* acc x))))]
    (helper x y 1)))
        
(define (~ x)
  (* -1 x))

; ==============================================

(define (eval-op1 op)
  (type-case UnaryOp op
     [(op-fac) !]
     [(op-neg) ~]))

(define (eval-op2 op)
  (type-case BinaryOp op
    [(op-add) +]
    [(op-sub) -]
    [(op-mul) *]
    [(op-div) /]
    [(op-pow) ^]))

(define (eval e)
  (type-case Exp e
    [(exp-number n) n]
    [(exp-op1 op e)
     ((eval-op1 op) (eval e))]
    [(exp-op2 op e1 e2)
     ((eval-op2 op) (eval e1) (eval e2))]))

;(eval (parse-Exp `(+ 1 (! 4))))