%include 'function.asm'
section .data
	msg1:db	'Enter first number: ',0h
	msg2:db	'Enter second number: ',0h
	msg3:db	'Largest of two is: ',0h
section .bss
	tmp1:	resb 10
	size1:	resb 10
	tmp2:	resb 10
	size2:	resb 10
	a1:	resb 10
	a2:	resb 10
section .txt
global _start:
_start:
	mov eax, msg1
	call sprintf

	mov eax, 3
	mov ebx, 0
	mov ecx, tmp1
	mov edx, size1
	call sys
	
	mov eax, msg2
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx, tmp2
	mov edx, size2
	call sys

	mov esi,tmp1
	call atoi
	mov [a1],eax

	mov esi,tmp2
	call atoi
	mov [a2],eax

	mov eax,msg3
	call sprintf

	compare:
		mov eax,[a1]
		mov ebx,[a2]
		cmp eax,ebx
		jg greater
		je greater
		jmp less
		greater:
			mov eax,[a1]
			call iprintf
			call breakline
			jmp exit
		less:
			mov eax,[a2]
			call iprintf
			call breakline
			jmp exit
		exit:
			call quit
