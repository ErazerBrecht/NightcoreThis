#Fir filter

Fir filter of voluit Finite impulse response filter, is de filter die we gebruiken om in scilab onze laag, hoog en band doorlat filter te ontwerpen. Finite impulse response is een term die aangeeft dat de impulsresponsie van een digitale filter eindig is. Bij het aanleggen van een puls op een FIR-filter zal het uitgangssignaal na een bepaalde tijd gelijk aan nul worden; de impulsresponsie is dus eindig. Dit in tegenstelling tot de impulsresponsie van een IIR-filter (infinite impulse response), waar het uitgangssignaal oneindig lang ongelijk aan nul kan blijven. het voordeel van deze filter is dat geen terugkoppeling van de output naar de input nodig waardoor de filter steeds stabiel is. Dit kan je ook aan hun verschilvergelijkingen zien.
![FIR Verschilvergelijking.jpg](FIR Verschilvergelijking.jpg)


Het werkingsprincipe komt overeen met het bepalen van het gemiddelde in de vorige waarden die voorzien zijn van gewichten met een factor bk. Een nadeel aan de FIR is dat deze beduidend meer coëfficiënten nodig heeft dan de IIR- filter om dezelfde eigenschappen te kunnen bekomen. In tegenstelling tot de IIR-filter heeft de FIR-filter Lineaire faseresponse, wat een enorm voordeel. Niet Lineaire faseresponse wilt namenlijk zeggen dat er vervorming zal optreden. Magnitude en fase kunnen bijd de FIR onafhankelijk van elkaar bepaald worden.


#Wave generatie


