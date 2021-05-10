// nasm -f macho64 q3asm.s && clang -o q3.o -c q3.c && clang -o q3 q3asm.o q3.o && rm *.o && ./q3
#include <stdio.h>

extern int sum_of_primes(int n, int m);

int main(int argc, char const *argv[])
{
    int n, m, sum;
    scanf("%d %d", &n, &m);

    sum = sum_of_primes(n, m);
    printf("%d\n", sum);

    return 0;
}