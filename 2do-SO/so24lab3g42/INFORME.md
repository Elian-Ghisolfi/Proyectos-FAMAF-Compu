# INFORME: PLANIFICADOR DE PROCESOS

## Primera parte: Estudiando el planificador de xv6 RISC-V

Analizando el archivo `proc.c` mas precisamente la función `scheduler()` podemos entender la forma en la que xv6 planifica los procesos esto es a través de una cola donde se ejecuta el primer proceso cuyo state sea RUNNABLE, el mismo será ejecutado hasta que finalice o se bloqueé esperando algún evento. 

~~~
intr_on();

    for(p = proc; p < &proc[NPROC]; p++) {
      acquire(&p->lock);
      if(p->state == RUNNABLE) {
        // Switch to chosen process.  It is the process's job
        // to release its lock and then reacquire it
        // before jumping back to us.
        p->state = RUNNING;
        c->proc = p;
        swtch(&c->context, &p->context);

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
      }
      release(&p->lock);
    }  
~~~

En el manual de xv6 se explica que pueden existir dos eventos donde se bloquee el proceso primero por un cambio voluntario donde el proceso debe esperar una llamada del sistema I/O donde puede entrar en SLEEPING y el segundo caso sucede un cambio involuntario donde xv6 fuerza periódicamente un context switch para hacer frente a los procesos que computan durante largos períodos. En cuyo caso el proceso no tenga state RUNNABLE se mandaran al final de la cola para esperar a que los demás procesos se ejecuten y ceden la CPU esta politica de planificacion es conocida como RR(Round Robin).
Ademas en el código no se evidencia ninguna tipo de prioridad para los procesos que están en la cola/arreglo `proc[NPROC]` ya que si el proceso deja de estar running por cualquier cambio voluntario o involuntario vuelve al final de cola.

En `proc.h` podemos encontrar la estructura principal `proc` y la definición de los posibles estados que puede tener un proceso  

~~~
enum procstate { UNUSED, USED, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };

// Per-process state
struct proc {
  struct spinlock lock;

  // p->lock must be held when using these:
  enum procstate state;        // Process state
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  int xstate;                  // Exit status to be returned to parent's wait
  int pid;                     // Process ID

  // wait_lock must be held when using this:
  struct proc *parent;         // Parent process

  // these are private to the process, so p->lock need not be held.
  uint64 kstack;               // Virtual address of kernel stack
  uint64 sz;                   // Size of process memory (bytes)
  pagetable_t pagetable;       // User page table
  struct trapframe *trapframe; // data page for trampoline.S
  struct context context;      // swtch() here to run process
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)
};
~~~

Hablamos de varios estados por los que puede pasar un proceso vamos a profundizar sobre eso (analizamos la `struc proc` y el manual de xv6):

 - **UNUSED**: El proceso creado no fue inicializada, es decir, que su estructura no esta asociada a un proceso activo por ende no puede correr en el kernel, esto no solo sucede al inicializar si no tambien cuando un proceso finaliza.
 - **USED**: la estructura del proceso fue inicilizada. Se le dio un PID que su numero de identificacion (no se restauran y siempre crecen), un _trapframe_ para manejar los traps, una _user table_ para el mapeo de direcciones y la configuracion del contexto del proceso.
 - **SLEEPING**: El proceso esta bloqueado dado que sufrio un cambio voluntario(esperando una llamada de sistema I/O) o un cambio involuntario (sufrio una timer interrups debe esperar en la cola). 
 - **RUNNABLE**: Proceso listo para ser ejecutado por una CPU, asi será cuando esté llegue a su turno en la cola de procesos.
 - **RUNNIG**: Proceso que se está ejecutando actualmente en la CPU, solo se ejecutará un proceso cuando su estado anterior sea _RUNNABLE_ y se el primero en la cola de procesos.
 - **ZOMBIE**: Es un proceso que ya finalizó su ejecucion pero su estructura sigue ligada y no se liberó para otro proceso.

Retomando el tema de timer interrups, un *quantum* es la unidad básica de tiempo que se le asigna a un proceso para ejecutarse antes de que el planificador considere un cambio de contexto,es decir, el intervalo de tiempo entre interrupciones del timer. Este ayuda esencialmente a prevenir que un proceso monopolice la CPU, permite una distribución justa del tiempo de CPU entre procesos y es fundamental para el funcionamiento del scheduler round-robin que utiliza xv6. Observando `start.c` donde se define la cantidad de ciclos/unidad de tiempo/ticks, `trap.c` donde se define la interrupciones y el manual de xv6 vemos que el registro stimecmp contiene un tiempo en el que la CPU generará una timer interrups, un interrupcion se genera cuando suceden 1000000 ciclos; aproximadamente 100 ms en qemu RISC-V. En la información que nos proporciona la función vemos que este timer interrups es software interrupts.

~~~
void timerinit()
{
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();

  // ask the CLINT for a timer interrupt.
  // originally set just at 1000000, which was a 1/10th of a second.
  int interval = 1000000; // cycles; about one 1/10th of a second in qemu.
  *(uint64 *)CLINT_MTIMECMP(id) = *(uint64 *)CLINT_MTIME + interval;

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
  scratch[3] = CLINT_MTIMECMP(id);
  scratch[4] = interval;
  w_mscratch((uint64)scratch);

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
}
~~~

