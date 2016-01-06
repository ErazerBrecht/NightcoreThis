Fss = 10000;
t = [0:1/Fss:0.1];
N=size(t,'*');
sin_700Hz = 0.5*sin(2*%pi*700*t);
sin_1000Hz = 2*sin(2*%pi*1000*t);
sin_1800Hz = 2*sin(2*%pi*1800*t);
sin_2200Hz = 0.5*sin(2*%pi*2200*t);
testsign = sin_700Hz + sin_1800Hz + sin_2200Hz + sin_1000Hz;

Freq_FFT = abs(fft(testsign));
f = Fss*(0:(N/2))/N;
n=size(f,'*');
figure;
plot(f,Freq_FFT(1:n));

[LD_coeff, amplitude, frequentie] = wfir('bp',100,[800/Fss,2000/Fss],'hm',[0 0]);


plot(frequentie*Fss, amplitude*N, 'r');
