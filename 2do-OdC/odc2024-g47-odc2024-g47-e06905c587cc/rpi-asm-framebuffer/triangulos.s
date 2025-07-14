	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

.globl paintTriangulo_izq_arriba
.globl paintTriangulo_der_arriba
.globl paintTriangulo_escalera_izq
.globl paintTriangulo_escalera_abajo
.globl paintTriangulo_escalera_arriba_mountain
.globl paint_base_nube
.globl picos_de_nube
.globl paintTriangulo_der_abajo
.globl paintTriangulo_izq_abajo

/*
Dado un x0(direccion de memoria) pinta un triangulo con x1 pixeles de base de izq a derecha de color x10
*/
paintTriangulo_izq_arriba:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

aux_line_loop1:	
    bl paintLine                    // dibujo las diferentes bases hacia abajo  
    sub x1,x1,1                     // acorto la base
    sub x0,x0,SCREEN_WIDTH*4
    cbnz x1, aux_line_loop1

    ldur x30, [SP] 
    add SP, SP, 8 
    ret
//---- triagulo derecho -----
paintTriangulo_der_arriba:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

aux_line_loop2:
    bl paintLine
    sub x1,x1,1                     // acorto la base
    sub x0,x0,SCREEN_WIDTH*4
    add x0,x0,4
    cbnz x1, aux_line_loop2
    //vuelvo al link register
    ldur x30, [SP] 
    add SP, SP, 8 
    ret
// ----
paintTriangulo_escalera_izq:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

    mov x1, 1
aux_line_loop3:	
    bl paintLine                    // dibujo las diferentes bases hacia arriba 
    add x0,x0,SCREEN_WIDTH*4
    bl paintLine
    add x0,x0,SCREEN_WIDTH*4
    bl paintLine
    add x0,x0,SCREEN_WIDTH*4          
    add x1,x1,1                     // agrando la base
    sub x2,x2,1
    cbnz x2, aux_line_loop3
    //vuelvo al link register
    ldur x30, [SP] 
    add SP, SP, 8 
    ret

paintTriangulo_escalera_abajo:
    mov x4, x30  //guardo el link
    mov x2, 5    // altura de los rectangulos
    mov x3, x1   // iteraciones
    sub x3, x3, 2
aux_rectangulo_loop1:
    bl paintRectangle
    add x0, x0, 4
    sub x1,x1, 2
    sub x3,x3, 2
    cbnz x3, aux_rectangulo_loop1
    br x4

// Dibuja un triangulo escalonado hacia arriba con punta en x0 de color x10
paintTriangulo_escalera_arriba_mountain:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

    mov x2, 3               // niveles de escalonamiento
    mov x3, x1              // iteraciones
    mov x1, 0
aux_rectangulo_loop2:
    add x1,x1, 12
    bl paintRectangle
    sub x0, x0, 20
    sub x3,x3, 1
    cbnz x3, aux_rectangulo_loop2
    //vuelvo al link register
    ldur x30, [SP] 
    add SP, SP, 8 
    ret


// ------------- base de nubes y arbustos (pasar color en x10) ---------------
paint_base_nube:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

    mov x7, x0        // guardamos el x0 para replicar la forma en varios lugares horizontalmente
    bl picos_de_nube // dibujar picos
    mov x2, 2        // altura de los rectangulos
    mov x1, 32       // base nube
    mov x3, 4        // iteraciones
aux_loop_nube1:
    bl paintRectangle
    add x0, x0, 8
    sub x1,x1, 4
    sub x3,x3, 1
    cbnz x3, aux_loop_nube1
    // volvemos a posicionar el x0 y adelantamos 
    add x7, x7, 400
    add x7, x7, SCREEN_WIDTH*4
    mov x0, x7

    bl picos_de_nube // dibujar picos
    mov x1, 32
    mov x2, 2    // altura de los rectangulos
    mov x3, 4   // iteraciones
aux_loop_nube2:
    bl paintRectangle
    add x0, x0, 8
    sub x1,x1, 4
    sub x3,x3, 1
    cbnz x3, aux_loop_nube2


    // volvemos a posicionar el x0 y adelantamos 
    add x7, x7, 400
    add x7, x7, SCREEN_WIDTH*4
    mov x0, x7

    bl picos_de_nube // dibujar picos
    mov x1, 32
    mov x2, 2    // altura de los rectangulos
    mov x3, 4   // iteraciones
aux_loop_nube3:
    bl paintRectangle
    add x0, x0, 8
    sub x1,x1, 4
    sub x3,x3, 1
    cbnz x3, aux_loop_nube3

 
    //vuelvo al main desde sky_
    ldur x30, [SP] 
    add SP, SP, 8 
    ret

// picos de las nubes y arbustos
picos_de_nube:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]
    mov x17, x0     // guardo el cursor
    mov x2, 1      // niveles de escalonamiento
    mov x3, 6      // iteraciones
    mov x1, 14     // tamaño     
aux_pico1_nube:
    bl paintRectangle_arriba
    sub x1,x1, 2
    add x0,x0, 4
    sub x3,x3, 1
    cbnz x3, aux_pico1_nube

    mov x0, x17    // dejo el cursor donde estaba para hacer el otro pico
    add x0, x0, 48
    mov x2, 1      // niveles de escalonamiento     
    mov x3, 9      // iteraciones
    mov x1, 20     // tamaño 
aux_pico2_nube:
    bl paintRectangle_arriba
    sub x1,x1, 2
    add x0,x0, 4
    sub x3,x3, 1
    cbnz x3, aux_pico2_nube

    mov x0, x17    // dejo el cursor donde estaba para hacer la base
    ldur x30, [SP] 
    add SP, SP, 8 
    ret
    //----- triangulos hacia abajo -------
paintTriangulo_izq_abajo:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

    mov x13, x1
    mov x17, x0
triagunlo_line_loop3:	
    bl paintLine                    // dibujo las diferentes bases hacia abajo  
    sub x1,x1,1                     // acorto la base
    add x0,x0,SCREEN_WIDTH*4
    cbnz x1, triagunlo_line_loop3
    mov x1, x13
    mov x0, x17

    ldur x30, [SP] 
    add SP, SP, 8 
    ret
//---- triagulo derecho -----
paintTriangulo_der_abajo:
    sub SP, SP, 8   //Link de la funcion madre del fondo
    stur x30, [SP]

    mov x13, x1
    mov x17, x0
triangulo_line_loop4:
    bl paintLine
    sub x1,x1,1                     // acorto la base
    add x0,x0,SCREEN_WIDTH*4
    add x0,x0,4
    cbnz x1, triangulo_line_loop4

    mov x1, x13                     // dejo el tamaño igual
    mov x0, x17                     // dejo el cursor en el mismo lugar
    //vuelvo al link register
    ldur x30, [SP] 
    add SP, SP, 8 
    ret
