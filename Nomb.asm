ideal 
dosseg 
model small
stack 256h
dataseg 
msg db 13,10,"Cual es Su nombre? $",0
msg2 db 13,10,"Su nombre es: $",0
nombre db 81 dup(?),"$"
codeseg 
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax 

mov ah,09h 
lea dx,[msg]
int 21h 

mov di,offset nombre 
call scanf 

mov ah,09h 
lea dx,[msg2]
int 21h

mov ah,09h 
lea dx,[nombre]
int 21h
salir:
mov ah,4ch
mov al,0 
int 21h

proc scanf
push di
push ax
push bx
mov bh,0
cld
@@hacer:
mov ah,10h 
int 16h

mov ah,0Eh
int 10h 

cmp al,13
je @@fin 
cmp al,8
je @@borrar
stosb
jmp @@hacer

@@borrar:
dec di
jmp @@hacer
@@fin:

mov [byte di],0

 	mov al, 10
    mov ah, 0Eh
    int 10h

   pop di
   pop ax
   pop bx
ret
endp scanf
end inicio