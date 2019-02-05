%include 'function.asm'
section .data
	msg1:db 'Enter first number: ',0h
	msg2:db 'Enter second number: ',0h
section .bss
	numb1:	resb 10
	size1:	resb 10
	numb2:	resb 10
	size2:	resb 10
	a1:	resb 10
	a2:	resb 10
section .text
global _start:
_start:
	mov eax, msg1
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx, numb1
	mov edx, size1
	call sys
	
	mov eax, msg2
	call sprintf

	mov eax, 3
	mov ebx, 0
	mov ecx, numb2
	mov edx, size2
	call sys

	mov esi,numb1
	call atoi
	mov [a1], eax
	xor eax,eax
	mov esi,numb2
	call atoi
	mov [a2], eax
	
	mov eax,[a1]
	mov ebx,[a2]
	add eax,ebx
	
	call iprintf
	call breakline

	call quit
