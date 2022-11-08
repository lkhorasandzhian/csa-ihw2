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
