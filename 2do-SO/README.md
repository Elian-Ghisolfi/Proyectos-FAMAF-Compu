# Laboratorios de Sistemas Operativos

Este conjunto de trabajos se centra en **programación de sistemas operativos y concurrencia**, utilizando tanto herramientas de UNIX como el sistema operativo académico **xv6-riscv**.

Uno de los ejes principales es la **implementación de un intérprete de comandos o shell**, llamado `mybash`, inspirado en Bash. Este shell debe permitir ejecutar comandos en **foreground** y **background**, redirigir entrada y salida estándar, conectar comandos mediante **pipes**, e incluir comandos internos como `cd`, `help` y `exit`. Además, debe ser **robusto** ante errores y manejar adecuadamente el carácter de fin de transmisión (`CTRL+D`). Se hace énfasis en el uso de **buenas prácticas de programación**, como modularidad, estilo de código, uso de **TADs opacos**, pruebas unitarias, pruebas de caja negra, programación defensiva y gestión correcta de memoria.

Otro objetivo importante es el uso de mecanismos de **comunicación y concurrencia en UNIX**, como semáforos y procesos concurrentes, destacando cómo estas primitivas se reflejan en la estructura de un shell.

En un segundo proyecto, se implementan **semáforos nombrados** en **xv6-riscv**, inspirados en los definidos por **POSIX**. Estos semáforos son recursos del **kernel** accesibles globalmente por los procesos, y se identifican con números enteros (similares a descriptores de archivo). Se deben desarrollar **cuatro syscalls** (`sem_open()`, `sem_up()`, `sem_down()` y `sem_close()`) y un programa de prueba tipo **ping-pong** que demuestre su funcionamiento.

Por último, se estudia y modifica el **planificador de procesos de xv6-riscv**, que originalmente es apropiativo y sencillo. El objetivo es analizar su impacto en diferentes procesos y reemplazarlo por un **planificador MLFQ (Multilevel Feedback Queue)** de tres niveles. Se comienza registrando la **prioridad de los procesos** sin modificar el algoritmo, y luego se analiza cómo el nuevo planificador afecta la distribución del tiempo de CPU en comparación con el original.
