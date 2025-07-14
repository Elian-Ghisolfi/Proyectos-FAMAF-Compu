	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

.globl mountain_
.globl sky_
.globl nubes
.globl arbustos_
.globl pasto_fondo
.globl camino_tierra
/*
Asegurarse de que x0 = x20 es decir comienzo del frame buffer
 */
	mov x0,x20
    //--- CIELO setear bien los colores en x10----------------
sky_:
    sub SP, SP, 8   
    stur x30, [SP]  //Link de la funcion madre del fondo

    movz x11, 0x0101, lsl 00 // constante de tonalidades (-1) blue y green
    mov x1, 640
    mov x2, 3
    mov x3, 60
sky_loop:
    bl paintRectangle
    sub x10, x10, x11
    sub x3,x3,1
    cbnz x3, sky_loop

    ldur x30, [SP]
    add SP, SP, 8 //vuelvo al main desde sky_
    ret
//--- Nubes horizontales seteadas en el cielo --------------
nubes:
    sub SP, SP, 8   
    stur x30, [SP]  //Link de la funcion madre del fondo de las nubes
    mov x14, x1
	movz x10, 0xe7, lsl 16
	movk x10, 0xf3f0, lsl 00
    // idealmente las nubes arrancan en x = 70
	mov x2, 35
	bl setAddress
	bl paint_base_nube
	movz x10, 0xf3, lsl 16
	movk x10, 0xfbf9, lsl 00
    add x1, x14, 280 // ubicamos la 2da terna de nubes
	mov x2, 70
	bl setAddress
	bl paint_base_nube

    ldur x30, [SP]
    add SP, SP, 8 //vuelvo al main desde sky_
    ret
    //---- MONTAÑAS -----------
mountain_:
    mov x0, x20
    sub SP, SP, 8   
    stur x30, [SP]  //Link de la funcion madre del fondo

    //montaña 3 oscura de fondo
	mov x1, 70
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0x45, lsl 16 // color base de la montaña
	movk x10, 0x351b, lsl 00
	mov x1, 30
	bl paintTriangulo_escalera_arriba_mountain
	//nieve
	mov x1, 70
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0xe1, lsl 16 // color base de la montaña
	movk x10, 0xd9d9, lsl 00
	mov x1, 10
	bl paintTriangulo_escalera_arriba_mountain

	//montaña 4 oscura de fondo
	mov x1, 340
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0x45, lsl 16 // color base de la montaña
	movk x10, 0x351b, lsl 00
	mov x1, 30
	bl paintTriangulo_escalera_arriba_mountain
	//nieve
	mov x1, 340
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0xe1, lsl 16 // color base de la montaña
	movk x10, 0xd9d9, lsl 00
	mov x1, 10
	bl paintTriangulo_escalera_arriba_mountain 	

	// montaña 1 con nieve
	mov x1, 425
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0x6a, lsl 16 // color base de la montaña
	movk x10, 0x4b19, lsl 00
	mov x1, 30
	bl paintTriangulo_escalera_arriba_mountain
	//nieve
	mov x1, 425
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0xff, lsl 16 // color base de la nieve
	movk x10, 0xfafa, lsl 00
	mov x1, 10
	bl paintTriangulo_escalera_arriba_mountain

	// montaña 2 con nieve
	mov x1, 150
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0x6a, lsl 16 // color base de la montaña
	movk x10, 0x4b19, lsl 00
	mov x1, 30
	bl paintTriangulo_escalera_arriba_mountain
	//nieve
	mov x1, 150
	mov x2, 100
	bl setAddress   // ubicacion de la montaña
	movz x10, 0xff, lsl 16 // color base de la nieve
	movk x10, 0xfafa, lsl 00
	mov x1, 10
	bl paintTriangulo_escalera_arriba_mountain

    ldur x30, [SP]
    add SP, SP, 8 //vuelvo al main desde sky_
    ret


// ---- arbustos utilizando nubes (COMO EN MARIO) -----------

