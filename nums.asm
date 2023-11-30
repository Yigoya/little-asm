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
    mov edx, len
    mov ecx, strNum
    mov ebx, 1
    mov eax, 4
    int 0x80
%endmacro

section .data
    hl db 'hello world'
    num db 13
    len equ $ - hl

section .bss
    strNum resb 10
    nums resb 2

section .text
global _start
_start:
    mov edx,3
    mov ecx,nums
    mov ebx,1
    mov eax,3
    int 0x80

    ; mov ax, [nums]
    ; sub ax,'0'
    ; add ax,10
    ; add ax,'0'
    ; mov word [nums],ax

    mov edx,2
    mov ecx,nums
    mov ebx,1
    mov eax,4
    int 0x80

    mov eax,nums
    mov bl,0
    mov bh,10
    mov r8d,0
    mov dx,1
countdigit:
    cmp [eax+ebx],0
    jne countdigit
    mul bh
    inc bl
convert:
    movzx ecx, byte [nums]
    
base:
    mul bh
    cmp bl,0
    jne base
    dec bl

    sub ecx,'0'
    mul bh
    add r8d,ecx
    cmp bl,0
    jne convert
    


    


    ; inter nums
    mov eax, 1
    int 0x80