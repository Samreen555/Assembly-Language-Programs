;4. Write a program that displays numbers from 1 to 9 using loop in assembly language. 
.model small
.stack 100h
.data
    newline db 0Dh, 0Ah, '$'  ; Newline for clean output

.code
main proc
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Initialize counter (CX) for the loop
    mov cx, 9          ; Loop 9 times (from 1 to 9)

    ; Initialize the starting number
    mov dl, '1'        ; ASCII value of '1'

print_loop:
    ; Print the current number
    mov ah, 02h        ; DOS interrupt to print a character
    int 21h

    ; Increment the number
    inc dl             ; Move to the next ASCII character

    ; Loop until CX becomes 0
    loop print_loop

    ; Print newline for clean output
    lea dx, newline
    mov ah, 09h        ; DOS interrupt to print a string
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
