	.file	"13variant_reg.c"
	.intel_syntax noprefix
	.text
	.globl	generateArray
	.type	generateArray, @function
generateArray:
	push	rbp
	mov	rbp, rsp
	push	r14
	push	r12
	sub	rsp, 32
	mov	QWORD PTR -40[rbp], rdi
	mov	DWORD PTR -44[rbp], esi
	mov	DWORD PTR -48[rbp], edx
	mov	eax, DWORD PTR -48[rbp]
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	r12, rax
	mov	DWORD PTR -32[rbp], 0
	mov	DWORD PTR -20[rbp], 32
	mov	DWORD PTR -28[rbp], 0
	jmp	.L2
.L9:
	mov	DWORD PTR -24[rbp], 0
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	r14d, eax
	jmp	.L3
.L8:
	mov	eax, r14d
	test	al, al
	js	.L4
	mov	eax, r14d
	cmp	al, 64
	jle	.L5
	mov	eax, r14d
	cmp	al, 90
	jg	.L5
	mov	eax, DWORD PTR -20[rbp]
	mov	edx, eax
	mov	eax, r14d
	add	edx, eax
	mov	rcx, r12
	mov	eax, DWORD PTR -32[rbp]
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], dl
	jmp	.L6
.L5:
	mov	eax, r14d
	cmp	al, 96
	jle	.L7
	mov	eax, r14d
	cmp	al, 122
	jg	.L7
	mov	eax, r14d
	mov	edx, eax
	mov	eax, DWORD PTR -20[rbp]
	sub	edx, eax
	mov	rcx, r12
	mov	eax, DWORD PTR -32[rbp]
	cdqe
	add	rax, rcx
	mov	BYTE PTR [rax], dl
	jmp	.L6
.L7:
	mov	rdx, r12
	mov	eax, DWORD PTR -32[rbp]
	cdqe
	add	rax, rdx
	mov	edx, r14d
	mov	BYTE PTR [rax], dl
.L6:
	add	DWORD PTR -32[rbp], 1
.L4:
	add	DWORD PTR -24[rbp], 1
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	r14d, eax
.L3:
	mov	eax, r14d
	test	al, al
	jne	.L8
	add	DWORD PTR -28[rbp], 1
.L2:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L9
	mov	rax, r12
	add	rsp, 32
	pop	r12
	pop	r14
	pop	rbp
	ret
	.size	generateArray, .-generateArray
	.section	.rodata
.LC0:
	.string	"Output: "
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	sub	rsp, 40
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	mov	r13d, 0
	mov	DWORD PTR -40[rbp], 0
	jmp	.L12
.L16:
	mov	DWORD PTR -36[rbp], 0
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	r14d, eax
	jmp	.L13
.L15:
	mov	eax, r14d
	test	al, al
	js	.L14
	mov	eax, r13d
	add	eax, 1
	mov	r13d, eax
.L14:
	add	DWORD PTR -36[rbp], 1
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -64[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -36[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	r14d, eax
.L13:
	mov	eax, r14d
	test	al, al
	jne	.L15
	add	DWORD PTR -40[rbp], 1
.L12:
	mov	eax, DWORD PTR -52[rbp]
	sub	eax, 1
	cmp	DWORD PTR -40[rbp], eax
	jl	.L16
	mov	edx, r13d
	mov	eax, DWORD PTR -52[rbp]
	lea	ecx, -1[rax]
	mov	rax, QWORD PTR -64[rbp]
	mov	esi, ecx
	mov	rdi, rax
	call	generateArray
	mov	r15, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -40[rbp], 0
	jmp	.L17
.L18:
	mov	rdx, r15
	mov	eax, DWORD PTR -40[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	add	DWORD PTR -40[rbp], 1
.L17:
	mov	eax, r13d
	cmp	DWORD PTR -40[rbp], eax
	jl	.L18
	mov	edi, 10
	call	putchar@PLT
	mov	rax, r15
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	add	rsp, 40
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
