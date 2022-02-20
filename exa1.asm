ideal 
model small 
stack
dataseg  
msg db 13,10,"Materia 1:",0
msg2 db 13,10,"Materia 2:",0
msg3 db 13,10,"Materia 3:",0
msg4 db 13,10,"El Promedio ",0
msg5 db " Esta aprobado",0
msg6 db " Esta reprobado",0

str_cal1 db 81 dup(?)
str_cal2 db 81 dup(?)
str_cal3 db 81 dup(?)
str_prom db 81 dup(?)
cal1 dw 0
cal2 dw 0
cal3 dw 0
prom dw 0
codeseg 
extrn aputs:proc,agets:proc,aatoi:proc,aitoa:proc
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax

mov si,offset msg 
call aputs 

mov di,offset str_cal1
call agets 

mov si,offset msg2 
call aputs 

mov di,offset str_cal2
call agets 

mov si,offset msg3 
call aputs 

mov di,offset str_cal3
call agets 


mov si,offset str_cal1
call aatoi
mov [cal1],ax 

mov si,offset str_cal2
call aatoi
mov [cal2],ax

mov si,offset str_cal3
call aatoi
mov [cal3],ax 

xor dx,dx 
mov ax,[cal1]
add ax,[cal2]
add ax,[cal3]

mov bx,3d 

div bx 

mov [prom],ax



mov si,offset msg4
call aputs 

mov di,offset str_prom
call aitoa

mov si,offset str_prom
call aputs

cmp [prom],8
jae apro 
jb repro



salir:
mov ah,4ch 
mov al,0h
int 21h
apro:

mov si,offset msg5
call aputs 
jmp salir

repro:

mov si,offset msg6
call aputs 

jmp salir


end inicio