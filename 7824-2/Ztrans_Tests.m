% Z Transform
% See list online of easy functions
% https://www.mathworks.com/help/symbolic/ztrans.html
clc
syms a n m n y z

% f = sin(n);
f = (a^n)*heaviside(n) % Ignore 1/2 and sign, swap a and z
% f = (-a^n)*heaviside(-n-1)
% f = 7*((1/3)^n)*heaviside(n)
ztrans(f)