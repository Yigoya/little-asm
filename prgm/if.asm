section .data
    name db 'less than',0xa,0xd,0
    msg db 'grater than',0xa,0xd
    len equ $ - msg
    nlen equ $ - name
section .bss
    num1 resb 5
    num2 resb 5
section .text
    global _start

_start:

    mov edx, 5
    mov ecx, num1
    mov ebx, 1
    mov eax,3
    int 0x80
    mov edx, 5
    mov ecx, num2
    mov ebx, 1
    mov eax,3
    int 0x80
    mov eax,[num1]
    sub eax,'0'
    mov ebx,[num2]
    sub ebx,'0'
    cmp eax,ebx
    jg grb
    jl lsb

grb:
    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax,4
    int 0x80
    jmp endl
lsb:
    mov edx, nlen
    mov ecx, name
    mov ebx, 1
    mov eax,4
    int 0x80
    jmp endl
endl:
    mov eax,1
    int 0x80
