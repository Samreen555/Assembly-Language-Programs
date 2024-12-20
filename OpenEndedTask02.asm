; 2. Write a program that takes 32-bit integer from the user, stores the integer, and redisplays the integer.
.model small
.stack 100h
.data
    name_msg    db 'Enter 32-digit integer : $'
    display_msg db 0Dh, 0Ah, 'Your integer is: $'
    name_buffer db 20 dup('$')   ; Buffer to store the name (20 characters max)
.code
main proc
    ; Initialize DS
    mov ax, @data
    mov ds, ax

    ; Display "Enter your name:" message
    lea dx, name_msg
    mov ah, 09h
    int 21h

    ; Input the name
    lea di, name_buffer     ; Point DI to the buffer
    mov cx, 20              ; Max 20 characters
input_loop:
    mov ah, 01h             ; Read a character
    int 21h
    cmp al, 0Dh             ; Check if 'Enter' (Carriage Return) is pressed
    je end_input            ; End input if Enter is pressed
    mov [di], al            ; Store the character in the buffer
    inc di                  ; Move to the next buffer location
    loop input_loop
end_input:
    mov byte ptr [di], '$'  ; Terminate the string with '$'

    ; Display "Your name is:" message
    lea dx, display_msg
    mov ah, 09h
    int 21h

    ; Display the input name
    lea dx, name_buffer
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
