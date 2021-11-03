% T15 Chebyshev code w/ modifications
clc
syms x 
clear
%-----------------
wn = 5000*2*pi; %input corner freq in rad/s
order = 5; %desired order of filter
pbRipple=3; %-3dB
[n,d] = cheby1(order, pbRipple, wn, 'low', 's'); %'low', 'high' pass
                               % 's' for analog, default is digital
fprintf('Overall Chebyshev filter\n')
sys=tf(n,d)
W=logspace(0, 6, 10000);
bode(n,d,W)

%Factorization -----------------------------
fprintf('Factorization\n')
%z=roots(n) %zeros from numerator
p=roots(d) %poles from denom
% Multiply for complex conjugate pairs to get 2nd order polynomials

% denominator
d1=conv([1 -p(1)],[1 -p(2)])
d2=conv([1 -p(3)],[1 -p(4)])
d3= -p(5)

%define 1st and 2nd order tran5fer functions
fprintf('TF functions w/ numerator as wo\n')
n1=d1(1,3); sys1=tf(n1,d1)
n2=d2(1,3); sys2=tf(n2,d2)
n3 = d3;    sys3=tf(n3, [1, d3]) %scaled up 
% find Q values to determine cascade ordering
fprintf('Q values to determine cascade ordering\n')
q1=sqrt(d1(1,3))/d1(1,2)
q2=sqrt(d2(1,3))/d2(1,2)

fprintf('System ordering sys3 > sys2 > sys 1\n')


