
//binnenhalen van de WAV-file
[testsign,Fs,bits]=wavread("D:\Programs\scilab-5.5.2\modules\sound\demos\BART2.wav");

samplespeed = 44100;
delay = 1500; // choose the echo time of the sound (ms)
echotime = [delay/1000] * samplespeed;

//for loop voor de lengte van het audio-signaal
for n=1:length(testsign),
    if n <= echotime  then       //tijd wachten voor echo begint
        outputO = testsign(n); //buffer met origineel
        testsign(n)= outputO;
    elseif n > echotime then  //na bepaalde tijd start de echo
        
        //testsign gelijkstellen aan testsign + signaal van echotime sampeles terug
         testsign(n)=[testsign(n) + (testsign(n-echotime)*0.7 )]; 
end,
 
end
playsnd(testsign,samplespeed); //afspelen van het audio-signaal met echo 
