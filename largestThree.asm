%include 'function.asm'

section .data
	msg1:db	'Enter first number: ',0h
	msg2:db	'Enter second number: ',0h
	msg3:db	'Enter third number: ',0h
section .bss
	n1:	resb	10
	l1:	resb	10
	n2:	resb	10
	l2:	resb	10
	n3:	resb	10
	l3:	resb	10
	a1:	resb	10
	a2:	resb	10
	a3:	resb	10
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
	mov [a1],eax
	
	mov eax,msg2
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx, n2
	mov edx, l2
	call sys

	mov esi,n2
	call atoi
	mov [a2],eax

	mov eax, msg3
	call sprintf

	mov eax, 3
	mov ebx, 0
	mov ecx, n3
	mov edx, l3
	call sys

	mov esi,n3
	call atoi
	mov [a3],eax

	mov eax,[a1]
	mov ebx,[a2]
	call max
	mov eax,ecx

	mov ebx,[a3]
	call max
	mov eax,ecx

	call iprintf
	call breakline

	call quit
