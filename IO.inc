;------------------------------------------------------------------------------------------------------------------------
;INPUT/OUTPUT LIBRARY BY CARLOS SANDOVAL ASMX86
;------------------------------------------------------------------------------------------------------------------------

macro suma var,var2,res ;ADITION INPUT DATA VAR,VAR2 OUTPUT RES 
mov ax,[var]
add ax,[var2]
mov [res],ax 
endm 
;------------------------------------------------------------------------------------------------------------------------

macro resta var,var2,res 
mov ax,[var]
sub ax,[var2]
mov [res],ax 
endm 
;------------------------------------------------------------------------------------------------------------------------
macro Multi var,var2,res 
mov ax,[var]
imul [var2]
mov [res],ax 
endm 
;-----------------------------------------------------------------------------------------------------------------------

;***************************************************************


;-------------------------------------------------------------------------------------------------------------------------
macro divis var,var2,res 
xor dx,dx
mov ax,[var]
Idiv [var2]
mov [res],ax 
endm 
;------------------------------------------------------------------------------------------------------------------------
macro clrscr
mov ah,0fh
int 10h 
mov ah,0h 
int 10h 
endm 
;------------------------------------------------------------------------------------------------------------------------

macro acumulador acumu,var 
mov ax,[acumu]
add ax,[var]
mov [acumu],ax 
endm
;------------------------------------------------------------------------------------------------------------------------

macro EXIT_PROGRAM 
mov ah,4ch 
mov al,0
int 21h
endm
;------------------------------------------------------------------------------------------------------------------------ 
macro print msg 
LOCAL @@while
LOCAL @@endwhi
   push ax 
   push bx

    mov si,offset msg 
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
endm 
;------------------------------------------------------------------------------------------------------------------------

macro Initialize ;Initialize all Segment data and registers
mov ax,@data 
mov ds,ax 
mov es,ax 
mov dx,ax

xor cx,cx
xor ax,ax 
xor dx,dx 
xor bx,bx
endm 
;------------------------------------------------------------------------------------------------------------------------

macro scan var ;Read For Keyboard
 LOCAL @@while
LOCAL @@retro
LOCAL @@endwhi

     push ax
        push bx
        push di
    mov di,offset var
        mov bh, 0

        cld

@@while:
        mov ah, 10h
        int 16h

         cmp al,08
         je @@retro
        

        mov ah, 0Eh
        int 10h
    
        cmp al, 13
        je @@endwhi
       
        stosb
        
        jmp @@while

@@retro:
        dec di
        mov [byte di],""
        mov ah,0Eh
        int 10h
        mov al,0
        int 10h
        mov al,08h
        int 10h
        jmp @@while
        
@@endwhi:
        mov [byte di], 0

        mov al, 10
        mov ah, 0Eh
        int 10h

        pop di
        pop bx
        pop ax




endm 
;------------------------------------------------------------------------------------------------------------------------
macro aitoa var,var2 ;Convert a String to Numeric Value
LOCAL @@imprimir
push ax 
push bx 
push cx 
push dx
mov di,offset var
mov ax, [var2]
cmp ax,0

jge @@imprimir 
neg ax
mov [byte di],'-'
inc di


jmp @@imprimir

@@imprimir:
 base10 di,ax
pop ax 
pop bx 
pop cx 
pop dx 


endm 
macro base10 di,ax
local @@ciclo_1
local @@ciclo_2
local @@finciclo_1
local @@finciclo_2
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
   
endm 
;------------------------------------------------------------------------------------------------------------------------


macro astrlen msg, var;Get size of String  Input msg output var 
local ciclo
 mov si, offset msg
    
    mov di, si
    xor al, al
    
    cld
    
ciclo:
    scasb
    jnz ciclo
    
    mov cx, di
    sub cx, si
    dec cx
    mov [ word var],cx
endm 
;------------------------------------------------------------------------------------------------------------------------
macro astrupr msg ;To Upper a String Input msg output msg
local @@retorno ;LOCAL LABELS 
local @@ciclo 
local @@siguiente

local long:word=tamvar
push bp
    mov  bp, sp
    sub  sp, tamVar
    push bx
mov si,offset msg 
    astrlen msg,long   
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
   pop bx
    mov sp,bp
    pop bp
endm 
;------------------------------------------------------------------------------------------------------------------------
macro astrlpr msg ;ToLower String input/output msg 
local @@ciclo,@@siguiente,@@retorno

local long:word=tamvar
push bp
    mov  bp, sp
    sub  sp, tamVar
    push bx
mov si,offset msg 
    astrlen msg,long   
    jcxz @@retorno
    
    mov di, si
    
    cld

