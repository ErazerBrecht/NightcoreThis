#SD kaart
We moesten sowieso extra geheugen hebben op onze Arduino om aan muziekverwerkingen te kunnen doen. Er zijn talloze manieren waarop we het geheugen van de Arduino kunnen uitbreiden. Zo hadden we ervoor kunnen kiezen om het werkgeheugen van de Arduino te kunnen uitbreiden. Maar dit heeft weinig nut, we moeten muziek opslaan niet verwerken. Toch niet in de zin dat wij het volledig muziekstuk in ons werkgeheugen moeten plaatsen. Dit zou inefficiënt zijn, een betere werkwijze is in blokken het muziekstuk te sturen naar het RAM geheugen dan te verwerken (Von Neuman cyclus). Om dan uiteindelijk het geluid om je uitput te "zetten" in ons geval onze DAC. 
Dus waarom zouden we dan SRAM geheugen bij plaatsen (n.v.d.r. het RAM geheugen van de DUE is al vrij groot)? We moesten juist ons datageheughen (flash) uitbreiden...

Ik was eerst aan het denken om letterlijk een harde schijf eraan te hangen, ik had hier ooit een artikel over gelezen in Elektor. Het ging om een IDE harde schijf (SATA harde schijven zijn veel te snel om nuttig te gebruiken met een Arduino). Er bestaan bibliotheken om te communiceren met zo'n harde schijven. Alleen is dit wel zeer omslachtig, er waren minstens 24 pinnen nodig van de PATA aansluiting. Als alternatief zocht ik voor een USB stick. Ik weet dat één van de 2 Arduino DUE USB poorten gemaakt om te gebruiken als HOST. Tijdens het zoeken naar informatie hierover, kwam ik op het zalige idee om een SD kaart te gebruiken...

