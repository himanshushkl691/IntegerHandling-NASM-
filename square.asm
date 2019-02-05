%include 'function.asm'

square:
	imul eax
	ret

section .data
	msg1:db	'Enter number: ',0h
	msg2:db	'Square of number: ',0h
section .bss
	n1:	resb	10
	l1:	resb 	10
	a1:	resb	10
	a2	resb	10
section .text
global _start
_start:
	mov eax,msg1
	call sprintf

	mov eax, 3	
	mov ebx, 0
	mov ecx, n1
	mov edx, l1
	call sys

	mov esi,n1
	call atoi
	call square
	mov [a1],eax

	mov eax,msg2
	call sprintf
	
	mov eax,[a1]
	call iprintf
	call breakline

	call quit