Luego de cada cambio involuntario o voluntario el planificador realiza un _context switch_ que, como vimos, puede ser debido Timer interrups, llamada al sistema o esperar I/O. La funcion madre que se encarga es `scheduler()` que elige un proceso B _RUNNEABLE_ para que se ejecute pero antes de ese paso `switch()` se encarga de primero guardar en una `struc context` el contexto actual del proceso A, es decir, se guarda su PC, registros generales, stack pointer, frame pointer. Para luego finalizar con el _context switch_ quedando el proceso B ejecutando en la CPU. Este proceso es atomico, es decir, que el cambio se produce completamente o no se produce esto ayuda a que se generen cruces entre contextos de procesos.

En xv6, cada cambio de contexto consume tiempo del *quantum* de CPU asignado al proceso entrante. Este consumo se debe a que el cambio de contexto es un proceso que involucra:

Guardar el Estado del Proceso Saliente: Al hacer un cambio de contexto, el scheduler guarda el estado del proceso actual (registros, contador de programa, y stack).

Cargar el Estado del Proceso Entrante: El scheduler carga el estado del próximo proceso en la cola de ejecución, permitiéndole continuar desde donde fue interrumpido.

Este proceso de guardar y restaurar el estado del CPU requiere ciclos de CPU que consumen tiempo de ejecución normal del proceso entrante lo que significa que efectivamente se reduce el tiempo útil del *quantum* disponible para el proceso.


## Experimento 1 Round Robin

En este primer experimento debemos medir el rendimiento de planificador del tipo R.R, para hacer esto utilizamos 2 programas de los cuales 1 realiza muchas operaciones I/O y otro realiza muchas operaciones cpubound.
Tanto en el programa cpubench y el programa iobench contamos con 2 parámetros los cuales podemos modificar.

En el CPUBENCH buscamos realizar operaciones que consumen mucha cpu, por lo que se optó por realizar la multiplicación de 2 matrices de gran escala, una cantidad repetida de veces. Los parámetros a definir en este programa son los siguientes: 
 - **CPU_MATRIX_SIZE**: el cual define el tamaño de la matriz que multiplicaremos. En nuestro caso está definida como una matriz 128x128.
 - **CPU_EXPERIMENT_LEN**: el cual define la cantidad de veces que se multiplicaran 2 matrices de tamaño 128x128.

En el IOBENCH buscamos realizar muchas operaciones de entrada y salida (I/O), por lo que el programa abre el archivo en modo de escritura y, mediante un bucle, realiza una cantidad de 16.384 escrituras consecutivas, cada una de 512 bytes. Luego abre el mismo archivo en modo lectura y realiza 16.384 lecturas, cada una de 512 bytes. Los parámetros a definir son los siguientes:
 - **IO_OPSIZE**: el cual define el tamaño de cada operación de I/O. En nuestro caso está definida de 512 bytes.
 - **IO_EXPERIMENT_LEN**: el cual define el número de operaciones de escritura y lectura que se realizarán, En nuestro caso está definida 16.384.

En ambos programas se debe definir el parámetro N, el cual define la cantidad de ciclos (veces que se ejecutara) el experimento.

Es evidente que nuestro sistema operativo no puede ejecutar procesos en paralelo ya que nosotros forzamos al inicio del emulador QEMU que se trabaje con una sola CPU pero cuando tiene varios procesos que ejecutar xv6 trabajará con un planificador Round-Robin que utiliza una cola de procesos donde se le asigna un *quantum* y pueden o no ser bloqueadas de forma voluntaria esperando repuestas I/O o involuntarias cuando se les acaba el *quantum* o se genera una interrupción del sistema.

Vamos a comparar dos escenarios uno donde la CPU corre un solo procesos CPU-Bound y otro donde se corren 3 procesos CPU-Bound
Escenario C: 

| ID | EXPERIMENTO | CANTIDAD DE OPS POR TICK | TICK INICIO | TICK TRANSCURRIDOS |
| -- | ----------- | ------------------------ | ----------- | ------------------ |
| 4  | [cpubench]  | 13420                	| 3443    	| 40             	|
| 4  | [cpubench]  | 13420                	| 3483    	| 40             	|
| 4  | [cpubench]  | 13420                	| 3523    	| 40             	|
| 4  | [cpubench]  | 13420                	| 3564    	| 40             	|
| 4  | [cpubench]  | 13420                	| 3604    	| 40             	|

Escenario D: 