@@ciclo:
    lodsb
    cmp al, 'A'
    jb  @@siguiente
    cmp al, 'Z'
    ja @@siguiente    
    add al, 32d
    
@@siguiente:
    stosb
    loop @@ciclo 
    
@@retorno:
   pop bx
    mov sp,bp
    pop bp
endm 
;------------------------------------------------------------------------------------------------------------------------
 macro gotoxy x,y ;Move the console cursor to x & y position input x,y     output screen 
MOV AH,02h                            
 MOV DH,x                            
 MOV DL,y                 
 MOV BH,0                                ;pagina
 INT 10h                                 ;Video (int 10)
 endm        
 ;------------------------------------------------------------------------------------------------------------------------
macro readKey ;Wait until press a Key 
PRINTLN ""
mov ah,08h
int 21h
endm 
;------------------------------------------------------------------------------------------------------------------------
macro Sleep TIME ;Delay processor Input Time Output Screen
MOV     CX, TIME
MOV     DX, TIME
MOV     AH, 86H
INT     15H
endm

macro aatoi var,var2 ;Convert String to Numeric
local @@retorno
   push bx
    push cx
    push dx
    push si
    

    local long:word=tamvar
     mov si, offset var
     astrupr var 
     astrlen var,long
    
     mov cx,[long]

    obtenSigno si,cx
    obtenBase si,cx
     atou si,bx,cx
    cmp dx, 0
    je @@retorno
    neg ax
    
@@retorno:
 pop si
    pop dx
    pop cx
    pop bx 
 mov [var2],ax

     
endm 
macro obtenSigno si,cx
local @@positivo,@@negativo,@@retorno
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
   
endm
;------------------------------------------------------------------------------------------------------------------------
macro obtenBase si,cx  ;Get the base of Number
local @@bin,@@hex,@@retorno,@@decr
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
endm
;------------------------------------------------------------------------------------------------------------------------
macro atou si,bx,cx; ;Macro Necessary to Aatoi 
local @@retorno,@@ciclo
    
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
     valC dx
    add ax, dx
    mov di, ax
    inc si
    loop @@ciclo 

    mov ax, di
    
@@retorno:
      pop di
    pop dx
endm 
macro valC dx 
local @@hex,@@retorno

    cmp dx, '9'
    ja @@hex
    sub dx, '0'
    jmp @@retorno
    
@@hex:
    sub dx, 55d
    
@@retorno:
    
endm 
 ;-------------------------------------------------------------------------------------------------
    MACRO write   char
        PUSH    AX
        MOV     AL, char
        MOV     AH, 0Eh
        INT     10h     
        POP     AX
ENDM
macro DEFINE_PRINT_NUM_UNS
LOCAL begin_print, calc, skip, print_zero, end_print, ten
LOCAL skip_proc_print_num_uns


; protect from wrong definition location:
JMP     skip_proc_print_num_uns
PROC  PRINT_NUM_UNS   
        PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX

        ; flag to prevent printing zeros before number:
        MOV     CX, 1

        ; (result of "/ 10000" is always less or equal to 9).
        MOV     BX, 10000       ; 2710h - divider.

        ; AX is zero?
        CMP     AX, 0
        JZ      print_zero

begin_print:

        ; check divider (if zero go to end_print):
        CMP     BX,0
        JZ      end_print

        ; avoid printing zeros before number:
        CMP     CX, 0
        JE      calc
        ; if AX<BX then result of DIV will be zero:
        CMP     AX, BX
        JB      skip
calc:
        MOV     CX, 0   ; set flag.

        MOV     DX, 0
        DIV     BX      ; AX = DX:AX / BX   (DX=remainder).

        ; print last digit
        ; AH is always ZERO, so it's ignored
        ADD     AL, 30h    ; convert to ASCII code.
        write   AL


        MOV     AX, DX  ; get remainder from last div.

skip:
        ; calculate BX=BX/10
        PUSH    AX
        MOV     DX, 0
        MOV     AX, BX
        DIV     [CS:ten]  ; AX = DX:AX / 10   (DX=remainder).
        MOV     BX, AX
        POP     AX

        JMP     begin_print
        
print_zero:
        write    '0'
        
end_print:

        POP     DX
        POP     CX
        POP     BX
        POP     AX
        RET
ten             DW      10      ; used as divider.
 
  ENDP PRINT_NUM_UNS 
  skip_proc_print_num_uns:
  ENDM

      MACRO DEFINE_SCAN_NUM   
LOCAL make_minus, ten, next_digit, set_minus
LOCAL too_big, backspace_checked, too_big2
LOCAL stop_input, not_minus, skip_proc_scan_num
LOCAL remove_not_digit, ok_AE_0, ok_digit, not_cr

