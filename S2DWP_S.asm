ideal
 dosseg
 model small
;****** CODIGO DEL PROGRAMA *********************************
 codeseg
 public _s2dw
;****** PROCEDIMIENTOS *****

proc _s2dw
 push bp ; Preserva BP
 mov bp, sp
 mov ax, [bp+4] ;
 mov dx, [bp+6]
 add ax, [bp+8] ; suma += dato2
 adc dx, [bp+10]
 pop bp ; Restaura BP
 ret ; return suma
endp _s2dw
;****** CODIGO DE TERMINACION *******************************
 end