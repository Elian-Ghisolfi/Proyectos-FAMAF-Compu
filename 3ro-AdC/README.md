# Laboratorios de Arquitectura de Computadoras 
Estos proyectos abordan el diseño, la implementación a nivel lógico y el análisis de rendimiento de microprocesadores basados en la arquitectura ARMv8. El objetivo principal es comprender el funcionamiento interno del hardware, la gestión de memoria y cómo las decisiones microarquitectónicas impactan directamente en la ejecución del software de bajo nivel.

---

### **Primer Proyecto – Procesador ARMv8 con Pipeline en SystemVerilog (Hardware):**

El proyecto propone el desarrollo e implementación de un microprocesador **ARMv8 (LEGv8)** utilizando lenguajes de descripción de hardware (**SystemVerilog**). Se parte de una arquitectura de ciclo único hasta lograr un diseño avanzado con **segmentación de cauce (pipeline)**, requiriendo la modificación profunda del *datapath* y la unidad de control.

Se pone énfasis en el diseño de circuitos secuenciales y combinacionales, además de trabajar habilidades de resolución de problemas a muy bajo nivel:

* **Gestión de Hazards:** Detección y solución de riesgos de datos y de control, inicialmente mediante la inserción de instrucciones *NOP* por software, y posteriormente escalando a soluciones por hardware mediante la implementación de unidades de **Forwarding** y **Hazard Detection (Stall)**.
* **Mapeo de Entrada/Salida (E/S):** Integración de un bloque GPIO mapeado en memoria (dirección `0x8000`) para controlar periféricos físicos (16 LEDs y 16 switches), programando rutinas interactivas directamente en **Assembler**.
* **Validación y Síntesis:** Uso extensivo de *testbenches* para el análisis de formas de onda y comprobación de resultados utilizando Vivado.

**Tecnologías utilizadas:** SystemVerilog, Vivado (Xilinx), Assembler ARMv8/LEGv8, Placas FPGA (Boolean board).

---

### **Segundo Proyecto – Análisis de Microarquitecturas y Rendimiento (Simulación):**

Este laboratorio se centra en evaluar cómo distintas características microarquitectónicas afectan el rendimiento global de un procesador al ejecutar rutinas de alta carga computacional (microbenchmark *Daxpy* de LINPACK).

Utilizando un entorno simulado, el proyecto exige realizar mediciones precisas, graficar métricas (ciclos ociosos, *hits* de lectura) y justificar los resultados basándose en el código fuente escrito. Los ejes analizados incluyen:

* **Jerarquía de Memoria:** Comparación de la performance variando el tamaño de la memoria caché de datos (8KB, 16KB, 32KB) y sus políticas de mapeo (directo vs. asociativa por conjuntos de 2, 4 y 8 vías).
* **Predicción de Saltos:** Evaluación del *miss rate* comparando un predictor de saltos local básico contra un **predictor por torneos** (híbrido local/global).
* **Ejecución Dinámica:** Contraste de rendimiento entre microprocesadores con ejecución **En Orden (in-order)** y ejecución **Fuera de Orden (out-of-order)**.
* **Optimización de Software:** Aplicación de técnicas estáticas como *loop unrolling* e instrucciones condicionales en **Assembler** para maximizar el rendimiento del hardware disponible.

**Tecnologías utilizadas:** Simulador gem5 (sobre contenedores Docker), Assembler ARMv8, C, QEMU.