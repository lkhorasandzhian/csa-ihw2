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
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	DWORD PTR -20[rbp], 0		# int count_of_symbols = 0.
	mov	DWORD PTR -28[rbp], 0		# i = 0.
	jmp	.L2				# Переход к метке L2.
.L6:
	mov	DWORD PTR -24[rbp], 0		# j = 0.
	mov	eax, DWORD PTR -28[rbp]		# symbol = argv[i + 1][j]. (Начало)
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
	mov	BYTE PTR -29[rbp], al		# symbol = argv[i + 1][j]. (Конец)
	jmp	.L3				# Переход к метке L3.
.L5:
	cmp	BYTE PTR -29[rbp], 0		# Сравнение symbol с нулём.
	js	.L4				# Условный переход к метке L4.
	add	DWORD PTR -20[rbp], 1		# ++count_of_symbols.
.L4:
	add	DWORD PTR -24[rbp], 1		# ++j.
	mov	eax, DWORD PTR -28[rbp]		# symbol = argv[i + 1][j]. (Начало)
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
	mov	BYTE PTR -29[rbp], al		# symbol = argv[i + 1][j]. (Конец)
.L3:
	cmp	BYTE PTR -29[rbp], 0		# Проверка на конец строки, т. е. while (symbol != '\0').
	jne	.L5				# Условный переход к метке L5.
	add	DWORD PTR -28[rbp], 1		# ++i.
.L2:
	mov	eax, DWORD PTR -36[rbp]		# Запись argc в регистр eax.
	sub	eax, 1				# Вычитание из eax единицы.
	cmp	DWORD PTR -28[rbp], eax		# Сравнение вида i < argc - 1 только через регистр eax.
	jl	.L6				# Условный переход к метке L6.
	mov	eax, DWORD PTR -20[rbp]		# a = (char *) malloc(count_of_symbols * sizeof(char)). (Начало)
	cdqe
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -8[rbp], rax		# a = (char *) malloc(count_of_symbols * sizeof(char)). (Конец)
	mov	DWORD PTR -16[rbp], 0		# int index_a = 0.
	mov	DWORD PTR -12[rbp], 32		# const int kDelta = 32.
	mov	DWORD PTR -28[rbp], 0		# i = 0.
	jmp	.L7				# Переход к метке L7.
.L14:
	mov	DWORD PTR -24[rbp], 0		# j = 0.
	mov	eax, DWORD PTR -28[rbp]		# symbol = argv[i + 1][j]. (Начало)
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
	mov	BYTE PTR -29[rbp], al		# symbol = argv[i + 1][j]. (Конец)
	jmp	.L8				# Переход к метке L8.
.L13:
	cmp	BYTE PTR -29[rbp], 0		# Сравнение symbol с нулём.
	js	.L9				# Условный переход к метке L9.
	cmp	BYTE PTR -29[rbp], 64		# Сравнение symbol с '@'.
	jle	.L10				# Условный переход к метке L10, если symbol <= '@'.
	cmp	BYTE PTR -29[rbp], 90		# Сравнение symbol с 'Z'.
	jg	.L10				# Условный переход к метке L10, если symbol > 'Z'.
	mov	eax, DWORD PTR -12[rbp]		# a[index_a] = (char)(symbol + kDelta). (Начало)
	mov	edx, eax
	movzx	eax, BYTE PTR -29[rbp]
	lea	ecx, [rdx+rax]
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl		# a[index_a] = (char)(symbol + kDelta). (Конец)
	jmp	.L11				# Переход к метке L11.
.L10:
	cmp	BYTE PTR -29[rbp], 96		# Сравнение symbol с '`'.
	jle	.L12				# Условный переход к метке L12, если symbol <= '`'.
	cmp	BYTE PTR -29[rbp], 122		# Сравнение symbol с 'z'.
	jg	.L12				# Условный переход к метке L12, если symbol > 'z'.
	movzx	eax, BYTE PTR -29[rbp]		# a[index_a] = (char)(symbol - kDelta). (Начало)
	mov	edx, DWORD PTR -12[rbp]
	sub	eax, edx
	mov	ecx, eax
	mov	eax, DWORD PTR -16[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	edx, ecx
	mov	BYTE PTR [rax], dl		# a[index_a] = (char)(symbol - kDelta). (Конец)
	jmp	.L11				# Переход к метке L11.
.L12:
	mov	eax, DWORD PTR -16[rbp]		# a[index_a] = symbol. (Начало)
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -29[rbp]
	mov	BYTE PTR [rdx], al		# a[index_a] = symbol. (Конец)
.L11:
	add	DWORD PTR -16[rbp], 1		# ++index_a.
.L9:
	add	DWORD PTR -24[rbp], 1		# ++j.
	mov	eax, DWORD PTR -28[rbp]		# symbol = argv[i + 1][j]. (Начало)
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
	mov	BYTE PTR -29[rbp], al		# symbol = argv[i + 1][j]. (Конец)
.L8:
	cmp	BYTE PTR -29[rbp], 0		# Проверка на конец строки, т. е. while (symbol != '\0').
	jne	.L13				# Условный переход к метке L13.
	add	DWORD PTR -28[rbp], 1		# ++i.
.L7:
	mov	eax, DWORD PTR -36[rbp]		# Запись argc в регистр eax.
	sub	eax, 1				# Вычитание из eax единицы.
	cmp	DWORD PTR -28[rbp], eax		# Сравнение вида i < argc - 1 только через регистр eax.
	jl	.L14				# Условный переход к метке L14.
	lea	rax, .LC0[rip]			# printf("Output: "). (Начало)
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			# printf("Output: "). (Конец)
	mov	DWORD PTR -28[rbp], 0		# i = 0.
	jmp	.L15				# Переход к метке L15.
.L16:
	mov	eax, DWORD PTR -28[rbp]		# printf("%c", a[i]). (Начало)
	movsx	rdx, eax
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT			# printf("%c", a[i]). (Конец)
	add	DWORD PTR -28[rbp], 1		# ++i.
.L15:
	mov	eax, DWORD PTR -28[rbp]		# Запись i в регистр eax.
	cmp	eax, DWORD PTR -20[rbp]		# Сравнение вида i < count_of_symbols только через регистр eax.
	jl	.L16				# Переход к метке L16.
	mov	edi, 10				# printf("\n"). (Начало)
	call	putchar@PLT			# printf("\n"). (Конец)
	mov	rax, QWORD PTR -8[rbp]		# free(a). (Начало)
	mov	rdi, rax
	call	free@PLT			# free(a). (Конец)
	mov	eax, 0				# Завершение программы с кодом 0. (Начало)
	leave
	.cfi_def_cfa 7, 8
	ret					# Завершение программы с кодом 0. (Конец)
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
