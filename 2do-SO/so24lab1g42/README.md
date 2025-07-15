# LAB01-GEEK

# Tips para el desarrollo colaborativo
- Usar `git status` antes de hacer un commit para evitar subir binarios, logs y otros archivos innecesarios.
- Usar `git pull` antes de empezar a trabajar. Si bien la idea es modularizar el trabajo para evitar las confusiones, nunca está de más verificar si hubo cambios en un archivo que vamos a modificar, así evitar posibles conflictos de fusión.
- Usar `clangd` si no se usa Visual Studio Code. `clangd` es un servidor de lenguaje (LS o LSP) que puede integrarse con Vim u otros editores de texto. De usar `clangd`, se recomienda usar `bear` para generar un snapshot del proceso de construcción y así obtener el autocompletado y demás funcionalidades. Ya que usamos `make`, simplemente con correr `make clean; bear -- make` se genera un archivo `compile_commands.json` que permite a `clangd` funcionar correctamente.
- Usar `clang-format` (disponible en la mayoría de distribuciones, puede compilarse desde el código fuente también) para dar un formato estándar al código. Pudiéndose automatizar, se recomineda correr, desde la raíz del proyecto, `clang-format ./*.c -i` (ó `clang-format-{VERSION} ./*.c -i` en caso de haber instalado una versión en específico). Esto dará formato al código fuente únicamente, sin tocar tests ni outputs.

> Nota: usando Visual Studio Code: si no funciona el autocompletado o muestra errores para encontrar `glib.h`, agregar `/usr/include/**` y `/usr/lib/**` a la propiedad `includePath` del archivo `.vscode/c_cpp_properties.json`.

# Sobre el proyecto

## Objetivo del proyecto
Codificar un shell al estilo de bash (Bourne Again SHell) al que llamaremos mybash. El programa debe tener las siguientes funcionalidades generales:

- Ejecución de comandos en modo foreground y background 

- Redirección de entrada y salida estándar.

- Pipe entre comandos.

### Implementaciones esperadas
- Implementar los comandos internos  cd, help y exit.

- Poder salir con CTRL-D, el caracter de fin de transmisión (EOT).

- Ser robusto ante entradas incompletas y/o inválidas.

Para la implementación se pide en general:

- Utilizar TADs opacos.
- No perder memoria.
- Seguir buenas prácticas de programación (coding style, modularización, buenos comentarios, buenos nombres de variables, uniformidad idiomática, etc).


### Los requisitos de entrega

- Pasar el 100% del unit-testing (make test) dado para todo el proyecto.

- Manejar pipelines de dos comandos.

- Manejar de manera adecuada la terminación de procesos lanzados en segundo plano con &, sin dejar procesos zombies.

- Preservar las buenas prácticas de programación ya adquiridas durante los cursos anteriores (Algoritmos I y II).

## Modularizacion
Para la implementación de este laboratorio se propone una división en 6 módulos:

- mybash: módulo principal

- command: módulo con las definiciones de los TADs para representar comandos

- parsing: módulo de procesamiento de la entrada del usuario usando un parser

- parser: módulo que implementa el TAD parser

- execute: módulo ejecutor de comandos, administra las llamadas al sistema operativo

- builtin: módulo que implementa los comandos internos del intérprete de comandos.

### Modulo execute
En un principio buscamos una perspectiva “destructiva” o “consumista” para ejecutar los pipelines, haciendo “pop” de un comando una vez que se consumía. Esto funcionaba bien para dos, tres comandos. 

Pero se empezó a complicar cuando quisimos generalizar para una cantidad arbitraria de ellos. Entonces, creamos una función auxiliar que nos devolviera el i-ésimo comando de un pipeline y eso nos permitió entonces buscar un acercamiento “iterativo” para resolver el problema. Ahora, sabiendo que cada comando se comunica con el anterior (o el siguiente) a través de UN pipe, tenemos que para una cantidad N de comandos, necesitaremos N - 1 pipes, puesto que el primer comando se comunica con el segundo a través del primer pipe, el segundo con el tercero a través del segundo pipe y así sucesivamente. 

Decidimos entonces crear dos arreglos dinámicos que guardan por un lado las PIDs de los procesos que vamos creando y por otro los pipes que los comunican. Si no tuviéramos más que un comando, es innecesario crear un pipe, por lo que tomamos en cuenta el largo del pipeline a la hora de crearlos. A diferencia de nuestros primeros intentos que no salían del bucle hasta tener un pipeline vacío, ahora simplemente iteramos sobre cada uno de los comandos en el pipeline, cerrando todos los pipes que no corresponden y solo permitiendo leer del pipe anterior y escribir en el actual. Luego, reescribimos el procedimiento de configuración de las redirecciones para, en base al resultado de la función open() cambiar o no las puntas del pipe usado por el comando actual. Agregamos también un pequeño detalle que muestra el PID de un proceso que vaya a correr en segundo plano, a modo de equivalencia con BASH. 

Una vez que ejecutamos el comando, cerramos las puntas usadas de los pipes y continuamos iterando. Una vez finalizado ese proceso, cerramos todos los pipes y liberamos la memoria que hayan utilizado, También, si en el pipeline no hay algún proceso que corra en segundo plano, esperamos que todos terminen para cerrar. Finalmente, liberamos el arreglo de PIDs que habíamos generado. Este proceso de adaptación nos permitió, de forma directa, compilar sin problemas y pasar todos los tests, pero a su vez generalizar de forma segura la ejecución de una cantidad arbitraria de comandos, problemática que en el anterior acercamiento se nos había dificultado.

### Modulo builtin
Comenzamos la implementación del módulo utilizando un ciclo "destructivo" del cmd mientras verificamos y ejecutamos con un case (if else if) pero esta forma de encarar el problema nos trae errores en el módulo execute ya que destruíamos el cmd que luego se utilizaba. Entonces luego de arreglar y cambiar la forma en la que se implementa el módulo execute buscamos una forma de implementar el módulo builtin que sea extensible para que se pueda agregar nuevos comandos internos y que no sea un case enorme, utilizamos una estructura de datos simple con dos parámetros pero compleja ya que uno de los parámetros se trataba de un puntero a función, luego de buscar información pudimos implementarla sin problemas ya que solo había que identificar que comando interno era y este estaba asociado a una funcion que se ejecutaba. Pasando todos los test y los comandos necesarios.  

## Test unitarios

El proyecto cuenta con un conjunto de pruebas unitarias (unit testing) para los dos módulos a implementar, que se puede llamar desde el Makefile:
  
 - **Pruebas de command.c (scommand y pipeline):**
```bash
make test-command
```
    
-    **Pruebas de parsing.c:**
```bash
make test-command
```

- **Pruebas para todos los módulos juntos:**
```bash
make test
```

- **Pruebas de manejo de memoria en los módulos:**
```bash
make memtest
```

## Integrantes del grupo
- Integrante 1: Nicolas Jorge.

- Integrante 2: Ticiano Morvan.

- Integrante 3: Elian Ghisolfi.

## Profesor a cargo
- Profesor: Matias Bordone