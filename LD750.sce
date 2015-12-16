t = [0: 0.0000625: 0.02];
N = size(t, '*');
sin_100Hz = 2*sin(2*%pi*700*t);
sin_1000Hz = 2*sin(2*%pi*1000*t);
sin_5000Hz = 2*sin(2*%pi*5000*t);
testsign = sin_100Hz + sin_1000Hz + sin_5000Hz;
[LD_coeff, amplitude, frequentie] = wfir('lp',80,[750/16000 0],'hm',[0 0]);
LD_polynoom = poly(LD_coeff, 'z', 'coeff');
LD_functie = horner(LD_polynoom, 1/%z);
LD_lineair_system = syslin('d', LD_functie);
LD_output = flts(testsign, LD_lineair_system);

Frequentie_FFT = abs(fft(testsign));
f = 16000 * (0:(N/2))/N;
n = size(f, '*');
figure;

subplot(311);
plot(f, Frequentie_FFT(1:n));
plot(frequentie*16000, amplitude*N, 'black');
subplot(312);
plot(t, LD_output, 'r');
subplot(313);
plot(t, testsign)
plot(t, LD_output, 'r');
plot(t, sin_100Hz, 'g');
