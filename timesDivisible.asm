%include 'function.asm'

times_divisible:
	;n in eax
	;ans in ebx
	push eax
	push ebx
	push edi
	xor ebx,ebx
	xor edx,edx
	mov edi,2
	idiv edi
	.l:
		cmp edx,1
		je .e
		inc ebx
		idiv edi
		jmp .l
	.e:
		mov eax,ebx
		call iprintf
		call breakline
		pop edi
		pop ebx
		pop eax
		ret 

section .data
	msg1:db	'Enter a even number: ',0h
	msg2:db 'Number of times n is divisible by 2: ',0h
section .bss
	n1:	resb	10
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
	push eax
	mov eax,msg2
	call sprintf
	pop eax
	call times_divisible
	call quit	
