	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32
    .equ COLOR_SUELO1_1, 0x5d
    .equ COLOR_SUELO1_2, 0x4a1d
    .equ DINO_COLOR1_1, 0x0a
    .equ DINO_COLOR1_2,0x0a0a

.globl cactus_
.globl draw_dinosaur
.globl delete_left_leg
.globl delete_right_leg
.globl draw_left_leg
.globl draw_right_leg

    // --- color del cactus -----
cactus_:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

    movz x10, 0x00, lsl 16
	movk x10, 0x0a0a, lsl 00

    mov x2, 425
    bl setAddress
    mov x17, x0     // guardo el x0 para dibujar todo el cactus

    mov x1, 15
    mov x2, 60
    bl paintRectangle_arriba    // tronco del cactus
    mov x1, 2
    sub x0, x0, SCREEN_WIDTH *4
    
    bl paintTriangulo_escalera_arriba_mountain
    mov x0, x17

    // constante de moviento // podemos mover hasta 16000 pixeles en X y 102 pixeles en Y
    movz x15, 0x641C, lsl 00       // lo ubique 10 hacia arriba y 7 hacia la izquierda   
    sub x0, x0, x15 // reubicamos el cursor
    mov x1, 29
    mov x2, 10
    bl paintRectangle_arriba    // base de las ramas
    
    sub x0, x0, 40
    add x0, x0, SCREEN_WIDTH*4
    mov x1, 10
    bl paintTriangulo_der_abajo // rama derecha
    mov x1, 10
    mov x2, 25
    bl paintRectangle_arriba

    sub x0,x0,8
    mov x1, 2
    bl paintTriangulo_escalera_arriba_mountain
    mov x0,x17                  // reseteo el x0 a la base para reubicarlo

    movz x15, 0x6458, lsl 00 // 10 hacia arriba y 22 hacia la derecha

    add x0, x0, 156
    movz x10, 0x00, lsl 16
	movk x10, 0x0a0a, lsl 00
    mov x1, 10
    bl paintTriangulo_izq_abajo // rama izquierda
    mov x1, 9
    mov x2, 19
    bl paintRectangle_arriba

    sub x0,x0,8
    mov x1, 2
    bl paintTriangulo_escalera_arriba_mountain

    ldur x30, [SP] 
    add SP, SP, 8 
    ret
    
    
