%include 'function.asm'

__gcd:
;a in eax
;b in ebx
	xor esi,esi
	xor edi,edi
	euclid:
		cmp ebx,0
		je exit
		xor edx,edx
		mov edi,ebx
		mov esi,ebx
		idiv edi
		xor eax,eax
		xor ebx,ebx
		mov eax,esi
		mov ebx,edx
		jmp euclid
	exit:
		mov ecx,eax
		ret

divide:
;eax/ebx
	mov edi,ebx
	div edi
	ret		

section .data
	msg1:db 'Enter first number: ',0h
	msg2:db 'Enter second number: ',0h
	msg3:db	'GCD of two number is: ',0h
section .bss
	n1:	resb 10
	n2:	resb 10
	size1:	resb 10
	size2:	resb 10
	a1:	resb 10
	a2:	resb 10
	ans:	resb 10
section .text
global _start:
_start:
	mov eax,msg1
	call sprintf

	mov eax, 3
	mov ebx, 0
	mov ecx, n1
	mov edx, size1
	call sys
	
	mov eax,msg2
	call sprintf

	mov eax, 3
	mov ebx, 0
	mov ecx, n2
	mov edx, size2
	call sys

	mov esi,n1
	call atoi
	mov [a1],eax

	mov esi,n2
	call atoi
	mov [a2],eax

	xor edx,edx
	mov eax,[a1]
	mov ebx,[a2]
	call __gcd
	mov [ans],ecx

	mov eax,msg3
	call sprintf
	
	mov eax,[ans]
	call iprintf
	call breakline
	
	call quit
