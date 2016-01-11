## Filter (Scilab)
Als deel van onze opdracht was om onze filters op te bouwen in het programma Scilab. Je kan dit programma vergelijken met Matlab maar dan open source.

De opdracht bestond er uit om 3 filters op te bouwen. Een laagdoorlaat filter die enkel signalen tot 750 Hz doorlaat en alle hogere signalen eruit filtert. Verder ook een bandpass filter die van 800 Hz tot 2kHz filtert. Als laatste ook een hoog doorlaat filter die van vanaf 2kHz de signalen door laat.

### Code
We zullen deze kort onze code even stap voor stap overlopen. Fss is de bitrate van het nummer dat we inladen. Speed zegt hoeveel versnelt het muziekstuk moet worden afgespeeld. Wavread is de functie in Scilab die het mogelijk maakt om een .wav file in te laden in Scilab. 
```Matlab
Fss = 16000; //the bitrate of the song
Speed = 1.3; //how fast the song will be played

//reading the wav (music) file in a matrix
[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); 
```

De volgende stap is om maar 1 kanaal van het audio signaal op te slaan (audio is stereo). Hierna doen we een berekening voor het plotten van ons test signaal in functie van de sample frequentie.
Hierna volgt het eigenlijke filteren. Ik ga hier niet te diep op in gaan maar we gebruiken het type FIR filter en hebben en 80ste orde voor laag doorlaat en 100ste orde voor bandpass en highpass filter. Als laatste plotten we het oorspronkelijke en het gefilterde wave signaal. [750/Fss, 0] wilt zeggen tot waar we filteren. Hier moet een verhouding komen die kleiner is dan 0.5 en om het ons gemakkelijk te maken hebben we dit in een formule gegoten. Zo kunnen we de gewenste frequentie invullen en moeten we de verhouding niet zelf berekenen.
```Matlab
//filterontwerp HP met een orde van 100 die filterd met een fc 2050
[LD_coeff, amplitude, frequentie] = wfir('lp',80,[750/Fss, 0],'hm',[0 0]);
//bepalen van transfertfunctie van de filter
//maken van polynoom (veelterm)
LD_polynoom = poly(LD_coeff, 'z', 'coeff');
//omvormen van z-coeff naar 1/z coeff
LD_functie = horner(LD_polynoom, 1/%z);
//aangeven werken met discrete waarden
LD_lineair_system = syslin('d', LD_functie);
//filteren via scilab
LD_output = flts(testsign, LD_lineair_system);

//plot oorspronkelijk signaal
plot(t, testsign)
//plot gefilterd signaal
plot(t, LD_output, 'r');
```
Hier onder ziet u alle filters met hun wave form en spectrum

Bandpass 
![Bandpass](http://i.imgur.com/t5cUKDE.jpg?1 "Bandpass")
Spectrum
![Bandpass](http://i.imgur.com/j79e04v.jpg?1 "Bandpass")

Laagdoorlaat 
![Laagdoorlaat](http://i.imgur.com/WIYrNHZ.jpg?1 "Laagdoorlaat")
Spectrum
![Laagdoorlaatspec](http://i.imgur.com/uXJ3dNU.jpg?1 "Laagdoorlaat")

Hoog doorlaat 
![Hoogdoorlaat](http://i.imgur.com/vzSPBTB.jpg?1 "Hoog doorlaat")
Spectrum
![Hoogdoorlaatspec](http://i.imgur.com/IFFJeDS.jpg?1 "Hoog doorlaat")

Om te horen of onze filter werkt spelen we het gefilterde geluid af en eventueel versneld. Dit is afhankelijk van de ingestelde speed. Als laatste slaan we het gefilterde signaal op in een wav file.
```Matlab
playsnd(LD_output,Speed*Fss);
wavwrite(LD_output, Speed*Fss ,'SCI/modules/sound/demos/'+'yolold.wav');
```

Om een hoog of bandpass filter te maken moeten we maar 1 lijn code veranderen.
```Matlab
[LD_coeff, amplitude, frequentie] = wfir('lp',80,[750/Fss 0],'hm',[0 0]);
```
Voor de hoog doorlaat zal deze lijn er zo uit zien (Opgepast er staat hier bp van bandpass maar het is de hoog doorlaat filter. Volgens de opdracht mag het signaal maar tot 8kHz gaan en dit kan enkel met een bandpass filter).
```Matlab
[HD_coeff, amplitude, frequentie] = wfir('bp',100,[2050/Fss, 0.5],'hm',[0 0]);
```

Voor de bandpass filter zal de lijn code er zo uit zien.
```Matlab
[BD_coeff, amplitude, frequentie] = wfir('bp',100,[800/Fss, 2000/Fss],'hm',[0 0]);
```

### taakverdeling
Mijn taak binnen de groep was het opbouwen van de versterker (wat me niet goed gelukt is maar dankzij teamwork hebben we een ontzettend goede versterker gebouwd). Verder heb ik mezelf bezig gehouden met de filters in scilab. Ik heb deze opgebouwd en getest. Ook heb ik onderzoek gedaan naar het sampelen met de Arduino Due. In het begin leek dit een eenvoudige opgave maar na nader onderzoek zijn we tot de conclusie gekomen dat de sampel frequentie van de Due te hoog ligt. Om de sampel frequentie omlaag te doen heb je een ontzettend goede C kennis nodig. Deze hadden we spijtig genoeg niet in onze groep. Verder heb ik geholpen waar nodig. Ik heb mezelf overal binnen het project ingezet.




