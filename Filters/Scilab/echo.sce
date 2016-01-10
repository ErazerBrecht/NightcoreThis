//wavread("D:\Programs\scilab-5.5.2\modules\sound\demos\chimes.wav");


Myfile = uigetfile("*.wav");
[x,y] = loadwave(Myfile);
t = linspace(0/y(8),y(3),y(8));
plot2d(t,x);
