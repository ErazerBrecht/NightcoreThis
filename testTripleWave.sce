//Generates a Test wavfile for testing our filters
//Contains a wav file with three sine waves
//Now it's easy to check if a sine is filtered or not!

t = [0: 0.000001: 1];
sin_500Hz = 0.3*sin(2*%pi*500*t);
sin_1000Hz =0.3*sin(2*%pi*1000*t);
sin_5000Hz =0.3* sin(2*%pi*5000*t);
testsign = sin_500Hz +sin_1000Hz + sin_5000Hz;

wavwrite(testsign, 'SCI/modules/sound/demos/TripleSin.wav');
