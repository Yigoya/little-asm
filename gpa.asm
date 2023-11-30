section .data
    msg db 'hello world',10,0
    asknumcourse db 'How many courses do you take: ',0
    entername db 'Course name: ',0
    enterchr db 'Course credit hour: ',0
    entergrade db 'Course grade: ',0
    displayline db 'name',9,'chr',9,'grade',10,0
    coursenum dd  0
    fl dd 26.45
    teen dd 100.0
    FOUR db 4
    slen dd 0
    one dd 0
    total dw 0
    tab db 9,0
section .bss
    nm resb 4
    string resb 100
    coursenames resb 400
    coursecr resb 400
    coursegrade resb 400
section .text
    global _start:
_start:
    ; mov eax,[num]
    ; mov rsi,numStr
    ; call inttochar

    ; movss xmm0, dword [fl]
    ; mulss xmm0, dword [teen]
    ; cvtss2si eax,xmm0
    ; mov rsi,numStr
    ; call floattochar

; get Grade information from user
getGrade:
    mov ecx,asknumcourse
    call print

    mov rsi,coursenum
    mov ecx,nm
    call inputinteger

    mov r11d,0
    mov r11b,al
    mov rdi,0
forloops:
    mov ecx, entername
    call print
    mov ecx,coursenames
    add ecx,[slen]
    call input

    mov edx,[slen]
countstring:
    mov eax,[coursenames+edx]
    inc edx
    cmp al,0
    jne countstring
    mov byte [slen],dl

    mov ecx, enterchr
    call print

    mov ecx,coursecr
    add ecx,[one]
    call input

    mov ecx, entergrade
    call print
    mov ecx,coursegrade
    add ecx,[one]
    call input
    inc qword [one]
    dec r11b
    cmp r11b,0
    jne forloops

; calculateGPA:
;     mov ecx,0
; loops:
;     mov eax,[coursegrade+ecx] 
;     cmp al,0
;     je don
;     cmp al,'a'
;     je toa
;     cmp al,'b'
;     je tob
;     cmp al,'c'
;     je toc
;     cmp al,'d'
;     je tod
;     cmp al,'f'
;     je tof
; toa:
;     sub al,'0'
;     mov bl,4
;     mul bl
;     add [total],ax
;     inc ecx
;     jmp loops
; tob:
;     sub al,'0'
;     mov bl,3
;     mul bl
;     add [total],ax
;     inc ecx
;     jmp loops
; toc:
;     sub al,'0'
;     mov bl,2
;     mul bl
;     add [total],ax
;     inc ecx
;     jmp loops
; tod:
;     sub al,'0'
;     mov bl,1
;     mul bl
;     add [total],ax
;     inc ecx
;     jmp loops
; tof:
;     sub al,'0'
;     mov bl,0
;     mul bl
;     add [total],ax
;     inc ecx
;     jmp loops
; don:

display:

    mov ecx,displayline
    call print
    mov [slen],byte 0
    mov ecx,coursenames
    call print
    add [slen],edx
    mov ecx,tab
    call print
    mov ecx, coursecr
    call printone
end:
    mov ebx,0
    mov eax,1
    int 0x80

; input integer
inputinteger:
    mov eax,edi
    mul byte [FOUR]
    mov edx,10
    add ecx,eax
    mov ebx,0
    mov eax,3
    int 0x80
    mov eax,[nm]
    sub al,'0'
    mov [rsi],al
    ret

; float to charactor
floattochar:
    mov ecx,0
    mov ebx,10
fforloop:
    mov edx,0
    div ebx
    push rdx
    inc ecx
    cmp eax,0
    jne fforloop

    mov rdi,0
fpoploop:
    cmp ecx,2
    je adddot
afterloop:
    pop rax
    add al,'0'
    mov [rsi + rdi],al
    inc rdi
    loop fpoploop
    jmp done
adddot:
    mov [rsi + rdi],byte '.'
    inc rdi
    jmp afterloop
done: 
    mov byte [rsi + rdi],0
    ret

; integer to charactor
inttochar:
    mov ecx,0
    mov ebx,10
forloop:
    mov edx,0
    div ebx
    push rdx
    inc ecx
    cmp eax,0
    jne forloop

    mov rdi,0
poploop:
    pop rax
    add al,'0'
    mov [rsi + rdi],al
    inc rdi
    loop poploop

    mov byte [rsi + rdi],0
    ret



; charactor to integer 2 digit
chartoint:
    mov bl,10
    mov dx,0
    mov eax,[ecx]
    sub al,'0'
    mul bl
    add dx,ax
    mov eax,[ecx+1]
    sub al,'0'
    add dl,al
    mov [rsi],dx
    ret


; print string function
print:
    mov edx,0
countloop:
    mov eax,[ecx+edx]
    inc edx
    cmp al,0
    jne countloop

    mov ebx,1
    mov eax,4
    int 0x80
    ret
printone:
    mov edx,1
    mov ebx,1
    mov eax,4
    int 0x80
    ret

input:
    mov edx,10

    mov ebx,0
    mov eax,3
    int 0x80
    ret






    
