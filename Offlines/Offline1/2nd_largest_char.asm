.MODEL SMALL ;SCOPE OF CODE

.STACK 100H ;ALLOCATE MEMORY IN HEXADECIMAL

.DATA ;VARIABLE DECLARATION
CR EQU 0DH
LF EQU 0AH

NL DB CR,LF,'$'
EQUAL DB CR,LF,'All letters are equal$'



.CODE

MAIN PROC ; LIKE MAIN

;DATA SEGMENT INIT

MOV AX, @DATA;BRINGS DATA TO AX FOR INIT
MOV DS, AX     

;CHAR INPUT
MOV AH,1
INT 21H
MOV BL,AL 

MOV AH,1
INT 21H
MOV BH,AL

MOV AH,1
INT 21H 
MOV DL,AL

;inputs in bl(a),bh(b) and dl(c)

CMP BL,BH
JE  ABEQUAL
JL  ALESSB
JG  AGREATB


ALESSB:
    CMP BH,DL
    JE ANSA
    JL ANSB
    JG ALESSB_BGREATC

AGREATB:
    CMP DL,BH
    JLE ANSB
    JG AGREATB_BLESSC
    

ABEQUAL:
    CMP BL,DL
    JE  EQL
    JG  ANSC
    JL  ANSA

ALESSB_BGREATC:
    CMP BL,DL
    JGE ANSA
    JL ANSC  

AGREATB_BLESSC:
    CMP BL,DL
    JE ANSB
    JL ANSA
    JG ANSC
    

ANSA:
    LEA DX,NL
    MOV AH,9
    INT 21H
    
    MOV DL,BL
    JMP EXITANS 

ANSB:
    LEA DX,NL
    MOV AH,9
    INT 21H
    
    MOV DL,BH
    JMP EXITANS

ANSC:  
    MOV BH,DL ;temporarily move c to b's register

    LEA DX,NL
    MOV AH,9
    INT 21H
    
    MOV DL,BH
    JMP EXITANS


EQL:
    LEA DX,EQUAL 
    MOV AH,9
    JMP EXIT    

EXITANS:
    MOV AH,2

EXIT:      
    INT 21H
    
;DOES EXIT   
    MOV AH,4CH
    INT 21H ;INTERRUPT FUNCTION


MAIN ENDP


END MAIN;END OF CODE
