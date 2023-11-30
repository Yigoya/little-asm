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
    LF equ 10 ; line feed
    NULL equ 0 ; end of string
    TRUE equ 1
    FALSE equ 0
    EXIT_SUCCESS equ 0 ; success code
    STDIN equ 0 ; standard input
    STDOUT equ 1 ; standard output
    STDERR equ 2 ; standard error
    SYS_read equ 0 ; read
    SYS_write equ 1 ; write
    SYS_open equ 2 ; file open
    SYS_close equ 3 ; file close
    SYS_fork equ 57 ; fork
    SYS_exit equ 60 ; terminate
    SYS_creat equ 85 ; file open/create
    SYS_time equ 201 ; get time
    O_CREAT equ 0x40
    O_TRUNC equ 0x200
    O_APPEND equ 0x400
    O_RDONLY equ 000000q ; read only
    O_WRONLY equ 000001q ; write only
    O_RDWR equ 000002q ; read and write
    S_IRUSR equ 00400q
    S_IWUSR equ 00200q
    S_IXUSR equ 00100q
    BUFF_SIZE equ 225
    ; -----
    ; Variables for main.
    newLine db LF, NULL
    header db LF, "File Write Example."
    db LF, LF, NULL
    fileName db "url.txt", NULL
    url db "http://www.google.com"
    db LF, NULL
    len dq $-url-1
    writeDone db "Write Completed.", LF, NULL
    fileDesc dq 0
    errMsgOpen db "Error opening file.", LF, NULL
    errMsgRead db "Error reading to file.", LF, NULL
section .bss 
    readBuffer resb BUFF_SIZE
section .text
global _start
_start:
openInputfile:
    mov rax,SYS_open
    mov rdi,fileName
    mov rsi,O_RDONLY
    syscall

    cmp rax,0
    jl errorOnOpen

    mov qword [fileDesc],rax

    mov rax,SYS_read
    mov rdi,qword [fileDesc]
    mov rsi,readBuffer
    mov rdx, BUFF_SIZE
    syscall

    cmp rax,0
    jl errorOnRead

    mov rsi,readBuffer
    mov byte [rsi+rax],NULL
    mov rdi,readBuffer
    call printString

    mov rax,SYS_close
    mov rdi,qword [fileDesc]
    syscall

    jmp exampleDone
errorOnRead:
    mov rdi,errMsgRead
    call printString
errorOnOpen:
    mov rdi,errMsgOpen
    call printString
exampleDone:
    mov rax,SYS_exit
    mov rdi,EXIT_SUCCESS
    syscall
global printString
printString:
    push rbp
    mov rbp, rsp
    push rbx
    ; Count characters in string.
    mov rbx, rdi
    mov rdx, 0
strCountLoop:
    cmp byte [rbx], NULL
    je strCountDone
    inc rdx
    inc rbx
    jmp strCountLoop
strCountDone:
    cmp rdx, 0
    je prtDone
    ; Call OS to output string.
    mov rax, SYS_write ; code for write()
    mov rsi, rdi ; addr of characters
    mov rdi, STDOUT ; file descriptor
    ; count set above
    syscall ; system call
    ; String printed, return to calling routine.
prtDone:
    pop rbx
    pop rbp
    ret
