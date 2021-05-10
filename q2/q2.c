// nasm -f macho64 q2asm.s && clang -o q2.o -c q2.c && clang -o q2 q2asm.o q2.o && rm *.o && ./q2
#include <stdio.h>

extern int transpose(int *a, int m, int n);

int main(int argc, char const *argv[])
{
    int m, n;
    scanf("%d %d", &m, &n);

    int a[m][n];
    for (int i = 0; i < m; i++)
        for (int j = 0; j < n; j++)
            scanf("%d", &a[i][j]);

    // int m = 2, n = 3;
    // int a[2][3] = {{1, 2, 3}, {4, 5, 6}};
    // for (int i = 0; i < m; i++)
    // {
    //     for (int j = 0; j < n; j++)
    //         printf("%d ", a[i][j]);
    // }
    // printf("\n");

    int temp = transpose(&a[0][0], m, n), k = 0;
    // printf("%d\n", temp);

    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < n; j++)
        {
            k++;
            printf("%d ", a[i][j]);
            if (k % m == 0)
                printf("\n");
        }
    }

    return 0;
}