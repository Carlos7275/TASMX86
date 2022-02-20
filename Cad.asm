ideal 
dosseg 
model small
stack 
dataseg 
cadena db 81 dup(?),"$"
cadena3 db " Me gustas",0,"$"
cadena2 db "Carlos",0,"$"
codeseg 

inicio:
mov ax,@data 
mov ds,ax 
mov es,ax



mov di,offset cadena 
mov si,offset cadena2
call astrcat

mov di,offset cadena 
mov si,offset cadena3
call astrcat

mov ah,09h 
lea dx,[cadena]
int 21h
salir:
mov ah,4ch
mov al,0h 
int 21h

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

end inicio