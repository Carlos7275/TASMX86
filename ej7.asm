;*****************************************************************************************
;Estructuras en ASM X86 POR CARLOS SANDOVAL
;********************************************************************************************

  Persona struc ;Declaracion de Estructura
nom db 81 dup(?)
ed dw ?
Persona ends


ideal 
dosseg 
include "IO.inc"
model small
stack 256
dataseg 
public Persona
nombre db 81 dup(?)
edad dw ?
buffer db 81 dup(?)

Estructura Persona <> ;DEFINIMOS LA VARIABLE ESTRUCTURA
codeseg 

inicio:
INITIALIZE
DEFINE_PRINT_NUM
println "Ingrese su Nombre:"
scan nombre
println "Ingrese su edad:"
scan buffer 
aatoi buffer,edad
astrcat Estructura.nom,nombre ;Concatenamos el nombre ala Estructura
printf "Su nombre es:"
print Estructura.nom ;Imprimimos el nombre
println "" 
printf "Su edad es:"
mov ax,[edad]
mov [Estructura.ed],ax ;Movemos la edad ala Estructura

mov ax,[Estructura.ed] ;Imprimimos la edad
call Print_Num
Salir:
EXIT_PROGRAM


end inicio

