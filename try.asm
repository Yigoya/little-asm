section .data
    msg db 'hello world',10,0
    len equ $ - msg
section .bss
    ans resb 1
section .text
    global _start:
_start:
    mov edx,len
    mov ecx,msg
    mov ebx,1
    mov eax,4
    int 0x80

    mov edx,1
    mov ecx,ans
    mov ebx,0
    mov eax,3
    int 0x80

    mov eax,[ans]
    sub al,48
    add al,4
    add al,48
    mov [ans],al

    mov edx,len
    mov ecx,ans
    mov ebx,1
    mov eax,4
    int 0x80

    mov ebx,0
    mov eax,1
    int 0x80


    