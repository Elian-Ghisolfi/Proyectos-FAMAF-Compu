.equ SCREEN_WIDTH,   640
.equ SCREEN_HEIGH,   480
.equ BITS_PER_PIXEL, 32
.equ CANT_PIXEL_PER_PIXEL, 10
.equ COLOR_CONTORNO1_1, 0x14
.equ COLOR_CONTORNO1_2, 0x110c
.equ COLOR_HUESO1_1,0xe0
.equ COLOR_HUESO1_2,0xdb91
.equ COLOR_HUECO1_1, 0x3d
.equ COLOR_HUECO1_2, 0x2c1a
.equ COLOR_HUESO2_1,0x9b
.equ COLOR_HUESO2_2,0x9251

.globl paint_fosil

//Utilizo x11 para la cantidad de pixeles horizontales seguidos que quiero hacer, y x12 para verticalmente
paint_fosil:
    mov x4,x30

    movz x10, COLOR_HUESO1_1, lsl 16
	movk x10, COLOR_HUESO1_2, lsl 00

    mov x1,80
    mov x2,210
    bl setAddress
    bl single_pixel

    mov x1,90
    mov x2,220
    bl setAddress
    mov x1,20
    mov x2,20
    bl paintRectangle

    mov x1,110
    mov x2,230
    bl setAddress
    mov x1,30
    mov x2,20
    bl paintRectangle

    mov x1,130
    mov x2,240
    bl setAddress
    mov x1,40
    mov x2,30
    bl paintRectangle

    mov x1,170
    mov x2,250
    bl setAddress
    mov x1,60
    mov x2,30
    bl paintRectangle

    mov x1,230
    mov x2,240
    bl setAddress
    mov x1,180
    mov x2,40
    bl paintRectangle

    mov x1,240
    mov x2,230
    bl setAddress
    mov x1,170
    mov x2,10
    bl paintRectangle

    mov x1,260
    mov x2,220
    bl setAddress
    mov x1,150
    mov x2,10
    bl paintRectangle

    mov x1,230
    mov x2,280
    bl setAddress
    mov x1,210
    mov x2,10
    bl paintRectangle

    mov x1,270
    mov x2,290
    bl setAddress
    mov x1,190
    mov x2,10
    bl paintRectangle

    mov x1,270
    mov x2,300
    bl setAddress
    mov x1,150
    mov x2,10
    bl paintRectangle

    mov x1,270
    mov x2,310
    bl setAddress
    mov x1,130
    mov x2,10
    bl paintRectangle

    mov x1,280
    mov x2,320
    bl setAddress
    mov x1,150
    mov x2,10
    bl paintRectangle

    mov x1,270
    mov x2,330
    bl setAddress
    mov x1,170
    mov x2,10
    bl paintRectangle

    mov x1,260
    mov x2,330
    bl setAddress
    mov x1,100
    mov x2,30
    bl paintRectangle

    mov x1,240
    mov x2,350
    bl setAddress
    mov x1,90
    mov x2,20
    bl paintRectangle

    mov x1,230
    mov x2,370
    bl setAddress
    mov x1,100
    mov x2,20
    bl paintRectangle

    mov x1,250
    mov x2,390
    bl setAddress
    mov x1,50
    mov x2,20
    bl paintRectangle

    mov x1,310
    mov x2,390
    bl setAddress
    mov x1,20
    mov x2,40
    bl paintRectangle

    mov x1,310
    mov x2,390
    bl setAddress
    mov x1,20
    mov x2,40
    bl paintRectangle

    mov x1,410
    mov x2,210
    bl setAddress
    mov x1,130
    mov x2,40
    bl paintRectangle

    mov x1,430
    mov x2,200
    bl setAddress
    mov x1,70
    mov x2,10
    bl paintRectangle

    mov x1,470
    mov x2,250
    bl setAddress
    mov x1,100
    mov x2,10
    bl paintRectangle

    mov x1,480
    mov x2,260
    bl setAddress
    mov x3,4
    bl escalera_pixeles_derecha_descendente

    mov x1,470
    mov x2,260
    bl setAddress
    mov x3,5
    bl escalera_pixeles_derecha_descendente

    mov x1,520
    mov x2,260
    bl setAddress
    mov x1,50
    mov x2,10
    bl paintRectangle

    mov x1,540
    mov x2,270
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,540
    mov x2,230
    bl setAddress
    mov x1,20
    mov x2,20
    bl paintRectangle



