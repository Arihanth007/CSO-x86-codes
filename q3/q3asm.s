global _sum_of_primes
section .text

; input1 - rdi n
; input2 - rsi m
; output - rax sum of primes

_sum_of_primes:
    push    rbp         
    mov     rbp, rsp    ; initializes the stack

    ; edge case:
    ; if n <= 2
    ; sum = 0
    cmp     rdi, 2
    jle     end2

    mov     r15, 2      ; sum = 2
    mov     r9, 2       ; iterator1
    mov     r10, 2      ; iterator2

    find_primes:
        ; every number between
        ; 2 and n is checked to
        ; see if it is prime
        check_prime:
            mov     rax, r9
            xor     rdx, rdx
            div     r10
            
            cmp     rdx, 0
            je      skip

            inc     r10
            cmp     r10, r9
            jl      check_prime
            
            cmp     r10, r9
            je      found_prime
            
            ; if number is prime
            ; it is added to the sum
            found_prime:
                add     r15, r9 
                mov     rax, r15
                xor     rdx, rdx
                div     rsi
                mov     r15, rdx

        ; iterates all numbers
        ; between 2 to n
        ; check if that is prime
        ; using the above function
        skip:
            mov     r10, 2
            inc     r9
            
            cmp     r9, rdi
            jl      find_primes

    ; returns the sum mod m
    ; mod is not required
    ; but just to be sure
    end:
        mov     rax, r15
        xor     rdx, rdx
        div     rsi
        mov     rax, rdx
        
        pop     rbp
        ret

; edge case:
; returns 0
end2:
    mov     rax, 0
    pop     rbp
    ret