.model small
.stack 100h

.data
CR EQU 0DH
LF EQU 0AH

MSG1 DB 'ENTER UPPER CASE: $'
MSG2 DB CR,LF,'CHAR IN LOWER CASE: $'
CHAR DB ?

.code

MAIN PROC
;init ds
MOV AX,@DATA
MOV DS,AX

;print user prompt
LEA DX,MSG1 ;LOAD EFFECTIVE ADDRESS
MOV AH,9
INT 21H

;input a upper case character
mov ah,1
int 21h
add AL, 20h
mov char,AL

;display on next line
lea dx,MSG2
MOV AH,9
INT 21H


;display lower case
mov ah,2
mov dl,char
INT 21H

;DOS EXIT
MOV AH,4CH
INT 21H

MAIN ENDP

END MAIN









; [SOURCE]: D:\OG D drive\Level 3 Term 1\CSE 316_ Microprocessors, Microcontrollers, and Embedded Systems Sessional\8086-ASM\Practice\upper_to_lower\upper_to_lower.exe.asm
