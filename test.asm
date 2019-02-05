%include 'function.asm'
section .data
	msg1:db 'Himanshu Shukla',0ah
	msg2:db 'Iajksfbdkjf',0ah

section .bss
	numb0:	resb 8
	size:	resb 8
	numb1:	resb 8

section .text
global _start:
_start:
	mov eax, 3
	mov ebx, 0
	mov ecx, numb0
	mov edx, size
	int 80h

	mov esi,numb0
	call atoi
	mov [numb1],eax
	mov eax,[numb1]
	call iprintf
	call quit
