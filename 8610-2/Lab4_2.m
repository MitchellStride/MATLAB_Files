%cheblord Chebyshev Type I filter order selection.
clc; clear;

Wp=1000;
Ws=2200;
Rp=0.5;
Rs=25;
[N, Wp] = cheb1ord(Wp, Ws, Rp, Rs, 's') 
