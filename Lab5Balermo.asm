.stack 64

.data
 PARA_LIST LABEL BYTE
 ACT_LEN db ?
 KB_DATA db 1 DUP('B'), '$'  
    
.code
main proc near
    mov AX, @data
    mov ES,AX
    mov DS,AX
    
    mov AH,0AH
    lea DX,PARA_LIST
    int 21H
    
    L0:                                 x
        lea BX,KB_DATA
        lea SI,STR1
        mov CH,00
        mov CL,ACT_LEN
    
    L1:
        mov AL,[BX]
        cmp [SI],AL
        je CONT
        jne STOP
        
    CONT:
        inc SI
        inc BX
    
    LOOP L1
        lea DX,STR1
        mov AH,09H
        int 21H
        jmp end
    
    STOP:
        lea DX,KB_DATA
        mov AH,09H
        int 21H      
   
    end:
        mov AX, 4C00h
        int 21h

    
main endp


