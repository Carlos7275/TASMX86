;vector
ideal 
dosseg
include "IO.inc" 
model small
stack 256
dataseg 
array db 10 dup(?)
buffer db 81 dup(?)
num dw ?
x db ?
codeseg 
inicio:
Initialize 
DEFINE_PRINT_NUM
clrscr

do:
cmp [x],3
mov si,[word x]
jb pedir
jmp mostrar
aqui:
mov al,[byte num]
mov [array+si],al  
inc [x]
jmp do


pedir:
println "Ingrese el valor al vector:"
scan buffer 
aatoi buffer,num
jmp aqui


mostrar:
mov [x],0
xor si,si


println "El contenido del vector es:"
do2:
cmp [x],3
je salir
mov si,[word x] 
mov al,[array+si]
call print_Num
inc [x]
jmp do2
salir:
EXIT_PROGRAM

end inicio 