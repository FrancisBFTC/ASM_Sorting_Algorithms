; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;              ALGORITMOS DE ORDENAÇÃO
;
;              Programa em Assembly x86
;              Criado por Wender Francis
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

[ORG 0x0000]

jmp 		MAIN		; Execute o MAIN


; --------------------------------------------------------------------------------------
; ÁREA DE DADOS DO PROGRAMA

VetorDec 	db "0123456789",0
Zero 		db 0

Off_s		dd  0                                               ; Offset -1 do 1ª Vetor
Vector1 	dd 	8, 5, 9, 1, 3, 2, 0, 4, 7, 6, 24, 23, 11, 10    ; Vetor Exemplo 1 de tamanho 14
Vector2 	dd 	8, 12, 14, 1, 3, 2, 0, 4, 7, 6, 17, 16, 11, 10  ; Vetor Exemplo 2 de tamanho 14
Vector3 	dd 	14, 12, 13, 1, 5, 3, 8, 11, 9, 6, 4, 2, 10, 7   ; Vetor Exemplo 3 de tamanho 14
Vector4  	dd  16,14,12, 13, 1, 5, 3, 8, 11, 9, 6, 4, 2, 10, 7   ; Vetor Exemplo 3 de tamanho 15

InsSort 	db 13,10,"++++ INSERTIONSORT ++++",13,10,13,10,0
SelSort 	db 13,10,"++++ SELECTIONSORT ++++",13,10,13,10,0
QuiSort 	db 13,10,"++++ QUICKSORT ++++",13,10,13,10,0
RadSort 	db 13,10,"++++ RADIXSORT ++++",13,10,13,10,0

; --------------------------------------------------------------------------------------


; --------------------------------------------------------------------------------------
; ÁREA DE INCLUSÃO DOS ALGORITMOS

%INCLUDE "SortingMethods.inc"

; --------------------------------------------------------------------------------------


MAIN:
	cld
	mov 	ax, 0x0800
	mov 	ds, ax
	mov 	es, ax
	mov 	fs, ax
	mov 	gs, ax
	cli 
	mov 	ax, 0x07D0
	mov 	ss, ax
	mov 	sp, 0xFFFF
	sti
	
	; Configura Modo de Texto (80x20)
	mov 	ah, 00h
	mov 	al, 03h
	int 	10h
	
	; Limpa a tela
	mov 	ax, 03h
	int 	10h
	
Program:

	; Exibe Vector1 antes e depois do InsertionSort
	mov 	si, InsSort
	call 	Print_String
	
	mov 	ecx, 14
	mov 	esi, Vector1
	
	call 	Show_Vector32
	call 	InsertionSort
	call 	Show_Vector32
	
	; Exibe Vector2 antes e depois do SelectionSort
	mov 	si, SelSort
	call 	Print_String
	
	mov 	ecx, 14
	mov 	esi, Vector2
	
	call 	Show_Vector32
	call 	SelectionSort
	call 	Show_Vector32
	
	; Exibe Vector3 antes e depois do QuickSort
	mov 	si, QuiSort
	call 	Print_String
	
	mov 	eax, 0
	mov 	ecx, 14
	mov 	esi, Vector3
	
	call 	Show_Vector32
	call 	QuickSort
	call 	Show_Vector32
	
	
	; Exibe Vector4 antes e depois do QuickSort
	mov 	si, RadSort
	call 	Print_String
	
	mov 	eax, 0
	mov 	ecx, 15
	mov 	esi, Vector4
	
	call 	Show_Vector32
	call 	RadixSort
	call 	Show_Vector32
	
	jmp 	$
	
