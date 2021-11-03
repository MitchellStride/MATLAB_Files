clear all;
close all;

%Example 1: Plotting deterministic DT signals
figure(1)
n=-2:1:5; n=n';  %initialize the n variable over an appropriate range (array of consecutive integers)
x=[]; 
strTitle=[];
x(:,1)=0.5.^n; strTitle{1}=['Example 1:',newline,'x[n]=(1/2)^n']; 
x(:,2)=(-2).^n; strTitle{2}='x[n]=(-2)^n'; 
x(:,3)=0.5.^(0.5*n); strTitle{3}='x[n]=(0.5)^0^.^5^n'; 
for i=1:3
    subplot(3,1,i)
    stem(n,x(:,i),'filled','k');
    xlabel('n');
    ylabel('x[n]');
    title(strTitle{i})
end

%Example 2: Given x1[n] plot x2[n]=(0.5)^n*x1[n+2]
n=-3:1:9; n=n';  
x=[];
x(:,1)=[0 0 0 0 0 1 2 3 4 5 6 0 0 0 0 0 0 0]; % first column of x is x1[n]
% find x2[n]=(1/2)^n*x1[n+2]
for i=1:length(n)-2
    x(i,2)=0.5^n(i)*x(i+2,1);  % second column of x is x2[n]
end
figure(2)
for i=1:2
    subplot(2,1,i)
    stem(n,x(1:length(n),i),'filled','k'); xlabel('n'); 
    if i==1 strTitle=['Example 2:',newline,'x_1[n]']; else strTitle='x_2[n]=(1/2)^nx_1[n+2]'; end 
    title(strTitle);    
end
    
%Example 3: Plotting sinusoids and the unit step
figure(3)
n=-20:20; n=n'; %define range of n
x=[];
strTitle=[];
x(:,1)=[zeros(1,20) ones(1,21)]'; strTitle{1}=['Example 3:',newline,'x[n]=u[n]']; % u[n]
x(:,2)=cos(pi*n/12); strTitle{2}='x[n]=cos(pi*n/12)'; % cos(pi*n/12)
x(:,3)=cos(pi*n/12 +pi/2); strTitle{3}='x[n]=cos(pi*n/12 + pi/2)'; % cos(pi*n/12 +pi/2)
x(:,4)=x(:,1).*x(:,3); strTitle{4}='x[n]=cos(pi*n/12 + pi/2)u[n]'; % cos(pi*n/12 +pi/4)u[n]
for i=1:4
    subplot(4,1,i)
    stem(n,x(:,i),'filled','k');
    xlabel('n');
    ylabel('x[n]');
    title(strTitle{i});
end

%Example 4: Plotting periodic and aperiodic sinusoids
figure(4)
n=-40:40; n=n';
x=[];
strTitle=[];
x(:,1)=cos(pi*n/5); strTitle{1}=['Example 4:',newline,'x[n]=cos(pi*n/5): periodic, N_o=10']; % cos(pi*n/12)
x(:,2)=x(:,1); strTitle{2}=strTitle{1};
x(:,3)=sin(pi*n/15); strTitle{3}='x[n]=sin(pi*n/15): periodic, N_o=30'; % sin(pi*n/8)
x(:,4)=cos(n/3); strTitle{4}='x[n]=cos(n/3): aperiodic';
x(:,5)=x(:,1)+x(:,3); strTitle{5}='x[n]=cos(pi*n/5) + sin(pi*n/15): periodic, N_o=30';
x(:,6)=x(:,1)+x(:,4); strTitle{6}='x[n]=cos(pi*n/5) + cos(n/3); aperiodic';
for i=1:6 % want to plot first signal twice
    subplot(3,2,i);
    stem(n,x(:,i),'filled','k');
    xlabel('n');
    ylabel('x[n]');
    title(strTitle{i});
end

