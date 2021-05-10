global _binary_ones_counter
section .text

; input - rdi num
; output - rax 0 or 1

_binary_ones_counter:
    push    rbp         
    mov     rbp, rsp    ; initializes the stack

    mov     rcx, 0      ; initialize counter to 0
    mov     rbx, rdi    ; duplicates the number

    logic:
        and     rdi, 1
        cmp     rdi, 1
        je      add_one     ; if digit is one then increment counter
        jmp     update_number
        add_one:
            inc     rcx
        update_number:
            shr     rbx, 1      ; divide number by 2 (rightshift)
            cmp     rbx, 0
            je      end
            mov     rdi, rbx    ; replace the new value
            jmp     logic       ; loop it

    end:
        mov     rax, rcx
        mov     rbx, 2
        div     rbx
        mov     rax, rdx        ; logic to check even or odd

        pop     rbp
        ret