ideal
dosseg
model small
;****** CODIGO DEL PROGRAMA *******************************
codeseg
public astrcat, astrcmp
;****** PROCEDIMIENTOS ************************************
;**********************************************************
; ASTRCAT
; Este procedimiento concatena dos cadenas.
; Parámetros:
; DI = cadena1
; SI = cadena2
; Regresa:
; DI = cadena1 + cadena2
; SI = cadena2
;**********************************************************
proc astrcat
push ax ; Preserva AX, SI, DI
push si
push di
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
ret
endp astrcat
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
proc astrcmp
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
ret
endp astrcmp
;****** CODIGO DE TERMINACION *****************************
end