%Example 5: Plotting a harmonically related family of sinusoids
figure(5)
n=-25:25; n=n';
x=[];
for k=0:5
    y(:,k+1)=cos(k*pi*n/6);
    subplot(3,2,k+1);
    stem(n,y(:,k+1),'filled','k');
    xlabel('n');
    ylabel('x[n]')
    if k==0 || k==6  title(sprintf('Example 5: \n x[n]=cos(%d*pi*n/6)',k));
    else    title(sprintf('x[n]=cos(%d*pi*n/6)',k));
    end
end
figure(6)
for k=6:11
    y(:,k+1)=cos(k*pi*n/6);
    subplot(3,2,k+1-6);
    stem(n,y(:,k+1),'filled','k');
    xlabel('n');
    ylabel('x[n]')
    title(sprintf('x[n]=cos(%d*pi*n/6)',k));
end

%Example 6: Plotting sinusoids with frequencies separated by integer
%multiples of 2*pi (notice they give the exact same signal!)
figure(7)
n=-30:30; n=n';
x=[];
strTitle=[];
x(:,1)=cos(-31*pi*n/8); strTitle{1}=['Example 6:',newline,'x[n]=cos(w_on); w_o=pi/8 - 4*pi'];
x(:,2)=cos(-15*pi*n/8); strTitle{2}='x[n]=cos(w_on); w_o=pi/8 - 2*pi';
x(:,3)=cos(pi*n/8); strTitle{3}='x[n]=cos(w_on); w_o=pi/8';
x(:,4)=cos(17*pi*n/8); strTitle{4}='x[n]=cos(w_on); w_o=pi/8 + 2*pi';
x(:,5)=cos(33*pi*n/8); strTitle{5}='x[n]=cos(w_on); w_o=pi/8 + 4*pi';
x(:,6)=cos(49*pi*n/8); strTitle{6}='x[n]=cos(w_on); w_o=pi/8 + 6*pi';
for i=1:6
    subplot(3,2,i)
    stem(n,x(:,i),'filled','k')
    xlabel('n');
    ylabel('x[n]')
    title(strTitle{i});
end

% Example 7: Plotting unit step and shifted unit step
figure(8)
x=[]; 
strTitle=[];
n=-6:30; n=n';
x(:,1)=[zeros(1,6) ones(1,31)]'; strTitle{1}=['Example 7:',newline,'u[n]']; %u[n]
x(:,2)=zeros(length(x),1); strTitle{2}='u[n-3]'; % initialize to all zeros
x(:,3)=zeros(length(x),1); strTitle{3}='u[n+3]';  % initialize to all zeros
x(:,4)=zeros(length(x),1); strTitle{4}='u[n+3-u[n-3]'; % initialize to all zeros

%find u[n-3]
for k=4:length(x)
    x(k,2)=x(k-3,1); % u[n-3]
end
% find u[n+3]
for k=1:length(x)-3
    x(k,3)=x(k+3,1) % u[n+3]
end
% find u[n+3]-u[n-3]
x(:,4)=x(:,3)-x(:,2);
% plot them
for i=1:4
    subplot(4,1,i)
    stem(n,x(:,i),'filled','k'); title(strTitle{i}); xlabel('n'); xlim([-6 10]);
end

%Example 8: Convolution of finite duration signals in Matlab
n=[0:3]';
x=[1 1 1 1]; % rectangular signal of length 4
h=[1 1 1 1]; % rectangular signal of length 4
y=conv(x,h);
nn=0:length(x)+length(h)-1-1; %this will be the length of the output signal (see note at end)
figure(9); 
subplot(3,1,1)
stem(n,x,'filled','k'); xlim([-1 nn(end)+1]); title(sprintf('Example 8: \n Input signal x[n]'));
subplot(3,1,2)
stem(n,h,'filled','k'); xlim([-1 nn(end)+1]); title('Impulse response function h[n]');
subplot(3,1,3)
stem(nn,y,'filled','k'); xlim([-1 nn(end)+1]); title('Output signal y[n]');

% Note that the length of the output, y, of the convolution is the sum of the
%lengths of the two convolved signals subtract 1 (here, the lengths of x[n] and h[n] are
% both 4, so length of y[n] is 4 + 4 - 1 = 7).


