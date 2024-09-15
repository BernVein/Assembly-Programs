.model
.stack 64 
.data
     aVec dw 1,2,3,4,5,6,7,8,9,10
     bVec dw 4,5,6,7,8,10,11,12,13,3
     cVec dw 10 dup (0)

.code

main proc near
    mov AX, @data
    mov DS,AX
    mov ES,AX
    
    mov CX,20
    
    lea SI,aVec
    lea DI,bVec
    lea BX,cVec
    
    start:
        mov AL,[SI] ; AL = Content of [SI]
        add AL,[DI] ; AL = AL + [DI]
        mov [BX],AL ; [BX] = AL
        
        inc SI
        inc DI
        inc BX
    loop start
    


mov AX,4C00H
int 21H

main endp