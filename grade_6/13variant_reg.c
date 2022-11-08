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
