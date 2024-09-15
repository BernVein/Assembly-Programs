.model small
.stack 64
.data
    InitArray db 6,11,9,20,7,16,17,19,4,10,14,5,12,13,2,18,8,3,15,1
    FibInt dw 20 dup (0)
.code

main proc near
    mov AX,@data
    mov DS,AX
    mov ES,AX
    mov CH,20
    lea DI,FibInt
    lea SI,InitArray
    

INITIALIZATION:
    mov AX,1
    mov BX,1
    mov CL,1
    jmp FIBSEGMENT
    
    
FIBSEGMENT:
    cmp CL,[SI]
    je STOREFIB
    inc CL
    add AX,BX
    mov DX,AX
    mov AX,BX
    mov BX,DX
    jmp FIBSEGMENT  
    
STOREFIB:
    mov [DI],AX
    inc SI
    add DI,2
    dec CH
    cmp CH,0
    je STOP
    jne INITIALIZATION
    
    
STOP:    
   

    main endp