#SD kaart
We moesten sowieso extra geheugen hebben op onze Arduino om aan muziekverwerkingen te kunnen doen. Er zijn talloze manieren waarop we het geheugen van de Arduino kunnen uitbreiden. Zo hadden we ervoor kunnen kiezen om het werkgeheugen van de Arduino te kunnen uitbreiden. Maar dit heeft weinig nut, we moeten muziek opslaan niet verwerken. Toch niet in de zin dat wij het volledig muziekstuk in ons werkgeheugen moeten plaatsen. Dit zou inefficiënt zijn, een betere werkwijze is in blokken het muziekstuk te sturen naar het RAM geheugen dan te verwerken (Von Neuman cyclus). Om dan uiteindelijk het geluid om je uitput te "zetten" in ons geval onze DAC. 
Dus waarom zouden we dan SRAM geheugen bij plaatsen (n.v.d.r. het RAM geheugen van de DUE is al vrij groot)? We moesten juist ons datageheughen (flash) uitbreiden...

Ik was eerst aan het denken om letterlijk een harde schijf eraan te hangen, ik had hier ooit een artikel over gelezen in Elektor. Het ging om een IDE harde schijf (SATA harde schijven zijn veel te snel om nuttig te gebruiken met een Arduino). Er bestaan bibliotheken om te communiceren met zo'n harde schijven. Alleen is dit wel zeer omslachtig, er waren minstens 24 pinnen nodig van de PATA aansluiting. Als alternatief zocht ik voor een USB stick. Ik weet dat één van de 2 Arduino DUE USB poorten gemaakt om te gebruiken als HOST. Tijdens het zoeken naar informatie hierover, kwam ik op het zalige idee om een SD kaart te gebruiken...

Een beter voorbeeld van flash geheugen kun je niet voorzinnen, het wordt alom gebruikt in smartphones, fototoestellen, ... Ook is het vrij goedkoop. Toevallig hadden we op het school [één SD kaart "reader"](http://cdn1.bigcommerce.com/server800/a8995/products/561/images/1378/SDCardReader_2_1760__92122.1383080948.1280.1280.jpg?c=2) liggen, wij hebben deze direct getest en waren hier heel tevreden mee.

TODO

#Arduino code

#Lijm
