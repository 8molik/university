#lang racket

(require racket/contract)

(parametric->/c [a b] (-> a b a)) ; (a b -> a)
; (-> a b A))

(define/contract (fun1 a b)
  (parametric->/c [a b] (-> a b a))
  a)


(parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
; (-> (-> A B c) (-> A b) a C))

(define/contract (fun2 f1 f2 a)
  (parametric->/c [a b c] (-> (-> a b c) (-> a b) a c))
  (f1 a (f2 a)))


(parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
; (-> (-> B c) (-> A b) (-> a C)))

(define/contract (fun3 f g)
  (parametric->/c [a b c] (-> (-> b c) (-> a b) (-> a c)))
  (lambda (x) (f (g x))))

                  
(parametric->/c [a] (-> (-> (-> a a) a) a)) ; (((a->a) -> a) -> a)
; (-> (-> (-> a A) a) A))

(define (fun4 f)
  (parametric->/c [a] (-> (-> (-> a a) a) a))
  (f (lambda (x) (f (lambda (x) x)))))

(provide/contract
  [fun1 (-> any/c any/c any/c)]
  [fun2 (-> any/c any/c any/c any/c)]
  [fun3 (-> any/c any/c)]
  [fun4 (-> any/c any/c)])