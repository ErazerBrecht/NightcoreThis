Fss = 16000;
t = [0:0.001:0.2];
sin_10Hz = 2*sin(2*%pi*10*t);
sin_100Hz = 1*sin(2*%pi*100*t);
sin_300Hz = 0.5*sin(2*%pi*300*t);
testsign = sin_10Hz + sin_100Hz + sin_300Hz;

[LD_coeff, amplitude, frequentie] = wfir('bp',100,[2050/Fss, 0.5],'hm',[0 0]);
LD_polynoom = poly(LD_coeff, 'z', 'coeff');
LD_functie = horner(LD_polynoom, 1/%z);
LD_lineair_system = syslin('d', LD_functie);
LD_output = flts(testsign, LD_lineair_system);

plot(t, testsign)
plot(t, LD_output, 'r');
