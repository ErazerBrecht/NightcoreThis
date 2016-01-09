## Filter (Scilab)
Als deel van onze opdracht was om onze filters op te bouwen in het programma Scilab. Je kan dit programma vergelijken met Matlab maar dan open source.

De opdracht bestond er uit om 3 filters op te bouwen. Een laagdoorlaat filter die enkel signalen tot 750 Hz doorlaat en alle hogere signalen eruit filtert. Verder ook een bandpass filter die van 800 Hz tot 2kHz filtert. Als laatste ook een hoog doorlaat filter die van vanaf 2kHz de signalen door laat.

### Code
We zullen deze kort onze code even stap voor stap overlopen. Fss is de bitrate van het nummer dat we inladen. Speed zegt hoeveel versnelt het muziekstuk moet worden afgespeeld. Wavread is de functie in Scilab die het mogelijk maakt om een .wav file in te laden in Scilab. 
```Matlab
Fss = 16000;
Speed = 1.3;

[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav");
//[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest1(H-style).wav");
```

De volgende stap is om maar 1 kanaal van het audio signaal op te slaan (audio is stereo). TODO leg uit: t = [1:1:length(testsign)]*1/Fs; 
Hierna volgt het eigenlijke filteren. Ik ga hier niet te diep op in gaan maar we gebruiken het type FIR filter en hebben en 80ste orde. Als laatste plotten we het oorspronkelijke en het gefilterde wave signaal.
```Matlab
testsign = testsign(1,:);
t = [1:1:length(testsign)]*1/Fs;

[LD_coeff, amplitude, frequentie] = wfir('lp',80,[750/Fss 0],'hm',[0 0]);
LD_polynoom = poly(LD_coeff, 'z', 'coeff');
LD_functie = horner(LD_polynoom, 1/%z);
LD_lineair_system = syslin('d', LD_functie);
LD_output = flts(testsign, LD_lineair_system);

plot(t, testsign)
plot(t, LD_output, 'r');
```

Bandpass 
![Bandpass](http://i.imgur.com/t5cUKDE.jpg?1 "Bandpass")

spectrum
![Bandpass](http://i.imgur.com/j79e04v.jpg?1 "Bandpass")

Laagdoorlaat 
![Laagdoorlaat](http://i.imgur.com/WIYrNHZ.jpg?1 "Laagdoorlaat")

Hoog doorlaat 
![Hoogdoorlaat](http://i.imgur.com/vzSPBTB.jpg?1 "Hoog doorlaat")

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
[LD_coeff, amplitude, frequentie] = wfir('bp',100,[2050/Fss, 0.5],'hm',[0 0]);
```

Voor de bandpass filter zal de lijn code er zo uit zien.
```Matlab
[LD_coeff, amplitude, frequentie] = wfir('bp',100,[800/Fss, 2000/Fss],'hm',[0 0]);
```






