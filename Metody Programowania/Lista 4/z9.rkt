#lang racket

(define-struct ord (val priority) #:transparent)

(define-struct hleaf ())
(define-struct hnode (elem rank l r) #:transparent)
