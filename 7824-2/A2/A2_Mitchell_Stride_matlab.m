% ------------------------------------------------------------------------
% DSP A2
% Mitchell Stride, 201517901
% ------------------------------------------------------------------------
clear;
close all;
clc;

% Question 1 --------------------------------------------------------------
% Question 1ai ------
N = [32 64 128 256];
figure('Name','1Ai','NumberTitle','off');
for i = 1:1:4
    xn_k = zeros(N(i), 1);
    xn=zeros(N(i), 1);
    xn(1)=3;
    xn(2)=2;
    xn(3)=1;

    for k = 1:N(i)
        xk = 0;
        for n = 1:N(i)
            xk = xn(n)*exp((-1j)*(2*pi/N(i))*(k-1)*(n-1)) + xk;
        end
        xn_k(k) = xk;
    end
    
    %Plotting
    subplot(4,1,i); stem(0:(N(i)-1),abs(xn_k)); grid; 
    title('N = ' + string(N(i))); xlabel('N'); ylabel('Xi(k)');
    xlim([0 N(i)-1]);
    %stem(n,hA,'filled','k');
end

% Question 1aii ------
N = [32 64 128 256];
figure('Name','1Aii','NumberTitle','off');
for i = 1:1:4
    xn_k = zeros(N(i), 1);
    xn=zeros(N(i), 1);
    xn(1)=1;
    xn(2)=1;
    xn(3)=1;
    xn(4)=1;
    xn(5)=1;
    xn(6)=1;

    for k = 1:N(i)
        xk = 0;
        for n = 1:N(i)
            xk = xn(n)*exp((-1j)*(2*pi/N(i))*(k-1)*(n-1)) + xk;
        end
        xn_k(k) = xk;
    end
    
    %Plotting
    subplot(4,1,i); stem(0:(N(i)-1),abs(xn_k)); grid; 
    title('N = ' + string(N(i))); xlabel('N'); ylabel('Xi(k)');
    xlim([0 N(i)-1]);
    %stem(n,hA,'filled','k');
end

% Question 1b ------
% Question 1bi ------
fprintf('Question 1bi \n');
xn =0;
xn(1)=3;
xn(2)=2;
xn(3)=1;

Xi = 0;
w = [2*pi/32 9*pi/8];

%Finding Xi
for m=1:2
    for i=1:length(xn)
        Xi = xn(i)*exp((-1j)*(w(m))*(i-1)) + Xi;
    end
    fprintf('1bi) Xi with w = ' + string(w(m)))
    abs(Xi)
    Xi = 0;
end

% Question 1bii ------
xn=0;
xn(1)=1;
xn(2)=1;
xn(3)=1;
xn(4)=1;
xn(5)=1;
xn(6)=1;

Xi = 0;

%Finding Xi
for m=1:2
    for i=1:length(xn)
        Xi = xn(i)*exp((-1j)*(w(m))*(i-1)) + Xi;
    end
    fprintf('1bii) Xi with w= ' + string(w(m)))
    abs(Xi)
    Xi = 0;
end

% Question 2 --------------------------------------------------------------
% Question 2ai ------
figure('Name','2Ai','NumberTitle','off');
for i = 1:1:4
    xn_k = zeros(N(i), 1);
    xn=zeros(N(i), 1);
    xn(1)=3;
    xn(2)=2;
    xn(3)=1;

xn_k = fft(xn);
    
    %Plotting
    subplot(4,1,i); stem(0:(N(i)-1),abs(xn_k)); grid; 
    title('N = ' + string(N(i))); xlabel('N'); ylabel('Xi(k)');
    xlim([0 N(i)-1]);
    %stem(n,hA,'filled','k');
end

% Question 2aii ------
figure('Name','2Aii','NumberTitle','off');
for i = 1:1:4
    xn_k = zeros(N(i), 1);
    xn=zeros(N(i), 1);
    xn(1)=1;
    xn(2)=1;
    xn(3)=1;
    xn(4)=1;
    xn(5)=1;
    xn(6)=1;

