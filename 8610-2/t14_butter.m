% T14 Buttorworth
clc
syms x 
clear
%-----------------
wn = 1000; %input corner freq in rad/s
order = 4; %desired order of filter
[n,d] = butter(order, wn, 'low', 's'); %'low', 'high' pass
                               % 's' for analog, default is digital
sys=tf(n,d)
bode(sys)

%Factorization -----------------------------
z=roots(n) %zeros from numerator
p=roots(d) %poles from denom
% Multiply for complex conjugate pairs to get 2nd order polynomials
% numerator of new T1(s) for new TF
%n1= s in this case
%n2=conv([1 -z(2)],[1 -z(3)])
%n3=conv([1 -z(4)],[1 -z(5)])
% denominator
d1=conv([1 -p(1)],[1 -p(2)])
d2=conv([1 -p(3)],[1 -p(4)])
%d3=conv([1 -p(5)],[1 -p(6)])

% find Q values to determine cascade ordering
ql=sqrt(dl(l,3))/dl(l,2)
q2=sqrt(d2(l,3))/d2(l,2)

%define 1st and 2nd order tran5fer functions (numerators are wo of each tf)
nl=dl(l,3); sysl=tf(nl,dl)
n2=d2(1,2); sys2=tf(n2,d2)

%Design using inverting 1st order filter, and two Sallen-Key
% decide a value of capacitor
C=le-6 %luF - use for all caps in circuit
% Sallen-Key for sysl - will be stage 3 (highest Q value)
Rll=l/(sqrt(dl(l,3))*C)
kl=3-l/ql
RAl=Rll
RBl=(kl-l)*RAl
% Sallen-Key for sys 3 - will be state 2 (second highest Q value)
R13=1/(sqrt(d3(1,3) )*C)
k3=3-l/q3
RA3=Rl3
RB3=(k3-l)*RA3
% inverting 1st order - will be stage
R22=1/(d2(1,2)*C)
k2= 1/(kl*k3)