# Laboratorios de Paradigmas de la Programación 
Estos proyectos abordan distintos paradigmas de programación (funcional, orientado a objetos y procesamiento distribuido), con el objetivo de resolver problemas reales mediante herramientas y enfoques modernos.

---

### **Primer Proyecto – DSL en Haskell (Paradigma Funcional):**

El proyecto propone desarrollar un pequeño **lenguaje de descripción específico (DSL)** en **Haskell**, centrado en representar **figuras geométricas** complejas a partir de componentes simples y transformaciones (como rotar, apilar o juntar). Se pone énfasis en la separación entre **tipos de datos** y **funciones que operan sobre ellos**, así como en el uso de **polimorfismo** y **funciones de alto orden**.

Además, se trabajan habilidades transversales como:

* Aprender un lenguaje nuevo (Haskell).
* Leer y adaptar documentación técnica.
* Trabajar en equipo usando **control de versiones (git)**.

El proyecto culmina con una **implementación funcional de un DSL gráfico**, basado en el artículo de Peter Henderson, donde la **semántica** del lenguaje se refleja en un dibujo visible en pantalla.

---

### **Segundo Proyecto – Lector de Feeds en Java (POO):**

Este laboratorio se centra en la implementación de un **lector de feeds RSS** usando **Java** y el **paradigma orientado a objetos**. El programa funciona como aplicación de consola y permite al usuario configurar los sitios y temas de interés mediante un archivo `.json`. El sistema descarga y muestra los artículos de forma legible, y también analiza los contenidos para **identificar las entidades nombradas más frecuentes** (por ejemplo, personas, lugares, organizaciones).

---

### **Tercer Proyecto – Lector de Feeds + Big Data con Apache Spark:**

Extensión del proyecto anterior, ahora utilizando **Apache Spark** para procesar grandes volúmenes de datos de forma distribuida. El objetivo es escalar el lector de feeds para que pueda:

* Descargar y parsear múltiples feeds en paralelo (un worker por feed).
* Contar entidades nombradas en paralelo por artículo (un worker por artículo).

El sistema presenta al usuario un resumen final con el **conteo global de entidades nombradas**. Spark permite concentrarse en qué computar (lógica de negocio), dejando la **paralelización y gestión de recursos** a cargo del framework.
