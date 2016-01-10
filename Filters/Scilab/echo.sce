[testsign,Fs,bits]=wavread("D:\Programs\scilab-5.5.2\modules\sound\demos\BART.wav");
//t = [1:1:length(testsign)]*1/Fs;
outputO = 0;
outputE= 0;
for n=1:length(testsign),
    if n <= 50000  then        
        outputO = testsign(n);
        testsign(1)= outputO;
        
    elseif n > 50000 then 
         testsign(n)=[testsign(n) + (testsign(n-50000)*0.6 )]; 
    elseif n > 100000 then       
             
        testsign(n) = [testsign(n) + (testsign(n-50000)*0.6 ) + (testsign(n-100000)*0.7 )];
end,
 
end
playsnd(testsign,44100);
