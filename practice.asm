.stack 64
.data

.code
main proc near
    mov AX, @data
    mov DS, AX
    mov ES, AX   


main endp
end main
