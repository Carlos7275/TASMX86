ideal 
dosseg 
model small
stack 256
dataseg 
welcome db 13,10,"Bienvenido al Software Comparador de Peso",0
linea db 13,10,"----------------------------------------------------------",0
msg db 13,10,"Ingrese el Nombre:",0
msg2 db 13,10,"Ingrese el peso de ",0 
msg3 db ":",0
msg4 db 13,10," La persona con mayor peso fue ",0
msg5 db " Con un peso de ",0
msg6 db " Kilos",0
nombre db 81 dup(?)
nombre2 db 81 dup(?)
str_peso1 db 81 dup(?)
str_peso2 db 81 dup(?)
peso1 db ?
peso2 db ?

codeseg 
extrn aputs:proc,agets:proc,aatoi:proc,clrscr:proc
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax 

call clrscr

mov si,offset welcome
call aputs

mov si,offset linea 
call aputs

mov si,offset msg 
call aputs 

mov di,offset nombre
call agets 

mov si,offset msg2 
call aputs 

mov si,offset nombre
call aputs 

mov si,offset msg3
call aputs

mov di,offset str_peso1
call agets 
;---------------------------------
mov si,offset msg 
call aputs 

mov di,offset nombre2
call agets 

mov si,offset msg2 
call aputs 

mov si,offset nombre2
call aputs 

mov si,offset msg3
call aputs

mov di,offset str_peso2
call agets 

;------------------------
mov si,offset str_peso1
call aatoi
mov [peso1],al

mov si,offset str_peso2
call aatoi 
mov [peso2],al

cmp [peso1],al 
jae may
jb men



salir:
mov si,offset linea
call aputs 

mov ah,4ch
mov al,0h
int 21h


may:
mov si,offset msg4
call aputs 
mov si,offset nombre
call aputs
mov si,offset msg5
call aputs 
mov si,offset str_peso1
call aputs 
mov si,offset msg6
call aputs

jmp salir

men:
mov si,offset msg4
call aputs 
mov si,offset nombre2
call aputs
mov si,offset msg5
call aputs 
mov si,offset str_peso2
call aputs 
mov si,offset msg6
call aputs
jmp salir
end inicio