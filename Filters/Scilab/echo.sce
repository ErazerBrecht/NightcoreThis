[testsign,Fs,bits]=wavread("D:\Programs\scilab-5.5.2\modules\sound\demos\chimes.wav");
//t = [1:1:length(testsign)]*1/Fs;
outputO = 0;
outputE= 0;
for n=1:length(testsign),
    if n <= 1000  then        
        outputO = testsign(n);
        testsign(1)= outputO;
        
    elseif n > 1000 then 
         testsign(n)=[testsign(n) + (testsign(n-1000)*0.6 )]; 
    elseif n > 2000 then       
             
        testsign(n) = [testsign(n) + (testsign(n-1000)*0.6 ) + (testsign(n-2000)*0.4 )];
end,
 
end
playsnd(testsign,12000);
