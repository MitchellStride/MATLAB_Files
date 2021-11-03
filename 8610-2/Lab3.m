% T14 Butterworth code w/ modifications
clc
syms x 
clear
%-----------------
wn = 1000; %input corner freq in rad/s
order = 4; %desired order of filter
[n,d] = butter(order, wn, 'low', 's'); %'low', 'high' pass
                               % 's' for analog, default is digital
fprintf('Overall butterworth filter\n')
sys=tf(n,d)
W=logspace(0,6,1000);
bode(n,d,W)

%Factorization -----------------------------
fprintf('Factorization\n')
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
fprintf('Q values to determine cascade ordering\n')
q1=sqrt(d1(1,3))/d1(1,2)
q2=sqrt(d2(1,3))/d2(1,2)

%define 1st and 2nd order tran5fer functions
fprintf('TF functions w/ numerator as wo\n')
n1=d1(1,3); sys1=tf(n1,d1)
n2=d2(1,3); sys2=tf(n2,d2)

%Design two Sallen Keys
% decide a value of capacitor
C=1e-9 %lnF - use for all caps in circuit

% Sallen-Key for sysl - will be stage 2 (highest Q value)
fprintf('Sallen-Key - Sys 1 - Stage 2\n')
R11=1/(sqrt(d1(1,3))*C)
k1=3-1/q1
RA1=R11
RB1=(k1-1)*RA1

% Sallen-Key for sys 2 - will be stage 1 (second highest Q value)
fprintf('Sallen-Key - Sys 2 - Stage 1\n')
R12=1/(sqrt(d2(1,3) )*C)
k2=3-1/q2
RA2=R12
RB2=(k2-1)*RA2