| ID | EXPERIMENTO | CANTIDAD DE OPS POR TICK | TICK INICIO | TICK TRANSCURRIDOS |
| -- | ----------- | ------------------------ | ----------- | ------------------ |
| 5  | [cpubench]  | 4473                 	| 3708    	| 120            	|
| 7  | [cpubench]  | 4473                 	| 3709    	| 120            	|
| 8  | [cpubench]  | 4473                 	| 3710    	| 120            	|
| 7  | [cpubench]  | 4473                 	| 3829    	| 120            	|
| 8  | [cpubench]  | 4473                 	| 3830    	| 120            	|
| 5  | [cpubench]  | 4473                 	| 3831    	| 120            	|
| 7  | [cpubench]  | 4473                 	| 3949    	| 121            	|
| 8  | [cpubench]  | 4473                 	| 3950    	| 120            	|
| 5  | [cpubench]  | 4473                 	| 3951    	| 120            	|
| 7  | [cpubench]  | 4473                 	| 4069    	| 120            	|
| 5  | [cpubench]  | 4473                 	| 4071    	| 120            	|
| 8  | [cpubench]  | 4473                 	| 4073    	| 120            	|
| 7  | [cpubench]  | 4473                 	| 4189    	| 120            	|
| 5  | [cpubench]  | 4511                 	| 4191    	| 119            	|
| 8  | [cpubench]  | 4511                 	| 4193    	| 119            	|

Podemos ver en el escenario C qué el proceso CPU-Bound puede ejecutar toda su secuencia de manera consistente y eficiente con un total 13420 operaciones por tick. Cuando en el escenario D ponemos a competir 3 procesos CPU-Bound vemos que inician de manera secuencial por sus Tick de inicio y tantos los ticks transcurridos como la cantidad de operaciones por tick se comportan de manera casi lineal ya que los ticks transcurridos aumentan el triple y el rendimiento de las operaciones  disminuye un tercio, esto se debe por que los procesos consumen sus quantums de forma efectiva y no vuelven a tener a la CPU disponible (no la monopolizan) ya que sucede un context switch hacia otro proceso.

En el siguiente grafico vamos a ver como las variables **Cantidad de ops por tick** y **Ticks transcurrido** se comportan de forma casi lineal a medida de aumentamos los procesos **CPU-BOUND** en paralelo.

