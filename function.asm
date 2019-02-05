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
		ret

;integer to string
;integer in EAX
iprintf:
	push edx
	push ecx
	push ebx
	push eax	
	push esi
	sub ecx,ecx
	sub esi,esi
	count_digit:
		inc ecx
		mov edx, 0
		mov esi, 10
		idiv esi
		add edx, 48
		push edx
		cmp eax, 0
		jnz count_digit
	print_digit:
		dec ecx
		mov eax,esp
		call sprintf
		pop eax
		cmp ecx,0
		jnz print_digit
	pop esi
	pop eax
	pop ebx
	pop ecx
	pop edx
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
