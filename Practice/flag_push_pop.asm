.MODEL SMALL ;SCOPE OF CODE

.STACK 100H ;ALLOCATE MEMORY IN HEXADECIMAL

.DATA ;VARIABLE DECLARATION
CR EQU 0DH
LF EQU 0AH

NL DB CR,LF,'$'

; EQU MEANS EQUAL
; THESE CONSTANTS ARE USED IN ALL CODES
; USED FOR NEW LINE


.CODE

MAIN PROC ; LIKE MAIN

;DATA SEGMENT INIT

MOV AX, @DATA;BRINGS DATA TO AX FOR INIT
MOV DS, AX
;THE ABOVE PART IS SAME FOR MOST CODES

MOV AL,91H
MOV CL,1
ROL  AL,CL

PUSHF
PUSHF
POPF
POPF

;DOES EXIT
MOV AH,4CH
INT 21H ;INTERRUPT FUNCTION

MAIN ENDP


END MAIN;END OF CODE