Fss = 16000; //the bitrate of the song
Speed = 1.3; //how fast the song will be played

[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); //reading the wav (music) file in a matrix

testsign = testsign(1,:); //when reading in the wav file it creates 2 channels (stereo) and we only need one (mono)
t = [1:1:length(testsign)]*1/Fs; //We do this to plot the testsign in function of the sample frequetion of the wav file

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

//muziek afspelen afhankelijk van de speed
playsnd(LD_output,Speed*Fss);
//schrijven van muziek afhankelijk van speed
wavwrite(LD_output, Speed*Fss ,'SCI/modules/sound/demos/'+'yolold.wav');
