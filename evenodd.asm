%include 'function.asm'
section .data
	msg1:db	'Enter a number: ',0h
	even_nu:db 'Even!!!',0h
	odd_nu:db 'Odd!!!',0h
section .bss
	n1:	resb 10
	l1:	resb 10
	a1:	resb 10
	rem:	resb 4
section .text
global _start:
_start:
	mov eax, msg1
	call sprintf
	
	mov eax, 3
	mov ebx, 0
	mov ecx, n1
	mov edx, l1
	call sys
	
	mov esi,n1
	call atoi
	mov [a1],eax
	
	xor edx,edx
	mov eax,[a1]
	mov edi,2
	idiv edi
	cmp edx,0
	je even
	odd:
		mov eax,odd_nu
		call sprintfLF
		jmp exit
	even:
		mov eax,even_nu
		call sprintfLF
		jmp exit
	exit:
		call quit
