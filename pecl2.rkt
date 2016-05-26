#lang racket

(define (potencia x y) (if (= y 1) x (* x (potencia x (- y 1)))))

(define (aleatorioAux1 listaPunt valorAl inicial) (list-set listaPunt valorAl inicial))

(define (aleatorioAux listaPunt valorAl inicial)(aleatorioAux1(list-set listaPunt 0 (list-ref listaPunt valorAl)) valorAl inicial))

; Coge e intercambia el primer valor de la lista por uno aleatorio, se realliza tantas veces como longitud tenga la lista de puntuaciones con iteracion 
(define (aleatorio listaPunt valorAl iteracion) (if (= iteracion 0)
                                                    listaPunt
                                                    (aleatorio (aleatorioAux listaPunt valorAl (first listaPunt))(random (length listaPunt)) (- iteracion 1))))

;si es mayor es el peor camino alfa, si es menor es el mejor camino beta
;este metodo pone a cero el camino pues hay un nuevo camino de mayor o menor puntuacion
(define (cambiarCamino listaAB camino mayorMenor) (if (string=? mayorMenor "mayor") (list-set listaAB 2 (list camino))
                                                    (list-set listaAB 3 (list camino))
                                                    )
)
;este metodo no esta en ningun sitio pero lo que hace es añadir a la lista del camino elegido la direccion
(define (añadirCamino listaAB camino mayorMenor)(if (string=? mayorMenor "mayor") (list-set listaAB 2 (cons camino (list-ref listaAB 2)))
                                                    (list-set listaAB 3 (cons camino (list-ref listaAB 3)))
                                                    )
  )
;Comprueba si se tiene que realizar un corte o modificarlo, o simplemente devolverlo
(define (mayorAB listaAB nodo camino)
                                     (cond ((and (> nodo (first listaAB) )(>= nodo (second listaAB) )) listaAB)
                                     ((> nodo (first listaAB)) (cambiarCamino (list-set listaAB 0 nodo) camino "mayor"))
                                     (listaAB)))
(define (menorAB listaAB nodo camino)
                                     (cond ((and (< nodo(second listaAB))(>= (first listaAB) nodo)) listaAB)
                                     ((< nodo(second listaAB))(cambiarCamino (list-set listaAB 1 nodo) camino "menor"))
                                     (listaAB)))
;Si la lista es impar el camino es la derecha si no es la izuqierda, si el nivel es par es Max, si es impar es Min
(define (alfaBetaAux p pActual listaAB listaPunt) (if (= (length listaPunt) 0)
                                                                       listaAB
                                                                       (if (= p pActual)
                                                                        (cond ((and (even? (- pActual 1)) (even? (car listaPunt))) (alfaBetaAux p (- pActual 1) (mayorAB listaAB (first listaPunt) "I" ) (cdr listaPunt)))
                                                                        ( (and (odd? (- pActual 1)) (even? (car listaPunt))) (alfaBetaAux p (- pActual 1) (menorAB listaAB (first listaPunt)"I")(cdr listaPunt)))
                                                                        ( (and (even? (- pActual 1)) (odd? (car listaPunt))) (alfaBetaAux p (- pActual 1) (mayorAB listaAB (first listaPunt)"D")(cdr listaPunt)))
                                                                        ( (and (odd? (- pActual 1)) (odd? (car listaPunt))) (alfaBetaAux p (- pActual 1) (menorAB listaAB (first listaPunt)"D")(cdr listaPunt))))                                                                        
                                                                        (alfaBetaAux p (+ pActual 1) listaAB listaPunt)
                                                                        )
                                                   )
  )                                                                        
;Dado que tiene que mostrar el camino y se tiene que manejar alfa y beta, se ha creado una lista donde los valores son (alfa, beta, listaCaminoAlfa (peor puntuacion para el primero), listaCaminoBeta (mejor puntuacion para el primero)
(define (alfaBeta p listaPunt) (alfaBetaAux p p '(-inf.0 +inf.0 '() '()) listaPunt ))

(define(main p listaPunt azar)(cond ((and (= (length listaPunt) (potencia 2 p)) (= 0 azar))
                                 (alfaBeta p listaPunt))
                                     ((and (= (length listaPunt) (potencia 2 p)) (= 1 azar))
                                 (alfaBeta p (aleatorio listaPunt (random (length listaPunt)) (length listaPunt))))                                      
                                     ("La profundidad o la cantidad de puntuaciones no es correcta")
                                     )
)

;(main 2 '(4 5 6 7) 0)
;(main 1 '(4 5) 0)
