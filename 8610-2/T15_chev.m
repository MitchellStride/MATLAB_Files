clear all; close all; clc;
wp=2*pi*10000;
ws=2*pi*25000;
amax=0.3;
amin=22;n=
[n, wp] = cheb1ord(wp,ws,amax,amin,'s')
[n, wp]=cheb1ord(wp, ws, amax, amin, 's')
[num,den]= cheby1(n, amax, wp, 's')
sys=tf(num,den)
figure (1)
p=roots(den)
pzmap (sys)
ior can ge·t 20r0s/poles di.rec·tly
f.rom c1·1t􀃉by:l function
[z,p,k]=chebyl(n,amax,wp, 's')
dl=[l -p(3)]; nl=d1(2);
tfl=tf(nl,dl)
d2=conv([l -p(l)],[1 -p(2)]);
n2=d2(3); tf2=tf(n2,d2)
figure(2)
bode (tfl, tf2)
figure(3)
bode(tfl*tf2)