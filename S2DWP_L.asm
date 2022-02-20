
 ideal
 dosseg
 model large
;****** CODIGO DEL PROGRAMA *********************************
 codeseg
 public _s2dw
;****** PROCEDIMIENTOS ***
proc _s2dw
 push bp ; Preserva BP
 mov bp, sp
 mov ax, [bp+6] ; suma = dato1
 mov dx, [bp+8]
 add ax, [bp+10] ; suma += dato2
 adc dx, [bp+12]
 pop bp ; Restaura BP
 ret ; return suma
endp _s2dw
;****** CODIGO DE TERMINACION *******************************
 end