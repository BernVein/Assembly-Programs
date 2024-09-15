.stack 64

.data

text db "The quick brown fox jumps over the lazy dog$"
prompt1 db " does not contain $"
prompt2 db " does contain $" 
line db 13,10,'$' 
char db 'A'
.code
MAIN proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   
     
    lea DX,text
    mov AH,9
    int 21H
    
    call COUNTER
    call CHARCHECK
    
    mov AX,4C00H
    int 21H 
MAIN endp

NEWLINE proc near
    lea DX,line
    mov AH,9
    int 21H
    ret
NEWLINE endp

COUNTER proc near
    lea SI,text
    xor CX,CX
    xor AX,AX
    cld
    l1: 
        cmp AL,'$'
        je exit
        lodsb
        inc CX
        jmp l1
    exit:
        dec CX
        ret    
        
COUNTER endp  

CHARCHECK proc near
    mov AL,char 
    lea DI,text
    repne scasb 
    jz HASCHAR
    jmp NOCHAR
    
    HASCHAR:
        lea DX,prompt2
        mov AH,9
        int 21H
        
        mov DL,char
        mov AH,2
        int 21H
        ret
    NOCHAR:
        lea DX,prompt1
        mov AH,9
        int 21H
        
        mov DL,char
        mov AH,2
        int 21H
        ret   
    
CHARCHECK endp