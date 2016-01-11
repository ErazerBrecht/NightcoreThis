Fss = 10000;
N=size(t,'*');//Aantal samples
sin_100Hz = 2*sin(2*%pi*100*t);
sin_500Hz = 1*sin(2*%pi*500*t);
sin_1000Hz = 0.5*sin(2*%pi*1000*t);
testsign = sin_100Hz + sin_500Hz + sin_1000Hz;//samengesteld signaal

Freq_FFT = abs(fft(testsign));
//abs take absolute value
//FFT() kan je een signaal decomposeren in de sinuscompenten waarmee dit signaal is samengesteld.

f = Fss*(0:(N/2))/N;//geassocieerde frequentie vector
n=size(f,'*');
figure;//grijze achtergrond
plot(f,Freq_FFT(1:n));// 

[HD_coeff, amplitude, frequentie] = wfir('lp',100,[750/Fss],'hm',[0 0]);
//lp = lowpas filter; 100 = orde; 750/Fss = cut of frequentie; hm = hamming filter; window parameters
//frequentie = Frequency grid
//amplitude = frequency domain filter response on the grid fr
//time domain filter coefficients     niet nodig voor deze toepassing

plot(frequentie*Fss, amplitude*N, 'r');
//frequentie = Frequency grid
//
//filter output weergeven in rood
