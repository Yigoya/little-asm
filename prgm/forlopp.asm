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
    nums dd 1000,45,56,23,34
    len equ $ - nums
section .bss 
    strNum resb 8
    ave resb 4
    sum resb 4
section .text
global _start
_start:
    
    mov rdi,nums
    mov esi,5
    mov rdx,sum
    mov rcx,ave
    call _arraycall
    inter sum
    mov eax,1
    int 0x80
global _arraycall
_arraycall:
    push r12

    mov r12,0
    mov rax,0

    
forloop:
    add eax, dword [rdi+r12*4]
    inc r12
    cmp r12, rsi
    jl forloop

    mov dword [rdx],eax
    cdq
    idiv esi
    mov dword [rcx],eax
    pop r12
    ret