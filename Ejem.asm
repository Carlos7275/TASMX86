ideal 
dosseg 
model small
stack 100h
dataseg 
msg0 db 13,10,"Ingrese una cadena: $"
msg db 13,10,7,"El resultado es: $"
mensaje db 81 dup(?),"$"
num1 db 81 dup(?),"$"
num2 db 81 dup(?),"$"
result db 81 dup(?),"$"
ope db ?
codeseg 
inicio:
mov ax,@data 
mov ds,ax 
mov es,ax

mov ah,09h 
lea dx,[msg0]
int 21h

mov di,offset mensaje
call scanf

mov si,offset mensaje
call long

mov di,offset num1 
mov ax,offset num2
mov bx,offset ope
call split

mov si,offset num2
call aatoi
push ax

mov si,offset num1
call aatoi
pop dx

mov bl,[ope]
call operacion

mov di,offset result 
call final


mov ah,09h 
lea dx,[msg]
int 21h

mov ah,09h 
lea dx,[result]
int 21h



salir:
mov ah,4ch
mov al,0h
int 21h

proc scanf
push di
push ax
push bx
mov bh,0
cld
@@hacer:
mov ah,10h 
int 16h

mov ah,0Eh
int 10h 

cmp al,13
je @@fin 
cmp al,8
je @@borrar
stosb
jmp @@hacer

@@borrar:
dec di
jmp @@hacer
@@fin:

mov [byte di],0

 	mov al, 10
    mov ah, 0Eh
    int 10h

   pop di
   pop ax
   pop bx
ret
endp scanf

proc split
   push ax
    
@@ciclo:
    movsb
    loop @@ciclo
    
@@finciclo: 

    lodsb
    mov [bx], al
    
    pop di
    
@@whi:
    cmp [byte si], 0
    je @@endwhi
        
    movsb
    jmp @@whi
@@endwhi:
    
    ret
endp split

proc long;Obtiene la longitud del primer operador de una cadena de expresion aritmetica.
;Parametros: SI(Cadena). Regresa la longitud en CX
    push si
    
    cld
    xor cx, cx
    inc si
    inc cl
    
@@whi:    
    cmp [byte si], 0
    je @@endwhi
    
    lodsb
    cmp al, '0'
    jb  @@endwhi  
    inc cl
    jmp @@whi
    
@@endwhi:
pop si
ret
endp long

proc astrlen;Obtiene la longitud de una cadena terminada en 0
;Parametros: SI(Cadena). Regresa la longitud en CX.

    push ax
    push di
    
    mov di, si
    xor al, al
    
    cld
    
@@whi:
    scasb
    jnz @@whi
    
    mov cx, di
    sub cx, si
    dec cx
    
    pop di
    pop ax
    ret   
endp astrlen    
    
proc astrupr;Convierte las letras minusculas a mayusculas de una cadena.
;Parametros: SI(Cadena). Regresa la misma cadena.

    push ax
    push cx
    push si
    push di
    
    call astrlen   
    jcxz @@retorno
    
    mov di, si
    
    cld

@@ciclo:
    lodsb
    cmp al, 'a'
    jb  @@siguiente
    cmp al, 'z'
    ja @@siguiente    
    sub al, 32d
    
@@siguiente:
    stosb
    loop @@ciclo 
    
@@retorno:
    pop di
    pop si
    pop cx
    pop ax
    ret
endp astrupr

proc obtenSigno;Lee el primer caracter de una cadena y determina su signo.
;Parametros: SI(Cadena), CX(Longitud SI). Regresa 0 para positivo y 1 para negativo en DX.

     xor dx,dx
     cmp [byte si], '+'
     je @@positivo
     cmp [byte si], '-'
     je @@negativo
     jmp @@retorno
     
@@negativo: 
    mov dx, 1
    
@@positivo:
    inc si
    dec cx
    
@@retorno:
    ret    
endp obtenSigno

proc obtenBase;Lee el ultimo caracter de una cadena y determina su base numerica.
;Parametros: SI(Cadena), CX(Longitud SI). Regresa 2, 10 o 16 como base en BX.

    push si
    add  si, cx
    dec  si
    
    mov bx, 10
    
    cmp [byte si], 'B'
    je @@bin
    cmp [byte si], 'H'
    je @@hex
    cmp [byte si], 'D'
    je @@decr
    jmp @@retorno
    
