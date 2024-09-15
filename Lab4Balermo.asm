.model small
.stack 64
.data
numbers db 11, 22, 33, 44, 55, 66, 77, 88, 99, 10, 20, 30, 40, 50, 60, '#'
.code
start proc near
    mov AX, @data
    mov DS,AX
    mov ES,AX
    mov SI, 00H
    mov BX, 00H
    call selectionSort
    int 20H   
endp start

getMin proc near
     mov BL ,numbers+SI
     setOp: 
     mov AX, 00H
     mov DX, SI
     mov SI,00H
     limLoop:
     inc AX
     cmp [numbers+SI],'#'
     je setup
     inc SI
     jmp limLoop
     setup:
     mov SI,DX
     dec AX
     jmp minLoop
     minLoop:
     cmp BL,numbers+SI
     jg minStorage
     inc SI
     cmp SI,AX
     jne minLoop
     jle stop
     minStorage:
     mov BL,numbers+SI
     mov DI,SI
     inc SI
     cmp SI,AX
     jne minLoop
     je stop
     stop:
     mov SI,DX
     ret
endp getMin

selectionSort proc near
     setOpSort: 
     mov BH, 00H
     mov DX, SI
     limLoopSort:
     inc BH
     cmp numbers+SI,'#'
     je setupSort
     inc SI
     jmp limLoopSort
     setupSort:
     mov SI,DX
     dec BH
     jmp sort
     sort:
     cmp BH,00H
     mov CL,00H
     mov CH,00H
     je stopSort
     call getMin
     mov CL, numbers+SI
     mov CH, numbers+DI
     mov numbers+SI,CH
     mov numbers+DI,CL
     inc SI
     dec BH
     jmp sort
     stopSort:
     ret
endp selectionSort
