.model small
.stack 64
.data
 ;declare the variables from the memory map here
 byt db 0A4H
 word dw 84FBH
 dword dd 85BA45FDH
 bytArr db 05H,06H,07H    
 bytList db 08H,0AH,0BH,0CH
 wordArr dw 078AH,9453H, 321AH  
.code
 main proc near
 mov AX,@data
 mov DS,AX
 mov ES,AX

 ;Write your assembly code here
 mov AH, byt
 mov AL, bytArr 
 mov BX, word
 mov CX, wordArr
 mov DX, AX
                   
 mov byt, CH  
 mov bytArr,CL
 mov word, AX
 mov wordArr, BX
  
 mov AX,4C00H
 int 21H
 main endp