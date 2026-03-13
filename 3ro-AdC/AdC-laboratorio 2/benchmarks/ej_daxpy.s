	.data
	N:       .dword 4096	// Number of elements in the vectors
	Alpha:   .dword 2      // scalar value
	
	.bss 
	X: .zero  32768        // vector X(4096)*8
	Y: .zero  32768        // Vector Y(4096)*8
    Z: .zero  32768        // Vector Y(4096)*8

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
	mov	x1, 0
	mov	x0, 0
	bl	m5_dump_stats

	ldr     x0, N
    ldr     x10, =Alpha
    ldr     x2, =X
    ldr     x3, =Y
	ldr     x4, =Z

//---------------------- CODE HERE ------------------------------------
    // x10 tiene la dirección de Alpha en d0 
    ldr     d0, [x10]

    // Inicializar x5 con el índice 'i'.
    mov     x5, 0       // i = 0

.loop_start:
    // Comparamos el índice con N (que está en x0)
    cmp     x5, x0
    b.ge    .loop_end

    // Cargar X[i] en un registro flotante (d1)
    ldr     d1, [x2, x5, LSL 3]  // d1 = X[i]

    // Cargar Y[i] en un registro flotante (d2)
    ldr     d2, [x3, x5, LSL 3]  // d2 = Y[i]

    // Calcular alpha * X[i]
    // d3 = d0 (alpha) * d1 (X[i])
    fmul    d3, d0, d1

    // Calcular (alpha * X[i]) + Y[i]
    fadd    d3, d3, d2           // d3 = Z[i]

    // Almacenar el resultado en Z[i]
    str     d3, [x4, x5, LSL 3]  // Z[i] = d3

    add     x5, x5, 1            // i++

    b       .loop_start

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
