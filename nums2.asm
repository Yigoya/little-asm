section .data
    prompt db 'Enter the first number: ', 0
    prompt2 db 'Enter the second number: ', 0
    result_msg db 'The sum is: ', 0

section .bss
    num1 resd 1  ; Reserve space for the first number (32 bits)
    num2 resd 1  ; Reserve space for the second number (32 bits)
    sum resd 1   ; Reserve space for the sum (32 bits)

section .text
    global _start

_start:
    ; Display prompt for the first number
    mov eax, 4          ; System call number for sys_write
    mov ebx, 1          ; File descriptor 1 is stdout
    mov ecx, prompt     ; Pointer to the message
    mov edx, 25         ; Message length
    int 0x80            ; Call kernel

    ; Receive the first number from the user
    mov eax, 3          ; System call number for sys_read
    mov ebx, 0          ; File descriptor 0 is stdin
    mov ecx, num1       ; Pointer to the buffer to store the input
    mov edx, 4          ; Maximum number of bytes to read
    int 0x80            ; Call kernel

    ; Convert the string to an integer (assuming ASCII input)
    mov eax, [num1]
    sub eax, '0'
    mov [num1], eax

    ; Display prompt for the second number
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, 26
    int 0x80

    ; Receive the second number from the user
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 4
    int 0x80

    ; Convert the string to an integer
    mov eax, [num2]
    sub eax, '0'
    mov [num2], eax

    ; Add the two numbers
    mov eax, [num1]
    add eax, [num2]
    mov [sum], eax

    ; Display the result
    mov eax, 4
    mov ebx, 1
    mov ecx, result_msg
    mov edx, 14
    int 0x80

    ; Display the sum
    mov eax, 4
    mov ebx, 1
    mov ecx, sum
    mov edx, 1
    int 0x80

    ; Exit the program
    mov eax, 1          ; System call number for sys_exit
    xor ebx, ebx        ; Return code 0
    int 0x80            ; Call kernel
