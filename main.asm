%macro inter 1
    mov eax,dword [%1]
    mov ecx,0
    mov ebx,10
%%forloop:
    mov edx,0
    div ebx
    push rdx
    inc ecx
    cmp eax,0
    jne %%forloop

    mov rbx,strNum
    mov rdi,0
%%poploop:
    pop rax
    add al,"0"
    mov [rbx+rdi],al
    inc rdi
    loop %%poploop

    mov byte [rbx+rdi],0
    mov edx, 4
    mov ecx, strNum
    mov ebx, 1
    mov eax, 4
    int 0x80
%endmacro
section .data
    nums dd 10,10,10,10
    len equ $-nums

section .bss 
    strNum resb 4
    sum resb 4
    ave resb 4
extern stats
section .text
global _start
_start:
    mov rdi,nums
    mov rsi,4
    mov rdx,sum
    mov rcx,ave
    call stats
    inter sum
    mov eax,1
    int 0x80