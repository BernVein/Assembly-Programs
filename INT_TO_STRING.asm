.stack 64

.data
    toConvert db 16
    converted db 4 dup('$')
.code
MAIN proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   
    
    call INT_TO_STRING
    call PRINT
    mov AX,4C00H
    int 21H 
MAIN endp

INT_TO_STRING proc near
    xor AX,AX
    mov BH,10
    call COUNTER
    mov AL,toConvert
    lea SI,converted
    mov DX,CX 
    sub DX,1
    add SI,DX
    loopParse:
        mov AH,0
        div BH
        add AH,'0'
        mov [SI],AH
        dec SI
        loop loopParse
    ret
INT_TO_STRING endp

PRINT proc near
    lea DX,converted
    mov AH,9
    int 21H
    ret
PRINT endp

COUNTER proc near
    xor AX,AX
    xor CX,CX
    mov BH,10
    mov AL,toConvert  
    add SI,2
    
    count:
        mov AH,0
        div BH 
        inc CX
        cmp AL,0
        jne count
    ret
COUNTER endp