@@bin:
    mov bx, 2d
    jmp @@decr
    
@@hex:
    mov bx, 16d
    
@@decr:
    dec cx
    
@@retorno:
    pop si
    ret
endp obtenBase

proc atou;Convierte una cadena que representa un numero signado tama?o palabra en su valor 
;Parametros: SI(Cadena), BX(Base), CD(Longitud SI). Regresa el valor en AX.
    
    push dx
    push di
    
    xor ax, ax
    jcxz @@retorno
    
    xor di, di    
    
@@ciclo:
    mov ax, di
    mul bx
    mov dl, [byte si]
    xor dh, dh
    call valC
    add ax, dx
    mov di, ax
    inc si
    loop @@ciclo 

    mov ax, di
    
@@retorno:
    pop di
    pop dx
    ret
endp atou

proc valC;Convierte un caracter numerico a su valor numerico en binario.
;Parametros: DX(Caracter). Regresa el valor en DX.

    cmp dx, '9'
    ja @@hex
    sub dx, '0'
    jmp @@retorno
    
@@hex:
    sub dx, 55d
    
@@retorno:
    ret
endp valC

proc aatoi

    push bx
    push cx
    push dx
    push si
    
    call astrupr
    call astrlen
    call obtenSigno
    call obtenBase
    call atou
    
    cmp dx, 0
    je @@retorno
    neg ax
    
@@retorno:
    pop si
    pop dx
    pop cx
    pop bx      
    ret
endp aatoi


proc operacion
cmp bl,'+'
je @@suma
cmp bl,'-'
je @@resta
cmp bl,'*'
je @@mult
cmp bl,'/'
je @@divi

@@suma:
add ax,dx
jmp @@fin
@@resta:
sub ax,dx 
jmp @@fin
@@mult:
imul dx
jmp @@fin
@@divi:
push bx 
mov bx,dx
idiv bx
pop bx
jmp @@fin
@@fin:
ret 
endp operacion

proc final
push ax
cmp ax,0
jge @@imprimir 
neg ax
mov [byte di],'-'
inc di
jmp @@imprimir
@@imprimir:
call base10
call base2
call base16
pop ax
ret
endp final
proc base10
push ax
    mov bx, 10d
    xor cx, cx              
    cld
    
@@ciclo_1:
    xor dx, dx              
    idiv bx                   
    push dx                 
    inc cl                  
    test  ax, ax           
    jnz @@ciclo_1          
@@finciclo_1:

@@ciclo_2:
    pop ax                  
    add al, 48d       
    stosb
    loop @@ciclo_2      
    
@@finciclo_2:    
    mov [byte di], 'd'
    inc di
    
    mov al, ' '
    stosb
    mov al, '='
    stosb
    mov al,' '
    stosb
    mov [byte di], 0
    
@@retorno: 
    pop ax
    ret
endp base10

proc base2;Concatenar la base 2
    push ax
    mov bx, 2d
    xor cx, cx              
    cld
    
@@ciclo_1:
    xor dx, dx              
    idiv bx                   
    push dx                 
    inc cl                  
    test  ax, ax           
    jnz @@ciclo_1          
@@finciclo_1:

@@ciclo_2:
    pop ax                  
    add al, 48d       
    stosb
    loop @@ciclo_2      
    
@@finciclo_2:    
    mov [byte di], 'b'
    inc di
    mov al,' '
    stosb
    mov al,'='
    stosb
    mov al,' '
    stosb
    mov [byte di], 0
    
@@retorno: 
    pop ax
    ret
endp base2

proc base16;Concatenar la base 16

    push ax
    mov bx, 16d
    xor cx, cx              
    cld
    
@@ciclo_1:
    xor dx, dx              
    idiv bx                   
    push dx                 
    inc cl                  
    test  ax, ax           
    jnz @@ciclo_1          
@@finciclo_1:

@@ciclo_2:
    pop ax
    cmp al, 9d
    ja @@mayor
    add al, 48d 
    jmp @@anadir
@@mayor:
    add al, 55d

@@anadir:    
    stosb
    loop @@ciclo_2      
    
@@finciclo_2:    
    mov [byte di], 'h'
    inc di
    
    mov [byte di], 0 
    
@@retorno: 
    pop ax
    ret
    
endp base16
end inicio