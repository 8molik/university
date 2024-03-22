#lang racket

(define y 1)
(define x 1)
(define z 1)

;wystąpienie wolne - y, związane x
( let ([ x 3])
   (+ x y ) )

( let ([ x 1] 
       [ y (+ x 2) ]) ;tutaj x jest wolny
   (+ x y ) ) ;tutaj x jest związny

;wystąpeinie wolne
( let ([ x 1]) ;x wiąże wszystkie x wewnątrz
   ( let ([ y (+ x 2) ]) ;y też wiąże
      (* x y ) ) )


( define ( fu x y )
   (* x y z ) ) ;z - wolne, x, y - związane przez define

( define ( f x )
   ( define ( g y z )
      (* x y z ) )
   ( f x x x ) ) ; jakiś error

(fu 2 2)
