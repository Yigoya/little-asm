section .data
    Line db 10,0
section .text
    global _start

_start:
    pop rbx
    cmp rbx, 2
    jl  not_enough_args
    mov r12,0
printArgument:
    pop rsi
    mov rdx,10
    mov rdi,1
    mov rax,1
    syscall
    mov rdx,2
    mov rsi,Line
    mov rdi,1
    mov rax,1
    syscall
    inc r12
    cmp r12,rbx
    jl printArgument
    jmp endl

not_enough_args:
    mov rdx,10
    mov rsi, error_message
    mov rdi,1
    mov rax,1
    syscall
endl:
    ; Exit the program
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; status: 0
    syscall


section .data
    error_message db "Not enough arguments.", 0
