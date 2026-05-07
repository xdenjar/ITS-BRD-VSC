;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register
                ; Lade Wert 0x12 in R0
                mov   r0,#0x12                      ; Anw-01
                ; Lade Wert -128 in R1
                mov   r1,#-128                      ; Anw-02
                ; Lade Adresse 0x12345678 in R2
                ldr   r2,=0x12345678                ; Anw-03

; Zugriff auf Variable
                ; Lade Adresse von VariableA in R0
                ldr   r0,=VariableA                 ; Anw-04
                ; Lade Halbwort von Adresse in R0 nach R1
                ldrh  r1,[r0]                       ; Anw-05
                ; Lade Wort von Adresse R0 nach R2 
                ldr   r2,[r0]                       ; Anw-06
                ; Speichere Wert von R2 in VariableC
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07

; Zugriff auf Felder (Speicherzellen)
                ; Lade Adresse von Variable in R0
                ldr   r0,=MeinHalbwortFeld          ; Anw-08
                ; Lade Halbwort von Adresse R0 nach R1
                ldrh  r1,[r0]                       ; Anw-09
                ; Lade Halbwort von Adresse R0 und Offset 2 nach R2
                ldrh  r2,[r0,#2]                    ; Anw-10
                ; Schreibe Dezimal 10 in R3
                mov   r3,#10                        ; Anw-11
                ; Lade Halbwort aus Adresse R0 und dem Offset aus R3 nach R4
                ldrh  r4,[r0,r3]                    ; Anw-12
                ; Lade Halbwort aus Adresse R0 und Offset 2 nach R5 und aktualisiere R0
                ldrh  r5,[r0,#2]!                   ; Anw-13
                ; Lade Halbwort aus Adresse R0 und Offset 2 nach R6 und aktualisiere R0
                ldrh  r6,[r0,#2]!                   ; Anw-14
                ; Speichere Halbwort aus R6 nach Adresse aus R0 und Offset 2 und aktualisiere R0
                strh  r6,[r0,#2]!                   ; Anw-15

; Addition und Subtraktion von unsigned / signed Integer-Werten
                ; Lade Adresse aus Variable in R0
                ldr  r0,=MeinWortFeld               ; Anw-16
                ; Lade Wort von Adresse R0 nach R1
                ldr  r1,[r0]                        ; Anw-17
                ; Lade Wort von Adresse R0 und Offset 4 nach R2
                ldr  r2,[r0,#4]                     ; Anw-18
                ; Addiere R1 und R2 speichere Ergebnis in R3 und setze Flags
                adds r3,r1,r2                       ; Anw-19

                ; Lade Wort aus Adresse R0 und Offset 8 nach R4
                ldr  r4,[r0,#8]                     ; Anw-20
                ; Lade Wort aus Adresse R0 und Offset 12 nach R5
                ldr  r5,[r0,#12]                    ; Anw-21
                ; Subtrahiere R5 von R4 speichere Ergebnis in R6 und setze Flags
                subs r6,r4,r5                       ; Anw-22

                ; Lade Wort von Adresse R0 und Offset 16 nach R7
                ldr  r7,[r0,#16]                    ; Anw-23
                ; Lade Wort von Adresse R0 und Offset 20 nach R8
                ldr  r8,[r0,#20]                    ; Anw-24
                ; Subtrahiere R8 von R7 und speichere Ergebnis in R9 und setze Flags
                subs r9,r7,r8                       ; Anw-25
                ; Springe dauerhaft zu forever
forever         b   forever                         ; Anw-26
                ENDP
                END