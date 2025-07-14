	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

.globl paintTriangulo_izq_arriba
.globl paintTriangulo_der_arriba
.globl paintTriangulo_escalera_abajo
.globl paintTriangulo_escalera_izq

/*
Dado un x0(direccion de memoria) pinta un rectangulo con x1 pixeles de base de izq a derecha de color x10
*/
paintTriangulo_izq_arriba:
    mov x5,x30
    mov x1, x2
aux_line_loop1:	
    bl paintLine                    // dibujo las diferentes bases hacia arriba  
    sub x1,x1,1                     // acorto la base
    sub x0,x0,SCREEN_WIDTH*4
    cbnz x1, aux_line_loop1
	br x5

paintTriangulo_der_arriba:
    mov x5,x30
    mov x1,x2
aux_line_loop2:
    bl paintLine
    sub x1,x1,1                     // acorto la base
    sub x0,x0,SCREEN_WIDTH*4
    add x0,x0,4
    cbnz x1, aux_line_loop2
    br x5
paintTriangulo_escalera_izq:
    mov x5,x30
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
	br x5

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
