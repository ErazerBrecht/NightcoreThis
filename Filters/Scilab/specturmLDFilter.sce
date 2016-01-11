Fss = 10000;
t = [0:1/Fss:0.1];
N=size(t,'*');
sin_100Hz = 2*sin(2*%pi*100*t);
sin_500Hz = 1*sin(2*%pi*500*t);
sin_1000Hz = 0.5*sin(2*%pi*1000*t);
testsign = sin_100Hz + sin_500Hz + sin_1000Hz;

Freq_FFT = abs(fft(testsign));
f = Fss*(0:(N/2))/N;
n=size(f,'*');
figure;
plot(f,Freq_FFT(1:n));

[HD_coeff, amplitude, frequentie] = wfir('lp',100,[750/Fss],'hm',[0 0]);


plot(frequentie*Fss, amplitude*N, 'r');
