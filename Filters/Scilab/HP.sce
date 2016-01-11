Fss = 16000;
Speed = 1.3;

[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav");
//[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest1(H-style).wav");

testsign = testsign(1,:);
t = [1:1:length(testsign)]*1/Fs;

[HD_coeff, amplitude, frequentie] = wfir('bp',100,[2050/Fss, 0.5],'hm',[0 0]);
HD_polynoom = poly(LD_coeff, 'z', 'coeff');
HD_functie = horner(HD_polynoom, 1/%z);
HD_lineair_system = syslin('d', HD_functie);
HD_output = flts(testsign, HD_lineair_system);

plot(t, testsign)
plot(t, HD_output, 'r');

playsnd(HD_output,Speed*Fss);
wavwrite(HD_output, Speed*Fss ,'SCI/modules/sound/demos/'+'yolohp.wav');
