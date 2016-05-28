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

(define (valorPosicionAux v p)
    (if (null? v)
        null
        (cons (list (car v) p) (valorPosicionAux (cdr v) (+ p 1)))
    )
)

(define (valorPosicion v)
    (valorPosicionAux v 0)
)

; p = Profundidad
; v = Lista de resultados
(define (nuevoArbolAux p v)
    (if (= p 1)
        v
        (empareja (nuevoArbolAux (- p 1) v))
    )
)

(define (nuevoArbol p v)
    (nuevoArbolAux p (valorPosicion v))
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
    (if (integer? (primero nodo))
        nodo
        (if max
            ((lambda (x)
                (if (< b (primero x)) ; Poda
                    x
                    ((lambda (y)
                        (if (> (primero y) (primero x))
                            y
                            x
                        )
                    ) (alfabeta (segundo nodo) (- profundidad 1) a b #f))
                )
            ) (alfabeta (primero nodo) (- profundidad 1) a b #f))
            ((lambda (x)
                (if (< b (primero x)) ; Poda
                    x
                    ((lambda (y)
                        (if (< (primero y) (primero x))
                            y
                            x
                        )
                    ) (alfabeta (segundo nodo) (- profundidad 1) a b #t))
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

(alfabeta (nuevoArbol 3 nivel3) 3 -inf.0 +inf.0 #t)


; PARA SABER EL RECORRIDO CON LA ESTRUCTURA QUE TENEMOS AHORA:
;
;   X%nHojas >= nHojas/2;
;   Por ejemplo, para un árbol de nivel 3 (8 hojas):
;   La posición 5 se encontraría así:
;
;   5 % 8 >= 4 -> 1 (Derecha)
;   5 % 4 >= 2 -> 0 (Izquierda)
;   5 % 2 >= 1 -> 1 (Derecha)
;
; TODO main y posición de la máxima puntuación
