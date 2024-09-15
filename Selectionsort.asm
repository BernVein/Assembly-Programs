.model small

.stack 64

.data

array db 21,16,20,15,5,1,2,4,7,18,8,9,12,14,6,'$'


.code

main proc near
    
mov AX, @data
mov DS,AX
mov ES,AX

lea SI, array
mov BL, 00H

call getMin

   
    
    
    
endp main

getMin proc near
     
     
     
     
     mov DL, SI 
     mov AH, 0
     mov BH, 0
     mov DH, BL
     
     
     limLoop:
     inc AH
     cmp [SI+BH],'$'
     je minLoop
     inc BH
     jmp limLoop
     
     
     
     
     
     
     minLoop:
     cmp DL,[SI+DH]
     inc DH
     jg minStorage
     cmp AH,00H
     jne minLoop
     je stop
     
     
     
     
     
     minStorage:
     mov DL,[SI+DH]
     cmp AH,00H
     jne minLoop
     je stop
     
     
     
     
     stop:
     ret
        


    
    
    
    
endp getMin
            
selectionSort proc near
    
