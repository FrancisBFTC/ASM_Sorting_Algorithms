; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;              ALGORITMOS DE ORDENAÇÃO
;
;              Funções em Assembly x86
;              Criado por Wender Francis
; ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%IFNDEF 	__SORTINGMETHODS_INC__
%DEFINE 	__SORTINGMETHODS_INC__

; --------------------------------------------------------------------------------------
; ÁREA DE INCLUSÕES DOS ALGORITMOS

%INCLUDE "Library/Sort/InsertionSort.asm"
%INCLUDE "Library/Sort/SelectionSort.asm"
%INCLUDE "Library/Sort/QuickSort.asm"
%INCLUDE "Library/Sort/BubbleSort.asm"
%INCLUDE "Library/Sort/CombSort.asm"
%INCLUDE "Library/Sort/GnomeSort.asm"
%INCLUDE "Library/Sort/CockTailSort.asm"
%INCLUDE "Library/Sort/MergeSort.asm"
%INCLUDE "Library/Sort/ShellSort.asm"
%INCLUDE "Library/Sort/RadixSort.asm"
%INCLUDE "Library/Sort/HeapSort.asm"
%INCLUDE "Library/Sort/TimSort.asm"
%INCLUDE "Library/Sort/StrandSort.asm"
%INCLUDE "Library/Sort/OddEvenSort.asm"
%INCLUDE "Library/Sort/SmoothSort.asm"
%INCLUDE "Library/Sort/BogoSort.asm"
%INCLUDE "Library/Sort/StoogeSort.asm"

; --------------------------------------------------------------------------------------


; --------------------------------------------------------------------------------------
; ROTINAS AUXILIARES DO KERNEL

; ==============================================================
; Rotina que aloca uma quantidade de bytes e retorna endereço
; IN: ECX = Tamanho de Posições (Size)
;     EBX = Tamanho do Inteiro (SizeOf(int))

; OUT: EAX = Endereço Alocado
; ==============================================================
Calloc:
	pushad
	
	xor 	eax, eax
	mov 	ax, ds
	shl 	eax, 4
	add 	eax, SERIAL
	push 	ecx
	mov 	ecx, SERIAL_NUM_SECTORS
	
	Skip_Offset:
		add 	eax, 512
		loop 	Skip_Offset
		
	add 	eax, 4
	mov 	edi, eax
	xor 	eax, eax
	pop 	ecx
	push 	edi
	
	mov 	es, ax
	
	cmp 	ebx, 1
	je 		Alloc_Size8
	cmp 	ebx, 2
	je 		Alloc_Size16
	cmp 	ebx, 4
	je 		Alloc_Size32
	jmp 	Return_Call
	
	; TODO 
	; Dados que podem estar na memória serão perdidos
	; nesta alocação, então melhor certificar que salvamos 
	; estes dados em algum lugar (talvez via push)
	; e recuperarmos na função Free()
	Alloc_Size8:  
		mov 	dword[Size_Busy], ecx
		rep 	stosb
		jmp 	Return_Call
	Alloc_Size16: 
		mov 	dword[Size_Busy], ecx
		shl 	dword[Size_Busy], 1
		rep 	stosw
		jmp 	Return_Call
	Alloc_Size32: 
		mov 	dword[Size_Busy], ecx
		shl 	dword[Size_Busy], 2
		rep 	stosd
		jmp 	Return_Call
	
Return_Call:
	pop 	DWORD[Return_Var_Calloc]
	popad
	mov 	eax, DWORD[Return_Var_Calloc]
	mov 	byte[Memory_Busy], 1
ret

Return_Var_Calloc dd 0
Size_Busy 	dd 0
Memory_Busy db 0


; ==============================================================
; Libera espaço dado um endereço alocado
; IN: EBX = Ponteiro de Endereço Alocado
;
; OUT: Nenhum.
; ==============================================================
Free:
	pushad
	mov 	edi, dword[ebx]
	mov 	dword[ebx], 0x00000000
	
	mov 	ecx, dword[Size_Busy]
	rep 	stosb
	
	mov 	ax, ds
	mov 	es, ax
	
	mov 	dword[Size_Busy], 0
	mov 	dword[Return_Var_Calloc], 0
	mov 	dword[Memory_Busy], 0
	popad
ret

; --------------------------------------------------------------------------------------

%ENDIF