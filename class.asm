section .data
    ; Data section (initialize class data)
    class_data dd 0          ; Data member

section .text
    global _start

_start:
    ; Code section (initialize class and call member function)
    ; Allocate space for an instance of ExampleClass
    sub esp, 4              ; assuming 4 bytes for the data member

    ; Call the constructor
    mov eax, esp
    call ExampleClass_Constructor

    ; Call the member function
    mov eax, [esp]          ; Load the address of the class instance
    call ExampleClass_MemberFunction

    ; Cleanup
    add esp, 4              ; Restore the stack

    ; Exit the program
    mov eax, 1              ; syscall number for exit
    xor ebx, ebx            ; exit code 0
    int 0x80                ; call kernel

ExampleClass_Constructor:
    ; Constructor for ExampleClass
    mov eax, [esp]          ; Get the address of the class instance
    mov dword [eax], 42     ; Initialize the data member with 42
    ret

ExampleClass_MemberFunction:
    ; Member function for ExampleClass
    mov eax, [esp]          ; Get the address of the class instance
    add dword [eax], 1      ; Increment the data member by 1
    ret