; protect from wrong definition location:
JMP     skip_proc_scan_num

       PROC  SCAN_NUM   NEAR
        PUSH    DX
        PUSH    AX
        PUSH    SI
        
        MOV     CX, 0

        ; reset flag:
        MOV    [ CS:make_minus], 0

next_digit:

        ; get char from keyboard
        ; into AL:
        MOV     AH, 00h
        INT     16h
        ; and print it:
        MOV     AH, 0Eh
        INT     10h

        ; check for MINUS:
        CMP     AL, '-'
        JE      set_minus

        ; check for ENTER key:
        CMP     AL, 13  ; carriage return?
        JNE     not_cr
        JMP     stop_input
not_cr:


        CMP     AL, 8                   ; 'BACKSPACE' pressed?
        JNE     backspace_checked
        MOV     DX, 0                   ; remove last digit by
        MOV     AX, CX                  ; division:
        DIV     CS:ten                  ; AX = DX:AX / 10 (DX-rem).
        MOV     CX, AX
        write   ' '                     ; clear position.
        write   8                       ; backspace again.
        JMP     next_digit
backspace_checked:


        ; allow only digits:
        CMP     AL, '0'
        JAE     ok_AE_0
        JMP     remove_not_digit
ok_AE_0:        
        CMP     AL, '9'
        JBE     ok_digit
remove_not_digit:       
        write   8       ; backspace.
        write   ' '     ; clear last entered not digit.
        write    8       ; backspace again.        
        JMP     next_digit ; wait for next input.       
ok_digit:


        ; multiply CX by 10 (first time the result is zero)
        PUSH    AX
        MOV     AX, CX
        MUL     CS:ten                  ; DX:AX = AX*10
        MOV     CX, AX
        POP     AX

        ; check if the number is too big
        ; (result should be 16 bits)
        CMP     DX, 0
        JNE     too_big

        ; convert from ASCII code:
        SUB     AL, 30h

        ; add AL to CX:
        MOV     AH, 0
        MOV     DX, CX      ; backup, in case the result will be too big.
        ADD     CX, AX
        JC      too_big2    ; jump if the number is too big.

        JMP     next_digit

set_minus:
        MOV     CS:make_minus, 1
        JMP     next_digit

too_big2:
        MOV     CX, DX      ; restore the backuped value before add.
        MOV     DX, 0       ; DX was zero before backup!
too_big:
        MOV     AX, CX
        DIV     CS:ten  ; reverse last DX:AX = AX*10, make AX = DX:AX / 10
        MOV     CX, AX
        write    8       ; backspace.
        write   ' '     ; clear last entered digit.
        write    8       ; backspace again.        
        JMP     next_digit ; wait for Enter/Backspace.
        
        
stop_input:
        ; check flag:
        CMP     CS:make_minus, 0
        JE      not_minus
        NEG     CX
not_minus:

        POP     SI
        POP     AX
        POP     DX
        RET
make_minus      DB      ?       ; used as a flag.
ten             DW      10      ; used as multiplier.
    ENDP SCAN_NUM    

skip_proc_scan_num:
     ENDM
;-------------------------------------------------------------------------------------------------
;*********************
;**********************************************************
; ASTRCMP
; Este procedimiento compara dos cadenas
; lexicograficamente.
; Parámetros:
; SI = cadena1
; DI = cadena2
; Regresa:
; AX = 0 si cadena1 == cadena2
; = (+) si cadena1 > cadena2
; = (-) si cadena1 < cadena2
;**********************************************************
macro astrcmp cad1,cad2
mov si,offset cad1 
mov di,offset cad2 

cld ; Autoincrementa SI, DI
@@whi: cmp [byte si], 0 ; while([SI] != 0)
je @@fin ; {
cmpsb ; if([SI++] != [DI++])
jne @@endwhi ; break
jmp @@whi ; }
@@endwhi:
dec si ; SI--
dec di ; DI--
@@fin: mov al, [byte si] ; AX = [SI] - [DI]
sub al, [byte di]
cbw


endm 
 ;-------------------------------------------------------------------------------------------------
 MACRO printf   sdat
LOCAL   next_char, s_dcl, printed, skip_dcl

PUSH    AX      ; store registers...
PUSH    SI      ;

JMP     skip_dcl        ; skip declaration.
        s_dcl DB sdat, 0

skip_dcl:
        LEA     SI, [s_dcl]
        
next_char:      
        MOV     AL, [CS:[SI]]
        CMP     AL, 0
        JZ      printed
        INC     SI
        MOV     AH, 0Eh ; teletype function.
        INT     10h
        JMP     next_char
printed:

POP     SI      ; re-store registers...
POP     AX      ;
ENDM

  MACRO PRINTLN   sdat
LOCAL   next_char, s_dcl, printed, skip_dcl

