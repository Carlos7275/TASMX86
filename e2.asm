ideal 
model small 
stack
dataseg  
bienvenida db 13,10,"Software para calcular promedios y saber si esta reprobado o aprobado!",0
linea db 13,10,"----------------------------------------------------------------------------",0
msj db 13,10,"Materia 1:",0
msj2 db 13,10,"Materia 2:",0
msj3 db 13,10,"Materia 3:",0
msj4 db 13,10,"El Promedio ",0
msj5 db " Esta aprobado",0
msj6 db " Esta reprobado",0

;Variables 

cal1 dw ?
cal2 dw ?
cal3 dw ?
prom dw ?
;STRINGS
str_cal1 db 81 dup(?)
str_cal2 db 81 dup(?)
str_cal3 db 81 dup(?)
str_prom db 81 dup(?)

codeseg 
extrn aputs:proc,agets:proc,aatoi:proc,aitoa:proc,astrcat:proc
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax

mov si,offset bienvenida
call aputs  ;Mensaje de bienvenida

mov si,offset linea
call aputs  ;Diseño

mov si,offset msj 
call aputs  ;Mensaje Materia#1

mov di,offset str_cal1
call agets ;Pido cal1

mov si,offset msj2 
call aputs ;Mensaje Materia#2

mov di,offset str_cal2
call agets ;pido cal2 

mov si,offset msj3 ;Mensaje Materia#3
call aputs 

mov di,offset str_cal3
call agets ;pido cal3


mov si,offset str_cal1
call aatoi
mov [cal1],ax  ;Convertimos el valor string a numerico y lo almacenamos en cal1

mov si,offset str_cal2
call aatoi
mov [cal2],ax;Convertimos el valor string a numerico y lo almacenamos en cal2

mov si,offset str_cal3
call aatoi
mov [cal3],ax ;Convertimos el valor string a numerico y lo almacenamos en cal3

xor dx,dx ;Limpiamos dx 
mov ax,[cal1] 
add ax,[cal2]
add ax,[cal3]
mov bx,3d 
div bx 
mov [prom],ax ;prom=(cal1+cal2+cal3)/3



mov si,offset msj4
call aputs ;Mostramos el mensaje el promedio es 

mov di,offset str_prom 
call aitoa ;Convertimos el valor numerico a string y lo guardamos en str_prom
mov si,offset str_prom ;Mostramos el promedio 
call aputs 

cmp [prom],8 ;if(prom>=8) goto apro else goto repro
jae apro 
jb repro



salir:
mov si,offset linea
call aputs 
mov ah,4ch 
mov al,0h
int 21h


apro:
mov si,offset msj5
call aputs ;Mensaje esta aprobado
jmp salir

repro:

mov si,offset msj6 ;Mensaje esta reprobado
call aputs 

jmp salir


end inicio