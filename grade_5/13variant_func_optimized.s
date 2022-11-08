	.file	"13variant_func.c"
	.intel_syntax noprefix
	.text
	.globl	generateArray
	.type	generateArray, @function
generateArray:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi		# char *arr[] = rdi. (Приём входных данных)
	mov	DWORD PTR -44[rbp], esi		# int size = esi. (Приём входных данных)
	mov	DWORD PTR -48[rbp], edx		# int count_of_symbols = edx. (Приём входных данных)
	mov	eax, DWORD PTR -48[rbp]
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -24[rbp], 0
	mov	DWORD PTR -12[rbp], 32
	mov	DWORD PTR -20[rbp], 0
	jmp	.L2
.L9:
	mov	DWORD PTR -16[rbp], 0
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -25[rbp], al
	jmp	.L3
.L8:
	cmp	BYTE PTR -25[rbp], 0
	js	.L4
	cmp	BYTE PTR -25[rbp], 64
	jle	.L5
	cmp	BYTE PTR -25[rbp], 90
	jg	.L5
	mov	eax, DWORD PTR -12[rbp]
	mov	edx, eax
	movzx	eax, BYTE PTR -25[rbp]
	lea	ecx, [rdx+rax]
	mov	eax, DWORD PTR -24[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	jmp	.L6
.L5:
	cmp	BYTE PTR -25[rbp], 96
	jle	.L7
	cmp	BYTE PTR -25[rbp], 122
	jg	.L7
	movzx	eax, BYTE PTR -25[rbp]
	mov	edx, DWORD PTR -12[rbp]
	sub	eax, edx
	mov	ecx, eax
	mov	eax, DWORD PTR -24[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl
	jmp	.L6
.L7:
	mov	eax, DWORD PTR -24[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -25[rbp]
	mov	BYTE PTR [rdx], al
.L6:
	add	DWORD PTR -24[rbp], 1
.L4:
	add	DWORD PTR -16[rbp], 1
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -25[rbp], al
.L3:
	cmp	BYTE PTR -25[rbp], 0
	jne	.L8
	add	DWORD PTR -20[rbp], 1
.L2:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L9
	mov	rax, QWORD PTR -8[rbp]		# rax = char *generated. (Возврат входных данных)
	leave
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
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	DWORD PTR -12[rbp], 0
	mov	DWORD PTR -20[rbp], 0
	jmp	.L12
.L16:
	mov	DWORD PTR -16[rbp], 0
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -21[rbp], al
	jmp	.L13
.L15:
	cmp	BYTE PTR -21[rbp], 0
	js	.L14
	add	DWORD PTR -12[rbp], 1
.L14:
	add	DWORD PTR -16[rbp], 1
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rdx, QWORD PTR [rax]
	mov	eax, DWORD PTR -16[rbp]
	cdqe
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -21[rbp], al
.L13:
	cmp	BYTE PTR -21[rbp], 0
	jne	.L15
	add	DWORD PTR -20[rbp], 1
.L12:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cmp	DWORD PTR -20[rbp], eax
	jl	.L16
	mov	eax, DWORD PTR -36[rbp]		# eax = int argc.
	lea	ecx, -1[rax]			# ecx = -1 + argc. (Размер)
	mov	edx, DWORD PTR -12[rbp]		# edx = count_of_symbols.
	mov	rax, QWORD PTR -48[rbp]		# rax = char *argv[].
	mov	esi, ecx			# int size.
	mov	rdi, rax			# char *arr[].
	call	generateArray			# Вызов функции.
	mov	QWORD PTR -8[rbp], rax		# char *a = rax. (Приём выходных данных)
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	DWORD PTR -20[rbp], 0
	jmp	.L17
.L18:
	mov	eax, DWORD PTR -20[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
	add	DWORD PTR -20[rbp], 1
.L17:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	jl	.L18
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
