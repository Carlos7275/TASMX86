;Calcular Fibonacci en ASMX86
ideal 
dosseg 
model small
stack 256
include "IO.inc" ;Librerias Desarrollada Por Mi INPUT/OUTPUT

dataseg 
;Declaracion de variables 
buffer db 81 dup(?)
fib dw ?
max dw ? 
codeseg 
inicio:
DEFINE_PRINT_NUM
INITIALIZE ;Inicializa todos los segmentos de datos , y los   registros en 0
clrscr 
println "Bienvenido ala Calculadora de Sucesion de Fibonacci"
println "----------------------------------------------------"
println "Ingrese el Numero Max a Calcular Fibonacci:"
scan buffer 
aatoi buffer,max 

printf "La serie fibonacci del numero:"
print buffer
println ""
println "-----------------------------------------------------"
call getFibonacci
salir:
EXIT_PROGRAM ;Return 0;

proc getFibonacci
xor bx,bx
xor dx,dx 
mov cx,[max]
mov dx,1
ciclo:
jcxz @@salir
add bx,dx
xchg bx,dx 
mov [fib],bx 
mov ax,[fib]
call PRINT_NUM
cmp cx,1
jne imprimir
aqui:
loop ciclo
@@salir:
ret
imprimir:
write ","
jmp aqui

endp getFibonacci
end inicio