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
    ldr d0, [x10]
    
    // Inicializar x5 con el índice 'i'.
    mov    x5, 0

.loop_start:
    // Comparamos el índice con N (que está en x0)
    cmp     x5, x0
    b.ge    .loop_end
    
    // Cargar X en registros flotantes
    ldr     d1, [x2, #0]    // d1 = X[i]
    ldr     d3, [x2, #8]    // d3 = X[i+1]
    ldr     d5, [x2, #16]   // d5 = X[i+2]
    ldr     d7, [x2, #24]   // d7 = X[i+3]

    // Cargar Y en registros flotantes
    ldr     d2, [x3, #0]    // d2 = Y[i]
    ldr     d4, [x3, #8]    // d4 = Y[i+1]
    ldr     d6, [x3, #16]   // d6 = Y[i+2]
    ldr     d8, [x3, #24]   // d8 = Y[i+3]

    fmul    d9, d1, d0      // alpha * X[i]
    fmul    d10, d3, d0     // alpha * X[i+1]
    fmul    d11, d5, d0     // alpha * X[i+2]
    fmul    d12, d7, d0     // alpha * X[i+3]

    fadd    d9, d9, d2      // Z[i] = ...
    fadd    d10, d10, d4    // Z[i+1] = ...
    fadd    d11, d11, d6    // Z[i+2] = ...
    fadd    d12, d12, d8    // Z[i+3] = ...

    // Almacenar los resultados
    str     d9, [x4, #0]    // Z[i] = d9
    str     d10, [x4, #8]   // Z[i+1] = d10
    str     d11, [x4, #16]  // Z[i+2] = d11
    str     d12, [x4, #24]  // Z[i+3] = d12

    add     x2, x2, #32     // X_ptr += 32
    add     x3, x3, #32     // Y_ptr += 32
    add     x4, x4, #32     // Z_ptr += 32

    add    x5, x5, #4    // i+=4
    b    .loop_start
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
