% DTFT
% See list online of easy functions
% https://www.mathworks.com/help/symbolic/fourier.html
clc
syms a b t n

% f = a*cos(b*t);
% f = a*cos(b*t);
f = heaviside(n)
f_FT = fourier(f)