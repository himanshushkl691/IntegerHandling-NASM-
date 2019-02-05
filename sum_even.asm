%include 'function.asm'

isEven:
	;x in eax
	push eax
	push ebx
	push ecx
	push esi
	push edi
	xor edx,edx
	mov edi,2
	idiv edi
	pop edi
	pop esi
	pop ecx
	pop ebx
	pop eax
	ret

sum_even:
	;n in ecx
	;sum in eax
	push esi
	push edx
	xor eax,eax  ;sum = 0
	.loop:
		cmp ecx,0   ;if (n == 0) .exit
		je .exit
		push ecx
		push eax
		mov eax,ecx
		call isEven
		mov eax,ecx
		mov esi,1
		sub esi,edx
		mov edx,esi
		mul edx     		;tmp = n * (1-isEven(n))
		mov ecx,eax
		pop eax
		add eax,ecx		;sum += tmp
		pop ecx
		dec ecx			;n--
		jmp .loop
	.exit:
		push eax
		mov eax,msg2
		call sprintf
		pop eax
		call iprintf
		call breakline
		pop edx
		pop esi
		ret

section .data
	msg1:db	'Enter number n: ',0h
	msg2:db	'Sum of even term is: ',0h
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
	mov ecx,eax

	call sum_even
	
	call quit
	
		
