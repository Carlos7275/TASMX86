ideal 
dosseg
model small
stack 256
dataseg 
;Mensajes
central db 13,10,"Bienvenido ala Calculadora (Decimal,Hexadecimal,Binario) ASM",0
linea db 13,10,"-------------------------------------------------------------------",0
msg db 13,10,"Ingrese la Expresion a Calcular:",0
msg2 db 13,10,"El resultado es:",0
msg3 db 13,10,"Error Matematico !",0
;Variables
soper db 81 dup (?)
op1 db 81 dup(?)
op2 db 81 dup(?)
sresul db 81 dup (?)
operacion db ?
codeseg 
extrn aatoi:proc,aputs:proc,agets:proc,astrcat,clrscr:proc,split:proc,long:proc,operaciones:proc,final:proc
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax


call clrscr ;Limpia en Pantalla y Cambia letras a color verde
;Muestro mensajes
;-----------------------------------------------------------------------------------------
mov si,offset central
call aputs

mov si,offset linea
call aputs

mov si,offset msg 
call aputs
;-----------------------------------------------------------------------------------------
;Pido por teclado soper
mov di,offset soper
call agets
;Obtenemos la longitud de la cadena soper
mov si,offset soper
call long

mov di,offset op1 
mov ax,offset op2
mov bx,offset operacion

call split
;Separo las Cadenas

;Convierto a valor numero op2 y op1 
mov si,offset op2
call aatoi 
push ax 

cmp [operacion],'/'
je divi
result:
mov si,offset op1 
call aatoi 
pop dx


mov bl,[operacion]

call operaciones
;Realizamos la operacion deseada


  mov di, offset sresul
  call final
  ;Generamos la cadena final de resultado
;Imprimimos mensajes 
  mov si,offset msg2 
  call aputs

  mov si,offset sresul
  call aputs

  mov si,offset linea
call aputs


salir:
mov ah,4ch
mov al,0h 
int 21h

divi: ;Caso de Division
cmp ax,0
je alerta
jmp result
alerta: ;Siempre y cuando el denominador de una division valga 0
mov si,offset msg3
call aputs
jmp salir
end inicio