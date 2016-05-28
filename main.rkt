#lang racket
(require pict)
(require pict/tree-layout)
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



; Cada hoja del árbol contiene su valor y su posición
(define (valorPosicion v)
    (valorPosicionAux v 0)
)

(define (valorPosicionAux v p)
    (if (null? v)
        null
        (cons (list (car v) p) (valorPosicionAux (cdr v) (+ p 1)))
    )
)

; p = Profundidad
; v = Lista de resultados
(define (nuevoArbol p v)
    (nuevoArbolAux p (valorPosicion v))
)

(define (nuevoArbolAux p v)
    (if (= p 1)
        v
        (empareja (nuevoArbolAux (- p 1) v))
    )
)


; v = Lista de resultados
(define (empareja v)
    (if (null? v)
        v
        (cons (list (primero v) (segundo v)) (empareja (cola v)))
    )
)

; Algoritmo minimax con poda alfabeta
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

; Ver qué camino hay que tomar para llegar al valor en función de su posición
(define (camino profundidad resultado)
    (if (= profundidad 0)
        null
        ((lambda (hojas)
            (if (>= (modulo (segundo resultado) hojas) (/ hojas 2))
                (cons "derecha" (camino (- profundidad 1) resultado))
                (cons "izquierda" (camino (- profundidad 1) resultado))
            )
        )(expt 2 profundidad))
    )
)

; Imprimir resultado del juego
(define (printArbol a)
  (naive-layered (make-tree a))
)

(define (make-tree a)
  (if (integer? (primero a))
      (tree-layout #:pict (text (number->string (primero a))))
      (tree-layout (make-tree (primero a)) (make-tree (segundo a)))
  )
)
(define (printResultado res profundidad jugador)
    (printf "El mejor valor para el ~a jugador es ~a, y su camino es: ~a.\n" jugador (primero res) (string-join (camino profundidad res) ", "))
)
; v = Lista de valores
(define (juegoAux profundidad v)
    ((lambda (arbol)
        (printf "Esta es la lista de valores: ~a\n" v)
        (printResultado (alfabeta arbol profundidad -inf.0 +inf.0 #t) profundidad "primer")
        (printResultado (alfabeta arbol profundidad -inf.0 +inf.0 #f) profundidad "segundo")
        (printf "Arbol:\n")
        (printArbol arbol)
    ) (nuevoArbol profundidad v))
)

; Desordenar la lista
(define (removePosition p l)
    (if (null? l)
        null
        (if (= p 0)
            (cdr l)
            (cons (car l) (removePosition (- p 1) (cdr l)))
        )
    )
)
(define (desordena l)
    (if (null? l)
        null
        ((lambda (x)
            (cons (list-ref l x) (desordena (removePosition x l)))
        ) (random (length l)))
    )
)

(define (juego profundidad v aleatorio)
    (if aleatorio
        (juegoAux profundidad (desordena v))
        (juegoAux profundidad v)
    )
)


(juego 4 nivel4 #t)
