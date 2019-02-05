%include 'function.asm'

section .data
	msg1:db	'Enter a number: ',0h
	msg2:db	'Its a prime',0h
	msg3:db	'Not a prime',0h
section .bss
	n1:	resb 	10
	l1:	resb	10
	a1:	resb	10
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
	
	call isPrime
	cmp esi,1
	je yes
	jmp no
	yes:
		mov eax,msg2
		call sprintfLF
		jmp finish
	no:
		mov eax,msg3
		call sprintfLF
		jmp finish
	finish:
		call quit
