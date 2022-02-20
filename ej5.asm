ideal 
dosseg 
include "IO.inc"

model small
stack 256 

dataseg 
msg db "CARLOS",0
msg2 db "CARLOS2",0
buffer db 81 dup(?)
num dw ?
num2 dw ?
res dw ?
codeseg
  
inicio: 
Initialize
DEFINE_PRINT_NUM


clrscr 

gotoxy 1,5
 PrintDateTime
 
println ""
println "Bienvenido al Programa "
println "----------------------------------------------"
println "Ingrese un Numero:"
scan buffer
aatoi buffer,num 
println "Ingrese otro numero:"
scan buffer 
aatoi buffer,num2
println "Operaciones"
println "-----------------------------------------------------"
suma num,num2,res 
mov ax,[num]
call Print_num

printf "+"

mov ax,[num2]
call Print_num

printf "="

mov ax,[res]
call Print_num

println ""
resta num,num2,res 
mov ax,[num]
call Print_num

printf "-"

mov ax,[num2]
call Print_num

printf "="

mov ax,[res]
call Print_num


println ""
multi num,num2,res 
mov ax,[num]
call Print_num

printf "*"

mov ax,[num2]
call Print_num

printf "="

mov ax,[res]
call Print_num

cmp [num2],0
jne caso
println ""
println "No es posible dividir entre 0"
jmp salir

caso:
println ""
divis num,num2,res 
mov ax,[num]
call Print_num

printf "/"

mov ax,[num2]
call Print_num

printf "="

mov ax,[res]
call Print_num

jmp salir

salir:
EXIT_PROGRAM

end inicio