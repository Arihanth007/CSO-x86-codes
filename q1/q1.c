// nasm -f macho64 q1asm.s && clang -o q1.o -c q1.c && clang -o q1 q1asm.o q1.o && rm *.o && ./q1
#include <stdio.h>

extern int binary_ones_counter(int num);

int main(int argc, char const *argv[])
{
    int n, isOdd;
    scanf("%d", &n);
    isOdd = binary_ones_counter(n);
    if (isOdd)
        printf("TRUE\n");
    else
        printf("FALSE\n");
    return 0;
}