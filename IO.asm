;----------------------------------------------------------------------------------------------------
;Input/Output ASM X86 BY Carlos Sandoval
;----------------------------------------------------------------------------------------------------
ideal 
dosseg
model small
dataseg 
msj db "La hora actual es :",0
espacio db " ",0
simb db ":",0
msj2 db "/",0

strhour db 81 dup(?)
strmin db 81 dup(?)
strseconds db 81 dup(?)
strday db 81 dup(?)
stryear db 81 dup(?)
strmonth db 81 dup(?)
codeseg 
public astrlen,astrupr,atou,aatoi,astrcat,aputs,agets,clrscr,aitoa,exit,getDateTime

proc clrscr
mov ah,0fh
int 10h 
mov ah,0h 
int 10h 

     ret
endp clrscr
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


proc aputs;Imprime los caracteres de una cadena apuntada por SI
;Parametros: SI(Cadena).
    push ax
    push bx

    mov ah, 0Eh
    mov bh, 0

    cld

@@while:
    lodsb
    cmp al, 0
    je @@endwhi

    int 10h
    jmp @@while

@@endwhi:
    pop bx
    pop ax
    ret

endp aputs


proc agets;Lee una cadena de caracteres desde consola. "0' marca el final de la cadena.
;Parametros: DI(Cadena).

    push ax
    push bx
    push di

    mov bh, 0

    cld

@@while:
    mov ah, 10h
    int 16h

    mov ah, 0Eh
    int 10h
    
    cmp al, 13
    je @@endwhi
    cmp al, 8
    je @@borrar
    stosb
    jmp @@while
@@borrar:
    dec di
    jmp @@while

@@endwhi:
    mov [byte di],"$"
    mov [byte di], 0

    mov al, 10
    mov ah, 0Eh
    int 10h

    pop di
    pop bx
    pop ax
    ret
endp agets

proc astrcat;Concatena una cadena apuntada por DI a otra papuntada por SI.
;Parametros: SI(Cadena principal), DI(Cadena a concatenar).
    push ax
    push si
    push di

    xor al, al
    cld

@@whi:
    scasb
    jnz @@whi

    dec di

@@do:
    lodsb
    stosb
    cmp al, 0
    jne @@do

@@fin:
    pop di
    pop si
    pop ax
    ret
endp astrcat



proc aitoa
push ax
cmp ax,0
jge @@imprimir 
neg ax
mov [byte di],'-'
inc di


jmp @@imprimir

@@imprimir:
call base10

@@fin:
pop ax
ret
endp aitoa
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
    cmp  ax, 0           
    jne @@ciclo_1          
@@finciclo_1:

@@ciclo_2:
    pop ax                  
    add al, 48d       
    stosb
    loop @@ciclo_2      
    
@@finciclo_2:    
    mov [byte di], 0
    
@@retorno: 
    pop ax
    ret
endp base10

proc exit
mov ah,4ch
mov al,0h
int 21h
endp exit

proc getDateTime

    local day: word, month:word,year:word,hour:word,min:word,seconds:word = tamVar
     push bp
    mov  bp, sp
    sub  sp, tamVar
    push bx


MOV AH,2AH
INT 21H
mov [byte day],dl 
mov [year],cx 
mov [byte month],dh 

MOV AH,2CH
INT 21H
mov [byte hour],ch
mov [byte min],cl
mov [byte seconds],dh

mov si,offset msj 
call aputs

mov ax,[ day]
mov di,offset strday
call aitoa
mov ax,[ month]
mov di,offset strmonth
call aitoa
mov ax,[year]
mov di,offset stryear
call aitoa


mov si,offset strday
call aputs 
mov si,offset msj2
call aputs 
mov si,offset strmonth
call aputs 
mov si,offset msj2 
call aputs
mov si,offset stryear
call aputs 

mov si,offset espacio
call aputs 


xor ax,ax 
mov ax,[hour]
AAM
mov bx,ax 
;Print hour 
mov ah,02h 
mov dl,bh 
add dl,30h
int 21h

mov ah,02h 
mov dl,bl 
add dl,30h
int 21h

mov si,offset simb 
call aputs 


xor ax,ax 
mov ax,[min]
AAM
mov bx,ax 
;Print hour 
mov ah,02h 
mov dl,bh 
add dl,30h
int 21h

mov ah,02h 
mov dl,bl 
add dl,30h
int 21h

mov si,offset simb 
call aputs 

xor ax,ax 
mov ax,[seconds]
AAM
mov bx,ax 
;Print hour 
mov ah,02h 
mov dl,bh 
add dl,30h
int 21h

mov ah,02h 
mov dl,bl 
add dl,30h
int 21h
 pop bx
    mov sp,bp
    pop bp
ret
endp getDateTime
end 
