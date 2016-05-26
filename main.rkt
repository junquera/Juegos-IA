#lang racket
; https://docs.racket-lang.org/pict/Tree_Layout.html
;(require pict/tree-layout)

; p = Profundidad
; v = Lista de resultados
(define (primero par)
    (car par)
)
(define (segundo par)
    (list-ref par 1)
)
(define (cola v)
    (cdr (cdr v))
)

; p = Profundidad
; v = Lista de resultados
(define (nuevoArbol p v)
    (if (= p 1)
        v
        (empareja (nuevoArbol (- p 1) v))
    )
)

; v = Lista de resultados
(define (empareja v)
    (if (null? v)
        v
        (cons (list (primero v) (segundo v)) (empareja (cola v)))
    )
)

; Devuelve el mayor entre a y b
(define (mayor a b)
    (if (> a b)
        a
        b
    )
)

; Devuelve el menor entre a y b
(define (menor a b)
    (if (> a b)
        b
        a
    )
)

(define (alfabeta nodo profundidad a b max)
    (if (integer? nodo)
        nodo
        (if max
            ((lambda (x)
                (if (< b x) ; Poda
                    x
                    (mayor (alfabeta (segundo nodo) (- profundidad 1) a b #f) x)
                )
            ) (alfabeta (primero nodo) (- profundidad 1) a b #f))
            ((lambda (x)
                (if (< b x) ; Poda
                    x
                    (menor (alfabeta (segundo nodo) (- profundidad 1) a b #f) x)
                )
            ) (alfabeta (primero nodo) (- profundidad 1) a b #t))
        )
    )
)

; Listas de prueba
(define nivel1 (list 1 2))
(define nivel2 (list 1 2 3 4))
(define nivel3 (list 1 2 3 4 5 6 7 8))
(define nivel4 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))

(alfabeta (nuevoArbol 4 nivel4) 4 -inf.0 +inf.0 #t)
