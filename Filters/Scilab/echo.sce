
//binnenhalen van de WAV-file
[testsign,Fs,bits]=wavread("D:\Programs\scilab-5.5.2\modules\sound\demos\BART.wav");

//for loop voor de lengte van het audio-signaal
for n=1:length(testsign),
    if n <= 50000  then        //eerste 50.000 samples gewoon doorlaten
        outputO = testsign(n); //buffer met origineel
        testsign(n)= outputO;
    elseif n > 50000 then  //na 50.000 samples echo starten
        
        //testsign gelijkstellen aan testsign + signaal van 50.000 sampeles terug
         testsign(n)=[testsign(n) + (testsign(n-50000)*0.6 )]; 
end,
 
end
playsnd(testsign,44100); //afspelen van het audio-signaal met echo 