//CONTORNO 
    movz x10, COLOR_CONTORNO1_1, lsl 16
	movk x10, COLOR_CONTORNO1_2, lsl 00
    
    //Direccion de pixel
    mov x1,70
    mov x2,200
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,80
    mov x2,200
    bl setAddress
    bl single_pixel

    mov x1,90
    mov x2,210
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,70
    mov x2,210
    bl setAddress
    mov x3,4
    bl escalera_pixeles_derecha_descendente

    mov x1,110
    mov x2,250
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,130
    mov x2,260
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,150
    mov x2,270
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,170
    mov x2,280
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle
    
    mov x1,190
    mov x2,270
    bl setAddress
    bl single_pixel

    mov x1,200
    mov x2,280
    bl setAddress
    mov x1,30
    mov x2,10
    bl paintRectangle

    mov x1,230
    mov x2,290
    bl setAddress
    bl single_pixel

    mov x1,240
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,250
    mov x2,290
    bl setAddress
    bl single_pixel

    mov x1,260
    mov x2,290
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,270
    mov x2,310
    bl setAddress
    bl single_pixel

    mov x1,280
    mov x2,320
    bl setAddress
    bl single_pixel

    mov x1,260
    mov x2,330
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,250
    mov x2,340
    bl setAddress
    bl single_pixel

    mov x1,240
    mov x2,350
    bl setAddress
    bl single_pixel

    mov x1,230
    mov x2,360
    bl setAddress
    bl single_pixel

    mov x1,220
    mov x2,370
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,230
    mov x2,390
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,250
    mov x2,400
    bl setAddress
    bl single_pixel

    mov x1,260
    mov x2,410
    bl setAddress
    mov x1,30
    mov x2,10
    bl paintRectangle

    mov x1,290
    mov x2,400
    bl setAddress
    bl single_pixel

    mov x1,290
    mov x2,390
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,310
    mov x2,400
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,300
    mov x2,420
    bl setAddress
    bl single_pixel

    mov x1,310
    mov x2,430
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,330
    mov x2,390
    bl setAddress
    mov x1,10
    mov x2,40
    bl paintRectangle

    mov x1,320
    mov x2,360
    bl setAddress
    mov x1,10
    mov x2,30
    bl paintRectangle

    mov x1,330
    mov x2,360
    bl setAddress
    bl single_pixel

    mov x1,340
    mov x2,350
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,360
    mov x2,340
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,380
    mov x2,310
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle
    mov x1,30
    mov x2,10
    bl paintRectangle

    mov x1,410
    mov x2,340
    bl setAddress
    bl single_pixel

    mov x1,420
    mov x2,330
    bl setAddress
    bl single_pixel

    mov x1,430
    mov x2,340
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,440
    mov x2,330
    bl setAddress
    bl single_pixel

    mov x1,430
    mov x2,320
    bl setAddress
    bl single_pixel

    mov x1,420
    mov x2,310
    bl setAddress
    bl single_pixel

    mov x1,400
    mov x2,300
    bl setAddress
    mov x1,20
    mov x2,20
    bl paintRectangle

    mov x1,420
    mov x2,290
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,440
    mov x2,300
    bl setAddress
    bl single_pixel

    mov x1,430
    mov x2,270
    bl setAddress
    mov x3, 3
    bl escalera_pixeles_derecha_descendente

    mov x1,420
    mov x2,270
    bl setAddress
    bl single_pixel

    mov x1,410
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,400
    mov x2,260
    bl setAddress
    mov x1,10
    mov x2,30
    bl paintRectangle

    mov x1,410
    mov x2,250
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,430
    mov x2,230
    bl setAddress
    bl single_pixel
    bl single_pixel

    mov x1,440
    mov x2,240
    bl setAddress
    mov x1,30
    mov x2,10
    bl paintRectangle
    
    mov x1,460
    mov x2,250
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,470
    mov x2,270
    bl setAddress
    mov x3, 5
    bl escalera_pixeles_derecha_descendente

    mov x1,520
    mov x2,290
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,510
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,500
    mov x2,260
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,490
    mov x2,260
    bl setAddress
    bl single_pixel

    mov x1,510
    mov x2,250
    bl setAddress
    mov x3,4
    bl escalera_pixeles_derecha_descendente

    //OJO
    mov x1,520
    mov x2,230
    bl setAddress
    bl single_pixel

    mov x1,490
    mov x2,220
    bl setAddress
    bl single_pixel

    mov x1,550
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,390
    mov x2,250
    bl setAddress
    mov x3,2
    bl escalera_pixeles_izquierda_descendente

    mov x1,350
    mov x2,270
    bl setAddress
    bl single_pixel

    movz x10, COLOR_HUECO1_1, lsl 16
	movk x10, COLOR_HUECO1_2, lsl 00

    bl single_pixel

    mov x1,330
    mov x2,290
    bl setAddress
    bl single_pixel

    mov x1,310
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,340
    mov x2,300
    bl setAddress
    bl single_pixel
    bl single_pixel

    mov x1,520
    mov x2,240
    bl setAddress
    bl single_pixel

    mov x1,540
    mov x2,240
    bl setAddress
    bl single_pixel

    mov x1,550
    mov x2,260
    bl setAddress
    bl single_pixel

    mov x1,480
    mov x2,220
    bl setAddress
    bl single_pixel

    mov x1,300
    mov x2,360
    bl setAddress
    bl single_pixel

    mov x1,280
    mov x2,370
    bl setAddress
    bl single_pixel

    movz x10, COLOR_CONTORNO1_1, lsl 16
	movk x10, COLOR_CONTORNO1_2, lsl 00

    mov x1,350
    mov x2,290
    bl setAddress
    bl single_pixel

    mov x1,330
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,330
    mov x2,300
    bl setAddress
    bl single_pixel

    mov x1,340
    mov x2,320
    bl setAddress
    bl single_pixel

    mov x1,310
    mov x2,270
    bl setAddress
    bl single_pixel

    mov x1,300
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,310
    mov x2,290
    bl setAddress
    bl single_pixel

    mov x1,290
    mov x2,300
    bl setAddress
    bl single_pixel

    mov x1,360
    mov x2,300
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,550
    mov x2,280
    bl setAddress
    bl single_pixel

    mov x1,320
    mov x2,320
    bl setAddress
    mov x3,4
    bl escalera_pixeles_izquierda_descendente

    mov x1,320
    mov x2,330
    bl setAddress
    bl escalera_pixeles_izquierda_descendente

    mov x1,560
    mov x2,270
    bl setAddress
    bl single_pixel

    mov x1,570
    mov x2,250
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,530
    mov x2,210
    bl setAddress
    mov x3,4
    bl escalera_pixeles_derecha_descendente

    mov x1,520
    mov x2,210
    bl setAddress
    bl single_pixel

    mov x1,490
    mov x2,190
    bl setAddress
    mov x3,3
    bl escalera_pixeles_derecha_descendente

    mov x1,450
    mov x2,190
    bl setAddress
    mov x1,40
    mov x2,10
    bl paintRectangle

    mov x1,440
    mov x2,200
    bl setAddress
    bl single_pixel

    mov x1,430
    mov x2,190
    bl setAddress
    mov x3,3
    bl escalera_pixeles_izquierda_descendente

    mov x1,380
    mov x2,210
    bl setAddress
    mov x1,30
    mov x2,10
    bl paintRectangle

    mov x1,370
    mov x2,220
    bl setAddress
    bl single_pixel

    mov x1,360
    mov x2,210
    bl setAddress
    bl single_pixel

    mov x1,350
    mov x2,220
    bl setAddress
    bl single_pixel

    mov x1,340
    mov x2,210
    bl setAddress
    bl single_pixel

    mov x1,330
    mov x2,220
    bl setAddress
    bl single_pixel

    mov x1,320
    mov x2,210
    bl setAddress
    bl single_pixel
    
    mov x1,290
    mov x2,220
    bl setAddress
    mov x1,30
    mov x2,10
    bl paintRectangle

    mov x1,260
    mov x2,210
    bl setAddress
    mov x1,30
    mov x2,10
    bl paintRectangle

    mov x1,240
    mov x2,220
    bl setAddress
    mov x1,20
    mov x2,10
    bl paintRectangle

    mov x1,230
    mov x2,230
    bl setAddress
    bl single_pixel

    mov x1,190
    mov x2,240
    bl setAddress
    mov x1,40
    mov x2,10
    bl paintRectangle

    mov x1,160
    mov x2,230
    bl setAddress
    mov x3,3
    bl escalera_pixeles_derecha_descendente
    
    mov x1,150
    mov x2,230
    bl setAddress
    mov x1,10
    mov x2,20
    bl paintRectangle

    mov x1,140
    mov x2,230
    bl setAddress
    bl single_pixel

    mov x1,110
    mov x2,220
    bl setAddress
    mov x1,30
    mov x2,10
    bl paintRectangle

    //Termine el contorno pense que duraria menos D:

    movz x10, COLOR_HUESO2_1, lsl 16
	movk x10, COLOR_HUESO2_2, lsl 00

    mov x1,320
    mov x2,220
    bl setAddress
    mov x1,10
    mov x2,40
    bl paintRectangle

    mov x1,340
    mov x2,220
    bl setAddress
    mov x1,10
    mov x2,40
    bl paintRectangle

    mov x1,360
    mov x2,220
    bl setAddress
    mov x1,10
    mov x2,40
    bl paintRectangle

    br x4

single_pixel:
    mov x14,x30
    mov x1,CANT_PIXEL_PER_PIXEL
    mov x2,CANT_PIXEL_PER_PIXEL
    bl paintRectangle
    br x14

//escalera hacia derecha diagonal hacia abajo x3 pixeles
escalera_pixeles_derecha_descendente:
    mov x29,x30
    mov x28,x3
    mov x1,10
    mov x2,10
escalera_pixeles_loop_derecha_descendente:
    bl paintRectangle
    add x0,x0,10*4
    sub x28,x28,1
    cbnz x28,escalera_pixeles_loop_derecha_descendente
    br x29

//escalera hacia izquierda diagonal hacia abajo x3 pixeles

escalera_pixeles_izquierda_descendente:
    mov x29,x30
    mov x28,x3
    mov x1,10
    mov x2,10
escalera_pixeles_loop_izquierda_descendente:
    bl paintRectangle
    sub x0,x0,10*4
    sub x28,x28,1
    cbnz x28,escalera_pixeles_loop_izquierda_descendente
    br x29

    






//Ultima linea

