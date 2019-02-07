;void sys()
sys:
	int 80h
	ret
	
;void quit()
quit:
	mov eax,1
	mov ebx,0
	call sys
	ret

br:	db 0ah
;breakline
breakline:
	push eax
	push ebx
	push ecx
	push edx
	mov eax, 4
	mov ebx, 1
	mov ecx, br
	mov edx, 1
	call sys
	pop edx
	pop ecx
	pop ebx
	pop eax
	ret

;int strlen(char *str)
;string in EAX
;length in EAX
strlen:
	push ebx
	mov ebx,eax
	;while(str[i] != '\n')
	.next_char:
		cmp byte[eax],0
		je .break
		inc eax
		jmp .next_char
	.break:
		sub eax,ebx
		pop ebx
		ret

;void sprintf(char *str)
;string in EAX
sprintf:
	push edx
	push ecx
	push ebx
	push eax
	call strlen
	
	mov edx, eax
	pop eax

	mov ecx, eax
	mov ebx, 1
	mov eax, 4
	call sys
	pop ebx
	pop ecx
	pop edx
	ret

;void sprintfLF(char *str)
;string in EAX
sprintfLF:
	call sprintf
	push eax
	mov eax,0ah
	push eax
	mov eax,esp
	call sprintf
	pop eax
	pop eax
	ret

;int str_to_int(char *str)
;string in ESI
;integer in EAX
atoi:
	push esi
	xor ebx,ebx	
	.loop:
		cmp byte[esi],0ah
		je .exit
		movzx eax,byte[esi]
		inc esi
		sub eax,48
		imul ebx,10
		add ebx,eax
		jmp .loop
	.exit:
		mov eax,ebx
		pop esi
		ret

;convert to signed or unsigned
;esi contains string
atosigned:
	push esi
	cmp byte[esi],45
	je sign
	unsign:
		call atoi
		jmp exit_u
	sign:
		inc esi
		call atoi
		not eax
		inc eax			;two's complement
		jmp exit_u
	exit_u:
		pop esi
		ret

;print integer
;n in eax
iprintf:
	push eax
	push ecx
	push edx
	push edi

	xor ecx,ecx
	cmp eax,0
	jne put_sign
	push eax
	mov eax,48
	push eax
	mov eax,esp
	call sprintf
	pop eax
	pop eax
	jmp break_print_digit
	
	put_sign:
	push eax
	shr eax,31
	and eax,1
	cmp eax,1
	pop eax
	jne .digit_loop
	push eax
	mov eax,45
	push eax
	mov eax,esp
	call sprintf
	pop eax
	pop eax
	not eax
	inc eax

	.digit_loop:
		cmp eax,0
		je .print_digit
		inc ecx
		xor edi,edi
		xor edx,edx
		mov edi,10
		idiv edi
		add edx,48
		push edx
		jmp .digit_loop
	.print_digit:
		cmp ecx,0
		je break_print_digit
		dec ecx
		mov eax,esp
		call sprintf
		pop edx
		jmp .print_digit
	break_print_digit:
		pop edi
		pop edx
		pop ecx
		pop eax
		ret


;maximum of two
;x in eax
;y in ebx
;max in ecx
max:
	push eax
	cmp eax,ebx
	jg greater
	jmp less
	greater:
		mov ecx,eax
		jmp exit
	less:
		mov ecx,ebx
		jmp exit
	exit:
		pop eax
		ret

;minimum of two
;x in eax
;y in ebx
;min in ecx
min:
	push eax
	cmp eax,ebx
	jg .less
	jmp .greater
	.less:
		mov ecx,eax
		jmp .exit
	.greater:
		mov ecx,ebx
		jmp .exit
	.exit:
		pop eax
		ret

;bool isDivisible(int a,int b) check if a%b == 0
;a in eax
;b in ebx
isDivisible:
	push eax
	push ebx
	xor edx,edx
	idiv ebx
	cmp edx,0
	je .y
	jmp .n
	.y:
		mov edx,1
		jmp .e
	.n:
		mov edx,0
		jmp .e
	.e:
		pop ebx
		pop eax
		ret

;bool isPrime(int n)
;n in eax
;ans in esi
isPrime:
	push edx
	push edi
	push eax
	push ebx
	mov esi,eax	;tmp = n
	xor edx,edx	;rem = 0
	mov edi,2
	idiv edi	;n = n/2
	mov ecx,eax	;h = n
	add ecx,1	;h = h + 1
	mov eax,esi	;n = tmp
	mov ebx,2	;i = 2
	.l:
		cmp ebx,ecx	;for (int i = 2;i < h;i++)
		je .break
		call isDivisible	;check if eax%ebx == 0
		cmp edx,1
		je not_prime
		inc ebx
		jmp .l
	.break:
		mov esi,1
		jmp return
	not_prime:
		mov esi,0
		jmp return	
	return:
		pop ebx
		pop eax
		pop edi
		pop edx
		ret
