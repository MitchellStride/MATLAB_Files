clc; clear; close;
%Chebyshev poles for when amax /= tables 
%And continures to INV Chebyshev poles

%Find E and n
ws= 20000; %*2*pi if Hz
wp= 5450;
amin=35; % Enter dB
amax=3;

fprintf('Verify that.... (From your own workings)\n')
E=sqrt(1/((10^(amin/10))-1))
n=(acosh(sqrt(((10^(amin/10))-1)/(10^(amax/10)-1))))/(acosh(ws/wp))
fprintf('Round up n\n')

n=5 %INPUT HERE U DINGUS COME ON DONT FORGET

%Finding Chebyshev Poles q/ eq use rads
pk=double.empty(0,n);
pkj=double.empty(0,n);
a=(1/n)*asinh(1/E)
for k=1:1:n
    pk(k)=-sin(((2*k-1)*pi)/(2*n))*sinh(a);
    pkj(k)=cos(((2*k-1)*pi)/(2*n))*cosh(a);
end
pk
pkj
fprintf('e.g. 1,2 is outside, 2,4 is 2 inner, 5 is middle\n')

w01=sqrt(abs(pk(1).^2+pkj(1).^2)) %=w02
w03=sqrt(abs(pk(2).^2+pkj(2).^2)) %=w04


%Finding INV Chebyshev Poles q/ eq use rads
fprintf('Inverse Poles')
thetak1= pk(1)%thetak = real part of pole
wk1= pkj(1)%wk = img part of pole
w0k=w01

Sk=double.empty(0,n);
Skj=double.empty(0,n);
for k=1:1:n
    Sk(k)=thetak1/(w0k.^2);
    Skj(k)=wk1/(w0k.^2);
end
Sk
Skj
w01inv=sqrt(abs(Sk(1).^2+Skj(1).^2)) %=w02

fprintf('That was first one 1,2 do rest by hand\n')



