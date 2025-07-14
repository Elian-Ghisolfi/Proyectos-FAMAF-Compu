	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34


	.equ color1_1, 0xB3
	.equ color1_2, 0xFF53
	.equ edificio1_1, 0x05
	.equ edificio1_2, 0x141b

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------



	//COMENTARIOS
	/*
	x20 guarda la direccion del primer pixel no modificar, para direcciones de memoria temporales utilizamos x0
	x10 para guardar los colores, guardarlos como constantes arriba
	x5 x6 para guardar la direccion de donde fue llamado por si llamamos a una etiqueta dentro de una etiqueta
	x8 y x9 para algun temporal
	*/

	movz x10, 0xC7, lsl 16
	movk x10, 0x1585, lsl 00

	mov x2, SCREEN_HEIGH         // Y Size
loop1:
	mov x1, SCREEN_WIDTH         // X Size
loop0:
	stur w10,[x0]  // Colorear el pixel N
	add x0,x0,4    // Siguiente pixel
	sub x1,x1,1    // Decrementar contador X
	cbnz x1,loop0  // Si no terminó la fila, salto
	sub x2,x2,1    // Decrementar contador Y
	cbnz x2,loop1  // Si no es la última fila, salto
	
	mov x0,x20
	
//-----------------------------------------------
// FONDO EJ1
	bl fondo_ej1

	// reinicio el x0
	mov x0,x20

	// detalle de la piedra en (10,127)
	mov x1, 5
	mov x2, 127
	bl setAddress
	mov x3, 4             // profundidad de la piedra ( < x2/2)
    mov x1, 20             // dimensiones x e y
    mov x2, 10
	bl stone_media

	mov x1, 45
	mov x2, 135
	bl setAddress
	mov x3, 4             // profundidad de la piedra ( < x2/2)
    mov x1, 20             // dimensiones x e y
    mov x2, 10
	bl stone_media
	
	// seteo 1ra piedra en (10,127)
	mov x1, 10
	mov x2, 127
	bl setAddress

	mov x3, 10             // profundidad de la piedra ( < x2/2)
    mov x1, 50             // dimensiones x e y
    mov x2, 30
	bl stone_media
	
	//detalle escalonado de la 1ra piedra
	mov x1, 60
	mov x2, 127
	bl setAddress
	movz x10, 0x82, lsl 16 // color base (gris piedra)
	movk x10, 0x8f7c, lsl 00
	mov x2, 10
	bl paintTriangulo_escalera_izq
	
	// detalles 2da piedra en (560, 380)
	mov x1, 555
	mov x2, 400
	bl setAddress
	mov x3, 4             // profundidad de la piedra ( < x2/2)
    mov x1, 20             // dimensiones x e y
    mov x2, 10
	bl stone_media

	mov x1, 580
	mov x2, 375
	bl setAddress
	mov x3, 4             // profundidad de la piedra ( < x2/2)
    mov x1, 20             // dimensiones x e y
    mov x2, 10
	bl stone_media

	// seteo 2da piedra en (560, 380)
	mov x1, 560
	mov x2, 380
	bl setAddress

	mov x3, 10             // profundidad de la piedra ( < x2/2)
    mov x1, 50             // dimensiones x e y
    mov x2, 30
	bl stone_media
	
// detalles 3ra piedra en (30, 400)
	mov x1, 25
	mov x2, 420
	bl setAddress
	mov x3, 4             // profundidad de la piedra ( < x2/2)
    mov x1, 20             // dimensiones x e y
    mov x2, 10
	bl stone_media

	mov x1, 50
	mov x2, 395
	bl setAddress
	mov x3, 4             // profundidad de la piedra ( < x2/2)
    mov x1, 20             // dimensiones x e y
    mov x2, 10
	bl stone_media

	// seteo 2da piedra en (30, 400)
	mov x1, 30
	mov x2, 400
	bl setAddress

	mov x3, 10             // profundidad de la piedra ( < x2/2)
    mov x1, 50             // dimensiones x e y
    mov x2, 30
	bl stone_media

	bl paint_fosil

	bl InfLoop

	//---------------------------------------------------------------
	// Infinite Loop




InfLoop:
	b InfLoop
