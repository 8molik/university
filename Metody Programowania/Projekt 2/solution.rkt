#lang racket

(require data/heap)

(provide sim? wire?
         (contract-out
          [make-sim        (-> sim?)]
          [sim-wait!       (-> sim? positive? void?)]
          [sim-time        (-> sim? real?)]
          [sim-add-action! (-> sim? positive? (-> any/c) void?)]

          [make-wire       (-> sim? wire?)]
          [wire-on-change! (-> wire? (-> any/c) void?)]
          [wire-value      (-> wire? boolean?)]
          [wire-set!       (-> wire? boolean? void?)]

          [bus-value (-> (listof wire?) natural?)]
          [bus-set!  (-> (listof wire?) natural? void?)]

          [gate-not  (-> wire? wire? void?)]
          [gate-and  (-> wire? wire? wire? void?)]
          [gate-nand (-> wire? wire? wire? void?)]
          [gate-or   (-> wire? wire? wire? void?)]
          [gate-nor  (-> wire? wire? wire? void?)]
          [gate-xor  (-> wire? wire? wire? void?)]

          [wire-not  (-> wire? wire?)]
          [wire-and  (-> wire? wire? wire?)]
          [wire-nand (-> wire? wire? wire?)]
          [wire-or   (-> wire? wire? wire?)]
          [wire-nor  (-> wire? wire? wire?)]
          [wire-xor  (-> wire? wire? wire?)]

          [flip-flop (-> wire? wire? wire? void?)]))

