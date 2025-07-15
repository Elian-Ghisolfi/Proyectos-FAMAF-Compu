# Solución del problema del delay.

A modo de narración más que de explicación, contamos que la ayuda incluida en el mensaje fue un disparador inicial para encontrar el camino correcto a la solución. Lo siguiente fue (aparte de pensar que borrando la ejecución de la función `ping_pong_loop` era la solución real) empezar a leer el para nada complicado: `obfuscated.c`.

El descubrir que la mayoría (si no todas) las cadenas de texto estaban codificadas en hexadecimal, fue cuestión de empezar a copiarlas y traducirlas para empezar a entender de que se trataba el archivo. El hecho de que pegara picos de muchos, _muchos_ megas de descarga también era un indicativo de que lo que estaba pasando debía involucrar una petición a algún servidor.

Al ir traduciendo las cadenas en hexadecimal, empezamos a encontrar "variables de entorno" (identificables por el formato en _snake case_). Al encontrar `PP_DISABLE_EASTER_EGG` tratamos de "setearla" en la ejecución del programa, pero no logramos hacerlo.

Mientras seguíamos explorando, empezamos a pensar desde arriba hacia abajo en orden de ejecución, a diferencia de leer el archivo entero. Arrancamos por la función que ejecutábamos nosotros desde nuestro código: `ping_pong_loop`

Luego, entre funciones y variables nombradas por `paraguay`, `oman` y `pakistan`, encontramos varios códigos que parecieran ser identificativos de un repositorio.

Siguiendo con el programa, vemos que se crea una cadena que contine estos valores y una `URL()`, por lo que traduciéndola vemos que corresponde a un _challenge_ que no responde correctamente.

Más abajo, se usa al fin nuestro parámetro `password`, solo si no es nulo, que era nuestro caso. Al imprimir por pantalla lo almacenado en `NORTHMACEDONIA` pudimos ver que obteníamos una URL accesible que contenía ahora sí las instrucciones para resolver el enigma.

Una vez usada la contraseña, fuimos capaces de sacar el error y poder continuar con nuestro programa.
