.stack 64

.data
    newline1 db 13, 10, '$'
    tab db "         $"
    prompt1 db "Matrix A:$"
    prompt2 db "Matrix B:$"
    prompt3 db "Matrix A + Matrix B:$"
    note db "NOTE: GANA NI ANG MATRIX ADD BASTA ANG RES IS <256 OR 00FFH",13,10, "PERO ANG PRINTING IS MOGANA RA IF ANG RES SA ADDITION IS <10",13,10, "FUCK YOU KAPOY CONVERT CONVERT UG 4BYTES$"
    matA db 0,1,3
         db 1,2,3
         db 3,2,2
    matB db 1,4,2
         db 4,2,3
         db 5,1,0
    matRes db 9 dup('$')
    matAConverted db 9 dup('$')
    matBConverted db 9 dup('$')
.code
MAIN proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   
    
    lea DX, note
    mov AH,9
    int 21H
    call NEWLINE
    
    call ADDMATRIX 
    
    lea DI,matAConverted
    lea SI,matA
    call INT_TO_STRING
    
    lea DI,matBConverted
    lea SI,matB       
    call INT_TO_STRING
    
    lea SI,matAConverted
    lea DX,prompt1
    call PRINTMATRIX 
    
    lea SI,matBConverted
    lea DX,prompt2
    call PRINTMATRIX   
    
    lea SI,matRes
    lea DX,prompt3
    call PRINTMATRIX
    
    mov AX,4C00H
    int 21H

MAIN endp

ADDMATRIX proc near
    xor CX,CX
    lea SI,matA
    lea DI,matB
    lea BX,matRes
    mov CX,9
    addLoop:
        lodsb
        mov AH,[DI]
        add AL,AH
        inc DI
        add AL,'0'
        mov [BX],AL
        inc BX
        loop addLoop
    ret
    
ADDMATRIX endp   


INT_TO_STRING proc near 
    ;Setup: i move ang address sa SI ang i convert na table
    ;i move ang address sa new table sa DI para adto ibutang ang converted shit
    xor AX,AX
    mov BH,10
    mov CX,10
    cld
    l1:
        lodsb
        add AL,'0'
        stosb
        loop l1
        
    ret
INT_TO_STRING endp   

PRINTMATRIX proc near
    ;Setup: print prompt, dapat i move sa ang address
    ;sa prmompt sa DX before i call 
    mov AH,9
    int 21H
    mov BX,3
    call NEWLINE
    ;Setup: i butang sa SI ang address sa matrix na iprint
    loop1:
        mov CX,3
        call TABPRINT
        l2:
            mov DL,[SI]
            mov AH,2
            int 21H
            inc SI
            mov DL,','
            int 21H
            loop l2
        call NEWLINE
        dec BX
        cmp BX,0
        jne loop1    
    ret
PRINTMATRIX endp   

NEWLINE proc near
    lea DX, newline1
    mov AH, 9
    int 21h
    
    ret
NEWLINE endp

TABPRINT proc near
    lea DX,tab
    mov AH,9
    int 21H
    ret
TABPRINT endp