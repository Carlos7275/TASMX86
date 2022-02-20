.model small 
.stack 
.data 
;Probando el Commit 2
Horas db 0
Minutos db 0
Segundos db 0

Msg  db 10,13,7, "Horas:","$"
Msg2  db " Minutos:","$"
Msg3  db " Segundos:","$"

.code 
mov ax,seg @data 
mov ds,ax 
inicio:

mov ah,02h
mov bh,00
mov dh,01
mov bl,12
int 10h
 mov cx,0fh
mov dx, 4240h
mov ah, 86h
int  15h 


inc Segundos
cmp Segundos,60
je Min




mov ah,0006h
mov bh,04h
mov cx,00
mov dx,184Fh
int 10h

mov al,Horas 
aam 
Mov bx,ax 
mov ah,09h
lea dx,Msg
int 21h
mov ah,02h
mov dl,bh
add dl,30h
int 21h
mov ah,02h
mov dl,bl
add dl,30h
int 21h



mov al,Minutos
aam 
Mov bx,ax 
mov ah,09h
lea dx,Msg2
int 21h
mov ah,02h
mov dl,bh
add dl,30h
int 21h
mov ah,02h
mov dl,bl
add dl,30h
int 21h



mov al,Segundos
aam 
Mov bx,ax 
mov ah,09h
lea dx,msg3
int 21h
mov ah,02h
mov dl,bh
add dl,30h
int 21h
mov ah,02h
mov dl,bl
add dl,30h
int 21h

jmp inicio
.exit

Min:
mov segundos,0
inc Minutos

cmp Minutos,60
je Hora
jmp inicio
.exit 

Hora:
mov Minutos,0
inc Horas
jmp inicio
.exit


end 