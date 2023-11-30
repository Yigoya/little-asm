section .data
    counter db 1

section .text
    global _start

_start:
    ; Initialize counter to 1
    mov al, [counter]

    ; Start of the loop
for_loop:
    ; Your loop body goes here

    ; For demonstration purposes, print the current value of the counter
    mov eax, 4          ; Syscall number for sys_write
    mov ebx, 1          ; File descriptor 1 is stdout
    lea ecx, [counter]  ; Load effective address of counter
    mov edx, 1          ; Length of the message (1 byte)
    int 0x80            ; Call kernel

    ; Increment counter
    inc byte [counter]

    ; Compare counter with 6 (end condition)
    cmp byte [counter], 6
    jl for_loop         ; Jump to the start of the loop if counter < 6

    ; End of the program
    mov eax, 1          ; Syscall number for sys_exit
    xor ebx, ebx        ; Exit code 0
    int 0x80            ; Call kernel
