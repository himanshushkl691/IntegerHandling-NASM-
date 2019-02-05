%include 'function.asm'
section .data
	msg1:db	'Enter n: ',0h
section .bss
	n1:	resb	10
	l1:	resb	10
	a1:	resb	10
section .text:
global _start:
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

	xor ecx,ecx
	print_n:
		cmp ecx,eax
		je exit
		push eax
		mov eax,ecx
		call iprintf
		call breakline
		pop eax
		inc ecx
		jmp print_n
	exit:
		call quit
