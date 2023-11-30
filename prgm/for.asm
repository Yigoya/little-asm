section .data

section .bss
    input1 resb 5
section .text
    global _start
_start:
    mov edx, 5
    mov ecx, input1
    mov ebx, 1
    mov eax,3
    int 0x80

;     ; mov rsi,input1
;     ; mov rdx,input1
    mov ecx,65

forloop:
    cmp ecx,80
    inc ecx
    je endl
    mov edx, 8
    mov ecx
    mov ebx, 1
    mov eax,4
    int 0x80 
    jmp forloop
endl:
    mov eax,1
    int 0x80
