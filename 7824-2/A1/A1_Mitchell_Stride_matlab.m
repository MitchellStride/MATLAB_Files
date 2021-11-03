% ------------------------------------------------------------------------
% DSP A1
% Mitchell Stride, 201517901
% ------------------------------------------------------------------------
clear;
close all;

% Question 1 --------------------------------------------------------------
% Question 1B
% y[n]-y[n-1]+y[n-2]=x[n]
n=-5:1:60;          %init n over -5 to 60
hA=zeros(66,1);     %Create hA

for i=1:1:66        %Fill hA with correct values.
    if (i-6)<0 || mod(i,6)==2 || mod(i,6)==5
        hA(i)=0;
    elseif mod(i,6)==0 || mod(i,6)==1
        hA(i)=1;
    elseif mod(i,6)==3 || mod(i,6)==4
        hA(i)=-1;
    end
end

figure(1)
subplot(2,1,1); stem(n,hA,'filled','k'); grid; 
title('Q1B - hA[n] vs. n'); xlabel('n'); ylabel('hA[n]');

% Question 1C
x=zeros(66,1);      %Create x
x(6)=1;             %Setting x(0) as delta input but shifted from -5 start
a=[1 -1 1];
b=[1];
hA=filter(b,a,x);

subplot(2,1,2); stem(n,hA,'filled','k'); grid; 
title('Q1C - hA[n] vs. n from filter function'); xlabel('n'); ylabel('hA[n]');

% Question 1E
x=[];                        %Create x
u1=[zeros(1,5) ones(1,61)];   %Unit Step u[n]
x(:,1)=cos(2*pi*n/6).*u1;
a=[1 -1 1];
b=[1];
y=filter(b,a,x);

figure(2)
subplot(2,1,1); stem(n,x,'filled','k'); grid; 
title('Q1E - x[n] vs. n'); xlabel('n'); ylabel('x[n]');
subplot(2,1,2); stem(n,y,'filled','k'); grid; 
title('Q1E - y[n] vs. n'); xlabel('n'); ylabel('y[n]');

% Question 2 --------------------------------------------------------------
% Question 2A
u2=[zeros(1,10) ones(1,56)];   %Unit Step u[n-5]
hB=zeros(66,1);     %Create hB
hB=hA.*transpose(u1-u2);

figure(3)
subplot(1,1,1); stem(n,hB,'filled','k'); grid; 
title('Q2A - hB[n] vs. n'); xlabel('n'); ylabel('hB[n]');

% Question 2C
% y[n]=x[n]+x[n-1]-x[n-3]-x[n-4]
a=[1];
b=[1 1 0 -1 -1];
y=filter(b,a,x);

figure(4)
subplot(2,1,1); stem(n,x,'filled','k'); grid; 
title('Q2C - x[n] vs. n'); xlabel('n'); ylabel('x[n]');
subplot(2,1,2); stem(n,y,'filled','k'); grid; 
title('Q2C - y[n] vs. n'); xlabel('n'); ylabel('y[n]');

% Question 2E
n1=0:1:60;         %new n from 0 to 60
x1=zeros(61,1);
hB1=zeros(61,1); 
for i=1:1:61
    hB1(i)=hB(i+5);
    x1(i)=x(i+5);
end
y1=conv(x1,hB1);    %using conv function this time
y1=y1(1:end-60);    %shortening / fixing y

figure(5)
subplot(3,1,1); stem(n1,x1,'filled','k'); grid; 
title('Q2E - x[n] vs. n'); xlabel('n'); ylabel('x[n]');
subplot(2,1,2); stem(n1,y1,'filled','k'); grid; 
title('Q2E - y[n] vs. n from conv function'); xlabel('n'); ylabel('y[n]');

% Question 3 --------------------------------------------------------------
% Filter with moving average.

load('Assignment1_Q3_DTsignal.mat');
figure(6)
subplot(3,1,1); plot(xn); grid; 
title('Q3 - x[n] vs. n loaded from Assignment1 Q3 DTsignal.mat'); 
xlabel('n'); ylabel('x[n]');

%Adding filter y[n]=(1/N)*(X[n]+x[n-1]+....+x[n-(m-1)])
N=[5 10 20 30 40 50];
y2=cell(1,6);
yleg=cell(1,6);
a=ones(1,1);
subplot(3,1,2); grid; title('Q3 - x[n] & y[n] vs. n w/ moving filter'); 
xlabel('n'); ylabel('x[n] & y[n]');
hold on
for i=1:1:6
    b=(1/N(i))*ones(1,N(i));
    y2{i}=filter(b,a,xn);
    yleg{i}=plot(y2{i});
end
legend([yleg{1},yleg{2},yleg{3},yleg{4},yleg{5},yleg{6}],'N = 5','N = 10','N = 20','N = 30','N = 40','N = 50')
hold off
subplot(3,1,3); plot(y2{3}) ;grid; title('Q3 - y[n] N= 20 vs. n'); 
xlabel('n'); ylabel('y[n]');

% Question 4 --------------------------------------------------------------
% Fourier Series Plotting
k=0:1:31;
ak=0;
x3=[ones(1,5) zeros(1,23) ones(1,4)];

for i=1:1:32
    ak=ak+(1/32)*x3(i)*exp(-j*k*(2*pi/32)*(i-1));
end
%warning('off','last')

figure(7)
subplot(1,1,1); stem(k,ak,'filled','k'); grid; 
title('Q4 - ak[k] vs. k'); xlabel('k'); ylabel('ak[k]');

% Question 5 --------------------------------------------------------------
% Fourier Series Synthesis
figure(8)
n2=0:1:31;
xh=0;
hf=[8 16 24 32];
for z=1:1:4
    for i=1:1:hf(z)
         xh=xh+ak(i)*exp(j*(i-1)*(2*pi/32)*n2);
         subplot(4,1,z); stem(n2,xh,'filled','k'); grid; 
         title(['Q5 - Harmonic = ',num2str(hf(z)),' x[n] vs. n']); 
         xlabel('n'); ylabel('x[n]');
    end
    xh=0;
end

% Question 6 --------------------------------------------------------------
% Question 6A
load('Assignment1_Q6_DTsignal.mat');
figure(9)
ak = 0;         %Clear Variable
k=0:1:15;
for i=1:1:16
    ak=ak+(1/16)*xa(i)*exp(-j*k*(2*pi/16)*(i-1));
end
subplot(2,1,1); plot(xa); grid; 
title(['Q6A - xa[n] vs. n']); 
xlabel('n'); ylabel('ak[k]');
subplot(2,1,2); stem(k,ak,'filled','k'); grid; 
title(['Q6A - ak[k] vs. k for one period of xa[n]']); 
xlabel('k'); ylabel('ak[k]');

% Question 6B
figure(10)
ak = 0;         %Clear Variable
k=0:1:30;
for i=1:1:31
    ak=ak+(1/30)*xb(i)*exp(-j*k*(2*pi/30)*(i-1));
end
subplot(3,1,1); plot(xb); grid; 
title(['Q6B - xb[n] vs. n']); 
xlabel('n'); ylabel('xb[n]');
subplot(3,1,2); stem(k,(ak),'filled','k'); grid; 
title(['Q6B - Real ak[k] vs. k for one period of xb[n]']); 
xlabel('k'); ylabel('ak[k]');
subplot(3,1,3); stem(k,imag(ak),'filled','k'); grid; 
title(['Q6B - Imag ak[k] vs. k for one period of xb[n]']); 
xlabel('k'); ylabel('ak[k]');
