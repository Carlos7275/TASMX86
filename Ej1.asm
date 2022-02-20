proc ordena
push ax
cmp ax,[lado2]
ja @@mayor 
cmp bx,[lado3]
ja @@mayor2
mov al,'N'
ret 

@@mayor: 
mov dx,ax 
mov ax,[lado2]
mov bx,dx 
cmp bx,[lado3]
ja @@mayor2

@@mayor2:
mov dx,bx
mov bx,[lado3]
mov cx,dx 
cmp ax,bx 
ja @@final

@@final:
xor dx,dx 
mov dx,ax 
mv ax,bx 
mov bx,dx 

ret
endp ordena