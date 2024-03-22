#lang racket

(provide (struct-out column-info)
         (struct-out table)
         (struct-out and-f)
         (struct-out or-f)
         (struct-out not-f)
         (struct-out eq-f)
         (struct-out eq2-f)
         (struct-out lt-f)
         table-insert
         table-project
         table-sort
         table-select
         table-rename
         table-cross-join
         table-natural-join)

(define-struct column-info (name type) #:transparent)

(define-struct table (schema rows) #:transparent)

(define cities
  (table
   (list (column-info 'city    'string)
         (column-info 'country 'string)
         (column-info 'area    'number)
         (column-info 'capital 'boolean))
   (list (list "Wrocław" "Poland"  293 #f)
         (list "Warsaw"  "Poland"  517 #t)
         (list "Poznań"  "Poland"  262 #f)
         (list "Berlin"  "Germany" 892 #t)
         (list "Munich"  "Germany" 310 #f)
         (list "Paris"   "France"  105 #t)
         (list "Rennes"  "France"   50 #f))))

(define countries
  (table
   (list (column-info 'country 'string)
         (column-info 'population 'number))
   (list (list "Poland" 38)
         (list "Germany" 83)
         (list "France" 67)
         (list "Spain" 47))))

(define (empty-table columns) (table columns '()))

; Podpunkt 1
; Insert

; Sprawdzanie typu zmiennej
(define (type-v var)
  (cond [(number? var) 'number]
        [(string? var) 'string]
        [(boolean? var) 'boolean]
        [(symbol? var) 'symbol]
        [else (error "type-v: Unsuported type of value")]))

; Funkcja sprawdzająca czy typy obu list są takie same
(define (check-types xs ys)
  (cond [(null? xs) #t]
        [(equal? (type-v (car xs)) (type-v (car ys)))
         (check-types (cdr xs) (cdr ys))]
        [else #f]))

(define (table-insert row tab)
  (cond [(not (equal? (length row) (length (table-schema tab)))) (error "table-insert: Number of columns in row does not match the schema")]
        [(not (check-types row (first (table-rows tab)))) (error "table-insert: Wrong type of given arguments")]
        [(make-table (table-schema tab) (append (table-rows tab) (list row)))]))

;(table-rows (table-insert (list "Rzeszow" "Poland" 126 #f) cities))

; Podpunkt 2
; Project

; Funkcja zwracająca indeks kolumny
(define (index-of col tab)
  (let loop ((i 0) (tab tab))
    (cond [(null? tab) (error "get-col-index: Column not found")]
          [(equal? (column-info-name (car tab)) col) i]
          [else (loop (+ i 1) (cdr tab))])))

; Funkcja zwracająca typ kolumny, dla podanej nazwy
(define (column-type col tab)
  (let loop ((tab tab))
    (cond [(null? tab) (error "column-type: Column not found")]
          [(equal? (column-info-name (car tab)) col) (column-info-type (car tab))]
          [else (loop (cdr tab))])))

; Funkcja zwracająca wartość w danym rzędzie dla danej kolumny
(define (extract-column col row tab)
  (list-ref row (index-of col (table-schema tab))))

; Funkcja zwracająca listę elementów w danym rzędzie dla danych kilku kolumn
(define (extract-columns cols row tab)
  (map (lambda (col) (extract-column col row tab)) cols))

; Funkcja zwracająca listę elementów we wszystkich rzędach dla danych kolumn
(define (extract-rows cols rows tab)
  (map (lambda (row) (extract-columns cols row tab)) rows))

(define (table-project cols tab)
  (cond [(null? cols) tab] 
        [else (make-table (map (lambda (col) (column-info col (column-type col (table-schema tab)))) cols)
              (extract-rows cols (table-rows tab) tab))]))

;(table-project '(city country) cities)

; Podpunkt 3
; Rename

(define (table-rename col ncol tab)
  (let ((schema (table-schema tab)))
    (cond [(null? ncol) (error "table-rename: Column must have a name")]
          [(not (member col (map column-info-name schema))) (error "Column not found")]
          [else (make-table (map (lambda (x)
                                   (if (equal? col (column-info-name x))
                                       (column-info ncol (column-info-type x))
                                        x))
                                 schema)                     
                    (table-rows tab))])))

;(table-rename 'city 'name cities)

; Podpunkt 4
; Sort

; Funkcja sprawdzająca czy podane nazwy znajdują się w tablicy
(define (iter-cols cols tab)
  (for-each (lambda (col) (member col tab)) cols))

(define (lex<? x y)
  (cond [(and (boolean? x) (boolean? y)) (< (if x 1 0) (if y 1 0))]
        [(and (number? x) (number? y)) (< x y)]
        [(and (string? x) (string? y)) (string<? x y)]
        [(and (symbol? x) (symbol? y)) (symbol<? x y)]
        [else (error "lex<?: Uknown type")]))

(define (compare cols tab)
  (lambda (row1 row2)
    (let loop ((cols cols))
      (cond [(null? cols) #f]
            [(lex<? (extract-column (car cols) row1 tab)
                    (extract-column (car cols) row2 tab))]
            [else (loop (cdr cols))]))))

(define (table-sort cols tab)
  (cond [(null? cols) (error "table-sort: No sort pattern")]
        [(not (iter-cols cols (table-schema tab))) (error "table-sort: Column not found")]
        [else (make-table (table-schema tab) (sort (table-rows tab) (compare cols tab)))]))

;(table-sort '(city country) cities)

; Podpunkt 5
; Select

(define-struct and-f (l r))
(define-struct or-f (l r))
(define-struct not-f (e))
(define-struct eq-f (name val))
(define-struct eq2-f (name name2))
(define-struct lt-f (name val))

(define (eval form row tab)
  (cond [(and-f? form) (and (eval (and-f-l form) row tab)
                            (eval (and-f-r form) row tab))]
        [(or-f? form) (or (eval (or-f-l form) row tab)
                          (eval (or-f-r form) row tab))]
        [(not-f? form) (not (eval (not-f-e form) row tab))]
        [(eq-f? form)  (eq? (extract-column (eq-f-name form) row tab)
                            (eq-f-val form))]
        [(eq2-f? form) (eq? (extract-column (eq2-f-name form) row tab)
                            (extract-column (eq2-f-name2 form) row tab))]
        [(lt-f? form) (lex<? (extract-column (lt-f-name form) row tab)
                         (lt-f-val form))]
        [else (error "eval: Invalid form")]))

(define (table-select form tab)
  (if (empty? (table-rows tab))
      (empty-table (table-schema tab))
      (make-table (table-schema tab)
                  (filter (lambda (row) (eval form row tab)) (table-rows tab)))))

;(table-rows (table-select (and-f (eq-f 'capital #t) (not-f (lt-f 'area 300))) cities))

; Podpunkt 6
; Złączenie kartezjańskie

(define (table-cross-join tab1 tab2)
  (if (empty? (or (table-rows tab1) (table-rows tab2)))
      (empty-table (append (table-schema tab1) (table-schema tab2)))
      (make-table (append (table-schema tab1) (table-schema tab2))
              (append-map (lambda (row1)
                            (map (lambda (row2) (append row1 row2)) (table-rows tab2)))
                          (table-rows tab1)))))

;(table-cross-join cities (table-rename 'country 'country2 countries))

; Podpunkt 7
; Natural Join

; Funkcja zwracająca duplikaty w postaci listy par 
(define (find-duplicates tab1 tab2)
  (let ((names1 (map column-info-name (table-schema tab1)))
        (names2 (map column-info-name (table-schema tab2))))
    (filter-map (lambda (col)
                  (if (member col names2)
                      (cons col (string->symbol (string-append "new-" (symbol->string col))))
                      #f))
                names1)))

; Funkcja zwracająca tab2 ze zmodyfikowanymi nazwami powielających się kolumn
(define (rename-duplicates tab1 tab2)
  (let ((duplicates (find-duplicates tab1 tab2)))
    (foldl (lambda (pair tab) (table-rename (car pair) (cdr pair) tab)) tab2 duplicates)))

; Funkcja usuwająca kolumny, które nie mają takich samych wartości po złączeniu kartezjańskim
(define (filter-duplicate-rows tab1 tab2)
 (let ((new-tab (table-cross-join tab1 (rename-duplicates tab1 tab2)))
       (duplicates (find-duplicates tab1 tab2)))
   (map (lambda (dup) (table-select (eq2-f (car dup) (cdr dup)) new-tab)) duplicates)))

; Funkcja usuwająca nowe kolumny
(define (remove-new-columns tab duplicates)
  (let ((names (map column-info-name (table-schema tab))))
    (apply append (map (lambda (dup) (if (member (cdr dup) names)
                           (remove (cdr dup) names)
                           #f)) duplicates))))

(define (table-natural-join tab1 tab2)
  (let ((filtered (last (filter-duplicate-rows tab1 tab2))))
   (table-project (remove-new-columns filtered (find-duplicates tab1 tab2))
                  filtered)))

;(table-natural-join cities countries)
