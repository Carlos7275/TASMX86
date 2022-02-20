ideal 
dosseg 
model small
stack 256
dataseg 
msg db 13,10,"Ingrese el Nombre: ",0
msg2 db 13,10,"Ingrese la edad de ",0
msg3 db ":",0
msg4 db " Es Mayor que:",0

nombre db 81 dup(?)
str_edad db 81 dup(?)
nombre2 db 81 dup(?)
str_edad2 db 81 dup(?)
edad db ?
edad2 db ?
codeseg 
extrn aputs:proc,agets:proc,aatoi:proc ;
inicio:
mov ax,@data
mov ds,ax
mov es,ax ;Inicializa el segmento extra de datos. 

mov si,offset msg  ;cout<<"Ingrese el nombre";
call aputs 

mov di,offset nombre
call agets  ;Cin>>nombre

mov si,offset msg2 ;cout<<"Ingrese la edad de"<<nombre<<":"; 26-33
call aputs 

mov si,offset nombre 
call aputs 

mov si,offset msg3
call aputs 

mov di,offset str_edad 
call agets ;cin>>edad;


mov si,offset msg  ;cout<<"Ingrese el nombre";
call aputs 

mov di,offset nombre2
call agets  ;Cin>>nombre

mov si,offset msg2 ;cout<<"Ingrese la edad de"<<nombre<<":"; 26-33
call aputs 

mov si,offset nombre2
call aputs 

mov si,offset msg3
call aputs 

mov di,offset str_edad2
call agets ;cin>>edad


mov si,offset str_edad 
call aatoi 
mov [edad],al

mov si,offset str_edad2
call aatoi 
mov [edad2],al 

mov bl,[edad2]

cmp [edad],bl 
ja may 
jb men 



salir:
mov ah,4ch
mov al,0h 
int 21h

may:
mov si,offset nombre 
call aputs 
mov si,offset msg4 
call aputs 

mov si,offset nombre2
call aputs 


jmp salir 

men:
mov si,offset nombre2 
call aputs 
mov si,offset msg4 
call aputs 

mov si,offset nombre
call aputs 
jmp salir
end inicio