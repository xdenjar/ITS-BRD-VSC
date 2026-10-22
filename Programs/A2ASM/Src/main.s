;******************** (C) COPYRIGHT HAW-Hamburg ********************************
;* File Name          : main.s
;* Author             : Dennis Jarmolinski (Martikel-Nr. 2875536), Arash Ghaboos (Martikel-Nr. 2857505)
;* Version            : V1.2
;* Date               : 22.10.2026
;* Description        : This is a main to show Byte behavior on our
;                     : ITS-Board.
;                     : 
;
;*******************************************************************************
    EXTERN initITSboard ; Helper to organize the setup of the board

    EXPORT main         ; we need this for the linker - In this context it set the entry point,too

ConstByteA  EQU 0xaffe
    
;* We need some data to work on
    AREA DATA, DATA, align=2    
VariableA   DCW 0xbeef
VariableB   DCW 0x1234
VariableC   DCW 0xaffe

;* We need minimal memory setup of InRootSection placed in Code Section 
    AREA  |.text|, CODE, READONLY, ALIGN = 3    
    ALIGN   
main
    BL initITSboard             ; needed by the board to setup
;* swap memory - Is there another, at least optimized approach?
    ldr     R0,=VariableA   ; Anw01
    ldrb    R2,[R0]         ; Anw02
    ldrb    R3,[R0,#1]      ; Anw03
    lsl     R2, #8          ; Anw04
    orr     R2, R3          ; Anw05
    strh    R2,[R0]         ; Anw06 
    
;* const in var
    mov     R5,#ConstByteA  ; Anw07
    strh    R5,[R0]         ; Anw08
    ldr     R0,=VariableC   ; Gehe an Adresse &VariableC
    ldrb    R5,[R0]         ; Lade das erste Byte in R5
    ldrb    R6,[R0, #1]     ; Lade +1 Offset Byte in R6
    lsl     R5, #8          ; Schiebe 8 Bits in R5 auf (Platz fuer neues Byte)
    orr     R5, R6          ; OR Operator (0 wird aufgefuellt)
    strh    R5, [R0]        ; Neues Halfword (16bit) kommt an die selbe Adresse R0
    
;* Change value from x1234 to x3412 Differenz = Zielwert - Startwert
    ldr     R1,=VariableB   ; Anw09
    ldrh    R6,[R1]         ; Anw0A
    mov     R7, #0x21DE     ; Anw0B
    add     R6, R6, R7      ; Anw0C
    strh    R6,[R1]         ; Anw0D
    b .                     ; Anw0E
    
    ALIGN
    END