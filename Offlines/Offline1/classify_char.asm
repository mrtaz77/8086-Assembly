.MODEL SMALL ;SCOPE OF CODE

.STACK 100H ;ALLOCATE MEMORY IN HEXADECIMAL

.DATA ;VARIABLE DECLARATION
CR EQU 0DH
LF EQU 0AH   

UPPER_MSG DB CR,LF,'Uppercase letter$'
LOWER_MSG DB CR,LF,'Lowercase letter$'
NUM_MSG DB CR,LF,'Number$'
NON_ALPHA_MSG DB CR,LF,'Not an alphanumeric value$'



.CODE

MAIN PROC ; LIKE MAIN

;DATA SEGMENT INIT

MOV AX, @DATA;BRINGS DATA TO AX FOR INIT
MOV DS, AX     

;CHAR INPUT
MOV AH,1
INT 21H


CMP AL,'0'
JL NONALPHA

CMP AL,'9'
JLE  NUM

CMP AL,'A'
JL  NONALPHA

CMP AL,'Z'
JLE  UPPER

CMP AL,'a'
JL  NONALPHA

CMP AL,'z'
JLE  LOWER

JMP NONALPHA


NONALPHA:
    LEA DX,NON_ALPHA_MSG
    JMP EXIT

UPPER:
    LEA DX,UPPER_MSG
    JMP EXIT 

LOWER:
    LEA DX,LOWER_MSG
    JMP EXIT   


NUM:
    LEA DX,NUM_MSG
    JMP EXIT
    

            
;DOES EXIT
EXIT:      
    MOV AH,9
    INT 21H
    
    
    MOV AH,4CH
    INT 21H ;INTERRUPT FUNCTION


MAIN ENDP


END MAIN;END OF CODE
