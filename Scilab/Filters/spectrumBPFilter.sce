Fss = 10000;// a variable for defining they sample frequency called FFs because FS already existed
N=size(t,'*');//Aantal samples
sin_700Hz = 0.5*sin(2*%pi*700*t);
sin_1000Hz = 2*sin(2*%pi*1000*t);
sin_1800Hz = 2*sin(2*%pi*1800*t);
sin_2200Hz = 0.5*sin(2*%pi*2200*t);
testsign = sin_700Hz + sin_1800Hz + sin_2200Hz + sin_1000Hz;//samengesteld signaal

Freq_FFT = abs(fft(testsign));
//abs take absolute value
//FFT() kan je een signaal decomposeren in de sinuscompenten waarmee dit signaal is samengesteld.

f = Fss*(0:(N/2))/N;//geassocieerde frequentie vector
n=size(f,'*');//n krijg de grootte van het aantal samples in f
figure;//grijze achtergrond
plot(f,Freq_FFT(1:n));
//f is an arry with values   
//Freq_FFT(1:n) voor elk element in de array een absolute gedecomposeerde waarde van het samegesteld signaal toe wijzen

[BP_coeff, amplitude, frequentie] = wfir('bp',100,[800/Fss,2000/Fss],'hm',[0 0]);
//Bp = lowpas filter; 100 = orde; 800/Fss,2000/Fss = cut of frequentie; hm = hamming filter; window parameters
//cut of frequentie mag niet hoger zijn dan 0.5 (vanwege de nyquistfrequentie)
//frequentie = Frequency grid
//amplitude = frequency domain filter response on the grid fr
//time domain filter coefficients     niet nodig voor deze toepassing

plot(frequentie*Fss, amplitude*N, 'r');
//frequentie = Frequency grid
//N = aantal keren een frequentie voor komt * amplitude om totale hoogte van een peak te krijgen
//filter output weergeven in rood
