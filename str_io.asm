ideal
dosseg
model small

	codeseg
	public aputs, agets

proc aputs
	push ax
	push bx

	mov ah, 0Eh
	mov bh, 0

	cld

@@while:
	lodsb
	cmp	al, 0
	je @@endwhi

	int 10h
	jmp @@while

@@endwhi:
	pop bx
	pop ax
	ret

endp aputs

proc agets
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

	stosb
	jmp @@while

@@endwhi:
	mov [byte di], 0

	mov al, 10
	mov ah, 0Eh
	int 10h

	pop di
	pop bx
	pop ax

	ret

endp agets
	
	end