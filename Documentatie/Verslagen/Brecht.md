#SD kaart
We moesten sowieso extra geheugen hebben op onze Arduino om aan muziekverwerkingen te kunnen doen. Er zijn talloze manieren waarop we het geheugen van de Arduino kunnen uitbreiden. Zo hadden we ervoor kunnen kiezen om het werkgeheugen van de Arduino te kunnen uitbreiden. Maar dit heeft weinig nut, we moeten muziek opslaan niet verwerken. Toch niet in de zin dat wij het volledig muziekstuk in ons werkgeheugen moeten plaatsen. Dit zou inefficiënt zijn, een betere werkwijze is in blokken het muziekstuk te sturen naar het RAM geheugen dan te verwerken (Von Neuman cyclus). Om dan uiteindelijk het geluid om je uitput te "zetten" in ons geval onze DAC. 
Dus waarom zouden we dan SRAM geheugen bij plaatsen (n.v.d.r. het RAM geheugen van de DUE is al vrij groot)? We moesten juist ons datageheughen (flash) uitbreiden...

Ik was eerst aan het denken om letterlijk een harde schijf eraan te hangen, ik had hier ooit een artikel over gelezen in Elektor. Het ging om een IDE harde schijf (SATA harde schijven zijn veel te snel om nuttig te gebruiken met een Arduino). Er bestaan bibliotheken om te communiceren met zo'n harde schijven. Alleen is dit wel zeer omslachtig, er waren minstens 24 pinnen nodig van de PATA aansluiting. Als alternatief zocht ik voor een USB stick. Ik weet dat één van de 2 Arduino DUE USB poorten gemaakt om te gebruiken als HOST. Tijdens het zoeken naar informatie hierover, kwam ik op het zalige idee om een SD kaart te gebruiken...

Een beter voorbeeld van flash geheugen kun je niet voorzinnen, het wordt alom gebruikt in smartphones, fototoestellen, ... Ook is het vrij goedkoop. Toevallig hadden we op het school [één SD kaart "reader"](http://cdn1.bigcommerce.com/server800/a8995/products/561/images/1378/SDCardReader_2_1760__92122.1383080948.1280.1280.jpg?c=2) liggen, wij hebben deze direct getest en waren hier heel tevreden mee.

TODO

#Arduino code

##TODO (Via SD kaart)

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

>  0x400C0004 |= TODO

Nadat we dit gedaan hadden, hebben we opnieuw getest maar ging het eigenlijk nog altijd veel te snel. Omdat onze C++ kennis niet bijster groot is hebben we besloten om dit verloopig te stoppen. De ADC heeft ook maar 12 bit, we vonden het niet meer de moeite om te samplen!

##Onverwachte wending
Tijdens de kerstperiode heb ik toch nog iets interssant gevonden. Ik heb namelijk een bibliotheek gevonden om de sample frequentie in te stellen. Deze bibliotheek stond op een blog waar meedere zaken te lezen waren over "Arduino + Sampling". Een echte aanrader! Jammer dat ik hem zo laat gevonden heb.

> [RT Audio](http://www.rtaudio.co.uk/liboverview/)

##Samplen
Er stond een voorbeeld op hoe we moesten samplen en daarna terug afspelen. We hebben dit getest en dit werkt perfect in het mogelijke. De ADC van de Arduino is maar 12 bit. Dus de geluidskwaliteit is niet optimaal. Ook worden alle sampels onder nul gezien als 0. We verliezen dus veel belangrijke informatie.

We zouden dus nog een schakeling moeten verzinnen die -2 => 2V omzet in 0 => 3V. We hadden hier echter geen tijd meer voor. 
De code vindt u in dit project

##Filteren
Daarna heb ik geprobeerd om de FIR filter toe te voegen. Dit is niet gelukt, zelfde probleem als bij de SD card. Het filter algortime werkt niet snel genoeg. Ik heb code wat moeten aanpassen om de filter er in te krijgen. Ik kan uiteraard niet filteren in de ISR. Maar ook in de loop zelf duurt het te lang.

Ik had hier nog wel wat zaken op kunnen testen, maar omdat ik zelf niet 100% zeker was dat de FIR bibliotheek werkte, ik heb ik dit niet meer gedaan. Ik had eigenlijk zelf een FIR filter bibliotheek moeten maken, waarin ik zelf een convolutie maakte. Ik betwijfel echter of ik dit efficiënt zelf kan maken. Maar dit hadden we nog moeten proberen.

#Lijm
