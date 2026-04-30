 R0  
 R2
 R3
 Speicher VariableA

 "beef"


 Anw01 => Load register, die Speicheradressierung von "VariableA" wird ins Register 0 geladen. "0x2000000c"
 Anw02 => Load Register Byte, das erste Byte von R0, ist "ef" hex, und wird an das Register 2 vergeben. R2 = "0xef"
 Anw03 => Load Register Byte, Stelle 1 im Byte vom Register 0 also "be" hex, wird ins Register 3 geladen. "0xbe"
 Anw04 => Logical Shift Left, Verschiebung des Wertes im Register R2 um 8 Bits => 1 Byte.
 Anw05 => OR Register (bitweises ODER), Wert von R3 mit R2 bitweise verglichen und den neuen Wert in R2 gespeichert.
 Anw06 => Store Register Halfword, speichert "0xefbe" in den Speicher von R0 und durch das "Little Endian" tauschen die Bytes ihren Platz.