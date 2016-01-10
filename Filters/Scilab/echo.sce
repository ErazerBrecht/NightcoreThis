[testsign,Fs,bits]=wavread("D:\Programs\scilab-5.5.2\modules\sound\demos\BART.wav");
//t = [1:1:length(testsign)]*1/Fs;
outputO = 0;
outputE= 0;
for n=1:length(testsign),
    if n == 1 then        
        outputO = testsign(n);
        testsign(1)= outputO;
        
    elseif n == 2 then 
        outputO = testsign(n);             
        outputE = [testsign(n) + (testsign(n-1)*0.6 )]; 
         testsign(2)= outputE; 
    else 
        outputO = testsign(n);             
        outputE = [testsign(n) + (testsign(n-1)*0.5 ) + (testsign(n-2)*0.3 )];         
        testsign(n) = outputE;
end,
 
end
playsnd(testsign,44100);
