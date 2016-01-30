Fss = 16000; //the bitrate of the song
Speed = 1.3; //how fast the song will be played

[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); //reading the wav (music) file in a matrix

testsign = testsign(1,:); //when reading in the wav file it creates 2 channels (stereo) and we only need one (mono)
t = [1:1:length(testsign)]*1/Fs; //We do this to plot the testsign in function of the sample frequetion of the wav file

//filterontwerp HP met een orde van 100 die filterd met een fc 2050
[HD_coeff, amplitude, frequentie] = wfir('bp',100,[2050/Fss, 0.5],'hm',[0 0]);
//bepalen van transfertfunctie van de filter
//maken van polynoom (veelterm)
HD_polynoom = poly(LD_coeff, 'z', 'coeff');
//omvormen van z-coeff naar 1/z coeff
HD_functie = horner(HD_polynoom, 1/%z);
//aangeven werken met discrete waarden
HD_lineair_system = syslin('d', HD_functie);
//filteren via scilab
HD_output = flts(testsign, HD_lineair_system);

//plot oorspronkelijk signaal
plot(t, testsign)
//plot gefilterd signaal
plot(t, HD_output, 'r');

//muziek afspelen afhankelijk van de speed
playsnd(HD_output,Speed*Fss);
//schrijven van muziek afhankelijk van speed
wavwrite(HD_output, Speed*Fss ,'SCI/modules/sound/demos/'+'yolohp.wav');
