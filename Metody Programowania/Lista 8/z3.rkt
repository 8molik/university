#lang racket

(provide
 dequeue?
 nonempty-dequeue?
 (contract-out
   [dequeue-empty? (-> dequeue? boolean?)]
   [new-dequeue   (-> dequeue?)]
   [dequeue-push-front   (-> dequeue? any/c void?)]
   [dequeue-push-back   (-> dequeue? any/c void?)]
   [dequeue-pop-front    (-> dequeue? any/c)]
   [dequeue-pop-back    (-> dequeue? any/c)]))

(define-struct node
  (val
  [prev #:mutable]
  [next #:mutable]))

(define-struct dequeue
  ([front #:mutable]
   [back #:mutable]))

(define (new-dequeue)
  (dequeue null null))

(define (dequeue-empty? q)
  (and (null? (dequeue-front q))
       (null? (dequeue-back q))))

(define (nonempty-dequeue? q)
  (and (dequeue? q) (node? (dequeue-front q))))

(define (dequeue-push-back q x)
  (define n (node x null null))
  (if (dequeue-empty? q)
      (begin
        (set-dequeue-front! q n)
        (set-dequeue-back! q n))
      (begin
        (set-node-prev! n (dequeue-back q))
        (set-node-next! (dequeue-back q) n)))
  (set-dequeue-back! q n))

(define (dequeue-push-front q x)
  (define n (node x null null))
  (if (dequeue-empty? q)
      (begin 
        (set-dequeue-back! q n)
        (set-dequeue-front! q n))
      (begin
        (set-node-prev! (dequeue-front q) n)
        (set-node-next! n (dequeue-front q))))
  (set-dequeue-front! q n))

(define (dequeue-pop-front q)
  (define p (dequeue-front q))
  (set-dequeue-front! q (node-next p))
  (if (null? (node-next p))
      (set-dequeue-back! q null)
      (set-node-prev! (dequeue-front q) null))
  (node-val p))

(define (dequeue-pop-back q)
  (define p (dequeue-back q))
  (set-dequeue-back! q (node-prev p))
  (if (null? (node-prev p))
      (set-dequeue-front! q null)
      (set-node-next! (dequeue-back q) null))
  (node-val p))
