ideal 
include "IO.inc"
dosseg 
model small
stack 256
dataseg 
msg db 13,10,7,"Bienvenido ala Facultad de Ingenieria UAS 2021",0
msg2 db 13,10,7,"--------------------------------------------------",0
msg3 db 13,10,7,"Ingrese su Nombre Completo:",13,10,7,0
msg4 db 13,10,7,"Ingrese el Num de Materias A cursar:",0
msg5 db 13,10,7,"Ingrese la Calificacion #",0
extramsg db ":",0
msg6 db " Y Su promedio es de ",0
msg7 db " Esta aprobado",0
msg8 db " Esta reprobado",0
msg9 db 13,10,7,"El alumno(a):",0
nombre db 81 dup(?)
strnum db 81 dup(?)
buffercal db 81 dup(?)
strprom db 81 dup(?)
strcont db 81 dup(?)
num dw ?
acum dw ?
cont dw 1
codeseg
extrn getDateTime:proc,aatoi:proc
inicio:
Initialize
clrscr
call getDateTime
print msg2
print msg 
print msg2
print msg3 
scan nombre
print msg4
scan strnum

mov si,offset strnum 
call aatoi
mov [num],ax
print msg2
;Ciclo
do:
aitoa strcont,cont
mov ax,[num]
cmp [cont],ax
ja imprimir

print msg5

print strcont
print extramsg
scan buffercal
mov si,offset buffercal
call aatoi
add [acum],ax
inc [cont]
jmp do


imprimir:
print msg2
divi acum,num,acum
print msg9
print nombre
print msg6
aitoa strprom,acum 
print strprom
cmp [acum],6
jge apro 
jmp repro
apro:
print msg7
jmp salir 

repro:
print msg8
jmp salir

salir:
EXIT_PROGRAM 
end inicio