// nasm -f macho64 q5asm.s && clang -o q5.o -c q5.c && clang -o q5 q5asm.o q5.o && rm *.o && ./q5
#include <stdio.h>
#include <math.h>

extern int towers(int n);

int main(int argc, char const *argv[])
{
    int n;
    scanf("%d", &n);
    printf("%d\n", towers(n));
}