section .data
    hello db 'Hello, Assembly World!',0

section .text
    global _start

_start:
    ; Connect to X server
    mov rax, 0x68          ; syscall number for syscall(socket)
    mov rdi, 0xffffffffffffd982 ; server address (localhost)
    mov rsi, 0x5c11         ; server port (X11)
    mov rdx, 0             ; protocol (Family Internet, Type Stream, Protocol 0)
    syscall

    ; Create a window
    mov rax, 0x6a           ; syscall number for syscall(open)
    mov rdi, hello            ; path (null-terminated string, in this case, null)
    mov rsi, 0x41           ; flags (O_CREAT | O_RDWR)
    mov rdx, 0x1ed          ; mode (S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)
    syscall

    ; Write message to the window
    mov rax, 0x1            ; syscall number for syscall(write)
    mov rdi, 1              ; file descriptor (stdout)
    mov rsi, hello            ; buffer
    mov rdx, 22             ; length
    syscall

    ; Exit
    mov rax, 0x3c           ; syscall number for syscall(exit)
    xor rdi, rdi            ; status
    syscall
