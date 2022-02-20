ideal 
dosseg 
model small
include "IO.inc"
stack 256
dataseg 
base dw ?
altura dw ?
buffer db 81 dup(?)
cont dw ?
cont2 dw ?
codeseg 
inicio:
INITIALIZE
println("Ingrese la base:")
scan buffer
aatoi buffer,base 
println("Ingrese la Altura:")
scan buffer
aatoi buffer,altura
do:
mov ax,[cont]
cmp ax,[base]
je salir

mov bx,[cont2]
cmp bx,[altura]
je do
jne do2
aqui:
inc [cont]
println("")
jmp do



do2:
mov bx,[cont2]
cmp bx,[altura]
je do
printf "*"
inc [cont2]
jmp aqui

salir:
EXIT_PROGRAM
end inicio