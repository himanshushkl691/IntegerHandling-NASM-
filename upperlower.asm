%include 'function.asm'

isupper:
	xor eax,eax
	mov al,byte[esi]
	cmp al,90
	jna less_z
	jmp _exit	
	less_z:
		cmp al,65
		jnb greater_a
		jmp _exit
		greater_a:
			mov eax, 1
			jmp _exit
	_exit:
		ret

section .data
	msg1:db	'Enter a character: ',0h
	msg2:db	'UpperCase! ',0h
	msg3:db	'LowerCase! ',0h
section .bss
	n1:	resb	2
	l1:	resb	2
section .text
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
	call isupper
	
	cmp eax,1
	je upper
	jne lower
	upper:
		mov eax,msg2
		call sprintfLF
		jmp exit
	lower:
		mov eax,msg3
		call sprintfLF
		jmp exit
	exit:
		call quit
