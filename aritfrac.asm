;Inicio
    ideal
    dosseg
    model   small
    
;Codigo
    codeseg
    public mcd
    public mcm
    public addfrac
    public redfrac
    public subfrac
    public mulfrac
    public divfrac
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
endp    mcd

proc mcm;Consigue el MCM de dos numeros.
;Parametros: AX y DX. Regresa el MCM en AX (y DX).

    local maxcd: word, num: word, num2:word = tamVar

    push bp
    mov  bp, sp
    sub  sp, tamVar
    push bx

    mov [num], ax
    mov [num2], dx
    
    call mcd
    mov  [maxcd], ax
    
    mov ax, [num]
    mul [num2]
    div [maxcd]
    
;Regreso
    pop bx
    mov sp,bp
    pop bp
    ret
endp mcm

proc redfrac ;Reduce una fraccion a su minima expresion.
;Parametros AX(Numerador) y DX(Denominador). Devuelve los mismos en AX y DX.

    local num: word, den: word = tamVar

    push bp
    mov  bp, sp
    sub  sp, tamVar
    push bx
    
    mov [num], ax
    mov [den], dx
     
    call mcd
    
    mov bx, ax ;BX = MCD
    xor dx, dx
    
    mov ax, [num] ;Reduccion
    div bx        ;de el 
    mov [num], ax ;numerador
    
    mov ax, [den] ;Reduccion
    div bx        ;de el 
    mov [den], ax ;denominador 
    
    mov ax, [num]
    mov dx, [den]
    
;Retorno 
    pop bx
    mov sp, bp
    pop bp
    ret
endp redfrac

proc addfrac ;Calcula la suma de dos fracciones.
;Parametros AX(numA), DX(denA), BX(numB)y CD(denB). Regresa la suma en AX(num) y DX(den).
    
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
    
    mov ax, [denA];Encontrar el mcm (denominador)
    call mcm      ;de ambas
    mov [mincm],ax;fracciones 
              
    mov ax, [mincm]  ;Encontrar el
    div [denA]       ;nuevo 
    xor dx,dx        ;numerador
    mul [numA]       ;para la
    mov [numA], ax   ;primera frac.
                                      
    mov ax, [mincm]  ;Encontrar el
    div [denB]       ;nuevo
    xor dx, dx       ;numerador
    mul [numB]       ;para la
    mov [numB], ax   ;segunda frac.
    
    mov ax, [numA] ;Sumar los
    add ax, [numB] ;numeradores
    
    mov dx, [mincm];Dar el denominador
    
    call redfrac
;Retorno    
    pop bx
    mov sp,bp
    pop bp
    ret
endp addfrac

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
    cmp ax, [numB]
    pushf         ;Comparar si A < B -> Resultado negativo.
    sub ax, [numB]
    popf
    
    ja @@sin_signo;
    not ax
    add ax, 1h
@@sin_signo:
    mov dx, [mincm];Dar el denominador
    
    call redfrac
;Retorno    
    pop bx
    mov sp,bp
    pop bp
    ret
endp subfrac

proc mulfrac;Calcula la multiplicacion de dos fracciones A y B tama?o palabra.
;Parametros AX(numA), DX(denA), BX(numB)y CX(denB). Regresa el resultado en AX(num) y DX(den).

    local numA:word, denA: word, numB:word, denB:word, numR:word = tamVar
    
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
    
    mov ax, [numA]
    mul [numB]     ;numA * numB = numR
    mov [numR], ax 
    
    mov ax, [denA]
    mul [denB]     ;denA * denB = denR
    
    mov dx, ax
    mov ax, [numR]
    
    call redfrac
;Retorno    
    pop bx
    mov sp,bp
    pop bp
    ret
endp mulfrac

proc divfrac;Calcula la division de dos fracciones A y B tama?o palabra.
;Parametros: AX(numA), DX(denA), BX(numB) y CX(denB). Regresa el resultado en AX(num) y DX(den).
    local numA: word, denA: word, numB: word, denB:word, numR:word = tamVar
    
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
    
    mov ax, [numA]
    mul [denB]     ;numA * denB = numR
    mov [numR], ax
    
    mov ax, [numB]
    mul [denA]     ;denA * numB = denR
    
    mov dx, ax
    mov ax, [numR]
    
    call redfrac
    
;Retorno    
    pop bx
    mov sp,bp
    pop bp
    ret
endp divfrac
;Terminacion
end 