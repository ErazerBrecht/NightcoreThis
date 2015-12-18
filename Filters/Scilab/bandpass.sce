[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest2(anja).wav");
//[testsign,Fs,bits]=wavread("SCI/modules/sound/demos/filterTest1(H-style).wav");

testsign = testsign(1,:);
t = [1:1:length(testsign)]*1/Fs;

[LD_coeff, amplitude, frequentie] = wfir('bp',100,[800/16000, 2000/16000],'hm',[0 0]);
LD_polynoom = poly(LD_coeff, 'z', 'coeff');
LD_functie = horner(LD_polynoom, 1/%z);
LD_lineair_system = syslin('d', LD_functie);
LD_output = flts(testsign, LD_lineair_system);

plot(t, testsign)
plot(t, LD_output, 'r');

wavwrite(LD_output, 'SCI/modules/sound/demos/'+'yolo.wav');
