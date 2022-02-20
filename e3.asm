ideal
dosseg
model small
stack 256
dataseg 
msj db 13,10,"Gastos del Mes",0
linea db 13,10,"-------------------------------------------------------------------",0
msj2 db 13,10,"Gasto Semana#1:$",0
msj3 db 13,10,"Gasto Semana#2:$",0
msj4 db 13,10,"Gasto Semana#3:$",0
msj5 db 13,10,"Gasto Semana#4:$",0
msj6 db 13,10,"El promedio de gastos semanales es $",0
msj7 db " y",0
msj8 db " No",0
msj9 db " Excede el presupuesto proyectado!!",0

str_gasto1 db 81 dup(?)
str_gasto2 db 81 dup(?)
str_gasto3 db 81 dup(?)
str_gasto4 db 81 dup(?)
str_prom db 81 dup(?)

gasto1 dw ?
gasto2 dw ?
gasto3 dw ?
gasto4 dw ?
prom dw ?

codeseg 
extrn aputs:proc,agets:proc,aatoi:proc,aitoa:proc
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax


mov si,offset msj ;Mensaje Gastos del mes 
call aputs

mov si,offset linea 
call aputs 

mov si,offset msj2 ;Mensaje Gasto#1
call aputs 

mov di,offset str_gasto1
call agets ;Pido el gasto1

mov si,offset msj3
call aputs  ;Mensaje Gasto#2

mov di,offset str_gasto2
call agets ;Pido gasto2

mov si,offset msj4
call aputs  ;Mensaje gasto#3

mov di,offset str_gasto3
call agets ;Pido gasto3 

mov si,offset msj5
call aputs  ;Mensaje gasto4

mov di,offset str_gasto4
call agets ;Pido gasto4

mov si,offset str_gasto1
call aatoi
mov [gasto1],ax ;Convierto de String a valor numerico y lo mando a gasto1

mov si,offset str_gasto2
call aatoi
mov [gasto2],ax ;Convierto de String a valor numerico y lo mando a gasto2

mov si,offset str_gasto3
call aatoi 
mov [gasto3],ax ;Convierto de String a valor numerico y lo mando a gasto3

mov si,offset str_gasto4
call aatoi
mov [gasto4],ax ;Convierto de String a valor numerico y lo mando a gasto4 

xor dx,dx ;Limpiamos dx

mov ax,[gasto1] 
add ax,[gasto2]
add ax,[gasto3]
add ax,[gasto4]
mov bx,4d
div bx
mov [prom],ax ;prom=(gasto1+gasto2+gasto3+gasto4)/4

mov si,offset msj6
call aputs  ;Muestro el mensaje de los promedios

mov bx,10d ;Muevo la base a convertir en bx
mov di,offset str_prom ;Fijamos str_prom para ahi almacenar el valor numero convertido a String
call aitoa ;Procedimiento que convierte un entero a String

mov si,offset str_prom 
call aputs ;Imprimimos el promedio convertido a string
mov si,offset msj7 ;"Y"
call aputs 

cmp [prom],5000d ;if(prom<5000) goto menor else goto salir
jb menor 

jmp salir

menor:
mov si,offset msj8
call aputs 
 
salir:
mov si,offset msj9
call aputs

mov si,offset linea
call aputs 


mov ah,4ch
mov al,0h 
int 21h

end inicio