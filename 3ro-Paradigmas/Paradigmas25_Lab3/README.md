# Laboratorio 3 - Frameworks - Computación Distribuida con Apache Spark

## Configuración del entorno y ejecución
Si el usuario Mantiene la creación de la sesión de spark con el master en `.master("local[*]")`, la sesión será creada en un entorno local, ejecutando todo en la JVM local sin que halla una configuracion de cluster real, ya que es simulada con hilos dentro de un solo proceso. En cambio al cambiar el master por una direccion `.master("spark://localhost:7077")`(local host por el momento), se está configurando y ejecutando el Master de Spark y los Workers que sean necesarios, simulando un entorno distribuido real dentro de la misma JVM, con comunicacion en red.

## Decisiones de diseño

Las entidades nombradas las guardamos como `List<NamedEntity> namedEntities`.
Utilizamos `parallelize()` para los workers.
`implements Serializable` por herencia de Spark.
El ejecutable muestra todas las entidades que encontró en los feeds.

## Conceptos importantes
1. **Flujo de la Aplicación**
El sistema sigue un flujo de procesamiento distribuido en 5 etapas clave:

    a. Inicialización de Spark.
    La aplicación comienza configurando una sesión local de Spark con todos los núcleos disponibles (local[*]), creando el contexto fundamental para el procesamiento paralelo.

    b. Carga y distribución de fuentes:
    El SubscriptionParser lee y parsea el archivo JSON de suscripciones (feeds.json).
    Se transforma en una lista de tuplas (URL, parámetro).
    Spark distribuye estas tuplas en un RDD particionado (5 particiones).

    c. Procesamiento paralelo de feeds.
    Cada worker de Spark:
    Realiza peticiones HTTP concurrentes mediante httpRequester.
    Parsea el XML/RSS obtenido usando RssParser.
    Maneja errores individualmente (feeds nulos se filtran luego).

    d. Extracción de entidades nombradas.
    Para cada feed válido:
    Se aplica la QuickHeuristic para identificar entidades.
    Se calculan frecuencias de aparición.
    Las entidades se agrupan por feed.

    e. Consolidación de resultados.
    Spark recolecta los resultados en memoria tratando de mantener el orden original.

2. **Justificación de Apache Spark**

    Problema central resuelto: El procesamiento eficiente de múltiples fuentes RSS/Atom con requerimientos de:
    Alto volumen (decenas de feeds).
    Tiempo real (actualizaciones frecuentes).
    Cómputo intensivo (análisis semántico).
    Ventajas específicas:
    Escalabilidad horizontal: El mismo código funciona para 5 o 500 feeds.
    Tolerancia a fallos: Un feed corrupto no detiene el proceso completo.
    Optimización de recursos: Procesamiento en memoria evita I/O disk.

    Caso de uso: Al procesar 50 feeds de medios internacionales, Spark distribuye automáticamente la carga entre los núcleos, reduciendo el tiempo.

3. **Ventajas y Desventajas de Spark**
    Ventajas:
    Abstracción eficiente: Los RDDs ocultan la complejidad del paralelismo.
    Pipeline optimizado: Fusiona operaciones automáticamente (map + filter).
    Manejo elegante de nulos: Operaciones como filter(Objects::nonNull) simplifican el código.

    Desventajas:
    Overhead en pequeños datasets: Para <10 feeds, la configuración supera el beneficio.
    Debugging complejo: Los stack traces distribuidos son difíciles de rastrear.

    Ejemplo problemático: Al procesar feeds con formatos XML inconsistentes, los errores se reportan como NullPointerException genéricos sin indicar claramente el feed culpable.

4. **Inversión de Control en el Proyecto**

    El flujo delega control en:

    a. Framework Spark:
    Gestiona la planificación de tareas.
    Controla el ciclo de vida de los RDDs.
    Decide el orden de ejecución de operaciones (lazy evaluation).

    b. Componentes especializados:
    RssParser: Implementa el patrón Strategy para diferentes formatos XML.
    Heuristic: Clase abstracta que delega la lógica de detección a QuickHeuristic.

    c. Control invisible:
    El desarrollador no decide qué feed se procesa en qué núcleo.
    Spark optimiza automáticamente operaciones como collect().
    La heurística se aplica sin control sobre el orden de procesamiento.

5. **Integración de Spark**

    Loose coupling predominante gracias a:

    Interfaces claras entre componentes (Parser ↔ Feed ↔ Heuristic).
    Serialización automática de objetos entre nodos.
    Introducir dependencias de forma natural (ej: Heuristic en ProcessNamedEntity).

    Excepciones tight-coupled:
    La clase Feed debe ser serializable (requisito Spark).
    Los RDDs imponen un modelo específico de transformaciones.

    Balance: Spark incentiva un diseño modular (70% loose) pero exige ciertas convenciones (30% tight) para la distribución eficiente.

6. **Uso de Spark vs la estructura de su código original**

    Tuvimos que modificar bastantes métodos y formas de organizar los package, ya que no cumplían correctamente con el encapsulamiento y la modularización. En el proceso adoptamos varias forma de mirar las entidades nombradas ya que pudimos expresarlas como `List<NamedEntity>` o como un `Map<String, Int>`. También tuvimos complicaciones de como utilizábamos los feed y en que formato los almacenábamos.
    Finalmente luego de mucha prueba y error definimos todos los modulos como necesitábamos y pudimos lograr de forma exitosa la parte 1 del laboratorio.