xn_k = fft(xn);
       
    %Plotting
    subplot(4,1,i); stem(0:(N(i)-1),abs(xn_k)); grid; 
    title('N = ' + string(N(i))); xlabel('N'); ylabel('Xi(k)');
    xlim([0 N(i)-1]);
    %stem(n,hA,'filled','k');
end

% Question 3 --------------------------------------------------------------
% Question 3a ------
fs = 100;
Ts = 1/fs;
t = 0:0.0001:0.5;
n = 0:Ts:0.5;

xt = sin(pi/6*t);
xn = sin(pi/6*n);

%Plotting
figure('Name','3A','NumberTitle','off');
plot(t, xt); hold on;
stem(n, xn); hold off;
grid; title('x[n] = sin((π/6)*n)'); xlabel('t [s]'); 
ylabel('x(t), x(nT)');

% Question 3b ------
fs = 4;
Ts = 1/fs;
t = 0:0.0001:15;
n = 0:Ts:15;

xt = (0.9.^t).*cos(pi/8*t);
xn = (0.9.^n).*cos(pi/8*n);

%Plotting
figure('Name','3B','NumberTitle','off');
plot(t, xt); hold on;
stem(n, xn); hold off;
grid; title('x[n] = (0.9.^n)cos((π/8)*n)'); xlabel('t [s]'); 
ylabel('x(t), x(nT)');

% Question 3c ------
fs = 20;
Ts = 1/fs;
t = 0:0.0001:2.5;
n = 0:Ts:2.5;

xt = t;
xn = n;

%Plotting
figure('Name','3C','NumberTitle','off');
plot(t, xt); hold on;
stem(n, xn); hold off;
grid; title('x[n] = n'); xlabel('t [s]'); 
ylabel('x(t), x(nT)');

% Question 4 --------------------------------------------------------------
% Question 4a ------
EEG = load('Assign2_eeg.mat');
fs = 256;
Ts = 1/fs;
Ns = 5409; %From inspection after loading file
time = Ts*(Ns-1);
t = 0:Ts:time;

figure('Name','4A','NumberTitle','off');
plot(t,EEG.data);  grid; 
title('EEG Signal'); xlabel('t [s]'); ylabel('EEG');
xlim([0 time]);

% Question 4b ------
eeg_fft = abs(fft(EEG.data));
ws = fs*2*pi;
Ws = 0:ws/(Ns-1):ws;

figure('Name','4B','NumberTitle','off');
plot(Ws,eeg_fft);  grid; 
title('EEG Signal FFT'); xlabel('Ws'); ylabel('EEG FFT');
xlim([0 ws]);

% Question 5 --------------------------------------------------------------
% Question 5a ------
fprintf('Question 5a')
b = [0.0001201 0.0009608 0.003363 0.006725 0.008407 0.006725 0.003363 0.0009608 0.0001201];
a = [1 -3.919 7.325 -8.275 6.106 -2.989 0.9423 -0.1742 0.01442];
Hz=tf(b,a)
%Select option to open by default.
fvtool(b,a,'freq'); %'freq', 'impulse', 'polezero'

% Question 5c ------
%Create Xn
fs = 10;
Ts = 1/fs;
time = 20; %Sampling 25Hz for 20s
% t = 0:0.0001:time;
n = 0:Ts:time;

% xt = sin((pi/5)*t);
xn = sin((9*pi/2)*n) + sin((pi/5)*n);
yn = filter(b,a,xn);
xn_filt = sin((pi/5)*n);

figure('Name','5C','NumberTitle','off');
subplot(3,1,1); stem(n,xn); grid; title('Input Signal x[n] = sin((9π/2)*n) + sin((π/5)*n)'); 
xlabel('t [s]'); ylabel('x[n]'); xlim([0 time]);

subplot(3,1,2); stem(n,yn); grid; title('Filtered Signal y[n]'); 
xlabel('t [s]'); ylabel('y[n]'); xlim([0 time]);

subplot(3,1,3); stem(n,xn_filt); grid; title('Reference x[n] = sin((π/5)*n)'); 
xlabel('t [s]'); ylabel('x[n]'); xlim([0 time]);
