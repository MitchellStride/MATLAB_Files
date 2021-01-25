%Convert TF to SS Controller Canonical Form and display by rotating
clc
syms k0 k1 k2 s
%Setup
%   A=[0 1 0; 0 0 1; -1 -3 -10]
%   B=[0; 0; 1]
%   C=[1 0 0]
%   D=[0]
% [b,a] = ss2tf(A,B,C,D);
% sys=tf(b,a)

sz=size(A,1);
if sz > 2
        k=[k0 k1 k2];
else
        k=[k0 k1];
end

Bk=B*k;
Abk=A-Bk;
Cp=s^2+s*(-Abk(2,2))+(-Abk(2,1)); % only working for 2x2

fprintf('A = \n')
disp(A)
fprintf('B = \n')
disp(B)
fprintf('k = \n')
disp(k)
fprintf('A-Bk = \n')
disp(Abk)
fprintf('Characteristic Poly A-Bk = \n')
disp(Cp)

