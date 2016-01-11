Fss = 16000; //the bitrate of the song
Speed = 1.3; //how fast the song will be played

[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); //reading the wav (music) file in a matrix
 //[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest1(H-style).wav");

testsign = testsign(1,:); //when reading in the wav file it creates 2 channels (stereo) and we only need one (mono)
t = [1:1:length(testsign)]*1/Fs; //We do this to plot the testsign in function of the sample frequetion of the wav file

//filterontwerp BP met een orde van 100 die filterd van 800hz tot 2000hz
[BD_coeff, amplitude, frequentie] = wfir('bp',100,[800/Fss, 2000/Fss],'hm',[0 0]);
//bepalen van transfertfunctie van de filter
//maken van polynoom (veelterm)
BD_polynoom = poly(BD_coeff, 'z', 'coeff');
//omvormen van z-coeff naar 1/z coeff
BD_functie = horner(BD_polynoom, 1/%z);
//aangeven werken met discrete waarden
BD_lineair_system = syslin('d', BD_functie);
//filteren via scilab
BD_output = flts(testsign, BD_lineair_system);

//plot oorspronkelijk signaal
plot(t, testsign)
//plot gefilterd signaal
plot(t, BD_output, 'r');

//muziek afspelen afhankelijk van de speed
playsnd(BD_output,Speed*Fss);
//schrijven van muziek afhankelijk van speed
wavwrite(BD_output, Speed*Fss ,'SCI/modules/sound/demos/'+'yolo.wav');
