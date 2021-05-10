global _towers
section .text

; input1 - rdi n
; output - rax min steps

_towers:
    push    rbp         
    mov     rbp, rsp    ; initializes the stack

    mov     r8, 1
    
    ; 8n+1
    mov     r15, 8
    mov     rax, rdi
    mul     r15
    mov     r15, rax
    inc     r15

    ; find square root of (8n+1)
    loop1:
        ; find square of every number
        ; less than or equal to n
        mov     rax, r8
        mul     r8
        mov     r9, rax

        ; next number
        inc     r8

        ; equal means we found it
        cmp     r9, r15
        je      logic

        ; continue to search
        cmp     r9, r15
        jl      loop1

        ; largest square < n
        dec     r8

    logic:
        ; s = (r8-1)/2
        dec     r8
        ; r8 - 1
        dec     r8
        ; flushes rdx
        ; and divies r8 by 2
        xor     rdx, rdx
        mov     rax, r8
        mov     r10, 2
        div     r10
        mov     r8, rax     ; s = r8

        ; 2^s
        mov     rcx, 1
        mov     r9, 2
        ; multiplies 2 to the reslut
        ; s number of times
        loop2:
            mov     rax, 2
            mul     r9
            mov     r9, rax
            inc     rcx
            cmp     rcx, r8
            jl      loop2

        ; x = s(s-1)/2
        mov     rax, r8
        dec     rax
        mul     r8
        xor     rdx, rdx
        div     r10
        mov     r11, rax
        
        ; x = n - x - 1
        mov     r12, rdi
        sub     r12, r11
        dec     r12

        ; x = x * 2^s
        mov     rax, r12
        mul     r9
        mov     r9, rax
        
        ; x = x + 1
        inc     r9


    end:
        mov     rax, r9

        pop     rbp
        ret