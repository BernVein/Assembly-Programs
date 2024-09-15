.stack 64

.data
matrixA db 1,2,0
        db 0,2,0
        db 4,0,2 
        
matrixB db 9,0,0
        db 1,2,9
        db 0,9,0
matSize1 db 3 
matSize2 db 3
matrixRes db 9 dup('$') 
.code
MAIN proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   
    call MULTIPLYMATRIX
    
    mov AX,4C00H
    int 21H 
MAIN endp

MULTIPLYMATRIX proc near
    xor AX,AX  
    xor CX,CX 
    lea DI,matrixB 
    lea SI,matrixA
    lea BX,matrixRes
    cld
    OuterOuterLoop:
        mov AL,3
        mov matSize1,AL
        OuterLoop: 
            mov CX,3
                InnerLoop:
                    mov AL,[SI]
                    mov DL,[DI]
                    mul DL 
                    inc SI
                    add DI,3
                    add DH,AL
                    loop InnerLoop
                mov [BX],DH
                inc BX
                mov DH,0
                sub SI,3
                sub DI,9 
                inc DI
                dec matSize1
                cmp matSize1,0
             jne OuterLoop
         add SI,3
         lea DI,matrixB
         dec matSize2
         cmp matSize2,0
         jne OuterOuterLoop
    ret 
MULTIPLYMATRIX endp 
                            
