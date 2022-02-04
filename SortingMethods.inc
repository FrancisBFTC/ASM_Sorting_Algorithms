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

%INCLUDE "libkrnl.inc"

%INCLUDE "InsertionSort.asm"
%INCLUDE "SelectionSort.asm"
%INCLUDE "QuickSort.asm"
%INCLUDE "BubbleSort.asm"
%INCLUDE "CombSort.asm"
%INCLUDE "GnomeSort.asm"
%INCLUDE "CockTailSort.asm"
%INCLUDE "MergeSort.asm"
%INCLUDE "ShellSort.asm"
%INCLUDE "RadixSort.asm"
%INCLUDE "HeapSort.asm"
%INCLUDE "TimSort.asm"
%INCLUDE "StrandSort.asm"
%INCLUDE "OddEvenSort.asm"
%INCLUDE "SmoothSort.asm"
%INCLUDE "BogoSort.asm"
%INCLUDE "StoogeSort.asm"

; --------------------------------------------------------------------------------------


%ENDIF