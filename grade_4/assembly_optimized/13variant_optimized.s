	.file	"13variant.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"Output: "
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	DWORD PTR -20[rbp], 0
	mov	DWORD PTR -28[rbp], 0
	jmp	.L2
.L6:
	mov	DWORD PTR -24[rbp], 0
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -29[rbp], al
	jmp	.L3
.L5:
	cmp	BYTE PTR -29[rbp], 0
	js	.L4
	add	DWORD PTR -20[rbp], 1
.L4:
	add	DWORD PTR -24[rbp], 1
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -29[rbp], al
.L3:
	cmp	BYTE PTR -29[rbp], 0
	jne	.L5
	add	DWORD PTR -28[rbp], 1
.L2:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cmp	DWORD PTR -28[rbp], eax
	jl	.L6
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -16[rbp], 0
	mov	DWORD PTR -12[rbp], 32
	mov	DWORD PTR -28[rbp], 0
	jmp	.L7
.L14:
	mov	DWORD PTR -24[rbp], 0
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -29[rbp], al
	jmp	.L8
.L13:
	cmp	BYTE PTR -29[rbp], 0
	js	.L9
	cmp	BYTE PTR -29[rbp], 64
	jle	.L10
	cmp	BYTE PTR -29[rbp], 90
	jg	.L10
	mov	eax, DWORD PTR -12[rbp]
	mov	edx, eax
	movzx	eax, BYTE PTR -29[rbp]
	lea	ecx, [rdx+rax]
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	jmp	.L11
.L10:
	cmp	BYTE PTR -29[rbp], 96
	jle	.L12
	cmp	BYTE PTR -29[rbp], 122
	jg	.L12
	movzx	eax, BYTE PTR -29[rbp]
	mov	edx, DWORD PTR -12[rbp]
	sub	eax, edx
	mov	ecx, eax
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	jmp	.L11
.L12:
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -29[rbp]
	mov	BYTE PTR [rdx], al
.L11:
	add	DWORD PTR -16[rbp], 1
.L9:
	add	DWORD PTR -24[rbp], 1
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -29[rbp], al
.L8:
	cmp	BYTE PTR -29[rbp], 0
	jne	.L13
	add	DWORD PTR -28[rbp], 1
.L7:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cmp	DWORD PTR -28[rbp], eax
	jl	.L14
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -28[rbp], 0
	jmp	.L15
.L16:
	mov	eax, DWORD PTR -28[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	add	DWORD PTR -28[rbp], 1
.L15:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L16
	mov	edi, 10
	call	putchar@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
