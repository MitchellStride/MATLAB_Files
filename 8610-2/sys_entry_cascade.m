% T13 Cascade Design - System entry, pole/zero factorization, pole-zero pairing via pzmap
clc
syms x s
clear

% Enter numerator and denominator of desired TF
n=[1 0 2.5 0 0.5626 0];
d=[1 0.39 3.067 0.785 3.056 0.387 0.989];
sys=tf(n,d)
z=roots(n) %zeros from numerator
p=roots(d) %poles from denom

%From Factors ------------
% e=[-9; -8; -7] %factors
% a=poly(e);
% b=1;
% sys=tf(b,a)
% % r=roots(p)
% -----------------------

% Step 1 Factorization -----------------------------
% Multiply for complex conjugate pairs to get 2nd order polynomials
% numerator of new T1(s) for new TF
%n1= s in this case
n2=conv([1 -z(2)],[1 -z(3)])
n3=conv([1 -z(4)],[1 -z(5)])
% denominator
d1=conv([1 -p(1)],[1 -p(2)])
d2=conv([1 -p(3)],[1 -p(4)])
d3=conv([1 -p(5)],[1 -p(6)])

% Step 2 Pole-Zero Pairing -----------------------------
% Plot poles/zeros in s-plane then group close ones to minimize gain
% variation (see T13 p.3)
pzmap(sys)

% Step 3 Section Ordering -----------------------------
% Order sections of increasting Q to reduce overshoot
Q1=sqrt(d1(3))/d1(2)
Q2=sqrt(d2(3))/d2(2)
Q3=sqrt(d3(3))/d3(2)

% Step 4  Gain Adjustment -----------------------------
% Individual section gains must equal overall gain. In order to prevent any
% opamp from saturating keep larger gains for later sections
% k=k1*k2*k3
