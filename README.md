# Juegos-IA

PECL2 de Inteligencia Artificial en la Universidad de Alcalá.

## Enunciado
 
Supóngase un juego de dos contendientes, suma cero, con información completa, sin azar y con  jugadas alternas en el que los contendientes tengan en cada turno exactamente dos jugadas posibles y en el que todas las jugadas finales estén siempre al mismo nivel de profundidad.
 
Se pide elaborar un programa Scheme-Racket  que tenga como entradas el nivel de profundidad de las jugadas finales,  las puntuaciones de las mismas y la posibilidad de usar dichas puntuaciones  en el orden dado o distribuidas aleatoriamente para evaluar dichas jugadas finales.
Como salida, debe producir la estrategia óptima para cada jugador, calculada con el método que sea más efectivo computacionalmente.

## Resolución

Datos necesarios:

- Profundidad

- Puntuaciones

- ¿Puntuaciones ordenadas?

Generaremos:

- Árbol binario:

    - Número de hojas =  2**profundidad

    - Se modelará como una lista de listas de pares de la siguiente manera:

Profundidad   | Resultado
:------------:|-----------
0 | NULL
1 | (list p1 p2)
2 | (list (list p1 p2) (list p3 p4))
3 | (list (list (list p1 p2) (list p3 p4)) (list (list p5 p6) (list p7 p8)))

### Algoritmo

Utilizaremos un minimax y haremos poda alfa-beta.
