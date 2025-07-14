	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

    // Blanco y verde 0x68f360
    //Verde claro 0x18f00a
    //Verde oscuro 0x37a205
    //marron claro 0xbd5300 
    // marro oscuro 0x7b3600
    // negro y marron 0x532501

.globl fosil
.globl fondo_ej1
.globl stone_media

fosil:

fondo_ej1:
	//guardamos el pc
    mov x7, x30
	// Pintar el pasto
	movz x10, 0x42, lsl 16 // color base (verde pasto)
	movk x10, 0xc107, lsl 00
	movz x11, 0x0001, lsl 16 // constante para moverse 1 punto en red y green 
	movk x11, 0x0100, lsl 0

	//ubicamos x0 en 1/4 de la pantalla
	mov x1,0
	mov x2,0
	bl setAddress // x0 en 1/4 de pantalla
	mov x3,30	
	mov x1,640
	mov x2,4
loop_pasto:
	bl paintRectangle
	sub x10,x10,x11
	sub x10,x10,x11
	sub x3,x3,1
	cbnz x3, loop_pasto


	// ---- prueba de la tierra ---
	mov x0, x20
	// Pintar la tierra
	movz x10, 0x93, lsl 16 //color base (tierra)
	movk x10, 0x6212, lsl 00

	//ubicamos x0 en 1/4 de la pantalla
	mov x1,0
	mov x2,120
	bl setAddress // x0 en 1/4 de pantalla
	mov x3,90	
loop_tierra:
	mov x1,640
	mov x2,4
	bl paintRectangle
	sub x10,x10,x11
	sub x3,x3,1
	cbnz x3, loop_tierra

	//priemer detalle del pasto
	movz x10, 0x34, lsl 16 // color base (detalle pasto)
	movk x10, 0x820a, lsl 00
	mov x1,128
	mov x2,120
	bl setAddress // x0 en 1/4 de pantalla
	mov x14, x0   // guardamo en x14 la poscion de x0 para replicar los detalles
	mov x1, 20
	bl paintTriangulo_escalera_abajo
	add x14, x14, 64
	mov x0, x14
	mov x1, 16
	bl paintTriangulo_escalera_abajo
	add x14, x14, 64
	mov x0, x14
	mov x1, 28
	bl paintTriangulo_escalera_abajo
	
	// segundo detalle del pasto
	mov x1,300
	mov x2,120
	bl setAddress // x0 en 1/4 de pantalla
	mov x14, x0   // guardamo en x14 la poscion de x0 para replicar los detalles
	mov x1, 20
	bl paintTriangulo_escalera_abajo
	add x14, x14, 280
	mov x0, x14
	mov x1, 16
	bl paintTriangulo_escalera_abajo
	add x14, x14, 128
	mov x0, x14
	mov x1, 28
	bl paintTriangulo_escalera_abajo

	mov x1,400
	mov x2,120
	bl setAddress // x0 en 1/4 de pantalla
	mov x14, x0   // guardamo en x14 la poscion de x0 para replicar los detalles
	mov x1, 20
	bl paintTriangulo_escalera_abajo
	add x14, x14, 280
	mov x0, x14
	mov x1, 16
	bl paintTriangulo_escalera_abajo
	add x14, x14, 128
	mov x0, x14
	mov x1, 28
	bl paintTriangulo_escalera_abajo


    // volvemos donde quedo el PC
    br x7

    // settear poscion en x0 antes
stone_media:
    mov x15, x30
    movz x10, 0x82, lsl 16 // color base (gris piedra)
	movk x10, 0x8f7c, lsl 00
	movz x11, 0x0001, lsl 16 // constante para moverse 1 punto en cada color RGB
	movk x11, 0x0101, lsl 0
    mov x12, SCREEN_WIDTH*4
stone_mediana_loop:
    bl paintRectangle
    sub x1,x1,2             // rectangulos mas chicos para profundidad
    sub x2,x2,2
    sub x10,x10,x11         
    sub x10,x10,x11
    MSUB x0,x12,x2,x0
    add x0, x0, 4
    sub x3,x3,1
    cbnz x3,stone_mediana_loop
    br x15
