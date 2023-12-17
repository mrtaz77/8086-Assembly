.MODEL SMALL ;SCOPE OF CODE

.STACK 100H ;ALLOCATE MEMORY IN HEXADECIMAL

.DATA ;VARIABLE DECLARATION
CR EQU 0DH
LF EQU 0AH

NL DB CR,LF,'$'
ERROR DB CR,LF,'Invalid input$'


ARR3 DW 3 DUP (?)
ARR1 DW 01234H, 05678H, 09ABCH
ARR2 DB 2 DUP (01EH), 2 DUP (0ABH), 0FFH

; EQU MEANS EQUAL
; THESE CONSTANTS ARE USED IN ALL CODES
; USED FOR NEW LINE


.CODE

MAIN PROC ; LIKE MAIN

;DATA SEGMENT INIT

MOV AX, @DATA;BRINGS DATA TO AX FOR INIT
MOV DS, AX
;THE ABOVE PART IS SAME FOR MOST CODES  

;code here

LEA SI,ARR3

MOV CX,3
INPUT:
CALL INPUT_NUM
MOV WORD PTR[SI],AX
ADD SI,2
LOOP INPUT

MOV CX,3
OUTPUT:
MOV AX,[SI]
CALL PRINT_NUM
DEC WORD PTR[SI],2

LOOP OUTPUT


JMP EXIT


ERR: 
LEA DX,ERROR
MOV AH,9
INT 21H

EXIT:
;DOES EXIT
MOV AH,4CH
INT 21H ;INTERRUPT FUNCTION


MAIN ENDP
    
    
;takes a decimal number input and stores it in AX register 
;Number is space terminated
   
PROC INPUT_NUM NEAR 
        MOV BX,0
    INP:
        MOV AH,1
        INT 21H    
        
        CMP AL,' '
        JE EXIT_INPUT
        CMP AL,'0'
        JB ERR
        CMP AL,'9'
        JA ERR
        
        SUB AL,30H
        AND AX,0FFH
        PUSH AX
        MOV AL,0AH
        MUL BX
        MOV BX,AX
        POP AX  
        ADD BX,AX
        MOV AH,1
        JMP INP
    EXIT_INPUT:
        MOV AX,BX
        RET
    
    

; prints the number in decimal stored in AX register

PROC PRINT_NUM NEAR
    MOV BX,0AH
    PUSH 404H ; end of number
    ;DISPLAY NUM
    NUM_IN_STACK:
        CMP BX,AX
        JA EXIT_NUM_STACK
        MOV DX,0
        DIV BX
        PUSH DX
        JMP NUM_IN_STACK
    EXIT_NUM_STACK:
        CMP AX,0
        JE NO_PUSH
        PUSH AX
    NO_PUSH:
        MOV AH,2
    DISPLAY:
        POP DX
        CMP DX,404H
        JE EXIT_PRINT
        ADD DX,30H
        INT 21H
        JMP DISPLAY
    EXIT_PRINT:
        RET

END MAIN;END OF CODE