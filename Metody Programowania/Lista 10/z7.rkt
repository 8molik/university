#lang plait

(define-syntax my-or
  (syntax-rules ()
    ((my-or) #f)
    ((my-or exp) (if exp #t #f))
    ((my-or exp1 exp2 ...)
     (let ((result exp1))
       (if result
           #t
           (my-or exp2 ...))))))


(define-syntax my-and
  (syntax-rules ()
    ((my-and) #f)
    ((my-and exp) (if exp #t #f))
    ((my-and exp1 exp2 ...)
     (let ((result exp1))
       (if (not result)
           #f
           (my-and exp2 ...))))))


(my-or #t (= 1 2) #f)
(my-and)



(define-syntax my-let
  (syntax-rules ()
    ((my-let ((name val) ...)
       body)
     ((lambda (name ...)
        body)
      val ...))
    ))

(my-let ((x (+ 1 2)) (y 5)) (+ x y))
;(my-let ((x (+ 1 2)) (y x)) (+ x y))



(define-syntax my-let*
  (syntax-rules ()
    ((my-let* ((name val)) body)
     (my-let ((name val)) body))
    
    ((my-let* ((name1 val1) (name2 val2) ...) body)
     (my-let ((name1 val1))
       (my-let* ((name2 val2) ...)
		body)))))



(my-let* ((x (+ 1 2)) (y x)) (+ x y))
