# NightCore Project 3
* Brecht Carlier
* Stijn Schrauwen
* Bart Kerstens
* Arne Schoonvliet
 
## Inleiding
In ons derde jaar op AP Hogeschool wordt er van ons verwacht een digitale filtermaken. Wij maken deze in groepjes van vier. 
Het doel van dit project is dat onze kennis wordt getest en dat we op zelfstandige basis een project kunnen uitvoeren.

In ons project hebben we een aantal doelstellingen. Een zeer belangrijke hiervan is het plannen en het verdelen van taken. We werken in een groep van vier. Hier moet zeker de nodige planning gebeuren willen we tot een succesvolle project komen. We leren hier bepaalde technieken voor die ons hierbij kunnen helpen!
In ons latere leven zullen we hier ook mee te maken krijgen. We zullen ook vindingrijk moeten zijn bij het oplossen van problemen. Niet alles gaat van de eerste keer en we zullen zeker eens een probleem hebben en dat moeten we succesvol kunnen oplossen. Dit zal tevens belangrijk zijn in ons dagelijks leven. Onze werkhouding en ons gedrag binnen de groep en tegenover derden is ook een belangrijke doelstelling!

Het algemeen doel van ons project is dat we in een werkelijke situatie ervaring opdoen. 
In dit dossier vindt u de schriftelijke neerslag van en de extra informatie van onze taken. Wij wensen jullie nog veel leesplezier in ons portfolio.

Brecht Carlier, Arne Schoonvliet, Bart Kerstens en Stijn Schrauwen

## Doelstellingen
* Opbouwen van filters binnen Scilab
* Sampelen van geluid met Arduino
* Versnellen of vertragen van geluid met Arduino en Scilab
* Toevoegen van echo aan geluid met Arduino

## Fir filter

Fir filter of voluit *Finite impulse response* filter, is de filter die we gebruiken om in Scilab onze laag, hoog en band doorlaat filter te ontwerpen. Finite impulse response is een term die aangeeft dat de impulsresponsie van een digitale filter eindig is. Bij het aanleggen van een puls op een FIR-filter zal het uitgangssignaal na een bepaalde tijd gelijk aan nul worden; de impulsresponsie is dus eindig. Dit in tegenstelling tot de impulsresponsie van een IIR-filter (infinite impulse response), waar het uitgangssignaal oneindig lang ongelijk aan nul kan blijven. Het voordeel van deze filter is dat er geen terugkoppeling van de output naar de input nodig is, waardoor de filter steeds stabiel is. Dit kan je ook aan hun verschilvergelijkingen zien. Een verschilvergelijking is een rekenregel waarbij de huidige waarde van de outputsequence yk, de huidige waarde van de input xk en alle vorige waarden van de input- en output sequence worden gebruikt (in het geval van de FIR dus enkel de inputsignalen en coëfficiënten bn). De coëfficienten (bn) zijn een reeks waarden waarmee inputsampels (Xk) moeten vermenigvuldigd worden om een outputsequence (yk) te bekomen.

De coëfficiënten hebben de benaming bn en an.

FIR Verschilvergelijking

