	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

.globl setAddress
.globl paintRectangle
.globl paintLine


//Dado un x(x1) y un y(x2) te devulve en x0 la direccion de memoria de ese pixel
setAddress:
	mov x0,SCREEN_WIDTH
	MADD x0,x2,x0,x1
	lsl x0,x0,2
	ADD x0,x0,x20
	ret
/*
Dado un x0(direccion de memoria) pinta un rectangulo con x1 pixeles hacia la derecha y x2 hacia abajo de color x10
*/
paintRectangle:
	mov x5,x30
	mov x13, x2
paintRectangleLoop:
	bl paintLine
	add x0,x0,SCREEN_WIDTH*4
	sub x13,x13,1
	cbnz x13,paintRectangleLoop
	br x5
/*
Pinta una linea a partir de x0 x1 pixeles hacia la derecha
*/
paintLine:
	mov x9, x0
	mov x6,x30
	mov x8, x1
paintLineLoop:
	stur w10,[x9]
	add x9,x9,4
	sub x8,x8,1
	cbnz x8, paintLineLoop
	br x6
