; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; ***** FUNÇOES DE ORDENAÇÃO *****

; Ordenação por QUICKSORT
;
; O algoritmo quicksort é um método de ordenação muito rápido e eficiente, inventado por C.A.R. Hoare em 1960[1], 
; quando visitou a Universidade de Moscovo como estudante. Naquela época, Hoare trabalhou em um projeto de tradução 
; de máquina para o National Physical Laboratory. Ele criou o quicksort ao tentar traduzir um dicionário de inglês para russo, 
; ordenando as palavras, tendo como objetivo reduzir o problema original em subproblemas que possam ser resolvidos mais fácil e rápido.

; O quicksort é um algoritmo de ordenação por comparação não-estável. O quicksort adota a estratégia de divisão e conquista. A estratégia 
; consiste em rearranjar as chaves de modo que as chaves "menores" precedam as chaves "maiores". Em seguida o quicksort ordena as duas sublistas 
; de chaves menores e maiores recursivamente até que a lista completa se encontre ordenada.

pivo	dd 0
aux		dd 0

; EAX = BEGIN -> Índice Inicial
; ECX = END   -> Índice Final
; ESI = Endereço do Vetor
QuickSort:
	pushad                              ; Armazene todos os registradores na pilha
	mov 	dword[i], eax               ; Inicializando índice i com índice inicial
	;push 	ecx                         ; Salvando o índice final na pilha
	sub 	ecx, 1                      ; subtrai o índice final - 1
	mov 	dword[j], ecx               ; Inicializando índice j com índice final - 1
	;sub 	dword[j], 1
	;pop 	ecx                         ; Restaurando o índice final da pilha
	mov 	ebx, eax                    ; Mova o índice inicial para ebx
	add 	ebx, ecx                    ; Some o índice inicial com o índice final
	shr 	ebx, 1                      ; Divida o resultado por 2
	shl 	ebx, 2                      ; Com o índice em mãos, multiplique por 4 (4 bytes = 1 int)
	mov 	edx, dword[esi + ebx]       ; O índíce resultado de Vector em edx -> edx = Vector[(begin+end)/2]
	mov 	dword[pivo], edx            ; Inicialize a variável pivo com conteúdo do índice resultante do Vetor
	loop_while1:
		mov 	ebx, dword[j]           ; Mova o índice j para ebx 
		cmp 	dword[i], ebx           ; Compare o índice i com j
		jnbe    end_while1              ; Termine o ciclo do while externo se não for menor ou igual (se for maior)
	                                    ; A partir daqui referencia a condição while -> while(i <= j){...
		
	loop_while1.1:                          ; Label Identificadora do 1ª while interno
		first_cond1.1:                      ; Label da 1ª condição do 1ª while interno
			mov 	ebx, dword[i]           ; Mova o índice i para ebx
			shl 	ebx, 2                  ; Multiplique o índice por 4
			mov 	ebx, dword[esi + ebx]   ; Substitua ebx por Vector[i]
			cmp 	ebx, edx                ; Compare Vector[i] com pivo -> edx colocado antes do loop_while1
			jb 		second_cond1.1          ; Se atender a 1ª condição (Se for menor), vai para 2ª condição
			jmp 	loop_while1.2           ; Se não atender (Não ser menor), então inicie o 2ª while interno
		second_cond1.1:                     ; Label da 2ª condição do 1ª while interno
			cmp 	dword[i], ecx           ; Compare índice i com END (Índice Final)
			jb 		return_while1.1         ; Se for menor, Vai para o retorno do 1ª while interno para incrementar i
			jmp 	loop_while1.2           ; Se não for menor, inicie o 2ª while interno
		return_while1.1:                    ; Label de retorno do 1ª while interno com incremento de i
			inc 	dword[i]                ; Incremente o índice i
			jmp 	loop_while1.1           ; Retorne para o 1ª while interno
	loop_while1.2:                          ; Label Identificadora do 2ª while interno
		first_cond1.2:                      ; Label da 1ª condição do 2ª while interno
			mov 	ebx, dword[j]           ; Mova o índice j para ebx
			shl 	ebx, 2                  ; Multiplique o índice por 4
			mov 	ebx, dword[esi + ebx]   ; Substitua ebx por Vector[j]
			cmp 	ebx, edx                ; Compare Vector[j] com pivo -> edx colocado antes do loop_while1
			ja 		second_cond1.2          ; Se atender a 1ª condição (Se for MAIOR), vai para 2ª condição
			jmp 	first_cond_while1       ; Se não atender (Não ser MAIOR), Execute a 1ª condição	do while externo		
		second_cond1.2:                     ; Label da 2ª condição do 1ª while interno
			cmp 	dword[j], eax           ; Compare índice j com BEGIN (Índice Inicial)
			ja      return_while1.2         ; Se for maior, Vai pare o retorno do 2ª while interno para decrementar j
			jmp 	first_cond_while1       ; Se não for maior, inicie a 1ª condição do while externo
		return_while1.2:                    ; Label de retorno do 2ª while interno com decremento de j
			dec 	dword[j]                ; Decremente o índice j
			jmp 	loop_while1.2           ; Retorne para o 2ª while interno
			
	first_cond_while1:
		mov 	ebx, dword[j]           ; Mova índice j para ebx
		cmp 	dword[i], ebx           ; Compare índice i com índice j
		jnbe    end_while1              ; Termine o ciclo do while externo se não for menor ou igual (se for maior)
		                                ; A partir daqui referencia a condição if -> if(i <= j){...
		push 	eax                     ; Salve eax na pilha porque ele será alterado na Macro SWAP
		SWAP(i, j)                      ; Faça a troca de valores de Vector[i] com Vector[j]
		pop 	eax                     ; Restaure eax da pilha para usá-lo em breve
		inc 	dword[i]                ; Incremente i
		dec 	dword[j]                ; Decremente j
		jmp 	loop_while1             ; Retorne para o loop while externo
		
	end_while1:                         ; Label para fim do while externo
		cond1_tocall:                   ; Label da 1ª condição fora do while para chamada recursiva
			cmp 	dword[j], eax       ; Compare índice j com BEGIN
			jna 	cond2_tocall        ; Se não for maior, vai para 2ª condição
			;mov  	ecx, dword[j] 		; Se for maior, Mova o novo valor do índice j para END (ecx) 
			;add 	ecx, 1              ; Some ecx + 1, o mesmo que dizer: j+1 no argumento END
		;	add 	dword[j], 1
			call 	QuickSort           ; Chamada recursiva com os argumentos: BEGIN = EAX e END = j+1
		cond2_tocall:                   ; Label da 2ª condição fora do while para chamada recursiva
			cmp 	dword[i], ecx       ; Compare índice í com END
			jnb 	return_quick        ; Se não for menor, saia da rotina e retorne a chamada
			mov 	eax, DWORD[i]       ; Mova o novo valor de i para eax pois eax deve ser atualizado como argumento
			add 	ecx, 2
			; TODO resolver erro de ordenação
			; PROVAVELMENTE O ERRO ESTÁ AQUI
			call 	QuickSort           ; Chamada recursiva com os argumentos: BEGIN = i e END = ECX
return_quick:                           ; Retorna a chamada pro seu respectivo endereço "seja qual for"
	popad                               ; Restaure todos os registradores da pilha
ret                                     ; Retorne a instrução CALL da chamada atual até a 1ª CALL

;void QuickSort (int vet[], int begin, int end){
;	int i, j, pivo, aux;
;	i = begin;
;	j = end - 1;
;	pivo = vet[(begin + end) / 2];
;	while(i <= j){
;		while(vet[i] < pivo && i < end){
;			i++;
;		}
;		while(vet[j] > pivo && j > begin){
;			j--;
;		}
;		if(i <= j){
;			aux = vet[i];
;			vet[i] = vet[j];
;			vet[j] = aux;
;			i++;
;			j--;
;		}
;	}
;	if(j > begin)
;		QuickSort(vet, begin, j+1);
;	if(i < end)
;		QuickSort(vet, i, end);
;}


; ***** FIM DAS FUNÇOES DE ORDENAÇÃO *****
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++