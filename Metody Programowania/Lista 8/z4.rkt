#lang plait

(define-type Op
  (op-add) (op-mul) (op-sub) (op-div))

(define (parse-Op s)
  (let ([sym (s-exp->symbol s)])
  (cond
    [(equal? sym '+) (op-add)]
    [(equal? sym '-) (op-sub)]
    [(equal? sym '*) (op-mul)]
    [(equal? sym '/) (op-div)])))

; ==============================================

(define (eval s)
  (cond [(s-exp-number? s) (s-exp->number s)]
        [(s-exp-list? s)
         (let* ((xs (s-exp->list s)) (op (parse-Op (first xs))))
           (type-case Op op
             [(op-add) (+ (eval (second xs)) (eval (third xs)))]
             [(op-sub) (- (eval (second xs)) (eval (third xs)))]
             [(op-mul) (* (eval (second xs)) (eval (third xs)))]
             [(op-div) (/ (eval (second xs)) (eval (third xs)))]))]))

