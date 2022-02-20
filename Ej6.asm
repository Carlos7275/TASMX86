ideal 
dosseg
include "IO.inc" 
model small
stack 256
dataseg 
buffer db 81 dup(?)
GCenti dw ?
res dw ?
codeseg 
inicio:
Initialize 
DEFINE_PRINT_NUM
clrscr

println "Ingrese Los grados Centigrados:"
scan buffer 
aatoi buffer,Gcenti
call Calculate

println ""
printf "Grado Celsius:"
print buffer 
printf "= Grado Fahrenheit:"
mov ax,[res]
call Print_NUM


salir:
EXIT_PROGRAM

proc Calculate
mov ax,[Gcenti]
mov bx,9 
imul bx; AX*BX

mov bx,5 
idiv bx ;AX/BX  
add ax,32
mov [res],ax

RET
endp Calculate
end inicio 