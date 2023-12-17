.MODEL SMALL ;SCOPE OF CODE

.STACK 100H ;ALLOCATE MEMORY IN HEXADECIMAL

.DATA ;VARIABLE DECLARATION
CR EQU 0DH
LF EQU 0AH

NL DB CR,LF,'$'
ERROR DB CR,LF,'Invalid input$' 

ARR1 DW 10,20,20, 30, 40 ,50, 60, 70, 76 ,80 ,80 ,100, 110, 120, 120, 120 ,130
ARR2 DW 60,50,40,40,30,20,15,1,0
ARR3 DW 10,20,30,25,40

INCREASE DB 'Ascending$'
DECREASE DB 'Descending$'
UNSORT DB 'Not sorted$'



PREV DW ?
FLAG DW ?
CURR DW ?



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
LEA SI,ARR1   
MOV CX,17
CALL IS_SORTED

CALL NEWLINE

LEA SI,ARR2   
MOV CX,9
CALL IS_SORTED

CALL NEWLINE

LEA SI,ARR3   
MOV CX,5
CALL IS_SORTED









JMP EXIT

ERR: 
LEA DX,ERROR
CALL PRINT_STR
INT 21H

EXIT:
;DOES EXIT
MOV AH,4CH
INT 21H ;INTERRUPT FUNCTION


MAIN ENDP         

PROC IS_SORTED NEAR 
    MOV AX,[SI]
    MOV BX,AX
    ADD SI,2
    
    MOV FLAG,1
    
    
    
    CMP WORD PTR[SI],BX
    JAE FLAG_1
    MOV FLAG,2
    JMP INTO_LOOP    
        
        
    FLAG_1: 
        MOV FLAG,1
        
        
    INTO_LOOP:
        MOV BX,[SI]
        ADD SI,2
        DEC CX
        DEC CX
    
    CHECK_ARR:
        CMP WORD PTR[SI],BX
        JBE SECOND_CHECK 
        CMP FLAG,2
        JNE SECOND_CHECK
        MOV FLAG,3
        JMP LOOP_EX
        
        SECOND_CHECK:
        CMP WORD PTR[SI],BX
        JAE TO_NEXT
        CMP FLAG,1
        JNE TO_NEXT
        MOV FLAG,3
        JMP LOOP_EX
   
        TO_NEXT:
        MOV BX,[SI]
        ADD SI,2
    
        LOOP CHECK_ARR
        LOOP_EX:
        
        CMP FLAG,1
        JNE NX_CK
        LEA DX,INCREASE
        CALL PRINT_STR
        RET
        
        NX_CK:
        
        CMP FLAG,2
        JNE NX_CK2
        LEA DX,DECREASE
        CALL PRINT_STR
        RET
        
        NX_CK2:
        LEA DX,UNSORT
        CALL PRINT_STR
        RET
           




;print single char

PROC INPUT_CHAR NEAR
    MOV AH,1
    INT 21H
    RET


PROC PRINT_CHAR NEAR
     MOV AH,2
     INT 21H
     RET   

;outputs n(stored in cx) numbers as output and stores in array address

PROC OUTPUT_ARR_NUM NEAR
    OUTPUT_ARR_NUM1:
        MOV AX,WORD PTR[SI]
        CALL PRINT_NUM
        ADD SI,2       
        CALL NEWLINE
        LOOP OUTPUT_ARR_NUM1
        RET



;takes n(stored in cx) numbers as input and stores in the array address
;of SI

PROC INPUT_ARR_NUM NEAR
    INPUT_ARR_NUM1:
        CALL INPUT_NUM
        MOV WORD PTR[SI],AX
        ADD SI,2
        LOOP INPUT_ARR_NUM1
        RET   
    INPUT_ARR_NUM ENDP

PROC PRINT_STR NEAR
    MOV AH,9
    INT 21H
    RET       

PROC NEWLINE NEAR
    LEA DX,NL
    CALL PRINT_STR  
    RET                     
    
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