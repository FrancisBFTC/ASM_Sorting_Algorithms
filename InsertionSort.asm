; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
; FUNÇÕES DE ORDENAÇÃO

; Ordenação por Inserção
;
; Insertion Sort ou ordenação por inserção é o método que percorre um vetor de elementos da esquerda para a direita 
; e à medida que avança vai ordenando os elementos à esquerda. Possui complexidade C(n) = O(n) no melhor caso e C(n) = O(n²) 
; no caso médio e pior caso. É considerado um método de ordenação estável.

; Um método de ordenação é estável se a ordem relativa dos itens iguais não se altera durante a ordenação. 
; O funcionamento do algoritmo é bem simples: consiste em cada passo a partir do segundo elemento selecionar 
; o próximo item da sequência e colocá-lo no local apropriado de acordo com o critério de ordenação.


InsertionSort:


ret

; EQUIVALENTE LINGUAGEM C
;void InsertionSort (int vector[], int size){
;    int i, j, x;
;    for (i=1; i<=size; i++){                // começando do 2ª item, navega no Array até chegar no último item
;        x = vector[i];                      // armazena em x o 2ª item
;        j = i-1;                            // j apontará pro 1ª item
;        vector[-1] = x;                     // armazena o 2ª item em uma posição -1.
;        while (x < vector[j]){              // enquanto o 2ª item for menor que o 1ª item...
;            vector[j+1] = vector[j];        // a 2ª posição recebe o 1ª item
;            j--;                            // j aponta pro item x na posição -1.
;        }                                   // Itera no While até x seja igual ao valor da posição -1 (que é x)
;        vector[j+1] = x;                    // armazena o 2ª item na 1ª posição
;    }                                       // Na próxima iteração o 2ª item passará a ser o 3ª, depois o 4ª,etc..
;}


; ***** FIM DAS FUNÇOES DE ORDENAÇÃO ***** */
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++