PUSH    AX      ; store registers...
PUSH    SI      ;

JMP     skip_dcl        ; skip declaration.
        s_dcl DB sdat, 13, 10, 0

skip_dcl:
        LEA     SI, [s_dcl]
        
next_char:      
        MOV     AL,[ CS:[SI]]
        CMP     AL, 0
        JZ      printed
        INC     SI
        MOV     AH, 0Eh ; teletype function.
        INT     10h
        JMP     next_char
printed:

POP     SI      ; re-store registers...
POP     AX      ;
ENDM

       MACRO DEFINE_PRINT_NUM 
LOCAL not_zero, positive, printed, skip_proc_print_num
DEFINE_PRINT_NUM_UNS 
; protect from wrong definition location:
JMP     skip_proc_print_num

   PROC  PRINT_NUM      NEAR
        PUSH    DX
        PUSH    AX

        CMP     AX, 0
        JNZ     not_zero

        write    '0'
        JMP     printed

not_zero:
        ; the check SIGN of AX,
        ; make absolute if it's negative:
        CMP     AX, 0
        JNS     positive
        NEG     AX

        write   '-'

positive:
        CALL    PRINT_NUM_UNS
printed:
        POP     AX
        POP     DX
        RET
  ENDP PRINT_NUM     

skip_proc_print_num:
      ENDM
macro CrearArchivo nombre
local salir
mov ah,3ch ;instrucción para crear el archivo.
mov cx,0
mov dx,offset nombre ;crea el archivo con el nombre archivo2.txt indicado indicado en la parte .data
int 21h
jc salir ;si no se pudo crear el archivo arroja un error, se captura con jc.
printf "El archivo "
print nombre 
printf " Se ha creado exitosamente!"
mov bx,ax
mov ah,3eh ;cierra el archivo
int 21h
salir:
endm


macro ModificarArchivo nombre,vec 
local pedir,salir,editar

pedir:
 mov ah,01h 
 int 21h 


 mov [vec+si],al
 inc si 

 cmp al,0dh 
 je editar
 cmp al,8 
 je borrar 
 jmp pedir
 borrar:
 dec si 
 mov [vec+si],0
 jmp pedir

editar:
;abrir el archivo
mov ah,3dh
mov al,1h ;Abrimos el archivo en solo escritura.
mov dx,offset nombre
int 21h
jc salir ;Si hubo error

;Escritura de archivo
mov bx,ax ; mover hadfile
mov cx,si ;num de caracteres a grabar
lea dx,[vec]
mov ah,40h
int 21h
cmp cx,ax
jne salir ;error salir
mov ah,3eh  ;Cierre de archivo
int 21h

salir:
endm

macro EliminarArchivo nombre
local eliminar
eliminar:
mov ah,41h
mov dx, offset nombre
int 21h 
jc salir ;Si hubo error

endm

       MACRO  CURSORON 
        PUSH    AX
        PUSH    CX
        MOV     AH, 1
        MOV     CH, 08h
        MOV     CL, 09h
        INT     10h
        POP     CX
        POP     AX
ENDM

; turns off the cursor:
    MACRO CURSOROFF   
        PUSH    AX
        PUSH    CX
        MOV     AH, 1
        MOV     CH, 28h
        MOV     CL, 09h
        INT     10h
        POP     CX
        POP     AX
ENDM
macro PrintDateTime

local day,year,month,hour,min,seconds
XOR AX,AX
MOV AH,2AH
INT 21H
mov [ byte day],dl 
mov [year],cx 
mov [ byte month],dh 

MOV AH,2CH
INT 21H
mov [byte hour],ch
mov [byte min],cl
mov [byte seconds],dh

printf "La Fecha Actual es:"
BCDnum day
write "/"
BCDnum month
write "/"
mov ax,[year]
call PRINT_NUM_UNS

write " "
BCDnum hour 
write ":"
BCDnum min
write ":"
BCDnum seconds
println ""
endm

macro BCDnum num 

mov ax,[num] 
AAM 
mov bx,ax 
mov ah,02h
mov dl,bh
add dl,30h
int 21h
mov ah,02h
mov dl,bl
add dl,30h
int 21h

endm


macro astrcat cad,cad2
push ax ; Preserva AX, SI, DI
push si
push di
mov di,offset cad 
mov si,offset cad2
xor al, al ; AL = 0
cld ;
@@whi: scasb ; while([DI++]);
jnz @@whi
dec di ; DI--
@@do: ; do
; {
lodsb ; AL = [SI++])
stosb ; [DI++] = AL
cmp al, 0 ; }
jne @@do ; while(AL != 0)
@@fin: pop di ; Restaura DI, SI, AX
pop si
pop ax
endm astrcat
