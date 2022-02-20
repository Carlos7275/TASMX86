;*****************************************************************************************
;Estructuras en ASM X86 POR CARLOS SANDOVAL
;********************************************************************************************
;ESTRUCTURA NUMEROS

Numeros struc
Num dw ?
Num2 dw ?
opc db ?
Res dw ?
Numeros ends
ideal
model small
include "IO.inc"
stack 256h
dataseg 
public Numeros
buffer db 81  dup(?)
Nums Numeros<>
codeseg 

inicio: 
 INITIALIZE
 DEFINE_PRINT_NUM
 clrscr
 PrintDateTime
 println "<Bienvenida ala Calculadora Basica>"
 println "Ingrese un Numero:"
 scan buffer
 aatoi buffer,Nums.Num
 println "Ingrese otro Numero:"
 scan buffer
 aatoi buffer,Nums.Num2
 println "Elige una Opcion:"
 println"[+].-Suma"
 println"[-].-Resta."
 println"[*].-Multiplicacion."
 println"[/].-Division."
 scan Nums.opc

 cmp [Nums.opc],'+'
 je Sumar
 cmp [Nums.opc],'-'
 je Restar

 cmp [Nums.opc],'*'
 je Multiplicar

  cmp [Nums.opc],'/'
 je Division
 jne Indiferente

 Sumar:
  suma Nums.Num,Nums.Num2,Nums.Res
 jmp Resultado

 Restar:
  resta Nums.Num,Nums.Num2,Nums.Res
 jmp Resultado

 Multiplicar:
  Multi Nums.Num,Nums.Num2,Nums.Res
 jmp Resultado

 Division:
 cmp Nums.Num2,0
 je Cero
  divis Nums.Num,Nums.Num2,Nums.Res
 jmp Resultado

 Cero:
  println "¡No es Posible Dividir entre 0!"
  jmp Salir
 Indiferente:
  println "¡Opcion Invalida!"
  jmp Salir

  Resultado:
  
   printf "El Resultado de "
   mov ax,[Nums.Num]
   call PRINT_NUM
   write Nums.opc 
   mov ax,[Nums.Num2]
   call PRINT_NUM 
   printf "="
   mov ax,[Nums.Res]
   call PRINT_NUM


  jmp Salir
 Salir:
  EXIT_PROGRAM
end inicio