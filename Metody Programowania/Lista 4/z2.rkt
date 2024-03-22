#lang racket

(define-struct leaf () #:transparent)
(define-struct node (l elem r) #:transparent)

(define t
  (node
    (node (leaf) 2 (leaf))
    5
    (node (node (leaf) 6 (leaf))
          8
          (node (leaf) 9 (leaf)))))

(define (fold-tree f acc t)
  (cond [(leaf? t) acc]
        [(node? t)
         (f
          (fold-tree f acc (node-l t))
          (node-elem t)
          (fold-tree f acc (node-r t)))]))

(define (tree-sum t)
  (fold-tree + 0 t))

(define (tree-flip t)
  (fold-tree (lambda (l elem r) (node r elem l)) (leaf) t))

(define (tree-height t)
  (fold-tree (lambda (l elem r) (+ 1 (max l r))) 0 t))

(define (flatten t)
  (fold-tree (lambda (l elem r) (append l (cons elem r))) `() t))

(define (tree-span t)
  (cons (first (flatten t)) (last (flatten t))))

(define (tree-span2 t)
  (cons (fold-tree (lambda (l e r) (min l e r)) +inf.0 t)
        (fold-tree (lambda (l e r) (max l e r)) -inf.0 t)))

(tree-sum t)
(tree-flip t)
(tree-height t)
(flatten t)
(tree-span t)