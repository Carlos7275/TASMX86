;Modulo de Operaciones de Calculadora Fraccionaria CarlosSandoval@2020-18-12-2020.
ideal 
dosseg
model small 
dataseg 
codeseg 
public mcm,redfrac,mcd,addfrac,subfrac,mulfrac,divfrac

;Procedimientos
;---------------------------------------------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------------------------------------------

 proc mcd 

 local may: word, men:word = Var
    
    push bp
    mov  bp, sp
    sub  sp, Var
    push bx
    
    cmp ax, dx
    ja @@may_ax
    
    mov [men], ax
    mov [may], dx
    jmp @@primero
    
    @@may_ax:
    mov [may], ax
    mov [men], dx    
    
    @@primero:    
    mov ax, [may]
    
    @@operacion:
    xor dx, dx
    div [men]
    cmp dx, 0h
    je  @@salida 
    
    mov ax,[men] 
    mov [men], dx
    jmp @@operacion
    
    @@salida:
    mov ax, [men] 
    pop bx
    mov sp,bp
    pop bp
    ret
endp mcd
;---------------------------------------------------------------------------------------------------------------------

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
;---------------------------------------------------------------------------------------------------------------------
proc addfrac
local nA: word,nB:word,deA:word,deB:word,min:word = Var
push bp 
mov bp,sp 
sub sp,var
push bx 

;Le establecemos valores alas variables locales
	mov [nA],ax 
	mov [nB],bx 
	mov [DeA],dx
	mov [DeB],cx 

 	call redfrac
    mov [nA], ax
    mov [deA], dx

    mov ax, [nB]
    mov dx, [deB]

    call redfrac  
    mov [nB], ax
    mov [deB], dx
    ;Buscar Minimo comun multiplo 
    mov ax, [deA]
    call mcm      
    mov [min],ax
              
    mov ax, [min]   ;Encontrar el numerador para la primera fracción nA=(Min/deA)*nA
    div [deA]        
    xor dx,dx  ;Limpiamos el Residuo       
    mul [nA]     
    mov [nA], ax   
    ;Encontrar el numerador para la Segunda Fracción nB=(min/deB)*nB                                                              
    mov ax, [min] 
    div [deB]       
    xor dx, dx 
    mul [nB]       
    mov [nB], ax   
  ;Sumar Ambos numeradores 
    mov ax, [nA] 
    add ax, [nB] 
    ;Tomar el Minimo como denominador de resultado
    mov dx, [min]
    
    call redfrac

    pop bx
    mov sp,bp
    pop bp
    ret
endp addfrac
;---------------------------------------------------------------------------------------------------------------------
proc subfrac
local nA: word,nB:word,deA:word,deB:word,min:word = Var
push bp 
mov bp,sp 
sub sp,var
push bx 

;Le establecemos valores alas variables locales
	mov [nA],ax 
	mov [nB],bx 
	mov [deA],dx
	mov [deB],cx 
    
    ;Reduccion de Ambas Fracciones 
    call redfrac
    mov [nA], ax
    mov [deA], dx
    mov ax, [nB]
    mov dx, [deB]
    call redfrac  
    mov [nB], ax
    mov [deB], dx

    ;Buscar Minimo comun multiplo 
    mov ax, [deA]
    call mcm      
    mov [min],ax
              
    mov ax, [min]   ;Encontrar el nerador para la primera fraccion nA=(Min/deA)*nA
    div [deA]        
    xor dx,dx        
    mul [nA]     
    mov [nA], ax   
    ;Encontrar el nerador para la Segunda Fraccion nB=(min/deB)*nB                                                              
    mov ax, [min] 
    div [deB]       
    xor dx, dx       
    mul [nB]       
    mov [nB], ax   
  ;Restar Ambos neradores 
  	mov ax, [nA]     
    sub ax, [nB]
    
    jns @@no_negativo;
    not ax ;Invierte el numero y le suma 1 para asi mostrar el numero negativo correcto! 
    add ax,1 
    ;Tomar el Minimo como denominador de resultado
    @@no_negativo:
    mov dx, [min]
    
    pop bx
    mov sp,bp
    pop bp
    ret
endp subfrac
;---------------------------------------------------------------------------------------------------------------------
proc mulfrac
local nA: word,nB:word,deA:word,deB:word,res:word = Var
push bp 
mov bp,sp 
sub sp,var
push bx 

	mov [nA],ax 
	mov [nB],bx 
	mov [deA],dx
	mov [deB],cx 
    
    ;Multiplicar Numerador con Numerador2
    mov ax,[nA]
    mul [nB]
    mov [res],ax

    ;Multiplicar denominador con denominador2
    mov ax,[deA]
    mul [deB]
    mov dx,ax 
    mov ax,[res]
    ;Reducimos la fracción
    call redfrac
    pop bx
    mov sp,bp
    pop bp
    ret
 
endp mulfrac
;---------------------------------------------------------------------------------------------------------------------
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
;---------------------------------------------------------------------------------------------------------------------
end ;Fin del modulo