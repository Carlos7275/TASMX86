ideal 
dosseg 
model small
stack 256 
dataseg 
msg db "Ingrese su Nombre: $"
msg2 db 13,10,7,"Su nombre es: $"
nombre db 81 dup(?),"$"

codeseg 
extrn agets:proc
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax 
mov ah,09h 
lea dx,[msg]
int 21h

mov di,offset nombre 
call agets 

mov ah,09h 
lea dx,[msg2]
int 21h

mov ah,09h 
lea dx,[nombre]
int 21h

salir:
mov ah,4ch
mov al,0h 
int 21h
end inicio