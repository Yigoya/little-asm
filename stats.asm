section .data
section .text


global stats
stats:
    push r12
    mov r11,0
    mov r12d,0
forloop:
    mov eax,[rdi+r11*4]
    add r12d,eax
    inc r11
    cmp r11,rsi
    jb forloop

    mov [rdx],r12d
    pop r12
    ret

