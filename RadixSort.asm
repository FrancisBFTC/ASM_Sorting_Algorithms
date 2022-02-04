; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; ***** FUNÇOES DE ORDENAÇÃO EM SISTEMA BOOTÁVEL *****

; Ordenação por RADIXSORT

; O Radix sort é um algoritmo de ordenação rápido e estável que pode ser usado para ordenar itens que estão identificados por chaves únicas.
; Cada chave é uma cadeia de caracteres ou número, e o radix sort ordena estas chaves em qualquer ordem relacionada com a lexicografia.
; Na ciência da computação, radix sort é um algoritmo de ordenação que ordena inteiros processando dígitos individuais. Como os inteiros
; podem representar strings compostas de caracteres (como nomes ou datas) e pontos flutuantes especialmente formatados, radix sort não é 
; limitado somente a inteiros. 
; O algoritmo de ordenação radix sort foi originalmente usado para ordenar cartões perfurados. Um algoritmo computacional para o 
; radix sort foi inventado em 1954 no MIT por Harold H. Seward.

; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%INCLUDE "Library/Sort/vars.asm"

b 		dd b1     ; Ponteiro para vetor
major 	dd 0
exp 	dd 1
bucket 	times 10 dd 0
b1 		times 15 dd 0

; --------------------------------------------------------------------------------------------------------------------------
; ARGUMENTOS DA ROTINA RADIXSORT -------------------------------------------------------------------------------------------
; IN:  ECX = Tamanho do Vetor
;      ESI = Endereço do Vetor
;
; OUT: Nenhum.
; --------------------------------------------------------------------------------------------------------------------------
RadixSort:                                 ; Label que será chamada por instrução CALL
	pushad                                 ; Armazene todos os registradores na pilha
	
	; Conferido
	mov 	dword[i], 0
	mov 	eax, dword[esi + 0]
	mov 	dword[major], eax
	mov 	dword[exp], 1
	
	;mov 	ebx, 4
	;call 	Calloc
	;mov 	dword[b], eax
	
	; Primeiro FOR (Conferido)
	push 	ecx
	loop_for_rad1:
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	ebx, dword[esi + ebx]
		cmp 	ebx, dword[major]
		jbe 	return_loopfor_rad1
		mov 	dword[major], ebx
	return_loopfor_rad1:
		inc 	dword[i]
		loop 	loop_for_rad1
	pop 	ecx
	
	; Loop while principal externo (Conferido)
	loop_while_rad1:
		xor 	edx, edx
		mov 	eax, dword[major]
		mov 	ebx, dword[exp]
		div 	ebx
		cmp 	eax, 0
		jna 	ReturnRadix
	
	; Inicializa vetor bucket (Conferido)
		mov 	edi, bucket
		push 	ecx
		push 	edi
		mov 	ecx, 10
		mov 	eax, 0
		rep 	stosd
		pop 	edi
		pop 	ecx
		
	; 1ª loop for (Conferido)
	;for(i = 0; i < size; i++)               ; Confere
;			bucket[(vector[i] / exp) % 10]++;   ; Confere
		mov 	dword[i], 0
		;push 	ecx
	loop_rad1:
		cmp 	dword[i], ecx
		jnb 	init_loop2
		xor 	edx, edx
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	eax, dword[esi + ebx]
		mov 	ebx, dword[exp]
		div 	ebx
		xor 	edx, edx
		mov 	ebx, 10
		div 	ebx
		mov 	ebx, edx
		shl 	ebx, 2
		inc 	dword[edi + ebx]
		inc 	dword[i]
		jmp 	loop_rad1
		;loop 	loop_rad1
		;pop 	ecx
		
	; 2ª loop for (Conferido)
	;		for(i = 1; i < 10; i++)           ; Confere
