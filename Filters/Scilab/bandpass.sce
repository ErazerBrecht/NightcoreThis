Fss = 16000;
Speed = 1.3;

[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav");
//[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest1(H-style).wav");

testsign = testsign(1,:);
t = [1:1:length(testsign)]*1/Fs;

[BD_coeff, amplitude, frequentie] = wfir('bp',100,[800/Fss, 2000/Fss],'hm',[0 0]);
BD_polynoom = poly(BD_coeff, 'z', 'coeff');
BD_functie = horner(BD_polynoom, 1/%z);
BD_lineair_system = syslin('d', BD_functie);
BD_output = flts(testsign, BD_lineair_system);

plot(t, testsign)
plot(t, BD_output, 'r');

playsnd(BD_output,Speed*Fss);
wavwrite(BD_output, Speed*Fss ,'SCI/modules/sound/demos/'+'yolo.wav');
