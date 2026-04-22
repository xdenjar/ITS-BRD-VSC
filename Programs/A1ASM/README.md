A1ASM - LEDs auf dem ITS - Board ansteuern

-> In dieser Dokumentation geht es um die Fragen, die bei der Bearbeitung, sowie der Optimierung unserers Projektes aufgetreten sind und meine Ergebnisse.

1. Welcher war der genaue Endstand der LEDs?
Wir haben im Programm mehere Lines an Code um die LEDs D08, D09, D14 und D15 einen "on" oder "off" state zu setzen.
Ich bin mit dem Debugger durch den Code gegangen habe mir Zeile für Zeile angeschaut und gleichzeitg ein Auge auf die
Register-Liste geworfen und bin zu dem entschluss gekommen das der Endstand der LEDs wie folgt ausschaut:

                    D08: on
                    D09: on
                    D14: off
                    D15: off

Und somit wusste ich wie ich in der darauffolgenden Aufgabe, nämlich beim Optimieren des Programmes, zu arbeiten habe, im Bezug darauf welchen
Endzustand ich erreichen muss. Die Überflüssigen Lines an Code welche LED D14 und D15 sowie deren Register angesprechen habe ich dementsprechend noch im Projekt
stehen gelassen, aber diese auskommentiert, da sie nicht mehr nötig sind.

2. Wie steuer ich LED D08 und D09 zusammen an, so das ich beide in einer Line Code verpacken kann?
Ich habe erstmal nach Commands gesucht mit dennen man die Werte nicht einzeln an D08 und D09 vergeben kann, sondern wie ich beide direkt ansteuern kann. 
Dies war aber kompletter Quatsch, also habe ich mir den Code noch einmal genauer angeschaut und bin in ab Line 31 in den Code gegangen
und habe mir die Register angeschaut und mir ist aufgefallen das wir bei R0 die Hexadezimal #0x01 und bei R1 #0x02 setzen und damit einzeln die LEDs
über den Wert mit R6, welches unser GPIO_D auf "set" setzt, ansprechen.

                    R0 = 0000 0000 0001
                    R1 = 0000 0000 0010

Wenn wir uns diese in Binär anschauen sehen wir das jeweils die erste und die zweite Stelle im Binär auf "1" gesetzt wird, also habe ich
beide zusammen gerechnet und auf R0 gesetzt das sieht dann wie folgt aus:

                    R0 = 0000 0000 0011 => in Hex-Dezimal #0x03

Damit konnte ich dann in Verbindung mit R6 im Code beide LEDs gleichzeitig auf "1" ansprechen und einschalten.

3. Was bedeutet GPIO_D und was steuer ich genau damit an?
GPIO bedeutet General Purpose Input Output und ist ein Pin auf unserem Board, mit diesem Steuern wir von unserem NUCLEO unser ITS-Board an und können wiederrum hiermit, unsere
LEDs am ITS-Board ansprechen (D23- D08). Mit dem "SET" und "CLR" Register, setzen wir auf den Port D (?) jeweils ein high oder low Signal und können damit
Spannung direkt and die LEDs weiter geben und diese an-  high oder low, ausschalten.

4. Hätte ich auch einene anderen Register als R0 nehmen können?
Die Antwort zu dieser Frage lautet ja, da der Register nur als ein Platzhalter fungiert, bedeutet ich hätte meinen Wert "#0x03" auch
Besispielsweise dem Register 1 also R1 geben können.

5. Sind die Kommentare ab Line 33 - Line 37 richtig ausgeschrieben?
Jein, weil die Binär Zahl die im Kommentar steht keine Auswirkung auf dem Code hat und an für sich auch keinen Unsinn anzeigt,
da "0b1000" klar eine "8" anzeigt und "0b0100" eine 4 anzeigt. Da wir uns aber im Hexadezimal-System bewegen ist es der Sauberkeit geschuldet,
das wir hier die Nullen links und rechts entsprechend hinzufügen und mit einem Unterstrich trennen, damit wir eine bessere Lesbarkeit haben für jeden der sich diesen Code einmal ansieht und für einen selbst.
Wir bewegen uns im 8-Bit Bereich und die "8" ist eigentlich eine "128" und die "4" ist eigentlich als 64 gemeint im Hexadezimal-Bereich. Somit meinen wir dann den Bit genauer.