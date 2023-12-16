.MODEL SMALL ;SCOPE OF CODE

.STACK 100H ;ALLOCATE MEMORY IN HEXADECIMAL

.DATA ;VARIABLE DECLARATION
CR EQU 0DH
LF EQU 0AH

NL DB CR,LF,'$' 
ERROR DB CR,LF,'Invalid input$' 

; EQU MEANS EQUAL
; THESE CONSTANTS ARE USED IN ALL CODES
; NL USED FOR NEW LINE

.CODE

MAIN PROC ; LIKE MAIN

;DATA SEGMENT INIT

MOV AX, @DATA;BRINGS DATA TO AX FOR INIT
MOV DS, AX
;THE ABOVE PART IS SAME FOR MOST CODES

MOV BX,0

;Using loop to take a number
;and pushing it to the stack

INP:
MOV AH,1
INT 21H    

CMP AL,' '
JE NEXT
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

NEXT:

PUSH BX
CALL SUM_OF_DIGITS

MOV AX,CX
CALL PRINT_NUM

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

PROC SUM_OF_DIGITS NEAR
    PUSH BP
    MOV BP,SP 
    
    ;terminating condition
    CMP WORD PTR[BP+4],0AH
    JA END_IF
    MOV CX,[BP+4]
    JMP RETURN
    
    END_IF:
        MOV AX,[BP+4]
        MOV DX,0
        MOV BX,0AH
        DIV BX
        PUSH DX
        PUSH AX
        CALL SUM_OF_DIGITS
        ADD CX,WORD PTR[BP] 
        POP BP
    
    RETURN:
        POP BP
        SUB BP,2
        RET 2   

PROC PRINT_NUM NEAR
    MOV BX,0AH
    PUSH 404H ;end of number
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
        JE EXIT_FUNC
        ADD DX,30H
        INT 21H
        JMP DISPLAY
    EXIT_FUNC:
        RET
        
END MAIN;END OF CODE