# Juegos-IA

PECL2 de Inteligencia Artificial en la Universidad de Alcalá.

## Enunciado
 
Supóngase un juego de dos contendientes, suma cero, con información completa, sin azar y con  jugadas alternas en el que los contendientes tengan en cada turno exactamente dos jugadas posibles y en el que todas las jugadas finales estén siempre al mismo nivel de profundidad.
 
Se pide elaborar un programa Scheme-Racket  que tenga como entradas el nivel de profundidad de las jugadas finales,  las puntuaciones de las mismas y la posibilidad de usar dichas puntuaciones  en el orden dado o distribuidas aleatoriamente para evaluar dichas jugadas finales.
Como salida, debe producir la estrategia óptima para cada jugador, calculada con el método que sea más efectivo computacionalmente.

## Desarrollo

Como estrategia de resolución del problema, utilizaremos el algoritmo minimax y haremos poda alfa-beta.

Las hojas del árbol son un par valor-posiciónd, de esta manera, podemos obtener directamente del resultado el camino a seguir. Damos la posibilidad de que el usuario decida si el orden de las hojas es aleatorio o igual al de los valores introducidos. El método principal será alfabeta, que se encargará tanto de buscar el camino óptimo como de realizar la poda. Para la poda, utilizamos lambdas que "guardarán" los valores tanto para comparar con beta (para la poda) como para saber con qué valor nos quedamos. Al ser un árbol binario, nos ha sido muy fácil recorrer todos los hijos de cada nodo.

## Resolución

Datos necesarios:

- Profundidad

- Puntuaciones

- ¿Puntuaciones ordenadas?

Generaremos:

- Árbol binario:

    - Número de hojas =  2^profundidad

    - Se modelará como una lista de listas de pares de la siguiente manera:

Profundidad   | Resultado
:------------:|-----------
0 | NULL
1 | (list p1 p2)
2 | (list (list p1 p2) (list p3 p4))
3 | (list (list (list p1 p2) (list p3 p4)) (list (list p5 p6) (list p7 p8)))

### Algoritmo

Para obtener el recorrido, utilizamos el siguiente algoritmo:

    X%nHojas >= nHojas/2;

    Por ejemplo, para un árbol de nivel 3 (8 hojas):

    La posición 5 se encontraría así:

        5 % 8 >= 4 -> 1 (Derecha)
        5 % 4 >= 2 -> 0 (Izquierda)
        5 % 2 >= 1 -> 1 (Derecha)
