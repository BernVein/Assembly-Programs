.stack 64

.data
matrix db 13 dup('$')
transposed db 12 dup('$')
prompt db "Input:$"
matrixMsg db "Matrix:$"
transposedMsg db "Transposed Matrix:$"
newline db 13, 10, '$'
tab db "       $"

.code
main proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   

    lea DX, prompt
    mov AH, 9
    int 21h
    
    mov CX, 12
    lea SI, matrix  
    
readLoop:
    cld
    mov AH, 1
    int 21h
    stosb
    inc SI
    loop readLoop

    call TransposeMatrix
    
    lea DX, newline
    mov AH, 9
    int 21h

    lea DX, matrixMsg
    mov AH, 9
    int 21h
    
    lea DX, newline
    mov AH, 9
    int 21h

    lea SI, matrix
    mov CX, 3
    mov BX, 0 
    
printMatrix:
    mov DI, 4 
    lea DX,tab
    mov AH, 9
    int 21H
    printMatrixRow:
        mov DL, [SI+BX]
        mov AH, 2
        int 21h
        mov DL, ','
        int 21h
        inc BX
        dec DI
        jnz printMatrixRow
    
        lea DX, newline
        mov AH, 9
        int 21h
        loop printMatrix

    lea DX, transposedMsg
    mov AH, 9
    int 21h
    
    lea DX, newline
    mov AH, 9
    int 21h

    lea SI, transposed
    mov CX, 4
    mov BX, 0 
    
printTransposed:
    mov DI, 3 
    lea DX,tab
    mov AH, 9
    int 21H
    printTransposedRow:
        mov DL, [SI+BX]
        mov AH, 2
        int 21h
        mov DL, ','
        int 21h
        inc BX
        dec DI
        jnz printTransposedRow
    
        lea DX, newline
        mov AH, 9
        int 21h
        loop printTransposed

    lea DX, newline
    mov AH, 9
    int 21h

    mov AX, 4C00h
    int 21h

transposeMatrix proc near
    lea DI, transposed
    mov BX, 0
    transposeOuterLoop:
        mov CX, 3       
        mov SI, BX 
        transposeInnerLoop:
            mov AL, [matrix + SI]
            mov [DI], AL
            inc DI
            add SI, 4          
            loop transposeInnerLoop
    
        inc BX            
        cmp BX, 4
        jne transposeOuterLoop

    ret
transposeMatrix endp
end main
