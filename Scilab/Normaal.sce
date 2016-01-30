Fss = 16000; //the bitrate of the song
Speed = 1; //how fast the song will be played

[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav"); //reading the wav (music) file in a matrix

testsign = testsign(1,:); //when reading in the wav file it creates 2 channels (stereo) and we only need one (mono)
t = [1:1:length(testsign)]*1/Fs; //We do this to plot the testsign in function of the sample frequetion of the wav file

//muziek afspelen afhankelijk van de speed
playsnd(testsign,Speed*Fss);
