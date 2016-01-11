#Taken in het team

* opbouwen van versterker
* ontwerpen van echo in scilab

#Scilab echo

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

#Versterker
*Om onze Arduino (DAC) niet stuk te maken hebben we een versterkingsschakeling gebouwd.*
*De Arduino zou stuk kunnen gaan zonder deze schakeling omdat de max. stroom door de DAC maar 20mA kan/mag bedragen*

##Schema
![schema](http://img.bhs4.com/b5/8/b5880d6404b791d21a95a238d8213884b2c2ce9f_large.jpg)

###Uitleg over het schema

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
*uigangsschakeling bestaat uit een RC-kring voor filtering met parallel erover de uitgangsspeaker die in serie staat met een condenstator voor een "bass boost" te verkrijgen en voor de HF-signalen er nog uit te filteren*

pin 6: verbonden met de voeding
*voedingspin van de IC, deze wordt verbonden met een voeding die tussen de 5-12V ligt. Als je deze voeding op 12V zet kan je het volume aan de uitgang luider laten klinken dan als je dit kan met een voeding van 5V (zelfde gain)*

pin 7: verbonden met ground via condensator
*Bypass pin van de ic die we verbinden met de ground via een condensator, dit wordt gedaan om het circuit stabiel te houden en om onnodige oscillaties en clipping te vermijden*

pin 8: verbonden met pin 1 met een RC-kring (variabele weerstand):
*door deze schakeling tussen de gain pinnen van de schakeling te plaatsen kunnen we het volume van de luidspreker aan de uitgang bepalen*