// Funci�n para dibujar el dinosaurio // CON MOV X1 Y MOV X2 setear la posicion del dino 
draw_dinosaur:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

    movz x10, DINO_COLOR1_1, lsl 16
	movk x10, DINO_COLOR1_2, lsl 00

    // seteamos la posicion desde donde lo dibuja
    bl setAddress
    mov x17, x0     // guardo el x0 en la base de la cabeza para dibujar todo el cactus

    mov x1, 40
    mov x2, 20
    bl paintRectangle
    mov x1, 18
    mov x2, 6
    bl paintRectangle
    mov x1, 35
    mov x2, 4
    bl paintRectangle // cabeza

    sub x0, x0, 16
    mov x1, 19
    mov x2, 7
    bl paintRectangle
    sub x0, x0, 16
    mov x1, 23
    mov x2, 7
    bl paintRectangle
    sub x0, x0, 16
    mov x1, 27
    mov x2, 7
    bl paintRectangle // cuello

    mov x1, 38
    mov x2, 4
    bl paintRectangle    // brazo    
    add x0,x0, 136
    mov x1, 4
    mov x2, 4
    bl paintRectangle    // brazo    

    sub x0, x0, 204
    sub x0,x0, SCREEN_WIDTH*4
    sub x0,x0, SCREEN_WIDTH*4
    sub x0,x0, SCREEN_WIDTH*4
    sub x0,x0, SCREEN_WIDTH*4
    mov x1, 44
    mov x2, 12
    bl paintRectangle       // cuerpo

    sub x0, x0, 20
    sub x0,x0, SCREEN_WIDTH*4
    sub x0,x0, SCREEN_WIDTH*4
    sub x0,x0, SCREEN_WIDTH*4
    mov x1, 8
    mov x2, 14
    bl paintRectangle_arriba       // cola

    sub x0, x0, 20
    add x0,x0, SCREEN_WIDTH*4
    add x0,x0, SCREEN_WIDTH*4
    mov x1, 10
    mov x2, 7
    bl paintRectangle_arriba       // cola


    movz x15, 0xA014, lsl 00       // lo ubique 16 hacia abajo y 5 hacia la izquierda      

    add x0,x0,x15
    movz x15, 0x3C20, lsl 00       // lo ubique 16 hacia abajo y 5 hacia la izquierda
    add x0,x0,x15
    mov x1, 38
    mov x2, 4
    bl paintRectangle       // cuerpo

    add x0,x0, 12
    mov x1, 32
    mov x2, 4
    bl paintRectangle       // cuerpo

    add x0,x0, 12
    mov x1, 4
    mov x2, 13
    bl paintRectangle       // 1ra pata
    
    mov x1, 6
    mov x2, 3
    bl paintRectangle       // 1er pie
    

    movz x15, 0x9FF0, lsl 00       // lo ubique 10 en eje y y 4 en eje x
    sub x0,x0,x15    

    mov x1, 10
    mov x2, 4
    bl paintRectangle       // entre pierna

    mov x1, 6
    mov x2, 4
    bl paintRectangle       // entre pierna


    movz x15, 0x63C4, lsl 00       // lo ubique 16 en eje y y 30 en eje x
    sub x0,x0,x15
  
    mov x1, 8
    mov x2, 6
    bl paintRectangle       // entre pierna

    add x0,x0, 16
    mov x1, 4
    mov x2, 10
    bl paintRectangle       // 2da pata

    mov x1, 6
    mov x2, 3
    bl paintRectangle       // 2do pie

    mov x0,x17
    movz x10, 0x4a, lsl 16
	movk x10, 0xac06, lsl 00
    mov x1, 4
    mov x2, 4
    bl paintRectangle       // detalles de cabez


    movz x15, 0x2788, lsl 00       // lo ubique 4 en eje y y 30 en eje 36
    sub x0,x0,x15
    mov x1, 10
    mov x2, 3
    bl paintRectangle       // detalles de cabeza

    mov x0,x17
    movz x15, 0x3C20, lsl 00       // lo ubique 4 en eje y y 8 en eje 36
    add x0,x0,x15

    movz x10, 0xef, lsl 16
	movk x10, 0xfafa, lsl 00
    mov x1, 4
    mov x2, 4
    bl paintRectangle       // detalles de cabez   

    ldur x30, [SP] 
    add SP, SP, 8 
    ret

//borra la pierna izquierda del dino para simular que corre
delete_left_leg:
    mov x21,x30
    mov x1,280
    mov x2,410
    bl setAddress
    mov x1,10
    mov x2,20
    movz x10, COLOR_SUELO1_1, lsl 16
	movk x10, COLOR_SUELO1_2, lsl 00
    bl paintRectangle
    br x21

//borra la pierna derecha del dino para simular que corre
delete_right_leg:
    mov x21,x30
    mov x1,300
    mov x2,410
    bl setAddress
    mov x1,10
    mov x2,20
    movz x10, COLOR_SUELO1_1, lsl 16
	movk x10, COLOR_SUELO1_2, lsl 00
    bl paintRectangle
    br x21

//dibuja la pierna izquierda del dino para evitar tener que pintar tooodos los pixeles del dino y tambien para animar "mas facil"
draw_left_leg:
    mov x21,x30
    mov x1,280
    mov x2,408
    bl setAddress
    mov x1,5
    mov x2,10
    movz x10, DINO_COLOR1_1, lsl 16
	movk x10, DINO_COLOR1_2, lsl 00
    bl paintRectangle
    mov x1,7
    mov x2,2
    bl paintRectangle
    br x21
    

//dibuja la pierna derecha del dino para evitar tener que pintar tooodos los pixeles del dino y tambien para animar "mas facil"
draw_right_leg:
    mov x21,x30
    mov x1,300
    mov x2,408
    bl setAddress
    mov x1,5
    mov x2,10
    movz x10, DINO_COLOR1_1, lsl 16
	movk x10, DINO_COLOR1_2, lsl 00
    bl paintRectangle
    mov x1,7
    mov x2,2
    bl paintRectangle
    br x21


//linea vacia necesaria
