ideal
model small 

dataseg 
codeseg 
extrn num1:word,num2,num3:word
public suma

proc suma 
mov ax,[num1]
add ax,[num2]
mov [num3],ax
ret
endp suma

end