%Example 9: Convolution of infinite duration signals in Matlab - a noisy cosine convolved with h[n] for a 7-point causal moving average filter
n=0:200; n=n';
x=[]; y=[]; h=[];
x(:,1)=20*cos(63*pi*n/32);   %pure cosine (causal)
x(:,2)=2*wgn(length(x),1,1);  %white noise
x(:,3)=x(:,1)+x(:,2);  % cosine with noise
h=[1/7; 1/7; 1/7; 1/7; 1/7; 1/7; 1/7; zeros(194,1)]; % h[n]=1/7[delta[n] + delta[n-1] + delta[n-2] + delta[n-3] + delta[n-4] + delta[n-5] + delta[n-6]] -> moving average filter;
nn=0:length(x)+length(h)-2; %this will be the length of the output signal (see note at end)
figure(10); 
for i=1:3
    subplot(size(x,2)+1,1,i); 
    stem(n,x(:,i),'filled','k'); xlabel('n'); xlim([0 nn(end)]); ylim([-25 25]);
    if i==1 title(sprintf('Example 9: \n cosine function')); elseif i==2 title('Noise'); elseif i==3 title('Cosine + Noise'); end
end
y=conv(x(:,3),h);  %y[n]=x[n]*h[n] (where x[n] is the noisy cosine)
subplot(size(x,2)+1,1,i+1)
stem(nn,y,'filled','k'); xlim([0 nn(end)]); ylim([-25 25]); title('y[n]: filtered signal');

%NOTES: 
%1) First of all note that the effect of the system on the input was to
%reduce the white noise.

% 2) Next note that again the length of the output of the convolution is the sum of the
%lengths of the two convolved signals subtract 1 (here, the length of x[n] is
%201, length of h[n] is 201, and so length of y[n] is 201 + 201 - 1 =401).

% 3) In general the conv command cannot properly convolve infinite-duration signals. 
% Not surprising, since the computer can't store an infinite-duration signal. The conv 
% function can, however,correctly compute a portion of such convolution problems if the 
% signals are causal. If we pass the first N samples of the infinite duration (causal) 
% signal then conv returns a length (2N-1) sequance. The first N samples of this sequence 
% are valid, the remaining N-1 samples are not. 

% So in this example, x[n] is "supposed" to be of infinite duration, but the best we can do is define 
% it over an adequately large range of n (here, I chose from 0 to 200). So if we pass
% in the first 200 samples (N=200) of x[n], and the same for h[n], the
% resulting output y[n] is valid only for n=0 to 200. The full result would
% be valid for the an input x[n]=cos(63*pi*n/32)(u[n]-u[n-201])  (which is effectively 
% what we've entered due to having to truncate x[n]).

%Example 10: Using filter function to compute output of system
%characterized by linear constant coefficient difference equation

% Consider the system from Examples 9 with h[n]=1/7{delta[n] + delta[n-1] + delta[n-2] + delta[n-3] + delta[n-4] + delta[n-5] + delta[n-6]}
% The LCC difference equation for this system is y[n]=1/7{x[n] + x[n-1] + x[n-2] + x[n-3] + x[n-4] + x[n-5] + x[n-6]}
n=0:200; n=n';
x=[]; y=[];
x(:,1)=20*cos(63*pi*n/32);   %pure cosine (causal)
x(:,2)=2*wgn(length(x),1,1);  %white noise
x(:,3)=x(:,1)+x(:,2);  % cosine with noise
a=[1]; b=1/7*[1 1 1 1 1 1 1]; % coefficients of difference equation
y=filter(b,a,x(:,3)); %filtered signal
figure(11)
for i=1:3
    subplot(size(x,2)+1,1,i); 
    stem(n,x(:,i),'filled','k'); xlabel('n'); xlim([0 n(end)]); ylim([-25 25]);
    if i==1 title(sprintf('Example 10: \n cosine function')); elseif i==2 title('Noise'); elseif i==3 title('Cosine + Noise'); end
end
subplot(size(x,2)+1,1,i+1)
stem(n,y,'filled','k'); xlim([0 n(end)]); ylim([-25 25]); title('y[n]: filtered signal');

%Note we get the same result as the convolution
