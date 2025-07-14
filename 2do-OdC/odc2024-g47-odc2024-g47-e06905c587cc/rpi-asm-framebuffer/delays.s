.globl delay_corto
.globl delay_medio
.globl delay_largo

// delay de loop = 10000
delay_corto:
    movz x3, 0x1, lsl 16
    movk x3, 0x86A0, lsl 00
loop_corto:
    sub x3,x3,1
    cbnz x3, loop_corto
    br x30

// delay de loop = 16728640 reps por si queremos que sea mas rapido
delay_medio:
    movz x3, 0x3FD, lsl 16
    movk x3, 0x0900, lsl 00
loop_medio:
    sub x3,x3,1
    cbnz x3, loop_medio
    br x30

// delay de loop = 167108864 reps ideal 
delay_largo:
    movz x3, 0x9f5, lsl 16
    movk x3, 0xE100, lsl 00
loop_largo:
    sub x3,x3,1
    cbnz x3, loop_largo
    br x30

