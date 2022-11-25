# Отчёт по ИДЗ №2 АВС, вариант 13 - Хорасанджян Л. А., БПИ218

## Выполненные критерии на 4 балла

### Код на C (файл [13variant.c](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_4/13variant.c)):

```c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int i;
    int j;

    char *a;
    int count_of_symbols = 0;

    char symbol;

    for (i = 0; i < argc - 1; ++i) {
        j = 0;
        symbol = argv[i + 1][j];
        while (symbol != '\0') {
            if (symbol >= 0 && symbol <= 127) {
                ++count_of_symbols;
            }
            ++j;
            symbol = argv[i + 1][j];
        }
    }

    a = (char *) malloc(count_of_symbols * sizeof(char));

    int index_a = 0;

    const int kDelta = 32;

    for (i = 0; i < argc - 1; ++i) {
        j = 0;
        symbol = argv[i + 1][j];
        while (symbol != '\0') {
            if (symbol >= 0 && symbol <= 127) {
                if (symbol >= 'A' && symbol <= 'Z') {
                    a[index_a] = (char)(symbol + kDelta);
                } else if (symbol >= 'a' && symbol <= 'z') {
                    a[index_a] = (char)(symbol - kDelta);
                } else {
                    a[index_a] = symbol;
                }
                ++index_a;
            }
            ++j;
            symbol = argv[i + 1][j];
        }
    }

    printf("Output: ");
    for (i = 0; i < count_of_symbols; ++i) {
        printf("%c", a[i]);
    }
    printf("\n");

    free(a);

    return 0;
}
```
Пояснения к программе:
Входные данные должны подаваться через кавычки, например: "I waNNa TyPe tHiS TexT hERe!".
Изначально программа по введёной строке рассчитывает объём памяти, для хранения валидных символов в диапазоне [0; 127]. Программа калькулирует кол-во валидных символов и выделяет память. Далее вводится целочисленная константа 32, которая означает разность между кодами ASCII строчной и заглавной букв (например, 'a' - 'A' = 97 - 65 = 32). Затем с помощью входной строки массив а заполняется символами в диапазоне [0; 127] с условием на строчные (они записываются в массив как заглавные) и заглавные (они записываются как строчные) буквы. Наконец, последним действием выводятся все элементы массива а.

### Стандартная компиляция программы (получим файл [13variant.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_4/assembly-usual/13variant.s)):

```sh
gcc -O0 -Wall -masm=intel -S 13variant.c -o 13variant.s
```

### Компиляция программы с оптимизацией (получим файл [13variant_optimized.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_4/assembly_optimized/13variant_optimized.s)):

```sh
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none 13variant.c -o 13variant_optimized.s
```

### Тестовое покрытие (демонстрация эквивалентности функционирования программ [13variant.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_4/assembly-usual/13variant.s) и [13variant_optimized.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_4/assembly_optimized/13variant_optimized.s)):
| Input data                 | usual                      | optimized                  |
|----------------------------|----------------------------|----------------------------|
| *empty_string*             | *empty_string*             | *empty_string*             |
| "abcde"                    | "ABCDE"                    | "ABCDE"                    |
| "DON'T KILL ME, assembly!" | "don't kill me, ASSEMBLY!" | "don't kill me, ASSEMBLY!" |

## Выполненные критерии на 5 баллов

### Комментарии к [13variant_func_optimized.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_5/13variant_func_optimized.s) - фрагмент 1:

```assembly
generateArray:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -40[rbp], rdi		# char *arr[] = rdi. (Приём входных данных)
	mov	DWORD PTR -44[rbp], esi		# int size = esi. (Приём входных данных)
	mov	DWORD PTR -48[rbp], edx		# int count_of_symbols = edx. (Приём входных данных)
```

### Комментарии к [13variant_func_optimized.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_5/13variant_func_optimized.s) - фрагмент 2:

