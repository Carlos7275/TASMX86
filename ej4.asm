ideal 
dosseg 
include "IO.inc"
model small
stack 256 
dataseg 
stri1 db 81 dup(?)
stri2 db 81 dup(?)
strres db 81 dup(?)
n1 dw ?
n2 dw ?
n3 dw ?
codeseg
inicio: 
Initialize
clrscr
scan stri1
scan stri2 

aatoi stri1,n1
aatoi stri2,n2

suma n1,n2,n3 
aitoa strres,n3
print strres 
write " "
resta n1,n2,n3 
aitoa strres,n3
print strres
write " "
multi n1,n2,n3 
aitoa strres,n3
print strres
write " "

divi n1,n2,n3 
aitoa strres,n3
print strres
write " "

salir:
EXIT_PROGRAM
end inicio