![Grafica 1: Cantidad de ops por tick frente a procesos en paralelo](https://i.imgur.com/9YEgJrG.png)

![Grafica 2: Ticks transcurridos frente a procesos en paralelo](https://i.imgur.com/uXBPk7U.png)

Esto reafirma la idea de que nuestro SO **XV6-RISCV** utiliza un planificador tipo RR (Round-Robin) ya que cada proceso tiene el mismo *quantum*, usan de forma eficiente su tiempo de cpu para realizar las operaciones pertinentes y la cola de procesos es consistente a medida de crece la cantidad de procesos en paralelo sin tomar a ninguno de prioridad y cederle mayor *quantum*.

Realizaremos el mismo análisis con dos escenarios uno donde la CPU corre un solo procesos I/O-Bound y otro donde se corren 3 procesos I/O-Bound.

Escenario A: 

| ID | EXPERIMENTO | CANTIDAD DE OPS POR TICK | TICK INICIO | TICK TRANSCURRIDOS |
| -- | ----------- | ------------------------ | ----------- | ------------------ |
| 4  | [iobench]   | 89                   	| 3276    	| 366            	|
| 4  | [iobench]   | 98                   	| 3649    	| 333            	|
| 4  | [iobench]   | 98                   	| 3988    	| 334            	|
| 4  | [iobench]   | 96                   	| 4329    	| 340            	|
| 4  | [iobench]   | 97                   	| 4676    	| 335            	|

Escenario B: 

| ID | EXPERIMENTO | CANTIDAD DE OPS POR TICK | TICK INICIO | TICK TRANSCURRIDOS |
| -- | ----------- | ------------------------ | ----------- | ------------------ |
| 8  | [iobench]   | 39                   	| 2848    	| 833            	|
| 7  | [iobench]   | 37                   	| 2847    	| 864            	|
| 5  | [iobench]   | 36                   	| 2849    	| 888            	|
| 8  | [iobench]   | 42                   	| 3681    	| 777            	|
| 7  | [iobench]   | 39                   	| 3712    	| 827            	|
| 5  | [iobench]   | 38                   	| 3735    	| 848            	|
| 5  | [iobench]   | 39                   	| 4583    	| 824            	|
| 7  | [iobench]   | 36                   	| 4539    	| 891            	|
| 8  | [iobench]   | 33                   	| 4458    	| 973            	|
| 7  | [iobench]   | 40                   	| 5431    	| 812            	|
| 8  | [iobench]   | 38                   	| 5431    	| 846            	|
| 5  | [iobench]   | 37                   	| 5407    	| 884            	|
| 7  | [iobench]   | 39                   	| 6243    	| 835            	|
| 8  | [iobench]   | 39                   	| 6277    	| 820            	|
| 5  | [iobench]   | 39                   	| 6291    	| 831            	|

A diferencia de los escenarios anteriores en el caso A la ejecución no es consistente ni efectiva ya que los ticks transcurridos para cada proceso oscilan en rangos de hasta 20 ticks esto se debe a las esperas para la escritura y lectura del disco, además de que las operaciones promedios por tick caen demasiado en comparación con un proceso CPU-Bound. En el escenario B NO vemos una crecimiento lineal de los ticks transcurridos y disminución de las operaciones por tick esto se debe a que el planificador aprovecha el momento donde el proceso se bloquea voluntariamente esperando I/O para ejecutar otro proceso. 

En los siguientes graficos de barras vamos a ver la variables **Ticks transcurridos** frente al inicio de cada proceso **I/O-BOUND** con diferente cantidad de procesos en paralelo.

![Grafico 3: Tick transcurridos frente a tick de inicio 1 procesos IO-BOUND](https://i.imgur.com/Bonzn3k.png)

![Grafico 4: Tick transcurridos frente a tick de inicio 2 procesos IO-BOUND](https://i.imgur.com/VnJ6Aua.png)

Gráfico 3 y Gráfico 4: Con menor cantidad de procesos en paralelo, se observa una menor variabilidad y **Ticks transcurridos** relativamente consistente. Esto indica que el sistema puede manejar estos procesos de manera eficiente sin tener tanta diferencia entre procesos.

![Grafico 5: Tick transcurridos frente a tick de inicio 3 procesos IO-BOUND](https://i.imgur.com/KGF80a9.png)


![Grafico 6: Tick transcurridos frente a tick de inicio 4 procesos IO-BOUND](https://i.imgur.com/CzF07Pu.png)

Gráfico 5 y Gráfico 6: Al aumentar a tres o cuatro procesos en paralelo, la dispersión en los **Ticks transcurridos** se hace más evidente, con picos muy altos de 1289 *ticks transcurridos* y picos muy bajo 887 *ticks transcurridos*, lo que sugiere una mayor competencia por los recursos de IO. En estas condiciones, el sistema presenta mayores tiempos de espera, lo que se traduce en una menor eficiencia general en el uso de la CPU debido a los continuos cambios de contexto.

Conforme aumenta el número de procesos IO-bound en paralelo, se observa un incremento en la cantidad de ticks necesarios para completar las tareas. 
Esto se debe a que los procesos IO-bound tienden a generar interrupciones más frecuentes en el CPU, ya que dependen de operaciones de entrada/salida que implican esperas mas largas.

En el escenario E se mandaron a ejecutar 1 proceso I/O-Bound y 2 procesos CPU-Bound al mismo tiempo para competir por la CPU, pudimos observar que todos los procesos se inician de forma secuencial pero con poca diferencia en el Tick de Inicio.

| ID | EXPERIMENTO | TICK INICIO |
| -- | ----------- | ----------- |
| 5  | [iobench]   | 4185        |
| 7  | [cpubench]  | 4186        |
| 8  | [cpubench]  | 4195        |

pero rápidamente el proceso I/O-Bound cede ante un interrupción voluntaria ya que tiene q esperar a las ops I/O, esto genera los procesos CPU-Bound monopolizan la CPU consumiendo sus quantums de forma completa y se ceden entre ellos de manera muy eficiente y consistente la CPU, esto se observa claramente en la cantidad de operaciones y ticks transcurridos entre cambios.

| ID | EXPERIMENTO | CANTIDAD DE OPS POR TICK | TICK INICIO | TICK TRANSCURRIDOS |
| -- | ----------- | ------------------------ | ----------- | ------------------ |
| 7  | [cpubench]  | 6546                 	| 4262    	| 82             	|
| 8  | [cpubench]  | 6710                 	| 4275    	| 80             	|
| 7  | [cpubench]  | 6546                 	| 4344    	| 82             	|
| 8  | [cpubench]  | 6710                 	| 4355    	| 80             	|
| 7  | [cpubench]  | 6546                 	| 4428    	| 82             	|
| 8  | [cpubench]  | 6710                 	| 4437    	| 80             	|
| 7  | [cpubench]  | 6546                 	| 4510    	| 82             	|
| 8  | [cpubench]  | 6882                 	| 4517    	| 78             	|

Como lleva muchos ciclos de CPU es decir lleva muchos ticks esperar las respuestas de I/O el proceso IO-Bound se ejecuta al final y requiere de muchos ticks para ejecutar una cantidad ínfima de operaciones.

| ID | EXPERIMENTO | CANTIDAD DE OPS POR TICK | TICK INICIO | TICK TRANSCURRIDOS |
| -- | ----------- | ------------------------ | ----------- | ------------------ |
| 5  | [iobench]   | 98                   	| 4958    	| 332            	|
| 5  | [iobench]   | 96                   	| 5290    	| 338            	|
| 5  | [iobench]   | 96                   	| 5628    	| 339            	|
| 5  | [iobench]   | 95                   	| 5967    	| 342            	|

Cabe recalcar que no es adecuado comparar directamente las operaciones CPU-bound e I/O-bound porque funcionan de manera distinta: los procesos CPU-bound utilizan la CPU de forma continua, maximizando operaciones por tick sin interrupciones, mientras que los procesos I/O-bound dependen de esperas para completar operaciones de entrada/salida, lo que reduce sus operaciones por tick. Como los CPU-bound aprovechan todo su quantum en cada turno y los I/O-bound suelen cederlo rápidamente, sus rendimientos no son comparables en este caso.


## Experimento 2 Round Robin

*Frecuencia de Ticks y Duración de los Procesos*:
 - **Ticks Transcurridos**: La mayor frecuencia de ticks permite ver con más precisión cuándo y cómo ocurren las interrupciones de CPU, ayudando a entender cómo se reparte el tiempo de procesamiento.
 - **Procesos cpubench**: Estos procesos tienen una ejecución en bloques de ticks relativamente constantes, lo que es típico en procesos de uso intensivo de CPU, pues requieren un uso continuo del procesador sin detenerse mucho a esperar eventos externos. La variabilidad entre 40,000 y 50,000 ticks indica intervalos cortos y frecuentes en los que el proceso necesita ser reprogramado, probablemente para evitar monopolizar la CPU.
 - **Procesos iobench**: La duración en ticks aquí es significativamente mayor, con intervalos que pueden alcanzar cientos de miles de ticks. Esto sugiere que estos procesos esperan a que se completen operaciones de entrada/salida, en las que la CPU no necesita estar involucrada activamente y, por lo tanto, estos procesos son intercambiados con menor frecuencia en el planificador.
 
*Comparación de Operaciones por Tick entre I/O-bound y CPU-bound*:
## Procesos Dependientes de Entrada/Salida (I/O-bound: iobench)
- **Descripción**: El proceso `iobench` realiza una cantidad considerable de ticks por cada operación de I/O.
- **Características**:
    - La cantidad de ticks por operación de I/O varía entre 9, 4, y eventualmente 3 ticks.
    - Esto implica que el proceso `iobench` experimenta tiempos de espera considerables entre operaciones, típico de procesos dependientes de tareas de entrada/salida.
    - Los tiempos de espera están distribuidos en bloques largos, como lo evidencian los intervalos de más de 100,000 ticks, reflejando una naturaleza de espera pasiva mientras el proceso aguarda respuestas de dispositivos de I/O.

## Procesos de Uso Intensivo de CPU (CPU-bound: cpubench)
- **Descripción**: El proceso `cpubench` realiza múltiples operaciones de CPU por tick.
- **Características**:
    - La cantidad de operaciones de CPU por tick en `cpubench` varía entre 3 y 14, con la mayoría de los bloques oscilando entre 10 y 12.
    - Esto refleja un uso constante y optimizado de la CPU, ya que el *scheduler* permite que el proceso ejecute la mayor cantidad de instrucciones de CPU posible dentro del quantum asignado antes de ser interrumpido.

*Distribución del Quantum entre Procesos CPU-bound*:
## Procesos de Uso Intensivo de CPU (CPU-bound)

### Proceso `cpubench` (ID 8)
- **Variación de Operaciones por Tick**: 
    - El proceso `cpubench` (ID 8) muestra una variación en la cantidad de operaciones por tick, fluctuando entre 3 y 14.
    - Esta variación podría reflejar ajustes en el *scheduler* para redistribuir los ciclos de CPU cuando otros procesos están en espera, optimizando el uso de la CPU.

### Proceso CPU-bound con 12 Operaciones por Tick (PID 7)
- **Consistencia en la Duración de Ticks**:
    - Los procesos CPU-bound que operan con 12 operaciones por tick (PID 7) mantienen una duración en ticks casi constante, generalmente en el rango de 42,000 a 45,000.
    - Esto sugiere una eficiencia consistente en la ejecución de operaciones de CPU bajo el nuevo régimen de ticks frecuentes, maximizando el uso de la CPU dentro de un quantum bien definido.
    
*Intercalación entre Procesos I/O-bound y CPU-bound*:
# Interacción entre Procesos I/O-bound y CPU-bound en el Scheduler

## Coexistencia de `iobench` y `cpubench`
- **Distribución de Tiempos de CPU en Alta Latencia de I/O**:
    - Cuando los procesos `iobench` y `cpubench` coexisten, el proceso `iobench` parece recibir más tiempo de CPU durante los periodos de alta latencia de I/O, es decir, cuando requiere menos recursos de CPU.
    - Este comportamiento puede explicarse porque el *scheduler* asigna los ticks de CPU a `cpubench` mientras `iobench` está en espera por operaciones de I/O, reduciendo así la competencia directa por los recursos.

- **Intervalos de Ejecución Diferenciados**:
    - Los intervalos de ejecución de `cpubench` son significativamente menores en comparación con `iobench`.
    - Esto sugiere que el *scheduler* permite que el proceso CPU-bound utilice la CPU en fragmentos cortos y frecuentes, mientras que el proceso I/O-bound permanece en espera. Esta distribución ayuda a optimizar el rendimiento general y asegura un uso eficiente de los recursos de CPU.    

# Análisis del planificador MLFQ
En esta sección analizaremos el comportamiento del planificador MLFQ, realizando los mismos experimentos que con el planificador original de xv6. Vale la aclaración de que reutilizamos los mismos parámetros para realizar estas pruebas.

## Implementación
Nuestra implementación del planificador MLFQ se respalda de dos nuevos campos en la estructura `proc` sobre la cual se definen todos los procesos de xv6. Podemos ver este cambio en `kernel/proc.h` donde tenemos:

```c
// kernel/proc.h

#define NPRIO 3

/* ...otras definiciones */

struct proc {
  // ...otras propiedades que necesitan adquirir la cerradura
  int priority;

  // ...otras propiedades que son privadas, por lo que no necesitan la cerradura
  uint64 selected;
}
```

Estos campos nos dan más información a la hora de decidir que proceso planificar y por qué. El campo `priority` depende de la macro `NPRIO` que define la cantidad de colas de prioridad que tendrá nuestro planificador. Por otro lado, el campo `selected` almacena la cantidad de veces que el proceso ha sido planificado.

Luego, ahora dentro del archivo `kernel/proc.c` tuvimos que modificar ciertas funciones para que la estructura `proc` funcionase con los nuevos campos.

```c
// kernel.proc.c

void
procinit(void)
{
  struct proc *p;
  // ...
  for (p = proc; p < &proc[NPROC]; p++) {
    // ...
    p->selected = 0; // Inicializamos en cero la cantidad de planificaciones.
    p->priority = NPRIO - 1; // Inicializamos el proceso con la máxima prioridad posible.
  }
}

static void
freeproc(struct proc *p)
{
  // ...
  p->selected = 0; // Reestablecemos la cantidad de planificaciones.
  p->priority = NPRIO - 1; // Reestablecemos la prioridad.
}

int
fork(void)
{
  struct proc *np;
  // ...
  acquire(&np->lock);
  np->state = RUNNABLE;
  // Le damos al nuevo proceso la prioridad máxima
  // Esto ayuda a que el proceso no inicie en una
  // prioridad menor al haber sido primero un proceso
  // que ya había sido planificado.
  np->priority = NPRIO - 1;
  release(&np->lock);
}

void
scheduler(void)
{
  struct proc *sp; // El proceso seleccionado.

  // ...
  for(;;){
    intr_on();
    sp = 0; // Arrancamos siempre desde un proceso nuevo.

    // Iteramos por cada nivel de nuestra cola de prioridades.
    for(int prio = NPRIO - 1; prio >= 0; prio--)
    {
      // En cada nivel, iteramos sobre cada proceso disponible.
      for (p = proc; p < &proc[NPROC]; p++)
      {
        // Descartamos procesos que no se puedan correr
        // o que no correspondan al nivel de prioridad.
        if (p->state != RUNNABLE || p->priority != prio)
          continue;

        // Seleccionamos el proceso si se puede correr,
        // es del nivel de prioridad y, si ya habíamos
        // seleccionado uno, comparamos la cantidad de
        // veces que ambos fueron seleccionados.
        if (!sp || p->selected < sp->selected)
          sp = p;
      }

      // Si ya encontramos un proceso, este debe ser
      // el de mayor prioridad y el que fue menos elegido,
      // luego, lo ejecutamos.
      if (sp)
        break;
    }

    // Verificamos que hayamos seleccionado un proceso.
    if (sp != 0)
    {
      acquire(&sp->lock);
      sp->state = RUNNING;

      // Incrementamos la cantidad de planificaciones del proceso.
      sp->selected++;

      c->proc = sp;
      swtch(&c->context, &sp->context);

      // Actualizamos la prioridad del proceso
      // en base a su estado final.
      update_priority(sp);

      c->proc = 0;
      release(&sp->lock);
    }
  }
}
```

Finalmente, agregamos a `procdump()` los datos necesarios para imprimir la prioridad y la cantidad de planificaciones de los procesos que están actualmente siendo planificados.

Con todo esto, pudimos implementar correctamente el planificador MLFQ en xv6 y realizamos pruebas necesarias para concluir los siguientes experimentos.

## Experimento 1
En los escenarios donde tenemos varios procesos del mismo benchmark, por ejemplo en el [escenario B](#markdown-header-escenario-b) o el [escenario D](#markdown-header-escenario-d), podemos ver que todos empiezan o _ciclan_ alrededor del mismo _tick_, por lo que la ejecución entre ellos es, a grandes rasgos, **secuencial**.
Cuando mezclamos ejecuciones de ambos _benchmark_, vemos que el `cpubench` toma siempre la mayor prioridad, ejecutándose al principio. Luego se ejecutan los procesos de `iobench`, que al quedarse esperando dan paso nuevamente a los otros.
Esto nos demuestra que el planificador está pudiendo diferenciar a los procesos por una política de **prioridad** que hemos establecido, donde si bien los procesos _CPU-bound_ pierden rápidamente su prioridad, lo compensan con la velocidad en su ejecución. Por otro lado, los procesos _I/O bound_ ascienden en prioridad pero pasan gran parte de su ejecución esperando por otras operaciones.

Para ver esto más de cerca, tomemos por ejemplo las siguientes entradas del [escenario F](#markdown-header-escenario-f):
```
5   [cpubench]   CPU ops BY TICK 5263   906   102
5   [cpubench]   CPU ops BY TICK 5315   1009   101
5   [cpubench]   CPU ops BY TICK 5368   1111   100
5   [cpubench]   CPU ops BY TICK 5263   1212   102
5   [cpubench]   CPU ops BY TICK 5368   1315   100
8   [iobench]   IO ops BY TICK 21   908   1492
7   [iobench]   IO ops BY TICK 21   908   1509
8   [iobench]   IO ops BY TICK 31   2402   1037
7   [iobench]   IO ops BY TICK 31   2417   1042
```

Podemos observar que tanto el proceso `cpubench` (con ID 5) como ambos procesos `iobench` (con IDs 7 y 8) comienzan alrededor del _tick_ 900. En el caso del proceso 5, vemos que efectúa consecutivamente las cinco ejecuciones que se le pasaron como argumento, para terminar alrededor del _tick_ 1300 con un promedio de operaciones por _tick_ de 5300 y una duración promedio de 100 _ticks_.
Por otro lado, los procesos 7 y 8 tardan alrededor de 1500 _ticks_ en terminar su primera ejecución, lo que luego disminuye a un promedio de 1040 _ticks_.
De este escenario concluimos que los procesos _I/O-bound_ son rápidamente degradados para dar paso a procesos _CPU-bound_ que, aunque desciendan rápidamente de prioridad, terminan de forma más rápida.

También es notable la pérdida de rendimiento al llevar a cabo más de una ejecución de un mismo proceso en paralelo, es así que una instancia única de `cpubench` puede tardar 100 _ticks_ en ejecutarse, mientras que tres de ellas tardan en promedio 300 _ticks_ para hacerlo. Esto se repite con los procesos de `iobench`, aunque no de forma tan lineal.
Entendemos que este suceso es causado, en ambos casos, por la _pérdida de protagonismo_ del proceso que antes podía ocupar libremente los recursos del sistema y que ahora debe compartirlos, además de que no puede ejecutarse por completo desde el inicio hasta el final, sino que durante su ejecución se avanza sobre los demás.

De todas maneras, es inevitable darnos cuenta de la diferencia sustancial entre estos dos tipos de procesos. Aquellos que dependen exclusivamente de la CPU ejecutan miles de instrucciones por _tick_, mientras que las que esperan por operaciones I/O apenas superan un par de decenas. Esto también se ve en la cantidad de _ticks_ que tarda cada una de estas ejecuciones, pasando de poco más de 100 _ticks_ para una ejecución indiviual de `cpubench` a más de 600 para una de `iobench`.
Ambas clases de procesos son necesarios para un desempeño eficiente y lógico de cualquier programa, pero el entender las diferencias de su ejecución puede brindarnos una mejor idea de como utilizar nuestros recursos más eficientemente y aprovechar mejor el tiempo disponible.

En correspondencia con las pruebas realizadas sobre el planificador original de xv6, pudimos notar una pequeña diferencia de rendimiento entre ambos planificadores. A continuación, visualizamos los resultados de ejecutar algunos escenarios en ambos.

![Operaciones por tick, escenario A](https://imgur.com/YdHfIuy.png)

![Ticks pasados por medición, escenario A](https://imgur.com/F9bLFWs.png)

En base a estos gráficos, podemos notar que el haber implementado el planificador MLFQ corresponde a un incremento de aproximadamente **5% más operaciones por tick*^* y 4% menos ticks pasados por medición del *benchmark*.

## Experimento 2
Este experimento busca encontrar diferencias y similitudes entre las ejecuciones de nuestras pruebas cuando usamos un _quantum_ mucho más pequeño.  
El único cambio notorio que tuvimos que hacer fue multiplicar por 10 las operaciones por _tick_ que realizaba el `iobench`, puesto que después de dividir por 100 el _quantum_, estabamos logrando menos de una ejecución por tick, lo que nos daría valores no comparables.
Al ejecutar las pruebas nuevamente, vimos que en términos generales la ejecución de ambas era más lenta, por ejemplo el [escenario C](#markdown-header-escenario-c-quantum-sobre-100) tardando alrededor de 5 mil _ticks_, cuando con un _quantum_ menor tardaba poco más de 500. Si bien los _ticks_ son cocientes relativos a un segundo, lo que ralentiza en gran parte estas pruebas es el cambio de contexto, lo que sabemos de partes anteriores de la materia que se vuelve muy caro cuando el tiempo entre ellos es muy pequeño.
Esto hace que, por ejemplo, la ejecución del [escenario A](#markdown-header-escenario-a-quantum-sobre-1000) tarde más de 6 minutos, lo cual es mucho más tiempo que la prueba original, incluso aunque usemos un argumento menor que al que estuvimos utilizando.

Podemos ver ciertos comportamientos similares, como que los procesos de `cpubench` realizan relativamente las mismas operaciones (alrededor de 50 por _tick_). Por otro lado, los procesos de `iobench` tardan alrededor de 1,5 _ticks_ más (en escala relativa) en completar ejecución, por lo que se ven claramente perjudicados por los cambios de contexto y demás interrupciones que suceden durante la planificación.
Este experimento nos deja ver que, si bien con un _quantum_ más pequeño podemos progresar en más procesos en el mismo tiempo, el cambio de contexto y las interrupciones del sistema se vuelven más perjudiciales a medida que lo hacemos más y más pequeño, por lo que el objetivo original se ve totalmente anulado y pierde sentido. Ninguno de los dos tipos de procesos se beneficia de este cambio, puesto que tardan más en hacer las mismas operaciones.

Nuevamente, para este experimento realizamos comparaciones con el planificador original de xv6 y, usando un *quantum* cien veces menor, obtuvimos los siguientes resultados:

![Operaciones por tick, escenario B](https://imgur.com/C6tyDqH.png)

![Ticks pasados por medición](https://imgur.com/qnCSTLG.png)

Lo que, siguiendo un patrón, es una mejora del 5% en operaciones por tick y un decrecimiento del 5% en ticks pasados por medición.

### Conclusiones
De ambos experimentos pudimos notar que la implementación del planificador MLFQ **si provoca una mejoría del rendimiento**, aunque en nuestras pruebas no pudimos obtener alguna más significativa que apenas un 5%. Además, pudimos ver que al hacer cada vez más pequeño el *quantum*, el tiempo que tardan las operaciones aumenta considerablemente, dando a entender que, como hemos visto en la primera parte de la materia, el *context-switch* es realmente costoso cuando se lo realiza indiscriminada e innecesariamente.

### Referencias

## ESCENARIO A
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|-------|--|-----|---|
|8|[iobench]|45|35251|716|
|8|[iobench]|50|35968|652|
|8|[iobench]|50|36621|648|
|8|[iobench]|51|37270|641|
|8|[iobench]|50|37911|645|

## ESCENARIO A QUANTUM SOBRE 1000
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|-------|-|-----|------|
|4|[iobench]|1|32919|180047|
|4|[iobench]|1|213203|178021|
|4|[iobench]|1|391397|166150|
|4|[iobench]|1|557732|191951|
|4|[iobench]|1|749895|171294|

## ESCENARIO B
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|-------|--|---|----|
|6|[iobench]|31|592|1056|
|5|[iobench]|30|592|1074|
|6|[iobench]|31|1648|1043|
|5|[iobench]|31|1667|1034|
|6|[iobench]|31|2693|1026|
|5|[iobench]|31|2702|1043|
|6|[iobench]|31|3721|1050|
|6|[iobench]|31|3746|1038|
|6|[iobench]|31|4771|1032|
|6|[iobench]|31|4785|1024|

## ESCENARIO C
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|--------|----|-----|--|
|6|[cpubench]|5710|34692|94|
|6|[cpubench]|5710|34787|94|
|6|[cpubench]|5710|34882|94|
|6|[cpubench]|5710|34977|94|
|6|[cpubench]|5710|35072|94|

## ESCENARIO C QUANTUM SOBRE 100
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|--------|---|-----|----|
|6|[cpubench]|478|67113|1122|
|6|[cpubench]|478|68246|1121|
|6|[cpubench]|487|69378|1101|
|6|[cpubench]|474|70489|1131|
|6|[cpubench]|469|71630|1144|

## ESCENARIO D
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|---------|----|-----|---|
|21|[cpubench]|2855|64913|188|
|22|[cpubench]|2825|64914|190|
|21|[cpubench]|2855|65103|188|
|22|[cpubench]|2885|65106|188|
|21|[cpubench]|2885|65293|188|
|22|[cpubench]|2885|65296|188|
|21|[cpubench]|2885|65486|188|
|22|[cpubench]|2885|65673|190|
|21|[cpubench]|2885|65678|188|

## ESCENARIO E  
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|--------|----|----|---|
|7|[cpubench]|1864|1182|288|
|9|[cpubench]|1903|1192|282|
|10|[cpubench]|1864|1193|288|
|9|[cpubench]|1883|1477|285|
|10|[cpubench]|1883|1484|285|
|7|[cpubench]|1754|1473|306|
|9|[cpubench]|1903|1765|282|
|10|[cpubench]|1864|1772|288|
|7|[cpubench]|1754|1782|306|
|9|[cpubench]|1903|2050|282|
|10|[cpubench]|1883|2063|285|
|7|[cpubench]|1789|2091|300|
|9|[cpubench]|1903|2335|282|
|10|[cpubench]|1917|2351|280|
|7|[cpubench]|2097|2394|256|
|5|[iobench]|15|1181|2103|
|5|[iobench]|49|3285|665|
|5|[iobench]|49|3950|666|
|5|[iobench]|49|4617|666|
|5|[iobench]|49|5283|663|

## ESCENARIO F
|PID|BENCHMARK|OPS PER TICK|START TICK|ELAPSED TICKS|
|-|--------|----|---|---|
|5|[cpubench]|5263|906|102|
|5|[cpubench]|5315|1009|101|
|5|[cpubench]|5368|1111|100|
|5|[cpubench]|5263|1212|102|
|5|[cpubench]|5368|1315|100|
|8|[iobench]|21|908|1492|
|7|[iobench]|21|908|1509|
|8|[iobench]|31|2402|1037|
|7|[iobench]|31|2417|1042|
|8|[iobench]|31|3441|1037|
|7|[iobench]|31|3460|1045|
|8|[iobench]|31|4480|1040|
|7|[iobench]|31|4506|1043|
|8|[iobench]|31|5522|1048|
|7|[iobench]|31|5549|1042|