```assembly
	add	DWORD PTR -20[rbp], 1
.L2:
	mov	eax, DWORD PTR -20[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L9
	mov	rax, QWORD PTR -8[rbp]		# rax = char *generated. (Возврат входных данных)
	leave
	ret
```

### Комментарии к [13variant_func_optimized.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_5/13variant_func_optimized.s) - фрагмент 3:

```assembly
	mov	eax, DWORD PTR -36[rbp]		# eax = int argc.
	lea	ecx, -1[rax]			# ecx = -1 + argc. (Размер)
	mov	edx, DWORD PTR -12[rbp]		# edx = count_of_symbols.
	mov	rax, QWORD PTR -48[rbp]		# rax = char *argv[].
	mov	esi, ecx			# int size.
	mov	rdi, rax			# char *arr[].
	call	generateArray			# Вызов функции.
	mov	QWORD PTR -8[rbp], rax		# char *a = rax. (Приём выходных данных)
```

## Выполненные критерии на 6 баллов

### Код на C с регистрами (файл [13variant_reg.c](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_6/13variant_reg.c)):

```c
#include <stdio.h>
#include <stdlib.h>

char *generateArray(char *arr[], int size, int count_of_symbols) {
    register char *generated asm("r12") = (char *) malloc(count_of_symbols * sizeof(char));
    register char symbol asm("r14");
    int index_generated = 0;

    const int kDelta = 32;

    int i;
    int j;
    for (i = 0; i < size; ++i) {
        j = 0;
        symbol = arr[i + 1][j];
        while (symbol != '\0') {
            if (symbol >= 0 && symbol <= 127) {
                if (symbol >= 'A' && symbol <= 'Z') {
                    generated[index_generated] = (char)(symbol + kDelta);
                } else if (symbol >= 'a' && symbol <= 'z') {
                    generated[index_generated] = (char)(symbol - kDelta);
                } else {
                    generated[index_generated] = symbol;
                }
                ++index_generated;
            }
            ++j;
            symbol = arr[i + 1][j];
        }
    }

    return generated;
}

int main(int argc, char *argv[]) {
    int i;
    int j;

    register int count_of_symbols asm("r13") = 0;

    register char symbol asm("r14");

    for (i = 0; i < argc - 1; ++i) {
        j = 0;
        symbol = argv[i + 1][j];
        while (symbol != '\0') {
            if (symbol >= 0 && symbol <= 127) {
                ++count_of_symbols;
            }
            ++j;
            symbol = argv[i + 1][j];
        }
    }

    register char *a asm("r15") = generateArray(argv, argc - 1, count_of_symbols);

    printf("Output: ");
    for (i = 0; i < count_of_symbols; ++i) {
        printf("%c", a[i]);
    }
    printf("\n");

    free(a);

    return 0;
}
```

Примечание:
Каждая локальная переменная была переписана в формате: register 'TYPE' 'NAME' asm("'REGISTER_NAME'").
Решил не приписывать комментарии в очевидных местах, как я написал выше.


### Тестовое покрытие (демонстрация эквивалентности функционирования программ [13variant.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_4/assembly-usual/13variant.s) и [13variant_reg_optimized.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_6/13variant_reg_optimized.s)):
| Input data                 | usual                      | optimized                  |
|----------------------------|----------------------------|----------------------------|
| *empty_string*             | *empty_string*             | *empty_string*             |
| "abcde"                    | "ABCDE"                    | "ABCDE"                    |
| "DON'T KILL ME, assembly!" | "don't kill me, ASSEMBLY!" | "don't kill me, ASSEMBLY!" |

### Сопоставление размеров программ [13variant.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_4/assembly-usual/13variant.s) и [13variant_reg_optimized.s](https://github.com/lkhorasandzhian/csa-ihw2/blob/main/grade_6/13variant_reg_optimized.s):
13variant.s **(206 строк)**
```assembly
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
```

13variant_reg_optimized.s **(221 строк)**
```assembly
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
```

---
Полученная оценка за работу: 6
