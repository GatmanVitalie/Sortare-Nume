section .bss
    num1 resb 10    ; Reserve 10 bytes for the first number
    num2 resb 10    ; Reserve 10 bytes for the second number

section .text
    global _start

_start:
    ; Output prompt for the first number
    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor 1 (stdout)
    mov ecx, prompt1   ; address of the prompt string
    mov edx, prompt1len  ; length of the prompt string
    int 0x80

    ; Read the first number from the user
    mov eax, 3         ; sys_read
    mov ebx, 0         ; file descriptor 0 (stdin)
    mov ecx, num1      ; address to store the first number
    mov edx, 10        ; maximum number of bytes to read
    int 0x80

    ; Output prompt for the second number
    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor 1 (stdout)
    mov ecx, prompt2   ; address of the prompt string
    mov edx, prompt2len  ; length of the prompt string
    int 0x80

    ; Read the second number from the user
    mov eax, 3         ; sys_read
    mov ebx, 0         ; file descriptor 0 (stdin)
    mov ecx, num2      ; address to store the second number
    mov edx, 10        ; maximum number of bytes to read
    int 0x80

    ; Convert the input strings to integers
    call str2int

    ; Add the two numbers
    add eax, ebx

    ; Convert the result back to a string
    call int2str

    ; Output the result
    mov eax, 4         ; sys_write
    mov ebx, 1         ; file descriptor 1 (stdout)
    mov ecx, result    ; address of the result string
    mov edx, resultlen ; length of the result string
    int 0x80

    ; Exit the program
    mov eax, 1         ; sys_exit
    mov ebx, 0         ; exit code
    int 0x80

str2int:
    ; Convert a null-terminated string to an integer
    ; Input: ecx - address of the string
    ; Output: eax - the integer
    xor eax, eax        ; Clear eax (the result)
    xor ebx, ebx        ; Clear ebx (used as a flag)
.loop:
    movzx edx, byte [ecx]  ; Load the next character
    inc ecx               ; Move to the next character
    test  dl, dl          ; Check for the null terminator
    jz    .done           ; If null terminator, we're done
    sub   dl, '0'         ; Convert ASCII to integer
    imul  eax, eax, 10    ; Multiply current result by 10
    add   eax, edx        ; Add the new digit
    jmp   .loop
.done:
    ret

int2str:
    ; Convert an integer to a null-terminated string
    ; Input: eax - the integer to convert
    ; Output: ecx - address of the resulting string
    mov edi, ecx          ; Store the address of the string
    add edi, 10           ; Move edi to the end of the buffer
    mov byte [edi], 0     ; Null-terminate the string
    dec edi               ; Move edi to the last character
.reverse_loop:
    xor edx, edx           ; Clear any previous remainder
    div dword 10           ; Divide eax by 10, result in eax, remainder in edx
    add dl, '0'            ; Convert remainder to ASCII
    mov [edi], dl          ; Store the ASCII character
    dec edi                ; Move to the next position
    test eax, eax          ; Check if eax is zero
    jnz .reverse_loop       ; If not, continue the loop
    mov ecx, edi           ; Set ecx to the address of the resulting string
    ret

section .data
prompt1 db "Enter the first number: ", 0
prompt1len equ $ - prompt1
prompt2 db "Enter the second number: ", 0
prompt2len equ $ - prompt2
result db "The sum is: ", 0
resultlen equ $ - result
