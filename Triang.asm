;**********************************************************
; TRIANGU2.ASM
;
; Este programa determina sí tres líneas de longitudes:
; lado1 <= lado2 <= lado3, forman un triángulo y su tipo:
; equilátero, isósceles o escaleno. Los lados están en
; variables de tipo palabra no signadas. El programa guarda
; en la variable resul el carácter:
;
; 'N' Si las líneas no forman un triángulo
; 'E' Si forman un triángulo equilátero
; 'I' Si forman un triángulo isósceles
; 'S' Si forman un triángulo escaleno
; El programa utiliza un procedimiento para determinar sí
; las líneas forman un triángulo y su tipo. El pseudocódigo
; para este programa es este programa es:
;
; tipo = triang(lado1, lado2, lado3)
;
; El pseudocódigo del procedimiento triang es:
;
; char triang(lado1, lado2, lado3)
; {
; if(lado1+lado2 > lado3) goto equi
; return 'N'
;
; equi: if(lado1 != lado3) goto iso1
; return 'E'
; iso1: if(lado1 != lado2) goto iso2
; return 'I'
; iso2: if(lado2 != lado3) goto esca
; return 'I'
; esca: return 'S'
; }
;**********************************************************
;****** CÓDIGO DE INICIO **********************************
 ideal
 dosseg
 model small
 stack 256
;****** VARIABLES DEL PROGRAMA ****************************
 dataseg
codsal db 0
lado1 dw ?
lado2 dw ?
lado3 dw ?
tipo db ?
;****** CÓDIGO DEL PROGRAMA *******************************
 codeseg
inicio:
 mov ax, @data ; Inicializa el
 mov ds, ax ; segmento de datos
 mov ax, [lado1]
 mov bx, [lado2]
 mov cx, [lado3]
; Llama al procedimiento para determinar el tipo de
; triángulo.
 call triang
 mov [tipo], al ; tipo = AL
salir:
 mov ah, 04Ch
 mov al, [codsal]
 int 21h
;****** PROCEDIMIENTOS ************************************
;**********************************************************
; TRIANG
;
; Este procedimiento determina si tres líneas forman un
; triángulo y su tipo.
;
; Parámetros:
;
; AX = lado1
; BX = lado2
; CX = lado3
;
; Regresa:
;
; AL = tipo de triángulo.
;**********************************************************
proc ordenar;Ordena 3 numeros de mayor a menor.
;Parametros AX, BX y CX. Regresa AX>=BX>=CX.
   cmp ax,cx 
   ja @@caso1
 	
   cmp bx,cx 
   ja @@caso2

   cmp bx,ax 
   ja @@caso3

   @@caso1:
   xchg ax,cx 
   cmp ax,bx
   ja @@may1
   jmp @@retorno

   @@caso2:
   xchg bx,cx 
   cmp bx,ax 
   jb @@may2
   jmp @@retorno

   @@caso3:
   xchg bx,ax 
   cmp bx,cx 
   ja @@may3


   jmp @@retorno
   @@may1:
   xchg ax,bx 
   jmp @@retorno
   @@may2:
   xchg bx,ax 
   jmp @@retorno

   @@may3:
   xchg bx,cx
      jmp @@retorno
   @@retorno:


    ret    
endp ordenar
proc triang
call ordenar
 push ax ; Guarda el valor de lado1
 add ax, bx
 cmp ax, cx ; if(lado1+lado2 > lado3)
 ja @@equi ; goto equi
 pop ax ; recupera lado1
 mov al, 'N' ; return 'N'
 ret ;
@@equi: pop ax ; recupera lado1
 cmp ax, cx ; if(lado1 != lado3)
 jne @@iso1 ; goto iso1
 mov al, 'E' ; return 'E'
 ret
@@iso1: cmp ax, bx ; if(lado1 != lado2)
 jne @@iso2 ; goto iso2
 mov al, 'I' ; return 'I'
 ret
@@iso2: cmp bx, cx ; if(lado2 != lado3)
 jne @@esca ; goto esca
 mov al, 'I' ; return 'I'
 ret
@@esca: mov al, 'S' ; return 'S'
 ret
 endp triang
;****** CÓDIGO DE TERMINACIÓN *****************************


 end inicio