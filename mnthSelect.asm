.stack 64

.data
months db "January..$"
       db "February.$"
       db "March....$"
       db "April....$"
       db "May......$"
       db "June.....$"
       db "July.....$"
       db "August...$"
       db "September$"
       db "October..$"
       db "November.$"
       db "December.$"
prompt1 db "Select a month (1-12): $"
prompt2 db "Month you've chosen: $" 
prompt3 db "Choose only from 1-12!$"
line db 10,13,'$'

chosen label db
    MAX_LEN db 3
    ACT_LEN db ?
    KB_DATA db 2 dup ('$')
monthChosen db ?
.code
MAIN proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   
    
    lea DX,prompt1
    mov AH,9
    int 21H
    
    lea DX,chosen
    mov AH,0AH
    int 21H
    
    call STRING_TO_INT
    call PRINTSELECTEDMONTH
    
    mov AX,4C00H
    int 21H 
MAIN endp

STRING_TO_INT proc near
    lea SI,KB_DATA
    mov BL,[SI+1]
    cmp BL,13 ;Check if CRET
    je IfCRET
    mov AL,[SI]
    sub BL,'0'
    sub AL,'0' 
    mov BH,10
    mul BH
    add AL,BL
    mov monthChosen,AL
    xor AX,AX
    xor BX,BX
    ret
     
    IfCRET:
        mov AL,[SI]
        sub AL,'0'
        mov monthChosen,AL
        ret       
    
    ret
STRING_TO_INT endp
                            
PRINTSELECTEDMONTH proc near    
    sub monthChosen,1
    mov AL,monthChosen
    cmp AL,12
    jg IfError
    mov BL,10
    mul BL
    lea BX,months
    ;xlat
    add BX,AX
    call NEWLINE
    lea DX,prompt2
    mov AH,9
    int 21H
    mov DX,BX
    mov AH,9
    int 21H
    ret
    
    IfError:
        call NEWLINE
        lea DX,prompt3
        mov AH,9
        int 21H
        ret
  
PRINTSELECTEDMONTH endp

NEWLINE proc near
   lea DX,line
   mov AH,9
   int 21H
   xor DX,DX
   xor AX,AX
   ret
NEWLINE endp