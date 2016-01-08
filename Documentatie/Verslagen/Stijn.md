#Fir filter

Fir filter of voluit Finite impulse response filter, is de filter die we gebruiken om in scilab onze laag, hoog en band doorlat filter te ontwerpen. Finite impulse response is een term die aangeeft dat de impulsresponsie van een digitale filter eindig is. Bij het aanleggen van een puls op een FIR-filter zal het uitgangssignaal na een bepaalde tijd gelijk aan nul worden; de impulsresponsie is dus eindig. Dit in tegenstelling tot de impulsresponsie van een IIR-filter (infinite impulse response), waar het uitgangssignaal oneindig lang ongelijk aan nul kan blijven. het voordeel van deze filter is dat geen terugkoppeling van de output naar de input nodig waardoor de filter steeds stabiel is. Dit kan je ook aan hun verschilvergelijkingen zien. Een verschilvergelijking is een rekenregel waarbij de huidige waarde van de outputsequence yk, de huidige waarde van de input xk en alle vorige waarden van de input- en output sequence worden gebruikt.(In het geval van de FIR dus enkel de inputsignalen en coëfficiënten bn). De coëfficienten(bn) zijn een reeks waarden waarmee inputsampels(Xk) moeten vermenigvuldigd worden om een outputsequence(yk) te bekomen.

De coëfficiënten hebben de benaming bn en an.

FIR Verschilvergelijking
![FIR Verschilvergelijking.jpg](/Documentatie/Foto's/FIR Verschilvergelijking.jpg)

IIR Verschilvergelijking
![FIR Verschilvergelijking.jpg](/Documentatie/Foto's/IIR Verschilvergelijking.jpg)

 Een nadeel aan de FIR is dat deze beduidend meer coëfficiënten nodig heeft dan de IIR- filter om dezelfde eigenschappen te kunnen bekomen. In tegenstelling tot de IIR-filter heeft de FIR-filter Lineaire faseresponse, wat een enorm voordeel. Niet Lineaire faseresponse wilt namenlijk zeggen dat er vervorming zal optreden. Magnitude en fase kunnen bijd de FIR onafhankelijk van elkaar bepaald worden.


#Wav generatie
##Scilab
De liedjes die we gaan filteren in scilab zullen  de extentie .wav hebben. Dit om de eenvoudige rede dat scilab een functie heeft genaamd Wavread. Hiermee kan je makelijk Wav files uitlezen. MP3 uitlezen in scilab is veel moeilijker, hier zijn speciale encoders nodig. We gaan het onzelf niet onnodig moeilijk maken en kiezen daarom voor .wav bestanden. 
[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); met in y de gesampelde data, Fs de samplerate, bits het aantal bits gebruikt per sample om de data te encoderen. Audacity® is gratis, open source, cross-platform software voor het opnemen en bewerken van geluiden en onmisbaar bij het verwezelijken van dit project. Om te beginnen hebben we Audacity gebruikt om de liedjes die we gebruikten om te vormen van mp3 naar wav bestanden. Zo konden we ook het uitgangssignaal van scilab vergelijken met de orginele mp3 file. In Audacity is het ook mogelijk om te filteren, zo konden we de resultaten van onze Scilab filter vergelijken met de filter van audacity.



Zoals al eerder aangehaald in het Hoofdstuk over filters, is Wavread de functie in Scilab die het mogelijk maakt om een .wav file in te laden in Scilab.

##Praktisch
om de uniformiteit te bewaren Gebruiken we ook hier .wav files.
