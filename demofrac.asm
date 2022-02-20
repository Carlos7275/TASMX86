;Inicio
    ideal
    dosseg
    model   small
    stack   256
;Variables
    dataseg
    codsal  db  0
    numA    dw  ?
    denA    dw  ?
    numB    dw  ?
    denB    dw  ?
    numC    dw  ?
    denC    dw  ?
    numR    dw  ?
    denR    dw  ?
    numAB   dw  ?
    denAB   dw  ?
    numCA   dw  ?
    denCA   dw  ?
    numBC   dw  ?
    denBC   dw  ?
;Codigo
    codeseg
    extrn mcd: proc
    extrn mcm: proc
    extrn redfrac: proc
    extrn addfrac: proc
    extrn subfrac: proc
    extrn mulfrac: proc
    extrn divfrac: proc
inicio:
        mov ax, @data
        mov ds, ax
        
        mov ax, [numA]
        mov dx, [denA]
        mov bx, [numB]
        mov cx, [denB]
        
         call subfrac   
        mov [numAB], ax;
        mov [denAB], dx;
         ;call divfrac
        ;mov ax, [numC]
        ;mov dx, [denC]
        ;mov bx, [numA]
        ;mov cx, [denA]
        
        ;call subfrac   ; C - A
        ;mov [numCA], ax;
        ;mov [denCA], dx;
        
        ;mov ax, [numB]
        ;mov dx, [denB]
       ; mov bx, [numC]
       ; mov cx, [denC]
        
       
       ; mov [numBC], ax;
       ; mov [denBC], dx;
        
        ;mov ax, [numAB]
        ;mov dx, [denAB]
        ;mov bx, [numCA]
       ; mov cx, [denCA]
        
       ; call mulfrac    ;(A+B) * (C-A)
        
        ;mov bx, [numBC]
        ;mov cx, [denBC]
        
        ;call divfrac    ; ((A+B) * (C-A)) / (B+C)
        ;mov [numR], ax
        ;mov [denR], dx
        
salida:
        mov  ah, 04Ch
        mov  al, [codsal]
        int  21h

;Terminacion
        end inicio