Een beter voorbeeld van flash geheugen kun je niet voorzinnen, het wordt alom gebruikt in smartphones, fototoestellen, ... Ook is het vrij goedkoop. Toevallig hadden we op het school [één SD kaart "reader"](http://cdn1.bigcommerce.com/server800/a8995/products/561/images/1378/SDCardReader_2_1760__92122.1383080948.1280.1280.jpg?c=2) liggen, wij hebben deze direct getest en waren hier heel tevreden mee.

Een SD card bestaat dus uit flash geheugen. We kunnen dit geheugen via SPI aansturen. SPI is een bus die vaak gebruikt wordt in digitale systemen voor korte communicatie. Het is samen met I²C de bekenste communicatiebus voor communicatie tussen IC's (korte afstand).

We hebben tijdens het vak IoT leren werken met SPI, ik ga de volledige werking van SPI hier niet uit te doeken doen. Hiervoor verwijs ik graag naar het vak IoT (theorie + Labo 1 + Labo 2).

Omdat we gebruik zullen maken van Arduino, zullen wij geen native C++ moeten programmeren. We zullen dus niet manueel alle registers moeten instellen. Maar we zullen gebruik maken van een bibliotheek. Dit is één van de grote voordelen van de Arduino wereld.

#SD Card Reader

![SD <-> Arduino](http://i.imgur.com/kxKXH3W.jpg)

De SS pin (ookwel CS pin genoemd) mag je vrij kiezen. Dit kan elke digitale pin zijn. Wij hebben voor '4' gekozen. De rest van de pinnen zijn de voeding en de typische SPI pinnen. Deze pinnen liggen vast!

#Arduino code
Voor we verder gingen met geluid afspelen, hebben we eerst geprobeerd om een simpele tekstbestand te lezen/schrijven naar de SD card. Dit hebben we snel opgelost. De werking was zeer makkelijk, waardoor we zeker waren dat we met de SD kaart verder gingen. Na een snelle test om te bepalen hoe snel de SD card waren we helemaal zeker. De SD card wordt snel genoeg uitgelezen om geluid af te kunnen spelen!

Hierna was het ons doel om een WAV file die af te spelen met de Arduino. We gebruikten Audacity om de WAV file te genereren. Als luidsprekers hebben we 2 boxen van 4 Ohm in serie gebruikt. Deze zijn gedoneerd door Nick den Ridder.
We hebben gebruik gemaakt van de [*Simple Audio Tuturial*](https://www.arduino.cc/en/Tutorial/SimpleAudioPlayer).
Alles staat hier zeer goed in uitgelegd. 

##Play (Via SD kaart)
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

##Filteren
Onze volgende doel was uiteraard filteren. De zoektoch naar een bibliotheek was moeilijk. Iedereen dit aan filtering deed, deed dit met analoge waardes. Wij samplen (nog) niet. 

Uiteindelijk hadden we er één die het testen waard is.

> [Filter code](http://forum.arduino.cc/index.php?topic=44412.msg321510#msg321510)

Ik voeg een for loop toe om elke 'short' uit te lezen van de buffer array. In deze for voer ik de filter uit. Maar ik hoor geen geluid meer...

Nu wil ik dit debuggen door Serial.println() maar er gebeurd niets meer. Dan heb ik de filter weg gedaan, enkel de Serial.println() laten staan, we zien nu sampels verschijnen. Maar ook geen geluid meer. Mijn conclusie Serial.println() is te traag, we zijn niet instaat te debuggen laat staan de filter te laten werken.

Omdat er bar weinig informatie over te vinden is besluit ik om hiermee te stoppen.

##Samplen
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

##Onverwachte wending
Tijdens de kerstperiode heb ik toch nog iets interssant gevonden. Ik heb namelijk een bibliotheek gevonden om de sample frequentie in te stellen. Deze bibliotheek stond op een blog waar meedere zaken te lezen waren over "Arduino + Sampling". Een echte aanrader! Jammer dat ik hem zo laat gevonden heb.

> [RT Audio](http://www.rtaudio.co.uk/liboverview/)

##Samplen
Er stond een voorbeeld op hoe we moesten samplen en daarna terug afspelen. We hebben dit getest en dit werkt perfect in het mogelijke. De ADC van de Arduino is maar 12 bit. Dus de geluidskwaliteit is niet optimaal. Ook worden alle sampels onder nul gezien als 0. We verliezen dus veel belangrijke informatie. De ADC kan immers geen negatieve voltages omvormen.

We zouden dus nog een schakeling moeten verzinnen die -2 => 2V omzet in 0 => 3V. We hadden hier echter geen tijd meer voor... 
De code vindt u in dit project

##Filteren realtime
Daarna heb ik geprobeerd om de FIR filter toe te voegen. Dit is niet gelukt, zelfde probleem als bij de SD card. Het filter algortime werkt niet snel genoeg. Ik heb code wat moeten aanpassen om de filter er in te krijgen. Ik kan uiteraard niet filteren in de ISR. Maar ook in de loop zelf duurt het te lang.

Ik had hier nog wel wat zaken op kunnen testen, maar omdat ik zelf niet 100% zeker was dat de FIR bibliotheek werkte, ik heb ik dit niet meer gedaan. Ik had eigenlijk zelf een FIR filter bibliotheek moeten maken, waarin ik zelf een convolutie maakte. Ik betwijfel echter of ik dit efficiënt zelf kan maken. Maar dit hadden we nog moeten proberen.

##Echo
Dezelfde persoon had ook een voorbeeld gemaakt om een echo toe te voegen. Deze code was zeer goed gedocumenteerd en is eigenlijk vrij simpel! 

TODO: Wat uitleg

Ik heb zijn code nog aangepast zodanig we niet meer werken met een instelbare delay. Ook de knop om de delay aan en uit te zetten hadden wij niet nodig. </br>
De belangrijkste aanpassing die ik nog gedaan heb, is werken met een extra delay. Zodanig de echo "verder" klinkt. Nu wordt deze nog 2 keer herhaald (origineel maar 1 keer), dus hoor je dezelfde sample 3 keer. De code vind je ook terug bij het verslag. Ook heb ik de schaal aangepast zodanig je de delay kunt invullen als ms. Zo staat hij bij ons ingesteld op 250ms.

##Teensy!?
De Cortex M3 van de Arduino heeft een beperkte ADC met "maar" een resolutie van 12 bit. Ook heeft de M3 geen hardware DSP aan boord. Zijn opvolger de Cortex M4 heeft een 16 bit ADC en wel hardware DSP aan boord. Dit zou dus een veel geschiktere µcontroller zijn om met audio te werken.

De Teensy (Arduino variant), bevat zo'n M4. Je bent hier zelf instaat om gemakkelijk FFT's mee uit tevoeren, en dan kan het echte werk beginnen. Bekijk zeker het onderstaande filmpje (in de link), wat ze daar allemaal maken is eigenlijk wat we nodig hebben en de moeilijkheid is beperkt!

[Playing with Audio, Teensy](http://www.pjrc.com/teensy/td_libs_Audio.html)


#Lijm
