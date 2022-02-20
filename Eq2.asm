ideal 
dosseg
model small 
dataseg 
codeseg 
public mcm,redfrac,mcd,addfrac,subfrac,mulfrac,divfrac
;Carlos Sandoval
proc divfrac

local nA: word,nB:word,deA:word,deB:word,res:word = Var
    
    push bp 
    mov bp,sp 
    sub sp,var
    push bx 

	mov [nA],ax 
	mov [nB],bx 
	mov [deA],dx
	mov [deB],cx 
    
    ;Multiplicamos Numerador por Denominador2
	mov ax,[nA]
	mul [deB]
	mov [res],ax 
	;Multiplicamos Numerador2 Por Denominador
	 mov ax,[nB]
 	mul [deA]
 	mov dx,ax 
 	mov ax,[res]
 	;Reducimos la Fracción
    call redfrac

    pop bx
    mov sp,bp
    pop bp
    ret


endp divfrac 
;Carlos Sandoval
  proc mcm
    
    local maxim: word, n: word, n2:word = Var

    push bp
    mov  bp, sp
    sub  sp, Var
    push bx

    mov [n], ax
    mov [n2], dx
    
    call mcd ;Calcula el mcd 
    mov  [maxim], ax 
    
    mov ax, [n]
    mul [n2]
    div [maxim]
    
    pop bx
    mov sp,bp
    pop bp
    ret
endp mcm

;Aldo
proc addfrac

local d1:word, d2:word, n1:word, n2:word, res4:word, res5:word =tamsuma


push bp
mov bp, sp
sub sp, tamsuma
push bx

mov [d1], dx
mov [d2], cx
mov [n2], bx
mov [n1], ax

cmp dx, [d2]
je igual
jne otro

otro:
mov ax, [d1]
mov dx, [d2]
mul dx
mov [res5], ax
jmp sumaa

igual:
mov [res5], dx
mov ax, [n1]
add ax, [n2]
mov [res4], ax
call redfrac

jmp resul

sumaa:

mov ax, [n1]
mov cx, [d2]
mul cx

mov [res4], ax

mov ax, [d1]
mov bx, [n2]
mul bx

add [res4], ax

mov ax, [res4]
mov dx, [res5]

call redfrac

resul:

pop bx
mov sp, bp
pop bp

ret

endp addfrac

;aldo
proc mulfrac
local n1: word, d1: word, n2: word, d2: word, r1: word, r2: word = tammul

push bp
mov bp, sp
sub sp, tammul
push bx


mov [n1], ax
mov [d1], dx
mov [n2], bx
mov [d2], cx

mov ax, [n1]
mul [n2]

mov [r1], ax

mov ax, [d1]
mul [d2]

mov [r2], ax


mov ax, [r1]
mov dx, [r2]
call redfrac

pop bx
mov sp, bp
pop bp
ret
endp mulfrac
;Arnoldo
proc mcd ;Consigue el MCD de dos numeros.
;Parametros AX y DX. Regresa el MCD en AX.

    local mayor: word, menor:word = tamVar
    
    push bp
    mov  bp, sp
    sub  sp, tamVar
    push bx
    
    cmp ax, dx
    ja @@mayor_ax
    
    mov [menor], ax
    mov [mayor], dx
    jmp @@primer_calculo
    
@@mayor_ax:
    mov [mayor], ax
    mov [menor], dx    
    
@@primer_calculo:    
    mov ax, [mayor]
    
@@calculo:
    xor dx, dx
    div [menor]
    cmp dx, 0h
    je  @@retorno ;If r = 0 -> mcd = menor
    
    mov ax,[menor] ;Else mayor = menor, menor = r -> Loop
    mov [menor], dx
    jmp @@calculo
    
@@retorno:
    mov ax, [menor] ;AX = MCD
    
    pop bx
    mov sp,bp
    pop bp
    ret
endp   mcd

;Arnoldo
proc subfrac;Calcula la resta de dos fracciones A-B.
;Parametros AX(numA), DX(denA), BX(numB)y CD(denB). Regresa la resta en AX(num) y DX(den).    
    local numA: word, denA: word, numB:word, denB:word, mincm:word = tamVar
    
    push bp
    mov  bp, sp
    sub  sp, tamVar
    push bx
    
    mov [numA], ax
    mov [denA], dx
    mov [numB], bx
    mov [denB], cx
    
    call redfrac  ;Reduccion
    mov [numA], ax;de ambas
    mov [denA], dx;fracciones a
    mov ax, [numB];su
    mov dx, [denB];minima
    call redfrac  ;expresion
    mov [numB], ax;-
    mov [denB], dx;-
    
    mov ax, [denA] ;Encontrar el 
    call mcm       ;mcm (denominador)
    mov [mincm],ax ;de ambas fracciones
    
    div [denA]     ;Encontrar el nuevo 
    xor dx,dx      ;numerador
    mul [numA]     ;para la
    mov [numA], ax ;primer frac.
                                      
    mov ax, [mincm];Encontra el 
    div [denB]     ;nuevo
    xor dx, dx     ;numerador
    mul [numB]     ;para la
    mov [numB], ax ;segunda frac.
    
    
    mov ax, [numA]
    sub ax, [numB]
    mov dx, [mincm];Dar el denominador
    
    call redfrac
;Retorno    
    pop bx
    mov sp,bp
    pop bp
    ret
endp subfrac


proc redfrac ;Reduce una fraccion a su minima expresion.
;Parametros AX(nerador) y DX(Denominador). Devuelve los mismos en AX y DX.

    local n: word, den: word = Var

    push bp
    mov  bp, sp
    sub  sp, Var
    push bx
    
    mov [n], ax
    mov [den], dx
     
    call mcd
    
    mov bx, ax ;BX = MCD
    xor dx, dx
    
    mov ax, [n] ;Reduccion
    div bx        ;de el 
    mov [n], ax ;nerador
    
    mov ax, [den] ;Reduccion
    div bx        ;de el 
    mov [den], ax ;denominador 
    
    mov ax, [n]
    mov dx, [den]
    
;Retorno 
    pop bx
    mov sp, bp
    pop bp
    ret
endp redfrac
end