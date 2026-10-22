    ldr     R0,=VariableA    ; Anw01 
    ldrb    R2,[R0]         ; Anw02
    ldrb    R3,[R0,#1]      ; Anw03
    lsl     R2, #8          ; Anw04
    orr     R2, R3          ; Anw05
    strh    R2,[R0]         ; Anw06 

    Anw01 = Wir laden die Speicher-Adresse von "VariableA" in das R0.
    Anw02 = Wir, laden das erste Byte was nun an der Adresse bei R0 steht in R2.
    Anw03 = Wir, laden das Byte +1 weiter von der Startadresse was also in R0 steht in R3.
    Anw04 = Wir schieben das R2 um 8 Stellen nach links gezaehlt um ein Platz fuer das Byte zu machen, und füllen dann dadurch, mit Nullen auf.
    Anw05 = Wir vergleichen R2 mit R3 duch den OR Operanten und da wir in R3 "0xbe" stehen haben werden die Nullen im R2 "0xef00" mit "be" aufgefüllt.
    Anw06 = Nun nehmen wir das Halfword (16 Bit) von R2 und speichern es an der selben Adresse an der R0 anliegt und durch den "Little Endian", wird das Ergenis gedreht.