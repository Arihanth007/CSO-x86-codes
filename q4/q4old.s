global _nqueens
section .text

; input1 - rdi array
; input2 - rsi n
; output - rax for testing purpose

_nqueens:
    push    rbp         
    mov     rbp, rsp    ; initializes the stack

    ; initialize some iterators
    mov     r8, 0
    mov     r9, 0
    ; mov     rcx, 0
    
    mov     r10, 0      ; x
    mov     r11, 0      ; y
    mov     r8, r10     ; x_iter - r10
    mov     r9, r11     ; y_iter - r11
    mov     rbx, 1      ; boolean
    mov     rcx, 1      ; number of successful cols
    
    
    mov     byte [rdi], 1
    jmp     logic
    
    pre_logic:
        mov     r8, 0
        mov     r9, r11
        call    find_1D_index
        cmp     byte [rdi+4*r15], 1
        call    update

        inc     r8
        cmp     r8, rsi
        jl      pre_logic     
    logic:
        inc     r11
        mov     r10, 0
        mov     r9, 0

        verification:
            row_verify:
                mov     r8, r10

                call    check_row
                cmp     r10, rsi
                jge     backtrack

            ld_verify:
                mov     r8, r10
                mov     r9, r11

                call    check_lower_diagonal
                cmp     r10, rsi
                jge     backtrack

            ud_verify:
                mov     r8, r10
                mov     r9, r11

                call    check_upper_diagonal
                cmp     r10, rsi
                jge     backtrack

            mov     r8, r10
            mov     r9, r11

            cmp     rcx, 4
            je     end

        cmp     rbx, 0
        ; je      verification
        
        call    find_1D_index
        mov     byte [rdi+4*r15], 1
        inc     rcx

        cmp     rcx, rsi        
        jge     end

        jmp     logic
        
        ; mov     rax, r10

    end:
        mov     rax, r11
        ; mov     rax, rcx
        ; mov     rax, rsi 

        pop     rbp
        ret

find_1D_index:
    mov     rax, r8
    mul     rsi
    add     rax, r9
    mov     r15, rax   
    ret

check_row:
    cmp     r9, r11
    jge     exit_cr_1

    call    find_1D_index
    cmp     byte [rdi+4*r15], 1
    je      exir_cr_2
    
    cmp     r9, r11
    inc     r9
    call    check_row
    ret
    exit_cr_1:
        mov     rbx, 1
        ret
    exir_cr_2:
        inc     r10
        mov     rbx, 0
        ret

check_lower_diagonal:
    dec     r8
    cmp     r8, 0
    jl      exit_ld_1

    dec     r9
    cmp     r9, 0
    jl      exit_ld_1

    call    find_1D_index
    cmp     byte [rdi+4*r15], 1
    je      exit_ld_2

    call    check_lower_diagonal
    ret
    exit_ld_1:
        and     rbx, 1
        ret
    exit_ld_2:
        inc     r10
        mov     rbx, 0
        ret

check_upper_diagonal:
    inc     r8
    cmp     r8, rsi
    jge     exit_ud_1

    dec     r9
    cmp     r9, 0
    jl      exit_ud_1

    call    find_1D_index
    cmp     byte [rdi+4*r15], 1
    je      exit_ud_2

    call    check_upper_diagonal
    ret
    exit_ud_1:
        and     rbx, 1
        ret
    exit_ud_2:
        inc     r10
        mov     rbx, 0
        ret

backtrack:
    dec     r11
    dec     rcx
    mov     rbx, 1
    jmp     pre_logic

update:
    mov     byte [rdi+4*r15], 0
    inc     r8
    call    find_1D_index
    mov     byte [rdi+4*r15], 1
    ret