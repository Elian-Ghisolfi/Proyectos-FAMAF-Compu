# Laboratorios de Redes y Sistemas Distribuídos

Este conjunto de proyectos se enfoca en el desarrollo de aplicaciones de red y simulaciones, abarcando desde la **capa de aplicación** hasta la **capa de red** del modelo OSI, usando tecnologías como **sockets en Python**, **Flask**, y el simulador **OMNeT++**.

---

**Proyecto 0 – Cliente HTTP y Sockets:**
Se introduce la **programación cliente-servidor con sockets**, centrándose en el rol del **cliente**. Se analiza el protocolo **HTTP** según la RFC 2616, y se estudia un cliente desarrollado en **Python** llamado `hget`, que descarga páginas web. El objetivo es familiarizarse con el uso de protocolos reales y comprender código Python no trivial.

---

**Primer Proyecto – API REST con Flask:**
Se construye una **API REST** en Python usando el framework **Flask**, que gestiona una base de datos de películas. Se agregan funciones como **filtrar por género** e **integración con una API externa de feriados** para recomendar películas según la fecha. El proyecto incluye la **configuración del entorno con virtualenv**, pruebas exhaustivas, y buenas prácticas de desarrollo (seguridad, escalabilidad, estado HTTP, etc.). Se debe entregar el código en un repositorio junto a un **video de presentación**.

---

**Segundo Proyecto – Servidor de archivos HFTP:**
Se implementa un **servidor de archivos en Python** utilizando un **protocolo de aplicación diseñado ad-hoc** llamado **HFTP** (Home-made File Transfer Protocol), basado en TCP. El protocolo usa comandos y respuestas en texto (ASCII), con sintaxis clara y ordenada. El servidor responde a comandos como descarga de archivos o cierre de conexión, y debe cumplir con los principios de robustez, estructura clara del protocolo y comunicación secuencial cliente-servidor.

---

**Tercer Proyecto – Capa de Transporte con OMNeT++:**
Se trabaja en la **simulación de redes** utilizando **OMNeT++**, enfocándose en la **capa de transporte**. Se analiza el comportamiento del **tráfico de red bajo condiciones de congestión**, considerando tasas de datos y buffers limitados. Los estudiantes deben diseñar **soluciones de control de flujo y congestión**, y presentar los resultados en un informe en **Markdown** que incluya un anexo detallando el uso de herramientas de inteligencia artificial como ChatGPT, si las hubieran utilizado.

---

**Cuarto Proyecto – Capa de Red y Enrutamiento:**
También con OMNeT++, este proyecto se enfoca en la **capa de red**, trabajando sobre un **modelo de topología en anillo**. Se analizan estrategias de **enrutamiento** y se diseñan soluciones para distintas configuraciones de red. Se requiere la presentación de un informe técnico similar al del proyecto anterior, con un **anexo sobre el uso de IA** y validación de las respuestas obtenidas si se utilizaron asistentes inteligentes.

