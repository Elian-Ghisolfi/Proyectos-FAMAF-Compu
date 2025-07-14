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
	mov x20, x0 // Guarda la direcci�n base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	// ----- empieza el fondo -----	

	mov x0, x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	mov x1, 60 // ubicacion de las nubes en el eje x
	bl nubes

	bl mountain_
	bl pasto_fondo
	mov x18, 190 //detalles para ayudar a la animacion se mueven en x18 
	bl camino_tierra

	mov x1, 590	 // ubicacion de los arbustos en el eje x
	bl arbustos_
	
	
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	//---------------------------TODO DIBUJADO-------------------------

secuencia:

	//No son 60 frames por segundo ni a gancho pero esta bieen
	/*
	Nubes -2
	Arbustos -5
	Cactus -5
	*/
	//Frame 1
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,60
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,590
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,590
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 2
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,58
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,585
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,580
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 3
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,56
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,580
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,570
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 4
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,54
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,575
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,560
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 5
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,52
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,570
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,550
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 6
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,50
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,565
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,540
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 7
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,48
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,560
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,530
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 8
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,46
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,555
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,520
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 9
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,44
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,550
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,510
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 10
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,42
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,545
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,500
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 11
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,40
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,540
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,490
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 12
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,38
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,535
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,480
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 13
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,36
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,530
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,470
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 14
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,34
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,525
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,460
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 15
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,32
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,520
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,450
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 16
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,30
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,515
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,440
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 17
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,28
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,510
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,430
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 18
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,26
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,505
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,420
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 19
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,24
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,500
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,410
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio


	//Frame 20
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,22
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,495
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,400
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//---------Comienza a dar el salto----------
	//Frame 21
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,20
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,490
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,390
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 320
	bl draw_dinosaur
	bl delay_medio


	//Frame 22
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,18
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,485
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,380
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 310
	bl draw_dinosaur
	bl delay_medio


	//Frame 23
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,16
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,480
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,370
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 300
	bl draw_dinosaur
	bl delay_medio


	//Frame 24
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,14
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,475
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,360
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 290
	bl draw_dinosaur
	bl delay_medio


	//Frame 25
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,12
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,470
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,350
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 280
	bl draw_dinosaur
	bl delay_medio


	//Frame 26
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,10
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,465
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,340
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 270
	bl draw_dinosaur
	bl delay_medio


	//Frame 27
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,8
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,460
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,330
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 260
	bl draw_dinosaur
	bl delay_medio


	//Frame 28
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,6
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,455
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,320
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 250
	bl draw_dinosaur
	bl delay_medio


	//Frame 29
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,4
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,450
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,310
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio


	//Se mantiene arriba un momento


	//Frame 30
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,2
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,445
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,300
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio

	//Frame 31
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,0
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,440
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,290
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio


	//Frame 32
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,638
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,435
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,280
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio


	//Frame 33
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,636
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,430
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,270
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio


	//Frame 34
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,636
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,425
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,260
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio


	//Frame 35
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,634
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,420
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,250
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio


	//Frame 36
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,632
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,415
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,240
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 240
	bl draw_dinosaur
	bl delay_medio


	//Frame 37 ------------- EMPIEZA A BAJAR ---------------------
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,630
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,410
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,230
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 250
	bl draw_dinosaur
	bl delay_medio


	//Frame 38
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,628
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,405
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,220
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 260
	bl draw_dinosaur
	bl delay_medio


	//Frame 39
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,626
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,400
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,210
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 270
	bl draw_dinosaur
	bl delay_medio


	//Frame 40
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,624
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,395
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,200
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 280
	bl draw_dinosaur
	bl delay_medio


	//Frame 41
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,622
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,390
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,190
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 290
	bl draw_dinosaur
	bl delay_medio


	//Frame 42
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,624
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,385
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,180
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 300
	bl draw_dinosaur
	bl delay_medio


	//Frame 43
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,622
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,380
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,170
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 310
	bl draw_dinosaur
	bl delay_medio


	//Frame 44
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,620
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,375
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,160
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 320
	bl draw_dinosaur
	bl delay_medio


	//Frame 45
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes
	mov x1,618
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos
	mov x1,370
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus
	mov x1,150
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delay_medio

	//Frame 46
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,616
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,365
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,140
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 47
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,614
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,360
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,130
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 48
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,612
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,355
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,120
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 49
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,610
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,350
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,110
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 50
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,608
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,345
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,100
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 51
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,606
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,340
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,90
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 52
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,604
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,335
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,80
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 53
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,602
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,330
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,70
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 54
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,600
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,325
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,60
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 55
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,598
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,320
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,50
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 56
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,596
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,315
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,40
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 57
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,594
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,310
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,30
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 58
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,592
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,305
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,20
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 59
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,590
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,300
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,10
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 60
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,588
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,295
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,00
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 61
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,586
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,290
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,630
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 62
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,584
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,285
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,620
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio

	//Frame 63
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,582
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,280
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,610
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_left_leg
	bl delay_medio

	//Frame 64
	//Re pintar el fondo
	mov x0,x20
	movz x10, 0x2a, lsl 16
	movk x10, 0xc5b4, lsl 00
	bl sky_
	//Mover las nubes 2 en 2
	mov x1,580
	bl nubes
	bl mountain_
	bl pasto_fondo
	//Mover arbustos 5 en 5
	mov x1,275
	bl arbustos_
	//Pintar suelo
	bl camino_tierra
	//Mover cactus 10 en 10
	mov x1,600
	bl cactus_
	//Dibujar dinosaurio
	mov x1, 300
	mov x2, 330
	bl draw_dinosaur
	bl delete_right_leg
	bl delay_medio


    b secuencia 

	
InfLoop:
	b InfLoop