;			bucket[i] += bucket[i - 1];   ; Confere
	init_loop2:
		mov 	dword[i], 1
		;push 	ecx
		;mov 	ecx, 10
	loop_rad2:
		cmp 	dword[i], 10
		jnb  	init_loop3
		mov 	ebx, dword[i]
		push 	ebx
		sub 	ebx, 1
		shl 	ebx, 2
		mov 	eax, dword[edi + ebx]
		;add 	ebx, 4
		pop 	ebx
		shl 	ebx, 2
		add 	dword[edi + ebx], eax
		inc 	dword[i]
		;loop 	loop_rad2
		jmp 	loop_rad2
		;pop 	ecx
		
	init_loop3:
	; 3ª loop for (Conferido)
	;		for(i = size - 1; i >= 0; i--)                        ; Confere
;			b[--bucket[(vector[i] / exp) % 10]] = vector[i];  ; Confere
		mov 	dword[i], ecx
		sub 	dword[i], 1
	loop_rad3:
		cmp 	dword[i], 0xFFFFFFFF
		je	 	last_loop
		
		;b[--bucket[(vector[i] / exp) % 10]] = vector[i];
		mov 	edi, bucket
		xor 	edx, edx
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	eax, dword[esi + ebx]
		mov 	ebx, dword[exp]
		div 	ebx
		xor 	edx, edx
		mov 	ebx, 10
		div 	ebx
		mov 	ebx, edx
		shl 	ebx, 2
		sub		dword[edi + ebx], 1
		mov 	ebx, dword[edi + ebx]
		shl 	ebx, 2
		push 	ebx
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	eax, dword[esi + ebx]
		pop 	ebx
		mov 	edi, dword[b]
		mov 	dword[es:edi + ebx], eax
		
		dec 	dword[i]
		jmp 	loop_rad3
		
	; 4ª loop for (Conferido)
	;		for(i = 0; i < size; i++)  ; Confere
;			vector[i] = b[i];      ; Confere
	last_loop:
		mov 	dword[i], 0
		;push 	ecx
	loop_rad4:
		cmp 	dword[i], ecx
		jnb 	return_while_rad1
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	edi, dword[b]
		mov 	eax, dword[es:edi + ebx]
		mov 	dword[esi + ebx], eax
		inc 	dword[i]
		;loop 	loop_rad4
		jmp 	loop_rad4
		;pop 	ecx
	
	; Retorno ao ínicio do while externo (Conferido)
	return_while_rad1:
		xor 	edx, edx
		mov 	eax, dword[exp]
		mov 	ebx, 10
		mul 	ebx
		mov 	dword[exp], eax
		jmp 	loop_while_rad1
		
ReturnRadix:
	;mov 	ebx, b
	;call 	Free
	
	popad                                  ; Restaure todos os registradores da pilha
ret                                        ; Retorne para a chamada da instrução CALL
; --------------------------------------------------------------------------------------------------------------------------


;void RadixSort(int vector[], int size){
;	int i;                          ; Confere
;	int *b;                         ; Confere
;	int major = vector[0];          ; Confere
;	int exp = 1;                    ; Confere
;	
;	b = (int *) calloc(size, sizeof(int));   ; Confere
;	
;	for(i = 0; i < size; i++)    ; Confere
;		if(vector[i] > major)    ; Confere
;			major = vector[i];   ; Confere
;	
;	while((major / exp) > 0){    ; Confere
;		int bucket[10] = { 0 };  ; Confere
;		
;		for(i = 0; i < size; i++)               ; Confere
;			bucket[(vector[i] / exp) % 10]++;   ; Confere
;			
;		for(i = 1; i < 10; i++)           ; Confere
;			bucket[i] += bucket[i - 1];   ; Confere
;			
;		for(i = size - 1; i >= 0; i--)                        ; Confere
;			b[--bucket[(vector[i] / exp) % 10]] = vector[i];  ; Confere
;			
;		for(i = 0; i < size; i++)  ; Confere
;			vector[i] = b[i];      ; Confere
;		
;		exp *= 10;                 ; Confere
;	}
;	
;	free(b);
;}


; ***** FIM DAS FUNÇOES DE ORDENAÇÃO *****
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++