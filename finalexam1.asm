.stack 64
.data
matrix db 12 dup(?)
transposed db 12 dup(?)
prompt db 'Enter 12 characters: $'
inputMsg db 'Input: $'
matrixMsg db 'Matrix:$'
transposedMsg db 'Transposed Matrix:$'
newline db 13, 10, '$'

.code
main proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   

    mov dx, offset prompt
    mov ah, 9
    int 21h
    
    mov cx, 12
    mov si, offset matrix
readloop:
    mov ah, 1
    int 21h
    mov [si], al
    inc si
    loop readloop

    call transposematrix
    
    mov dx, offset newline
    mov ah, 9
    int 21h
    
    mov dx, offset inputMsg
    mov ah, 9
    int 21h

    mov si, offset matrix
    mov cx, 12
printinput:
    mov dl, [si]
    mov ah, 2
    int 21h
    inc si
    loop printinput

    mov dx, offset newline
    mov ah, 9
    int 21h

    mov dx, offset matrixMsg
    mov ah, 9
    int 21h
    
    mov dx, offset newline
    mov ah, 9
    int 21h

    mov si, offset matrix
    mov cx, 3
    mov bx, 0
printmatrix:
    mov di, 4
printmatrixrow:
    mov dl, [si + bx]
    mov ah, 2
    int 21h
    mov dl, ','
    int 21h
    inc bx
    dec di
    jnz printmatrixrow

    mov dx, offset newline
    mov ah, 9
    int 21h
    loop printmatrix

    mov dx, offset transposedMsg
    mov ah, 9
    int 21h
    
    mov dx, offset newline
    mov ah, 9
    int 21h

    mov si, offset transposed
    mov cx, 4
    mov bx, 0
printtransposed:
    mov di, 3
printtransposedrow:
    mov dl, [si + bx]
    mov ah, 2
    int 21h
    mov dl, ','
    int 21h
    inc bx
    dec di
    jnz printtransposedrow

    mov dx, offset newline
    mov ah, 9
    int 21h
    loop printtransposed

    mov dx, offset newline
    mov ah, 9
    int 21h

    mov ah, 4Ch
    int 21h

transposematrix proc near
    mov di, offset transposed
    mov bx, 0

transposeouterloop:
    mov cx, 3       
    mov si, bx
transposeinnerloop:
    mov al, [matrix + si]
    mov [di], al
    inc di
    add si, 4          
    loop transposeinnerloop

    inc bx            
    cmp bx, 4
    jne transposeouterloop

    ret
transposematrix endp

end main
