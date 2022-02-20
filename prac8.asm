ideal
dosseg
model small
stack 256

dataseg
codsal db 0
msj1 db 'Este programa compara dos cadenas'
db 13, 10, 0
msj2 db 'Dame la cadena 1: ', 0
msj3 db 'Dame la cadena 2: ', 0
msj4 db ' > ', 0
msj5 db ' < ', 0
msj6 db ' == ', 0
msj7 db 13, 10, 0
cad1 db 81 dup(?)
cad2 db 81 dup(?)
resp db 81 dup(?)

codeseg
extrn astrcat:proc, astrcmp: proc
extrn aputs:proc, agets:proc

inicio:
mov ax, @data 
mov ds, ax 
mov es, ax 
mov si, offset msj1 
call aputs 

mov si, offset msj2 
call aputs
 
mov di, offset cad1 
call agets

mov si, offset msj3 
call aputs 

mov di, offset cad2 
call agets

mov si, offset cad1 
mov di, offset cad2
call astrcmp

mov [byte resp], 0 
mov di, offset resp 
mov si, offset cad1
call astrcat

mov si, offset msj4 
cmp ax, 0 
jg sigue 
mov si, offset msj5 
jl sigue 

mov si, offset msj6 
sigue: call astrcat 
mov si, offset cad2 
call astrcat

mov si, offset msj7 
call astrcat
mov si, di 
call aputs
salir:
mov ah, 04Ch
mov al, [codsal]
int 21h

end inicio