;Inicio
    ideal
    dosseg
    model   small
    stack   256
;Variables
    dataseg
    codsal  db  0
    msg1    db 'Nombre: ', 0
    d_p     db ': ', 0
    str_peso db 'Dame el peso de ',0
    fin1    db 'La persona con mayor peso es ', 0
    fin2    db ' con un peso de ', 0
    fin3    db ' kilogramos', 0
    aux     db 81 dup (?)
    nom1    db 81 dup (?)
    nom2    db 81 dup (?)
    str_p1  db 81 dup (?)
    str_p2  db 81 dup (?)
    peso1   dw  ?
    peso2   dw  ?
    
;Codigo
    codeseg
    extrn aputs: proc, agets: proc, atou: proc, astrlen: proc
inicio:
    mov ax, @data
    mov ds, ax
    mov es, ax
        
    mov si, offset msg1    ;
    call aputs             ;
    mov di, offset nom1    ;
    call agets             ;
    mov si, offset str_peso;
    call aputs             ;Nombre y peso 1
    mov si, offset nom1    ;
    call aputs             ;
    mov si, offset d_p     ;
    call aputs             ;
    mov di, offset str_p1  ;
    call agets             ;
    
    
    mov si, offset msg1    ;
    call aputs             ;
    mov di, offset nom2    ;
    call agets             ;
    mov si, offset str_peso;
    call aputs             ;Nombre y peso 2
    mov si, offset nom2    ;
    call aputs             ;
    mov si, offset d_p     ;
    call aputs
    mov di, offset str_p2  ;
    call agets             ;
    
    
    mov si, offset str_p1;
    call astrlen         ;
    mov si, offset str_p1;Cadena a numerico del peso 1
    mov bx, 10d          ;
    call atou            ;
    mov [peso1], ax      ;
    
    mov si, offset str_p2;
    call astrlen         ;
    mov si, offset str_p2;Cadena a numerico del peso 2
    mov bx, 10d          ;
    call atou            ;
    mov [peso2], ax      ;
    
    cmp [peso1], ax
    jae @@p1_mayor
;    je @@p2_igual
    
@@p2_mayor:
    mov si, offset fin1
    call aputs
    mov si, offset nom2
    call aputs
    mov si, offset fin2
    call aputs
    mov si, offset str_p2
    call aputs
    mov si, offset fin3
    call aputs
    jmp salida
    
    
@@p1_mayor: 
    mov si, offset fin1
    call aputs
    mov si, offset nom1
    call aputs
    mov si, offset fin2
    call aputs
    mov si, offset str_p1
    call aputs
    mov si, offset fin3
    call aputs
    jmp salida   
    
salida:
    mov  ah, 04Ch
    mov  al, [codsal]
    int  21h

;Terminacion
        end inicio 