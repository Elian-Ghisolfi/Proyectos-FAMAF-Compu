	.text
	N:       .dword 1024	// Number of elements in the vectors
	
	.bss 
	X: .zero  8192
    Y: .zero  8192
    Z: .zero  8192

	.arch armv8-a
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB6:
	.cfi_startproc
	stp	x29, x30, [sp, -16]!
	.cfi_def_cfa_offset 16
	.cfi_offset 29, -16
	.cfi_offset 30, -8
	mov	x29, sp

    mov x0, 0
    mov x1, 0
    bl  m5_dump_stats

//---------------------- CODE HERE ------------------------------------
    // Cargar direcciones y valores
    ldr     x0, N           // x0 = N 
    ldr     x2, =X          
    ldr     x3, =Y          
    ldr     x4, =Z          

    // x5: Índice 'i'
    mov     x5, 0
    mov     x10, 0

.loop_start:

    ldr     x11, [x2, x5, LSL 3]
    ldr     x12, [x3, x5, LSL 3]

    // --- SALTO (Patrón T, T, NT) ---
    cmp     x10, 2
    b.ne    .rama_taken    // Salta si es 0 o 1 (Taken)
    
    // Rama Not Taken (x10 == 2)
    sub     x13, x11, x12
    mov     x10, 0         // Reset contador
    b       .store_result  // Salto para evitar el bloque Taken

.rama_taken:
    // Rama Taken (x10 == 0 o 1)
    add     x13, x11, x12
    add     x10, x10, 1    // Incrementar contador

.store_result:
    str     x13, [x4, x5, LSL 3]

    // --- CONTROL DEL BUCLE ---
    add     x5, x5, 1       // i++
    cmp     x5, x0          // Comparar i con N
    b.lt    .loop_start     // Si i < N, volver arriba

.loop_end:

//---------------------- END CODE -------------------------------------
	mov 	x0, 0
	mov 	x1, 0
	bl	m5_dump_stats
	mov	w0, 0
	ldp	x29, x30, [sp], 16	
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
