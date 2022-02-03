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

b 		dd 0x00000000    ; Ponteiro para vetor
major 	dd 0
exp 	dd 1
bucket 	times 10 dd 0

; --------------------------------------------------------------------------------------------------------------------------
; ARGUMENTOS DA ROTINA RADIXSORT -------------------------------------------------------------------------------------------
; IN:  ECX = Tamanho do Vetor
;      ESI = Endereço do Vetor
;
; OUT: Nenhum.
; --------------------------------------------------------------------------------------------------------------------------
RadixSort:                                 ; Label que será chamada por instrução CALL
	pushad                                 ; Armazene todos os registradores na pilha
	
	mov 	dword[i], 0
	mov 	eax, dword[esi + 0]
	mov 	dword[major], eax
	mov 	dword[exp], 1
	
	mov 	ebx, 4
	call 	Calloc
	mov 	dword[b], eax
	
	; Primeiro FOR
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
	
	; Loop while principal externo
	loop_while_rad1:
		xor 	edx, edx
		mov 	eax, dword[major]
		mov 	ebx, dword[exp]
		div 	ebx
		cmp 	eax, 0
		jbe 	ReturnRadix
		
	; Inicializa vetor bucket (talvez apague)
		push 	ecx
		mov 	ecx, 10
		xor 	ebx, ebx
	Init_Bucket:
		mov 	dword[bucket + ebx], 0
		inc 	ebx
		loop 	Init_Bucket
		pop 	ecx
		
	; 1ª loop for
		mov 	dword[i], 0
		push 	ecx
	loop_rad1:
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	eax, dword[esi + ebx]
		div 	dword[exp]
		xor 	edx, edx
		mov 	ebx, 10
		div 	ebx
		mov 	ebx, edx
		shl 	ebx, 2
		inc 	dword[bucket + ebx]
		inc 	dword[i]
		loop 	loop_rad1
		pop 	ecx
		
	; 2ª loop for
		mov 	dword[i], 1
		push 	ecx
		mov 	ecx, 10
	loop_rad2:
		mov 	ebx, dword[i]
		sub 	ebx, 1
		shl 	ebx, 2
		mov 	eax, dword[bucket + ebx]
		add 	ebx, 1
		add 	dword[bucket + ebx], eax
		inc 	dword[i]
		loop 	loop_rad2
		pop 	ecx
		
	; 3ª loop for
		mov 	dword[i], ecx
		sub 	dword[i], 1
		mov 	edi, dword[b]
	loop_rad3:
		cmp 	dword[i], 0
		jnae 	loop_rad4
		
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	eax, dword[esi + ebx]
		div 	dword[exp]
		xor 	edx, edx
		mov 	ebx, 10
		div 	ebx
		mov 	ebx, edx
		shl 	ebx, 2
		sub		dword[bucket + ebx], 1
		mov 	ebx, dword[bucket + ebx]
		shl 	ebx, 2
		push 	ebx
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	eax, dword[esi + ebx]
		pop 	ebx
		mov 	dword[edi + ebx], eax
		
		dec 	dword[i]
		jmp 	loop_rad3
		
	; 4ª loop for
		mov 	dword[i], 0
		push 	ecx
	loop_rad4:
		mov 	ebx, dword[i]
		shl 	ebx, 2
		mov 	eax, dword[edi + ebx]
		mov 	dword[esi + ebx], eax
		inc 	dword[i]
		loop 	loop_rad4
		pop 	ecx
	
	; Retorno ao ínicio do while externo
	return_while_rad1:
		xor 	edx, edx
		mov 	eax, dword[exp]
		mov 	ebx, 10
		mul 	ebx
		mov 	dword[exp], eax
		jmp 	loop_while_rad1
		
ReturnRadix:
	mov 	ebx, b
	call 	Free
	
	popad                                  ; Restaure todos os registradores da pilha
ret                                        ; Retorne para a chamada da instrução CALL
; --------------------------------------------------------------------------------------------------------------------------


;void RadixSort(int vector[], int size){
;	int i;
;	int *b; 
;	int major = vector[0];
;	int exp = 1;
;	
;	b = (int *) calloc(size, sizeof(int));
;	
;	for(i = 0; i < size; i++)
;		if(vector[i] > major)
;			major = vector[i];
;	
;	while((major / exp) > 0){
;		int bucket[10] = { 0 };
;		
;		for(i = 0; i < size; i++)
;			bucket[(vector[i] / exp) % 10]++;
;			
;		for(i = 1; i < 10; i++)
;			bucket[i] += bucket[i - 1];
;			
;		for(i = size - 1; i >= 0; i--)
;			b[--bucket[(vector[i] / exp) % 10]] = vector[i];
;			
;		for(i = 0; i < size; i++)
;			vector[i] = b[i];
;		
;		exp *= 10;
;	}
;	
;	free(b);
;}


; ***** FIM DAS FUNÇOES DE ORDENAÇÃO *****
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++