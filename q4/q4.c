// nasm -f macho64 q4asm.s && clang -o q4.o -c q4.c && clang -o q4 q4asm.o q4.o && rm *.o && ./q4
#include <stdio.h>

extern int nqueens(int *a, int n);

int main(int argc, char const *argv[])
{
    int n = 4;
    // int n;
    // scanf("%d", &n);

    // ind1D = ind_x * n + ind_y
    int a[n][n];
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            a[i][j] = 0;

    int temp = nqueens(&a[0][0], n);
    printf("%d\n", temp);

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
            printf("%d ", a[i][j]);
        printf("\n");
    }

    return 0;
}