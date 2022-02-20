;Inicio
    ideal
    dosseg
    model   small
    stack   256
;Variables
    dataseg
    msg0 db 'Calculadora Elaborada por CarlosSandoval@2020',0
    msg1    db  13,10,'Ingrese la Expresion a Calcular: ', 0
    msg2 db 13,10,'El resultado es ',0
    msg3 db 13,10,'------------------------------------------------------',0
    msg4 db 13,10,'No se puede dividir entre 0',0
    cadena  db  81 dup (?)
    op1     db  81 dup (?)
    op2     db  81 dup (?)
    oper    db  ?
    res     db  81 dup (?)
    
;Codigo
    codeseg
    extrn aputs: proc, agets: proc, aoplen: proc, aatoi: proc, getop: proc, operacion: proc, res_final: proc
inicio:
        mov ax, @data
        mov ds, ax
        mov es, ax
        ;Limpiar Pantalla
        mov ah,0fh
        int 10h
        mov ah,0h
        int 10h
        ;Muestra el Mensaje Principal
        mov si,offset msg0
        call aputs

        mov si,offset msg3
        call aputs
        ;Muestra el mensaje ingrese la expresion  a calcular
        mov si, offset msg1
        call aputs
       ;Obtiene la Cadenaa
        mov di, offset cadena
        call agets 
        
        mov si, offset cadena
        call aoplen
        
        jcxz salir
        ;Separa los operadores y operandos
        mov di, offset op1
        mov ax, offset op2
        mov bx, offset oper
        
        call getop
        ;Convierte el numero2 es numero signado
        mov si, offset op2
        call aatoi
        push ax
        ;Convierte numero1 en numero signado
        mov si, offset op1
        call aatoi
        pop dx
        
        mov bl, [oper]
        call operacion ;Mandamos a llamar a operacion donde se determinara la operacion a realizar

        cmp ax,0h 
        je imprime
        
        mov si,offset msg2
        call aputs
        ;Mostramos el mensaje 2 
        
        mov di, offset res
        call res_final
        ;LLama al res_final para obtener la cadena final
        
        mov si, offset res
        call aputs
        ;Muestra el resultado
        
        mov si,offset msg3
        call aputs

imprime:
mov si,offset msg4
call aputs

salir:
        mov  ah, 4ch
        mov  al, 0h
        int  21h

;Terminacion
        end inicio