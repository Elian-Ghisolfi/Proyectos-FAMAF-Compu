# Laboratorios de Organización del Computador (Electrónica Digital)

El proyecto tiene como objetivo principal trabajar con **programación en lenguaje ensamblador ARMv8**, enfocándose en la **interacción con el hardware** de una **Raspberry Pi 3** a través de emulación.

Se busca comprender cómo funciona la **entrada/salida (I/O)** de un microprocesador ARM utilizando una interfaz visual, y cómo operar con estructuras gráficas como el **FrameBuffer**, que representa píxeles de pantalla en memoria. Además, se explora el manejo de los **pines GPIO** simulados a través del teclado.

Uno de los ejes del trabajo es la **inicialización del Video Core (VC)** del sistema, que se realiza mediante el uso de un **mailbox**, una interfaz de comunicación entre la CPU y los periféricos que permite configurar el framebuffer. Este último se organiza en **palabras de 32 bits (formato ARGB)**, donde cada píxel se representa por una combinación de los colores rojo, verde, azul y el canal alfa (transparencia). La ubicación en memoria de cada píxel se calcula en función de sus coordenadas (x, y).

La configuración utilizada en este proyecto establece un **framebuffer de 640x480 píxeles**, con color en **formato ARGB de 32 bits**. Se incluyen ejemplos de valores hexadecimales que representan distintos colores.

Dado que no es posible utilizar físicamente la Raspberry Pi 3, se emplea el emulador **QEMU**, que permite correr el código ARM en un entorno virtual con soporte completo para estas funciones, replicando fielmente el comportamiento del hardware real.


