.model small

.stack 64

.data
;Mat 1 2 row 3 col
;MAT1 LABEL BYTE
    ;MAX_LEN1 DB 7
    ;ACT_LEN1 DB ?
    ;KB_DATA1 DB 7 DUP('$'), '$' 
;Mat 2 3 rows 2 col
;MAT2 LABEL BYTE
    ;MAX_LEN2 DB 7
    ;ACT_LEN2 DB ?
    ;KB_DATA2 DB 7 DUP('$'), '$'
;1d Array but access as 2d
KB_DATA1 DB 1,2,3,4,5,6
;1d Array but access as 2d
KB_DATA2 DB 7,8,9,10,11,12
msg1 db "Insert Mat1 elements here:$"
msg2 db "Insert Mat2 elements here:$"
mat3 db 5 dup('$')
Mat1RowTrack dw 0
Mat2ColTrack dw 0
outLoopCtr db 0
inLoopCtr db 0
resMatCtr db 0 

nw db 13, 10, '$'

.code

proc main near
    
    mov AX, @data
    mov DS,AX
    mov ES,AX
    
    ;lea DX,msg1
    ;mov AH, 09h
    ;int 21h

    ;mov AH, 0AH
    ;lea DX,MAT1
    ;INT 21H
   
    ;lea SI,KB_DATA1
    ;call MatConvSub30
    
    
           
    ;call newLine
           
    ;lea DX,msg2
    ;mov AH, 09h
    ;int 21h
    

    ;mov AH, 0AH
    ;lea DX,MAT2
    ;INT 21H
    
    ;lea SI,KB_DATA2
    ;call MatConvSub30
    
    xor CX,CX
    mov CX,4
    
    L1:
    mov BX,Mat1RowTrack
    lea SI,KB_DATA1+BX
    xor BX,BX
    
    mov BX,Mat2ColTrack
    lea DI,KB_DATA2+BX
    xor BX,BX
    
    xor DX,DX
    xor AX,AX
    mov outLoopCtr,CL
    mov inLoopCtr,0
    L2:
    mov AL,[SI]
    mov BL,[DI]
    mov CX,DX
    mul BX
    add DX,CX
    add DX,AX
    xor CX,CX
    inc SI
    inc DI
    inc DI
    mov CL,inLoopCtr
    inc inLoopCtr
    cmp CX,02
    jne L2
    
    xor BX,BX
    mov BL,resMatCtr
    lea SI,mat3+BX
    mov [SI],DX
    inc resMatCtr
    
    mov AX,Mat2ColTrack
    cmp AX,01
    je incRow
    jne incCol
    
    incRow:
    inc Mat1RowTrack
    inc Mat1RowTrack
    inc Mat1RowTrack
    mov Mat2ColTrack, 0
    xor CX,CX
    dec outLoopCtr
    mov CL,outLoopCtr
    cmp CX,0
    je END
    jne L1
    
    incCol:
    inc Mat2ColTrack
    xor CX,CX
    dec outLoopCtr
    mov CL,outLoopCtr
    cmp CX,0
    je END
    jne L1
    
    
    
    
    
    
    
    
    
    
    
    
    
    END:
    mov AX,4C00H
    int 21H
    
    




endp main


proc newLine near
    lea DX, nw
    mov AH, 09h
    int 21h
    ret
endp newLine

proc MatConvSub30 near
     mov CX,6
     
     ConvLoop:
        mov AX,[SI]
        sub AX,30H
        mov [SI],AL
        inc SI
        loop ConvLoop
     ret
   
    