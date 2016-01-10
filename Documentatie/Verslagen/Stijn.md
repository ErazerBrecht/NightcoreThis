#Fir filter

Fir filter of voluit *Finite impulse response* filter, is de filter die we gebruiken om in Scilab onze laag, hoog en band doorlaat filter te ontwerpen. Finite impulse response is een term die aangeeft dat de impulsresponsie van een digitale filter eindig is. Bij het aanleggen van een puls op een FIR-filter zal het uitgangssignaal na een bepaalde tijd gelijk aan nul worden; de impulsresponsie is dus eindig. Dit in tegenstelling tot de impulsresponsie van een IIR-filter (infinite impulse response), waar het uitgangssignaal oneindig lang ongelijk aan nul kan blijven. Het voordeel van deze filter is dat er geen terugkoppeling van de output naar de input nodig is, waardoor de filter steeds stabiel is. Dit kan je ook aan hun verschilvergelijkingen zien. Een verschilvergelijking is een rekenregel waarbij de huidige waarde van de outputsequence yk, de huidige waarde van de input xk en alle vorige waarden van de input- en output sequence worden gebruikt (in het geval van de FIR dus enkel de inputsignalen en coëfficiënten bn). De coëfficienten (bn) zijn een reeks waarden waarmee inputsampels(Xk) moeten vermenigvuldigd worden om een outputsequence(yk) te bekomen.

De coëfficiënten hebben de benaming bn en an.

FIR Verschilvergelijking

![FIR Verschilvergelijking.jpg](/Documentatie/Foto's/FIR Verschilvergelijking.jpg)

IIR Verschilvergelijking

![FIR Verschilvergelijking.jpg](/Documentatie/Foto's/IIR Verschilvergelijking.jpg)

Een nadeel aan de FIR is dat deze beduidend meer coëfficiënten nodig heeft dan de IIR- filter om dezelfde eigenschappen te kunnen bekomen. In tegenstelling tot de IIR-filter heeft de FIR-filter een lineaire faseresponse, wat een enorm voordeel is. Niet lineaire faseresponse wilt namenlijk zeggen dat er vervorming zal optreden. Magnitude en fase kunnen beide bij de FIR onafhankelijk van elkaar bepaald worden.


#Wav generatie
##Scilab
De liedjes die we gaan filteren in Scilab zullen  de extentie .wav hebben. Dit om de eenvoudige rede dat scilab een functie heeft genaamd Wavread. Hiermee kan je makelijk wav files uitlezen. MP3 uitlezen in scilab is veel moeilijker, hier zijn speciale encoders voor nodig (mp3 is ook geen vrije licentie). We gaan het onzelf niet onnodig moeilijk maken en kiezen daarom voor .wav bestanden. 

>[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); 

Met in 'testsin' de gesampelde data, 'Fs' de samplerate en 'bits' het aantal bits gebruikt per sample om de data te encoderen. 

Audacity® is gratis, open source, cross-platform software voor het opnemen en bewerken van geluiden en onmisbaar bij het verwezelijken van dit project. Om te beginnen hebben we Audacity gebruikt om de liedjes die we gebruikten om te vormen van mp3 naar wav bestanden. Zo konden we ook het uitgangssignaal van scilab vergelijken met de orginele mp3 file. In Audacity is het ook mogelijk om te filteren, zo konden we auditief de resultaten van onze Scilab filter vergelijken met de filter van Audacity. Tot slot hebben we Audacity gebruikt om onze .wav file van stereo naar mono om te vormen. Doen we dit niet krijgen we volgende fout: "Wrong size for argument: Incompatible dimensions." bij het aanroepen van de playsnd(); functie. Dit omdat een met de Wavread() ingelezen stereo-muziek bestand zal bestaan uit twee Array's met samples één voor elk kanaal. De playsnd() functie begint de file af te spelen bij het starten van het programma. Verder werkte onze filter ook niet meer. Deze wist niet hoe hij 2 array's moest behandelen. Na de signalen te hebben omgevormd werkt de filter feiloos. We hebben voor de zekerheid toch nog de 'tweede' array van samples (stereo kanaal) programatisch verwijderd.

> testsign = testsign(1,:);


##Praktisch
Om de uniformiteit te bewaren gebruiken we ook hier .wav files. Omdat de afspeelsnelheid van onze SD kaart dubbel zo hoog moest zijn als we stereo muziek afspelen, moet op voorhand beslist worden of we mono of stereo gaan gebruiken. Omdat we toch maar een kanaal speakers hebben en in SciLab ook van mono gebruik maken was de keuze voor mono snel gemaakt. De samplefrequentie kon zo vast gezet worden op 44100Hz (i.p.v. 88200Hz)
