global _transpose
section .text

; input1 - rdi array
; input2 - rsi m
; input3 - rdx n
; output - rax only for testing

_transpose:
    push    rbp         
    mov     rbp, rsp    ; initializes the stack

    mov     r9, rsi     ; r9 = m
    mov     r10, rdx    ; r10 = n
    mov     rax, rdx
    mul     r9
    mov     r11, rax    ; r11 = m*n
    mov     rcx, r11
    dec     rcx         ; counter = m*n - 1

    mov     r13, 0
    mov     r14, 0
    
    jmp     duplicate_array


; stores the values
; from the array
; in the stack
duplicate_array:
    cmp     rcx, 0      
    jl      logic       ; counter < 0
    
    mov     r12, [rdi+4*rcx]    ; duplicate value
    push    r12
    dec     rcx
    jmp     duplicate_array


; converts row major 
; to column major
; a[i][j] = a[j][i]
logic:
; runs two loops
; for i = 0 to m
; for j = 0 to n
    
    ; reset i = 0
    mov     r13, 0
    
    inner_loop:
        ; mov     [rdi+r13+r14*r9], [rsp+r13*r10+r14]
        ; above operation is performed in two steps

        ; [rsp+r13*r10+r14]
        mov     rax, r10
        mul     r13
        add     rax, r14
        mov     r8, 8
        mul     r8
        mov     r15, [rsp+rax]
        
        ; [rdi+r13+r14*r9]
        mov     rax, r9
        mul     r14
        add     rax, r13
        mov     r8, 4
        mul     r8
        mov     [rdi+rax], r15
        
        inc     r13
        cmp     r13, r9     
        jl      inner_loop      ; i < m
    
    inc     r14
    cmp     r14, r10    
    jl      logic       ; j < n
    
    cmp     r14, r10    
    je      end     ; j = n



end:
    ; mov     rax, [rsp+8*0]    ; for testing
    mov     rcx, 0      ; initialize counter
    
    ; pop all elements of the array
    ; from the stack
    pop_array:
        pop     r12
        inc     rcx
        cmp     rcx, r11
        jne     pop_array   ; counter != m*n
    
    pop     rbp
    ret