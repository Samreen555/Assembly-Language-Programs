;1. Write a program that prints “welcome assembly language” in 
;assembly language.
.MODEL SMALL
.STACK 100H
.DATA
    hello DB '!!!! Welcome Assembly Language :) !!!! $'  ; $ is used as the string terminator for DOS

.CODE
MAIN PROC
    MOV AX, @DATA   ; Load the data segment
    MOV DS, AX

    MOV AH, 09H     ; DOS function to display string
    LEA DX, hello   ; Load the address of 'hello' into DX
    INT 21H         ; Call DOS interrupt

    MOV AH, 4CH     ; DOS function to exit program
    INT 21H
MAIN ENDP
END MAIN
