section .data
    ; Define a variable
    my_variable db 42  ; A byte-sized variable initialized with the value 42

section .text
global main
main:
    ; Load the value of my_variable into a register
    mov al, byte [my_variable]

    ; Compare it with a specific value (e.g., 42)
    cmp al, 42

    ; Jump to label_equal if the values are equal
    je label_equal

    ; Code to execute if not equal goes here
    ; ...

    ; Jump to the end of the if statement
    jmp label_end

label_equal:
    ; Code to execute if equal goes here
    ; ...

label_end:
    ; Rest of the program

    ; Exit the program
    mov rax, 60         ; syscall number for exit
    xor rdi, rdi        ; exit status 0
    syscall
