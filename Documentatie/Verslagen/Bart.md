#Versterker
*Om onze Arduino (DAC) niet stuk te maken hebben we een versterkingsschakeling gebouwd*
*De Arduino wou stuk kunnen gaan zonder deze schakeling omdat de max. stroom door de DAC maar 20mA kan/mag bedragen*

##Schema
![schema](http://img.bhs4.com/b5/8/b5880d6404b791d21a95a238d8213884b2c2ce9f_large.jpg)

###Uitleg over het schema

####[IC LM386](http://www.biltek.tubitak.gov.tr/gelisim/elektronik/dosyalar/6/LM386.pdf)

De IC is een vermogen versterker die gebruikt wordt om kleine audio signalen te versterken met een kleinde voedingsspanning.
De interne gain van de IC is standaard 20 maar kan verhoogd worden tot liefst 200 door een RC schakeling toe te voegen aan de 1 en 8 pin.
Door hier gebruik te maken van een potentiometer kunnen we beter de versterknig bepalen die gedaan wordt op het audio signaal op de ingang.

De inputs van de IC werken t.o.v. de ground, terwijl de output automatisch gebiased is op half de voedingsspanning.
De IC bestaat in 4 uitvoeringen met typerend een zeer lage ruiskarakterestiek en werking is een bereik van 4-12V (de 4de uitvoering werkt in een gebied van 5-18V, indien je hierover zou gaan wordt het component te warm en beschadigd).

Enkele eigenschappen:
* Idle stroom van maar 4mA
* Max. power output van 1.25W bij een 8ohm speaker
* bandbreedte van 300Khz bij 6V voeding

![schema](http://i.imgur.com/nlC1tb1.jpg)

####schema

pin 1: verbonden met pin 8 met een RC-kring (variabele weerstand):
*door deze schakeling tussen de gain pinnen van de schakeling te plaatsen kunnen we het volume van de luidspreker aan de uitgang bepalen*

pin 2: verbonden met ground:
*-input naar ground niveau brengen* 

pin 3: verbonden met de variabele weerstand waar het inkomend signaal over staat:
*+input waar we het een fijne instelling kunnen doen via de potentiometer voor het signaal duidelijk op de uitgang te laten horen, eenmaal de instelling gebeurd is moeten we deze weerstand niet meer aanraken*

pin 4: verbonden met ground:
*ground niveau van de IC*

pin 5: verbonden met de uitgangsschakeling:
*uigangsschakeling bestaat uit een RC-kring voor filtering met parallel erover de uitgangsspeaker die in serrie staat met een condenstator voor een "bass boost" te verkrijgen en voor de HF-signalen er nog uit te filteren*

pin 6: verbonden met de voeding
*voedingspin van de IC, deze wordt verbonden met een voeding die tussen de 5-12V ligt. Als je deze voeding op 12V zet kan je het volume aan de uitgang luider laten klinken dan als je dit kan met een voeding van 5V (zelfde gain)*

pin 7: verbonden met ground via condensator
*Bypass pin van de ic die we verbinden met de ground via een condensator, dit wordt gedaan om het circuit stabiel te houden en om onnodige oscillaties en clipping te vermijden*

pin 8: verbonden met pin 1 met een RC-kring (variabele weerstand):
*door deze schakeling tussen de gain pinnen van de schakeling te plaatsen kunnen we het volume van de luidspreker aan de uitgang bepalen*