; Definiuję sim z czasem obecnym oraz kolejką zdarzeń
(struct sim (current-time event-queue) #:mutable)

; Definiuję przewód z wartością logiczną, procedurami do wykonania, symulacją
(struct wire ([logic-value #:mutable] [actions #:mutable] sim))

; ===== SYMULACJE =====

; Tworzy nową symulację
; current-time = 0
; heap = ()
; Kolejka zawiera pary (czas, akcja)
(define (make-sim)
  (sim 0 (make-heap (lambda (x y) (<= (car x) (car y))))))

; Służy do uruchomienia symulacji
; sim - symulacja
; work-time - czas przez jaki symulacja ma działać
(define (sim-wait! sim work-time)
  (let ([final-time (+ (sim-time sim) work-time)]
        [event-queue (sim-event-queue sim)])
   (define (loop)
     (if (> (heap-count event-queue) 0)
         (let* ([current-event (heap-min event-queue)]  ; Bierzemy pierwszy element kopca oraz jego czas
                [event-time (car current-event)])
           (if (<= event-time final-time)
               (begin
                 (heap-remove-min! event-queue)         ; Usuwamy ten pierwszy element
                 (set-sim-current-time! sim event-time) ; Modyfikujemy czas symulacji
                 ((cdr current-event))                  ; Wywołujemy akcję
                 (loop))
               (void)))
         (void)))
    (loop) ; Wywołujemy pętlę
    (set-sim-current-time! sim final-time))) ; Ustawiamy czas symulacji na ten końcowy

; Zwraca czas symulacji sim
(define (sim-time sim)
  (sim-current-time sim))

; Funkcja dodaje nową akcję do symulatora, jeżeli czas jest nieujemny
(define (sim-add-action! sim time action)
  (cond [(< time 0) (error "sim-add-action!: negative time")]
        [else
         (heap-add! (sim-event-queue sim) (cons (+ (sim-time sim) time) action))]))

; ===== PRZEWODY =====

; Tworzy nowy przewód
; value = #f
; actions = '()
; sim - symulacja
(define (make-wire sim)
  (wire #f null sim))

; Zwraca wartość logiczna przewodu wire
(define (wire-value wire)
  (wire-logic-value wire))

; Dodaje akcję i ją wywołuje
(define (wire-on-change! wire action)
  (set-wire-actions! wire (cons action (wire-actions wire)))
  (action))

; Wywołuje każdą akcję powiązaną z przewodem, dla każdego elementu w liście akcji wire
(define (call-each-action wire)
  (for-each (lambda (action) (action)) (wire-actions wire)))

; Ustawia wartość przewodu i wywołuje powiązane akcje
(define (wire-set! wire value)
  (if (not (eq? value (wire-value wire)))
      (begin
        (set-wire-logic-value! wire value)
        (call-each-action wire))
      (void)))

; ===== MAGISTRALE =====

(define (bus-set! wires value)
  (match wires
    ['() (void)]
    [(cons w wires)
     (begin
       (wire-set! w (= (modulo value 2) 1))
       (bus-set! wires (quotient value 2)))]))

(define (bus-value ws)
  (foldr (lambda (w value) (+ (if (wire-value w) 1 0) (* 2 value)))
         0
         ws))

; ===== BRAMKI =====

; Opóźnienia bramek logicznych
(define not-delay  1)
(define and-delay  1)
(define nand-delay 1)
(define or-delay   1)
(define nor-delay  1)
(define xor-delay  2)

; Funkcja pomocnicza, dla poprawy czytelności kodu
(define (add-gate-action in out gate-delay action)
  (wire-on-change! in (lambda () (sim-add-action! (wire-sim out) gate-delay action))))

(define (gate-not out in)
  (define (not-action)
    (wire-set! out (not (wire-value in))))       ; Oblicza wartość logiczną przewodu i ustawia ją
  (add-gate-action in out not-delay not-action)) ; Dodaje bramkę do przewodu

(define (gate-and out in1 in2)
  (define (and-action)
    (wire-set! out (and (wire-value in1) (wire-value in2))))
  (add-gate-action in1 out and-delay and-action)
  (add-gate-action in2 out and-delay and-action))

(define (gate-nand out in1 in2)
  (define (nand-action)
    (wire-set! out (not (and (wire-value in1) (wire-value in2)))))
  (add-gate-action in1 out nand-delay nand-action)
  (add-gate-action in2 out nand-delay nand-action))

(define (gate-or out in1 in2)
  (define (or-action)
    (wire-set! out (or (wire-value in1) (wire-value in2))))
  (add-gate-action in1 out or-delay or-action)
  (add-gate-action in2 out or-delay or-action))

(define (gate-nor out in1 in2)
  (define (nor-action)
    (wire-set! out (not (or (wire-value in1) (wire-value in2)))))
  (add-gate-action in1 out nor-delay nor-action)
  (add-gate-action in2 out nor-delay nor-action))

(define (gate-xor out in1 in2)
  (define (xor-action)
    (wire-set! out (xor (wire-value in1) (wire-value in2))))
  (add-gate-action in1 out xor-delay xor-action)
  (add-gate-action in2 out xor-delay xor-action))

; ===== PRZEWODY Z BRAMKAMI =====

(define (wire-not in)
  (let ([new (make-wire (wire-sim in))])
    (begin
     (gate-not new in)
     new)))

(define (wire-and in1 in2)
  (let ([new (make-wire (wire-sim in1))])
    (begin
     (gate-and new in1 in2)
     new)))

(define (wire-nand in1 in2)
  (let ([new (make-wire (wire-sim in1))])
    (begin
     (gate-nand new in1 in2)
     new)))

(define (wire-or in1 in2)
  (let ([new (make-wire (wire-sim in1))])
    (begin
     (gate-or new in1 in2)
     new)))

(define (wire-nor in1 in2)
  (let ([new (make-wire (wire-sim in1))])
    (begin
     (gate-nor new in1 in2)
     new)))
 
(define (wire-xor in1 in2)
  (let ([new (make-wire (wire-sim in1))])
    (begin
     (gate-xor new in1 in2)
     new)))

(define (flip-flop out clk data)
  (define sim (wire-sim data))
  (define w1  (make-wire sim))
  (define w2  (make-wire sim))
  (define w3  (wire-nand (wire-and w1 clk) w2))
  (gate-nand w1 clk (wire-nand w2 w1))
  (gate-nand w2 w3 data)
  (gate-nand out w1 (wire-nand out w3)))