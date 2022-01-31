; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; FUNÇÕES DE ORDENAÇÃO

; Ordenação por Seleção
;
; A ordenação por seleção ou selection sort consiste em selecionar o menor item e colocar 
; na primeira posição, selecionar o segundo menor item e colocar na segunda posição, segue 
; estes passos até que reste um único elemento. Para todos os casos (melhor, médio e pior caso) 
; possui complexidade C(n) = O(n²) e não é um algoritmo estável.

; MACRO EQUIVALENTE A:
;#define SSWAP(A, B) aux = A; A = B; B = aux;
;
%DEFINE SWAP(A,B) S_SWAP A,B

%MACRO S_SWAP 2 
	mov 	ebx, dword[%1]
	shl 	ebx, 2
	push 	ebx
	mov 	eax, dword[esi + ebx]
	mov 	ebx, dword[%2]
	shl 	ebx, 2
	mov 	edx, dword[esi + ebx]
	mov 	dword[esi + ebx], eax
	pop 	ebx
	mov 	dword[esi + ebx], edx
%ENDMACRO

minor dd 0

SelectionSort:
	pushad
	mov 	dword[i], 0
	mov 	dword[j], 0
	mov 	dword[minor], 0
	init_for1_Sel:
		mov 	ebx, dword[i]
		push 	ecx
		sub 	ecx, 1
		cmp 	ebx, ecx
		jb 		loop_for1_Sel
		pop 	ecx
		jmp 	return_Sel
	loop_for1_Sel:
		pop 	ecx
		mov 	dword[minor], ebx
	init_for2_Sel:
		mov 	dword[j], ebx
		add 	dword[j], 1
	loop_for2_Sel:
		cmp 	dword[j], ecx
		jb 		loop_for2_Sel1
		jmp 	return_for1_Sel
	loop_for2_Sel1:
		shl 	ebx, 2
		mov 	eax, dword[esi + ebx]
		mov 	ebx, dword[j]
		shl 	ebx, 2
		mov 	edx, dword[esi + ebx]
		cmp 	edx, eax
		jb 		select_minor
		jmp 	return_for2_Sel
	return_for1_Sel:
		SWAP 	(minor, i)
		inc 	dword[i]
		cmp 	ecx, 0
		jnz 	init_for1_Sel
	return_for2_Sel:
		inc 	dword[j]
		mov 	ebx, dword[minor]
		jmp 	loop_for2_Sel
	select_minor:
		mov 	ebx, dword[j]
		mov 	dword[minor], ebx
		jmp 	return_for2_Sel
return_Sel:
	popad
ret

; EQUIVALENTE LINGUAGEM C
;#define SSWAP(A, B) aux = A; A = B; B = aux;

;void SelectionSort (int vector[], int size){
;    int i, j, minor, aux;                           // Declara as variáveis
;    for (i = 0; i < size-1; i++){                   // Laço externo que começa na 1ª posição
;        minor = i;                                  // seleciona o (1ª ou 2ª ou ... Nª) índice atual
;        for (j = i+1; j < size; j++){               // Laço interno que percorre todo o array começando pelo índice após o selecionado
;            if (vector[j] < vector[minor])          // Se o item atual for menor que o item na Nª posição selecionada (índice atual)
;               minor = j;                           // Redefine a variável "menor" para o índice com o menor item
;        }                                           // Itera no laço interno até que o índice seja igual ao tamanho do array
;        SSWAP(vector[minor], vector[i]);            // Faz a troca do menor valor selecionado com a Nª posição selecionada
;    }
;}

; ***** FIM DAS FUNÇOES DE ORDENAÇÃO ***** */
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++