arbustos_:
    mov x0, x20
    sub SP, SP, 8   
    stur x30, [SP]  //Link de la funcion madre del fondo

    mov x14, x1 // guardo la cordena x = x1
    //arbustos1
	movz x10, 0x09, lsl 16
	movk x10, 0x4c05, lsl 00
    // primer arbusto base 
	mov x2, 220
	bl setAddress
	bl paint_base_nube
    //sombra del arbusto 1
	movz x10, 0x12, lsl 16
	movk x10, 0x8a0b, lsl 00
	add x1, x14, 5
	mov x2, 220
	bl setAddress
	bl paint_base_nube    

    //arbustos 2
	movz x10, 0x09, lsl 16
	movk x10, 0x4c05, lsl 00
	add x1, x14, 295
	mov x2, 220
	bl setAddress
	bl paint_base_nube
    //sombra del arbusto 2
	movz x10, 0x12, lsl 16
	movk x10, 0x8a0b, lsl 00
	add x1, x14, 300
	mov x2, 220
	bl setAddress
	bl paint_base_nube    



    //arbustos 3
	movz x10, 0x09, lsl 16
	movk x10, 0x4c05, lsl 00
	add x1, x14, 55
	mov x2, 270
	bl setAddress
	bl paint_base_nube
    //sombra del arbusto 3
	movz x10, 0x12, lsl 16
	movk x10, 0x8a0b, lsl 00
	add x1, x14, 60
	mov x2, 270
	bl setAddress
	bl paint_base_nube  

    //arbustos 4
	movz x10, 0x09, lsl 16
	movk x10, 0x4c05, lsl 00
	add x1, x14, 355
	mov x2, 270
	bl setAddress
	bl paint_base_nube
    //sombra del arbusto 4
	movz x10, 0x12, lsl 16
	movk x10, 0x8a0b, lsl 00
	add x1, x14, 360
	mov x2, 270
	bl setAddress
	bl paint_base_nube          

    ldur x30, [SP]
    add SP, SP, 8 //vuelvo al main desde arbustos_
    ret

    //----PASTO DE FONDO
pasto_fondo:
    sub SP, SP, 8   
    stur x30, [SP]  //Link de la funcion madre del fondo

	mov x1, 0
	mov x2, 190
	bl setAddress
	mov x1, 640
	mov x2, 190
	movz x10, 0x4a, lsl 16
	movk x10, 0xac06, lsl 00
	bl paintRectangle

    ldur x30, [SP]
    add SP, SP, 8 //vuelvo al main desde pasto del fondo
    ret

    //------CAMINO DE TIERRA --- los detalles se mueven en x18 (ese es el eje x) 
camino_tierra:
    sub SP, SP, 8   
    stur x30, [SP]  //Link de la funcion madre del fondo

	mov x1, 0
	mov x2, 380
	bl setAddress
    mov x14, x0 //
	mov x1, 640
	mov x2, 100
	movz x10, 0x5d, lsl 16
	movk x10, 0x4a1d, lsl 00
	bl paintRectangle
    //detalles del camino
    mov x1, x18
	mov x2, 370
	bl setAddress
    mov x14, x0 // guardamos x0 para hacer todo los detalles  
    movz x10, 0x5d, lsl 16 // color base de la montaña
	movk x10, 0x4a1d, lsl 00
	mov x1, 5
	bl paintTriangulo_escalera_arriba_mountain

    add x14,x14, 900
    mov x0, x14
	mov x1, 5
	bl paintTriangulo_escalera_arriba_mountain

    add x14,x14, 900
    mov x0, x14
	mov x1, 5
	bl paintTriangulo_escalera_arriba_mountain

    ldur x30, [SP]
    add SP, SP, 8 //vuelvo al main desde camino de tierra
    ret  


/* EJEMPLO de animar el cielo
	mov x7, 55
	// pintar el cielo 1ra tonalidad
	movz x10, 0x14, lsl 16
	movk x10, 0xdae0, lsl 00
fondo_:
	mov x0, x20
	bl sky_
	bl mountain_
	mov x10, x14
	sub x10, x10, x11
	sub x10, x10, x11
	mov x14, x10
	//delay 
	bl delay_largo
	mov x0, x20
	sub x7,x7,1
	cbnz x7, fondo_
 */
 
 