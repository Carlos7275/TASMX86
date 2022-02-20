
ideal 

dosseg 
model small
stack 256

dataseg 
welcome db 13,10,7,"Welcome to Mathematical Program",0
msj db 13,10,7,"Input a Number:",0
msj2 db 13,10,7,"Input Another Number:",0
msj3 db 13,10,7,"The adition is :",0
;String variables
strnum1 db 99 dup(?) 
strnum2 db 99 dup(?)
strtot db 99 dup(?)
;Dword variables
num1 dw ?
num2 dw ?

codeseg 
extrn aputs:proc,agets:proc,aatoi:proc,aitoa:proc,exit:proc
start:
mov ax,@data 
mov ds,ax 
mov ds,ax 
mov es,ax 

mov si,offset welcome
call aputs 

mov si,offset msj 
call aputs 

mov di,offset strnum1
call agets 

mov si,offset msj2 
call aputs 

mov di,offset strnum2 
call agets


mov si,offset strnum1
call aatoi
mov [num1],ax 

mov si,offset strnum2
call aatoi
mov [num2],ax

mov ax,[num1]
add ax,[num2]

mov di,offset strtot
call aitoa

mov si,offset msj3 
call aputs 

mov si,offset strtot
call aputs



salir:
call exit

end