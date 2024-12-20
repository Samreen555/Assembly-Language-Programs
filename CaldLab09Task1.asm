;Write a program that prints Sum , and Average of numbers stored in an array of integers.
.model small
.stack 100h
.data
array db 17, 12, 24, 28, 27 ; Array of integers
arraySize dw 5 ; Size of the array
sum dw 0 ; Variable to store the sum
avg dw 0 ; Variable to store the average
msgSum db "Array Sum is: $", 0 ; Message for sum
msgAvg db "Array Average is: $", 0 ; Message for average
.code
main proc
; Initialize data segment
mov ax, @data
mov ds, ax
; Initialize sum to 0 for start
xor ax, ax ; Clear AX for sum
xor bx, bx ; Clear BX (used as index)
mov cx, arraySize ; Load array size into CX
sumLoop:
add al, [array + bx] ; Add array element to AL (sum)
inc bx ; Move to next element
loop sumLoop ; Loop until all elements are added
; Store sum in memory
mov sum, ax
; Calculate average (sum / arraySize)
mov ax, sum ; Load sum into AX
mov cx, arraySize ; Load array size into CX
xor dx, dx ; Clear DX for division
div cx ; AX = sum / arraySize, DX = remainder
mov avg, ax ; Store the average
; Display sum message
lea dx, msgSum ; Load address of sum message
mov ah, 09h ; DOS function to display string
int 21h
; Display sum
mov ax, sum ; Load sum into AX
call PrintNumber ; Call PrintNumber procedure
; Display average message
lea dx, msgAvg ; Load address of average message
mov ah, 09h ; DOS function to display string
int 21h
; Display average
mov ax, avg ; Load average into AX
call PrintNumber ; Call PrintNumber procedure
; Exit program
mov ah, 4Ch ; DOS function to exit program
int 21h
PrintNumber proc
; Print AX as a decimal number
push ax
xor cx, cx ; Clear CX (counter for number of digits)
mov bx, 10 ; Divisor for converting to decimal
convertLoop:
xor dx, dx ; Clear DX (remainder)
div bx ; AX / BX, result in AX, remainder in DX
push dx ; Push remainder (digit) onto stack
inc cx ; Increment digit counter
test ax, ax ; Test if AX is zero
jnz convertLoop ; If not, continue dividing
printLoop:
pop dx ; Pop digit from stack
add dl, '0' ; Convert to ASCII
mov ah, 02h ; DOS function to display character
int 21h ; Print the digit
loop printLoop ; Loop for all digits
pop ax ; Restore AX
ret
PrintNumber endp
main endp
end main