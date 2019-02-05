%include 'function.asm'

isMultiple:
	;x in eax
	;y in ebx
	push edi
	push eax
	push ebx
	push ecx
	xor edx,edx
	mov edi, ebx
	div	edi
	cmp edx,0
	je .true
	jmp .false
	.true:
		mov eax,msg3
		call sprintfLF
		jmp exit
	.false:
		mov eax,msg4
		call sprintfLF
		jmp exit
	exit:
		pop ecx
		pop ebx
		pop eax
		pop edi
		ret

section .data
	msg1:db	'Enter first number: ',0h
	msg2:db 'Enter second number: ',0h
	msg3:db	'YES',0h
	msg4:db	'NO',0h
section .bss
	n1:	resb	10
	l1:	resb	10
	n2:	resb 	10
	l2:	resb	10
	a1:	resb	10
	a2:	resb	10
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

	mov eax,msg2
	call sprintf
		
	mov eax, 3
	mov ebx, 0
	mov ecx, n2
	mov edx, l2
	call sys
	
	mov esi, n1
	call atoi
	mov [a1],eax
	
	xor eax,eax
	mov esi, n2
	call atoi
	mov [a2], eax
	
	mov eax,[a1]
	mov ebx,[a2]
	call isMultiple

	call quit

	
