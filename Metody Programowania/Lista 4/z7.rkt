#lang racket

(define empty-queue
  (cons null null))

(define (empty? q)
  (null? (car q)))

(define (push-back x q)
  (if (empty? q)
      (cons (list x) '())
      (cons (car q) (cons x (cdr q))))) ; pierwszy element pary bez zmian

(define (front q)
  (car (car q)))

(define (pop q)
  (let [(temp (cons (cdr (car q)) (cdr q)))] ; kolejka bez 1 elementu
  (if (null? (car temp))
      (cons (reverse (cdr temp)) '())
      temp)))

(define q (push-back 4 (push-back 3 (push-back 2 (push-back 1 empty-queue)))))