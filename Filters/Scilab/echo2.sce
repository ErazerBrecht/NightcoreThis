//binnenhalen van de WAV-file
[testsign,Fs,bits]=wavread("F:\scilab-5.5.2\modules\sound\demos\BART4.wav");
samplespeed = Fs;
delay = 500; // choose the echo time of the sound (ms)
echotime = [delay/1000] * samplespeed;

//for loop voor de lengte van het audio-signaal
for n=1:length(testsign),
    if n + echotime < length(testsign) then  //na bepaalde tijd start de echo
        //testsign gelijkstellen aan testsign + signaal van echotime sampeles terug
        testsign(n + echotime)=testsign(n+echotime) + testsign(n) * 0.6;
     end         
end

playsnd(testsign,samplespeed); //afspelen van het audio-signaal met echo 
//playsnd(testsign,samplespeed * 1.3); //afspelen van het audio-signaal met echo in nightcore mode
