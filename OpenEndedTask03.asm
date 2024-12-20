;3. Write a program that uses 2 arrays of 16-bit integers, showing 
;both direct and indirect addressing modes working.
.model small
.stack 100h
.data
    ; Define two arrays of 16-bit integers
    array1 dw 19, 20, 35, 46, 57       ; Array 1 with 5 elements
    array2 dw 10, 20, 30, 40, 50  ; Array 2 with 5 elements
    result_msg db 'Result Array: $'
    newline db 0Dh, 0Ah, '$'
    result dw 5 dup(?)            ; Array to store results (sum of array1 and array2)

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Display header message
    lea dx, result_msg
    mov ah, 09h
    int 21h

    ; Initialize SI and DI for indirect addressing
    lea si, array1               ; Load address of array1 into SI
    lea di, array2               ; Load address of array2 into DI
    lea bx, result               ; Load address of result array into BX

    mov cx, 5                    ; Loop counter for 5 elements

array_loop:
    ; Access array elements indirectly
    mov ax, [si]                 ; Load value from array1 (indirect mode via SI)
    add ax, [di]                 ; Add value from array2 (indirect mode via DI)
    mov [bx], ax                 ; Store the result in result array (direct mode)

    ; Display the result
    mov dx, ax                   ; Move the result to DX for printing
    call print_number            ; Call the print routine

    ; Increment pointers for indirect addressing
    add si, 2                    ; Move to the next element in array1
    add di, 2                    ; Move to the next element in array2
    add bx, 2                    ; Move to the next result location

    loop array_loop              ; Repeat for all elements

    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

; Subroutine to print 16-bit number in DX
print_number proc
    push ax                      ; Preserve AX
    push bx                      ; Preserve BX
    push cx                      ; Preserve CX
    push dx                      ; Preserve DX

    mov cx, 0                    ; Digit counter

print_loop:
    xor dx, dx                   ; Clear DX
    mov bx, 10                   ; Divisor for decimal
    div bx                       ; Divide AX by 10 -> quotient in AX, remainder in DX
    push dx                      ; Save remainder (digit) on stack
    inc cx                       ; Increment digit counter
    test ax, ax                  ; Check if AX is zero
    jnz print_loop               ; Repeat until AX is zero

print_digits:
    pop dx                       ; Retrieve digit from stack
    add dl, '0'                  ; Convert to ASCII
    mov ah, 02h                  ; DOS print character
    int 21h                      ; Print digit
    loop print_digits            ; Repeat for all digits

    ; Print space after the number
    mov dl, ' '                  ; Space character
    mov ah, 02h
    int 21h

    pop dx                       ; Restore DX
    pop cx                       ; Restore CX
    pop bx                       ; Restore BX
    pop ax                       ; Restore AX
    ret
print_number endp

main endp
end main