![FIR Verschilvergelijking.jpg](/Documentatie/Foto's/FIR Verschilvergelijking.jpg)

IIR Verschilvergelijking

![FIR Verschilvergelijking.jpg](/Documentatie/Foto's/IIR Verschilvergelijking.jpg)

Een nadeel aan de FIR is dat deze beduidend meer coëfficiënten nodig heeft dan de IIR- filter om dezelfde eigenschappen te kunnen bekomen. In tegenstelling tot de IIR-filter heeft de FIR-filter een lineaire faseresponse, wat een enorm voordeel is. Niet lineaire faseresponse wilt namenlijk zeggen dat er vervorming zal optreden. Magnitude en fase kunnen beide bij de FIR onafhankelijk van elkaar bepaald worden.



    [LD_coeff, amplitude, frequentie] = wfir('lp',80,[750/Fss, 0],'hm',[0 0]);
    LD_polynoom = poly(LD_coeff, 'z', 'coeff');
    LD_functie = horner(LD_polynoom, 1/%z);
    LD_lineair_system = syslin('d', LD_functie);
    LD_output = flts(testsign, LD_lineair_system);

```
[LD_coeff, amplitude, frequentie] = wfir('lp',80,[750/Fss, 0],'hm',[0 0]);
Bepalen van de transfert functie van de filter, maken van een polynoom


LD_coeff
time domain filter coefficients

amplitude
frequency domain filter response on the grid fr

frequentie
Frequency grid


  Parameters van wfir()
  * ‘lp’ : laagdoorlaatfilter
  * 80 : orde filter
  * [750/Fss, 0] : bandbreedte (tussen  (750/16000)Hz en 0 Hz;
  750 >>> periodes per seconde 16000samples per seconde. 750/16000 = cut off frequentie 
  * ‘hm’ : hamming window
  * [0 0] parameters voor hamming window
  
  
LD_polynoom = poly(LD_coeff, 'z', 'coeff');
omvormen van Z-coeff naar 1/z coeff

LD_functie = horner(LD_polynoom, 1/%z);
aangeven dat we werken met discrete signalen

LD_lineair_system = syslin('d', LD_functie);
testen werking van de filter

LD_output = flts(testsign, LD_lineair_system);
filteren via scilab met funtie flts()
```


## Wav generatie
### Scilab
De liedjes die we gaan filteren in Scilab zullen  de extentie .wav hebben. Dit om de eenvoudige rede dat scilab een functie heeft genaamd Wavread. Hiermee kan je makelijk wav files uitlezen. MP3 uitlezen in scilab is veel moeilijker, hier zijn speciale encoders voor nodig (mp3 is ook geen vrije licentie). We gaan het onzelf niet onnodig moeilijk maken en kiezen daarom voor .wav bestanden. 

>[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); 

Met in 'testsin' de gesampelde data, 'Fs' de samplerate en 'bits' het aantal bits gebruikt per sample om de data te encoderen. 

Audacity® is gratis, open source, cross-platform software voor het opnemen en bewerken van geluiden en onmisbaar bij het verwezelijken van dit project. Om te beginnen hebben we Audacity gebruikt om de liedjes die we gebruikten om te vormen van mp3 naar wav bestanden. Zo konden we ook het uitgangssignaal van scilab vergelijken met de orginele mp3 file. In Audacity is het ook mogelijk om te filteren, zo konden we auditief de resultaten van onze Scilab filter vergelijken met de filter van Audacity. Tot slot hebben we Audacity gebruikt om onze .wav file van stereo naar mono om te vormen. Doen we dit niet krijgen we volgende fout: "Wrong size for argument: Incompatible dimensions." bij het aanroepen van de playsnd(); functie. Dit omdat een met de Wavread() ingelezen stereo-muziek bestand zal bestaan uit twee Array's met samples één voor elk kanaal. De playsnd() functie begint de file af te spelen bij het starten van het programma. Verder werkte onze filter ook niet meer. Deze wist niet hoe hij 2 array's moest behandelen. Na de signalen te hebben omgevormd werkt de filter feiloos. We hebben voor de zekerheid toch nog de 'tweede' array van samples (stereo kanaal) programatisch verwijderd.

> testsign = testsign(1,:);


## Praktisch
Om de uniformiteit te bewaren gebruiken we ook hier .wav files. Omdat de afspeelsnelheid van onze SD kaart dubbel zo hoog moest zijn als we stereo muziek afspelen, moet op voorhand beslist worden of we mono of stereo gaan gebruiken. Omdat we toch maar een kanaal speakers hebben en in SciLab ook van mono gebruik maken was de keuze voor mono snel gemaakt. De samplefrequentie kon zo vast gezet worden op 44100Hz (i.p.v. 88200Hz)

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

## Scilab echo

We hebben een echo gemaakt in scilab. Om dit te realiseren lezen we eerst een .wav file in. Hieruit halen we de samples waar we een echo op gaan toepassen. Deze bevinden zich in *testsign*. Ook is het interessant om de samplerate waarmee het audio bestand origineel afgespeeld wordt er uit te halen. Dit steken we in *samplespeed*.
```
[testsign,Fs,bits]=wavread("D:\Programs\scilab-5.5.2\modules\sound\demos\BART2.wav");
samplespeed = Fs;
```
Vervolgens stellen we wanneer de echo moet beginnen. Deze tijd is regelbaar van 500ms tot 3 000ms. Indien je de echo langer maakt wordt het meer akapella i.p.v. echo. De echotijd wordt dan omgevormd naar seconden en vermenigvuldigd met de samplerate. Dit doen we zodat de echotijd dezelfde blijft ongeacht de samplerate.
```
delay = 1500; // choose the echo time of the sound (ms)
echotime = [delay/1000] * samplespeed;
```
Vervolgens gaan we een loop doen over alle samplewaarden. Dit doen we voor de echo te plaatsen op het signaal dat we net binnen gelezen hebben. De eerste samples die in het gebied 'echotime' vallen laten we zonder echo door. Dit doen we omdat we hier geen echo op kunnen toepassen omdat de samplearray op testsign(0) begint [test(n - echotime) gaat negatief in de array en kan dus niet] . Eenmaal er genoeg samples gepasseerd zijn kunnen we echo beginnen toepassing op de rest van de samples. Een echo is simpelweg de waarde van het huidige signaal optellen met een verzwakking van een signaal(echotime) terug .
```
for n=1:length(testsign),
    if n <= echotime  then       //tijd wachten voor echo begint
        outputO = testsign(n); //buffer met origineel
        testsign(n)= outputO;
    elseif n > echotime then  //na bepaalde tijd start de echo
        
        //testsign gelijkstellen aan testsign + signaal van echotime samples terug
         testsign(n)=[testsign(n) + (testsign(n-echotime)*0.7 )]; 
end,
 
end
```

Eenmaal alle samples aangepast zijn naar hun variant met echo kunnen we deze afspelen.
Bovenste speelt met normale snelheid en echo, onderstaande is echto en versneld.
```
playsnd(testsign,samplespeed); //afspelen van het audio-signaal met echo 
// playsnd(testsign,samplespeed * 1.6); //afspelen van het audio-signaal met echo in nightcore mode
```

## SD kaart
We moesten sowieso extra geheugen hebben op onze Arduino om aan muziekverwerkingen te kunnen doen. Er zijn talloze manieren waarop we het geheugen van de Arduino kunnen uitbreiden. Zo hadden we ervoor kunnen kiezen om het werkgeheugen van de Arduino te kunnen uitbreiden. Maar dit heeft weinig nut, we moeten muziek opslaan niet verwerken. Toch niet in de zin dat wij het volledig muziekstuk in ons werkgeheugen moeten plaatsen. Dit zou inefficiënt zijn, een betere werkwijze is in blokken het muziekstuk te sturen naar het RAM geheugen dan te verwerken (Von Neuman cyclus). Om dan uiteindelijk het geluid om je uitput te "zetten" in ons geval onze DAC. 
Dus waarom zouden we dan SRAM geheugen bij plaatsen (n.v.d.r. het RAM geheugen van de DUE is al vrij groot)? We moesten juist ons datageheughen (flash) uitbreiden...

Ik was eerst aan het denken om letterlijk een harde schijf eraan te hangen, ik had hier ooit een artikel over gelezen in Elektor. Het ging om een IDE harde schijf (SATA harde schijven zijn veel te snel om nuttig te gebruiken met een Arduino). Er bestaan bibliotheken om te communiceren met zo'n harde schijven. Alleen is dit wel zeer omslachtig, er waren minstens 24 pinnen nodig van de PATA aansluiting. Als alternatief zocht ik voor een USB stick. Ik weet dat één van de 2 Arduino DUE USB poorten gemaakt om te gebruiken als HOST. Tijdens het zoeken naar informatie hierover, kwam ik op het zalige idee om een SD kaart te gebruiken...

Een beter voorbeeld van flash geheugen kun je niet voorzinnen, het wordt alom gebruikt in smartphones, fototoestellen, ... Ook is het vrij goedkoop. Toevallig hadden we op het school [één SD kaart "reader"](http://cdn1.bigcommerce.com/server800/a8995/products/561/images/1378/SDCardReader_2_1760__92122.1383080948.1280.1280.jpg?c=2) liggen, wij hebben deze direct getest en waren hier heel tevreden mee.

Een SD card bestaat dus uit flash geheugen. We kunnen dit geheugen via SPI aansturen. SPI is een bus die vaak gebruikt wordt in digitale systemen voor korte communicatie. Het is samen met I²C de bekenste communicatiebus voor communicatie tussen IC's (korte afstand).

We hebben tijdens het vak IoT leren werken met SPI, ik ga de volledige werking van SPI hier niet uit te doeken doen. Hiervoor verwijs ik graag naar het vak IoT (theorie + Labo 1 + Labo 2).

Omdat we gebruik zullen maken van Arduino, zullen wij geen native C++ moeten programmeren. We zullen dus niet manueel alle registers moeten instellen. Maar we zullen gebruik maken van een bibliotheek. Dit is één van de grote voordelen van de Arduino wereld.

## SD Card Reader

![SD <-> Arduino](http://i.imgur.com/kxKXH3W.jpg)

De SS pin (ookwel CS pin genoemd) mag je vrij kiezen. Dit kan elke digitale pin zijn. Wij hebben voor '4' gekozen. De rest van de pinnen zijn de voeding en de typische SPI pinnen. Deze pinnen liggen vast!

## Arduino code
Voor we verder gingen met geluid afspelen, hebben we eerst geprobeerd om een simpele tekstbestand te lezen/schrijven naar de SD card. Dit hebben we snel opgelost. De werking was zeer makkelijk, waardoor we zeker waren dat we met de SD kaart verder gingen. Na een snelle test om te bepalen hoe snel de SD card waren we helemaal zeker. De SD card wordt snel genoeg uitgelezen om geluid af te kunnen spelen!

Hierna was het ons doel om een WAV file die af te spelen met de Arduino. We gebruikten Audacity om de WAV file te genereren. Als luidsprekers hebben we 2 boxen van 4 Ohm in serie gebruikt. Deze zijn gedoneerd door Nick den Ridder.
We hebben gebruik gemaakt van de [*Simple Audio Tuturial*](https://www.arduino.cc/en/Tutorial/SimpleAudioPlayer).
Alles staat hier zeer goed in uitgelegd. 

### Play (Via SD kaart)
We hebben extra commentaar toegevoegd. Veel extra kan hier niet over gezegd worden. De code spreekt helemaal voor zich!

Ook hebben we zo ingesteld dat we het bestand 30% sneller afspelen, dan normaal. Dit is zo indien je een mono wav bestand gebruikt. Staat uitgelegd in de code:

```c
/*
  Simple Audio Player

  Demonstrates the use of the Audio library for the Arduino Due

  Hardware required :
  SD card reader with CS on pin 4
  A sound file named "test.wav" in the root directory of the SD card
  An audio amplifier to connect to the DAC0 and ground
  A speaker to connect to the audio amplifier

  Original by Massimo Banzi September 20, 2012
  Modified by Scott Fitzgerald October 19, 2012
  Changed for NightCoreThis by Brecht Carlier January 6, 2016

  This example code is in the public domain
  http://www.arduino.cc/en/Tutorial/SimpleAudioPlayer

*/

//Include libraries
//SD => Reading SD card
//SPI => Communicate with SD card
//Audio => Playing WAV files on DAC
#include <SD.h>
#include <SPI.h>
#include <Audio.h>

void setup() {
  //Start UART @ 115200 baud rate
  Serial.begin(115200);

  //Setup SD-card
  Serial.print("Initializing SD card...");
  //"Start" SD Card => SPI intitializing, ...
  //Pin 4 is the CS pin
  if (!SD.begin(4)) {
    Serial.println(" failed!");
    return;
  }
  Serial.println(" done.");
  // hi-speed SPI transfers
  SPI.setClockDivider(4);

  //Mono: 44100Khz 
  //Stereo: 88200 sample rate
  //100 mSec of prebuffering.
  //1.3 => Play it faster => 30%
  Audio.begin(1.3 * 44100, 100);
}

void loop() {

  //Open wave file from sdcard
  File myFile = SD.open("test.wav");
  if (!myFile) {
    //If the file didn't open, print an error and stop
    Serial.println("Error opening test.wav");
    while (true);
  }

  const int S = 1024; //Number of samples to read in block
  short buffer[S];    //Init buffer

  Serial.println("Playing");
  //Until the file is not finished
  while (myFile.available()) {
    //Read from the file into buffer
    myFile.read(buffer, sizeof(buffer));
    //Prepare samples, save them in the buffer
    //S = Numver of samples
    //1024 = Volume   
    Audio.prepare(buffer, S, 1024);
    //Feed samples to audio, read S amount of samples from the buffer and write it on the DAC buffer => Sound!!!
    Audio.write(buffer, S);
  }
  
  myFile.close();

  Serial.println("End of file. Thank you for listening!");
  while (true);   //Infinite loop, program stopped!
}
```

## Filteren
Onze volgende doel was uiteraard filteren. De zoektoch naar een bibliotheek was moeilijk. Iedereen dit aan filtering deed, deed dit met analoge waardes. Wij samplen (nog) niet. 

Uiteindelijk hadden we er één die het testen waard is.

> [Filter code](http://forum.arduino.cc/index.php?topic=44412.msg321510#msg321510)

Ik voeg een for loop toe om elke 'short' uit te lezen van de buffer array. In deze for voer ik de filter uit. Maar ik hoor geen geluid meer...

Nu wil ik dit debuggen door Serial.println() maar er gebeurd niets meer. Dan heb ik de filter weg gedaan, enkel de Serial.println() laten staan, we zien nu sampels verschijnen. Maar ook geen geluid meer. Mijn conclusie Serial.println() is te traag, we zijn niet instaat te debuggen laat staan de filter te laten werken.

Omdat er bar weinig informatie over te vinden is besluit ik om hiermee te stoppen.

## Samplen
We hadden eerst besloten dit niet te doen. Voor wel één goede reden. De Arduino DUE sampelt te snel. Deze Arduino werkt op een klokfrequentie van 84Mhz. Toen we begonnen aan het samplen van een audio signaal, kwamen we al vrij snel tot de conclusie dat de Arduino te snel aan het samplen was. Dit ging er probleem veroorzaken laten. Wij zouden nooit op deze snelheid geluid kunnen afspelen. En het vergt vooral veel rekenkracht en geheughen om op zo'n snelle frequentie te werken.

We waren dit niet van plan gingen dus opzoek naar een methode om de samplerate aan te passen van de ADC. [In de datasheet van de Cortex M3](http://www.atmel.com/images/atmel-11057-32-bit-cortex-m3-microcontroller-sam3x-sam3a_datasheet.pdf), vind je de nodige informatie. 

>*The ADC clock range is between MCK/2, if PRESCAL is 0, and MCK/512, if PRESCAL is set to 255 (0xFF).
PRESCAL must be programmed in order to provide an ADC clock frequency according to the parameters given in
the product Electrical Characteristics section.*

De minumum clock die we kunnen instellen is dus 84Mhz / 512 = 164kHz. Nog steeds een pak te hoog maar wel het proberen waard.
We stellen dus de juiste register in.

> ADCClock = MCK / ( (PRESCAL+1) * 2 )

![ADC Mode Register](http://i.imgur.com/vuKVgcL.png)

We moeten dus PRESCAL op 255 instellen, deze bevind zich in het ADC Mode Register (43.7.2). Bit 15 tot en met 7 komt is de PRESCAL.

> 0x400C0004 |= 0xFF << 8;

Dit is het 'commando' dat we gebruikt hebben hiervoor. Zet laatste 8 bit (FF) op 1 en schuif het dan 8 plaatsen op naar links. Het zou kunnen dat dit niet volledig het juiste commando is. Mijn C++ kennis is niet zo hoog (wat ik jammer vind). En toen we dit deden was Dhr. M. Luyts ons aan het helpen, waarvoor nog eens dank!

Nadat we dit gedaan hadden, hebben we opnieuw getest maar ging het eigenlijk nog altijd veel te snel. Omdat onze C++ kennis niet bijster groot is hebben we besloten om dit verloopig te stoppen. De ADC heeft ook maar 12 bit, we vonden het niet meer de moeite om te samplen!

## Onverwachte wending
Tijdens de kerstperiode heb ik toch nog iets interssant gevonden. Ik heb namelijk een bibliotheek gevonden om de sample frequentie in te stellen. Deze bibliotheek stond op een blog waar meedere zaken te lezen waren over "Arduino + Sampling". Een echte aanrader! Jammer dat ik hem zo laat gevonden heb.

> [RT Audio](http://www.rtaudio.co.uk/liboverview/)

## Samplen
Er stond een voorbeeld op hoe we moesten samplen en daarna terug afspelen. We hebben dit getest en dit werkt perfect in het mogelijke. De ADC van de Arduino is maar 12 bit. Dus de geluidskwaliteit is niet optimaal. Ook worden alle sampels onder nul gezien als 0. We verliezen dus veel belangrijke informatie. De ADC kan immers geen negatieve voltages omvormen.

We zouden dus nog een schakeling moeten verzinnen die -2 => 2V omzet in 0 => 3V. We hadden hier echter geen tijd meer voor... 
De code vindt u in dit project

## Filteren realtime
Daarna heb ik geprobeerd om de FIR filter toe te voegen. Dit is niet gelukt, zelfde probleem als bij de SD card. Het filter algortime werkt niet snel genoeg. Ik heb code wat moeten aanpassen om de filter er in te krijgen. Ik kan uiteraard niet filteren in de ISR. Maar ook in de loop zelf duurt het te lang.

Ik had hier nog wel wat zaken op kunnen testen, maar omdat ik zelf niet 100% zeker was dat de FIR bibliotheek werkte, ik heb ik dit niet meer gedaan. Ik had eigenlijk zelf een FIR filter bibliotheek moeten maken, waarin ik zelf een convolutie maakte. Ik betwijfel echter of ik dit efficiënt zelf kan maken. Maar dit hadden we nog moeten proberen.

## Echo
Dezelfde persoon had ook een voorbeeld gemaakt om een echo toe te voegen. Deze code was zeer goed gedocumenteerd en is eigenlijk vrij simpel! 

TODO: Wat uitleg

Ik heb zijn code nog aangepast zodanig we niet meer werken met een instelbare delay. Ook de knop om de delay aan en uit te zetten hadden wij niet nodig. </br>
De belangrijkste aanpassing die ik nog gedaan heb, is werken met een extra delay. Zodanig de echo "verder" klinkt. Nu wordt deze nog 2 keer herhaald (origineel maar 1 keer), dus hoor je dezelfde sample 3 keer. De code vind je ook terug bij het verslag. Ook heb ik de schaal aangepast zodanig je de delay kunt invullen als ms. Zo staat hij bij ons ingesteld op 250ms.

## Teensy!?
De Cortex M3 van de Arduino heeft een beperkte ADC met "maar" een resolutie van 12 bit. Ook heeft de M3 geen hardware DSP aan boord. Zijn opvolger de Cortex M4 heeft een 16 bit ADC en wel hardware DSP aan boord. Dit zou dus een veel geschiktere µcontroller zijn om met audio te werken.

De Teensy (Arduino variant), bevat zo'n M4. Je bent hier zelf instaat om gemakkelijk FFT's mee uit tevoeren, en dan kan het echte werk beginnen. Bekijk zeker het onderstaande filmpje (in de link), wat ze daar allemaal maken is eigenlijk wat we nodig hebben en de moeilijkheid is beperkt!

[Playing with Audio, Teensy](http://www.pjrc.com/teensy/td_libs_Audio.html)





## Versterker
*Om onze Arduino (DAC) niet stuk te maken hebben we een versterkingsschakeling gebouwd.*
*De Arduino zou stuk kunnen gaan zonder deze schakeling omdat de max. stroom door de DAC maar 20mA kan/mag bedragen*

### Schema
![schema](http://img.bhs4.com/b5/8/b5880d6404b791d21a95a238d8213884b2c2ce9f_large.jpg)

### Uitleg over het schema

####[IC LM386](http://www.biltek.tubitak.gov.tr/gelisim/elektronik/dosyalar/6/LM386.pdf)

De IC is een vermogen versterker die gebruikt wordt om kleine audio signalen te versterken met een kleine voedingsspanning.
De interne gain van de IC is standaard 20 maar kan verhoogd worden tot liefst 200 door een RC schakeling toe te voegen aan de 1 en 8 pin.
Door hier gebruik te maken van een potentiometer kunnen we beter de versterking bepalen die gedaan wordt op het audio signaal op de ingang.

De inputs van de IC werken t.o.v. de ground, terwijl de output automatisch gebiased is op half de voedingsspanning.
De IC bestaat in 4 uitvoeringen met typerend een zeer lage ruiskarakterestiek en werking is een bereik van 4-12V (de 4de uitvoering werkt in een gebied van 5-18V, indien je hierover zou gaan wordt het component te warm en beschadigd).

Enkele eigenschappen:
* Idle stroom van maar 4mA
* Max. power output van 1.25W bij een 8ohm speaker
* bandbreedte van 300Khz bij 6V voeding

![schema](http://i.imgur.com/nlC1tb1.jpg)

#### Schema

pin 1: verbonden met pin 8 met een RC-kring (variabele weerstand):
*door deze schakeling tussen de gain pinnen van de schakeling te plaatsen kunnen we het volume van de luidspreker aan de uitgang bepalen*

pin 2: verbonden met ground:
*-input naar ground niveau brengen* 

pin 3: verbonden met de variabele weerstand waar het inkomend signaal over staat:
*+input waar we het een fijne instelling kunnen doen via de potentiometer voor het signaal duidelijk op de uitgang te laten horen, eenmaal de instelling gebeurd is moeten we deze weerstand niet meer aanraken*

pin 4: verbonden met ground:
*ground niveau van de IC*

pin 5: verbonden met de uitgangsschakeling:
*uigangsschakeling bestaat uit een RC-kring voor filtering met parallel erover de uitgangsspeaker die in serie staat met een condenstator voor een "bass boost" te verkrijgen en voor de HF-signalen er nog uit te filteren*

pin 6: verbonden met de voeding
*voedingspin van de IC, deze wordt verbonden met een voeding die tussen de 5-12V ligt. Als je deze voeding op 12V zet kan je het volume aan de uitgang luider laten klinken dan als je dit kan met een voeding van 5V (zelfde gain)*

pin 7: verbonden met ground via condensator
*Bypass pin van de ic die we verbinden met de ground via een condensator, dit wordt gedaan om het circuit stabiel te houden en om onnodige oscillaties en clipping te vermijden*

pin 8: verbonden met pin 1 met een RC-kring (variabele weerstand):
*door deze schakeling tussen de gain pinnen van de schakeling te plaatsen kunnen we het volume van de luidspreker aan de uitgang bepalen*

##Taakverdeling
### Bart Kerstens
* opbouwen van versterker
* ontwerpen van echo in scilab

### Brecht Carlier
Ik (Brecht Carlier) heb ervoor gezorgd dat ons team bleef draaien, door de taken de verdelen. In het begin hielp ik waar nodig was. Zo heb ik de versterker helpen meebouwen. En heb ik Arne geholpen met de SD card uitelezen.

Hierna heb ik me gefocuust op het Arduino verhaal, afspelen van muziek, versnellen, samplen, ...

Ik heb ook minieem nog wat geholpen met de filters in Scilab

### Arne Schoonvliet
Mijn taak binnen de groep was het opbouwen van de versterker (wat me niet goed gelukt is maar dankzij teamwork hebben we een ontzettend goede versterker gebouwd). Verder heb ik mezelf bezig gehouden met de filters in scilab. Ik heb deze opgebouwd en getest. Ook heb ik onderzoek gedaan naar het sampelen met de Arduino Due. In het begin leek dit een eenvoudige opgave maar na nader onderzoek zijn we tot de conclusie gekomen dat de sampel frequentie van de Due te hoog ligt. Om de sampel frequentie omlaag te doen heb je een ontzettend goede C kennis nodig. Deze hadden we spijtig genoeg niet in onze groep. Verder heb ik geholpen waar nodig. Ik heb mezelf overal binnen het project ingezet.

### Stijn Schrauwen
Ik werd bekroond tot audacity kenner en vormde stereo mp3 files om naar mono wav bestanden. verder filterde ik deze ook in audacity om te kunnen vergelijken met de praktische en scilab filtering. Verder heb ik 3 spectrum analysers gemaakt voor één voor de LD, één voor de BP en één voor de HD. Verder hielp ik de andere en sprong bij waar nodig.


## Conclusie
De bedoeling was dat je leerde samenwerken in groep en leerde plannen van zo een groot project. Dit als voorbereiding voor onze bachelor proef in het derde jaar. Verder was dit ook een onderzoek naar het ontdekken van de embedded wereld. We kunnen concluderen dat dit onderzoek zeer interessant was. 
Omdat we in groep werkten was het belangrijk dat we een goede taakverdeling hadden. Als u naar het resultaat kijkt mag er geconcludeerd worden dat we dit uitstekend gedaan hebben. We hebben ons project afgekregen. We mogen hier zeer trots op zijn! 
Verder was het ook een zeer leerrijk proces. Ééntje met up en down, iets wat ieder project wel heeft. We hebben leren werken met scilab en onze filters daar met success in opgebouwd. We hebben het echo signaal kunnen maken binnen Arduino en versnellen van het singaal is ook gelukt. Ook hebben we geleerd dat je eerste en ook je tweede en derde idee niet steeds het beste idee is en dat je moet durven veranderen 
We willen ook graag lector M. Smets bedanken voor de hulp als we die nodig hadden. Zijn ervaring en zijn vindingrijkheid heeft ons zeker af en toe geholpen. 
Het was een leerrijk proces en we kijken uit naar onze bachelor proef.

Brecht Carlier, Arne Schoonvliet, Bart Kerstens en Stijn Schrauwen
