#lang racket
; https://docs.racket-lang.org/pict/Tree_Layout.html
;(require pict/tree-layout)

;(define main)

; a = Arbol minimax
;(define (poda a))

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
        (cons (list (car v) (car (cdr v))) (empareja (cdr (cdr v))))
    )
)

;(define nivel1 (list 1 2))
;(define nivel2 (list 1 2 3 4))
;(define nivel3 (list 1 2 3 4 5 6 7 8))
;(define nivel4 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
;(nuevoArbol 3 nivel3)
;(empareja (empareja nivel3))
;(nuevoArbol 4 nivel4)
;(empareja (empareja (empareja nivel4)))
;(list
;    (list
;        (list
;            (list 1 2)
;            (list 3 4)
;        )
;        (list
;            (list 5 6)
;            (list 7 8)
;        )
;    )
;    (list
;        (list
;            (list 9 10)
;            (list 11 12)
;        )
;        (list
;            (list 13 14)
;            (list 15 16)
;        )
;    )
;)
