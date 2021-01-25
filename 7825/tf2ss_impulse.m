clc
fprintf('SS Controller Canonical Form\n')
%   A=[0 -0.4;2 -1.3]
%   B=[0.8; 1]
%   C=[0 1]
%   D=[0]

syms s
si=size(A,1);
if si > 2
        I=s*([1 0 0; 0 1 0; 0 0 1]);
else
        I=s*([1 0; 0 1]);
end
L2=I-A;
middleL2=det(L2)*inv(L2);
%middleL2=rot90(middleL2,2)
detL2=det(L2);
L3=L2^(-1);
Hs=C*L3*B;
Ht=ilaplace(Hs);

fprintf('Find Impulse Response - u(t) = dirac\n')
fprintf('h(t)=Ce^(At)B+D(Dirac)\n')
fprintf('h(s)=C((sI-A)^-1)B+D(Dirac)\n\n')
fprintf('(sI-A)\n')
disp(L2)
fprintf('(sI-A) - middle step det (This seems to not work gr8 for 3x3\n')
disp(middleL2)
fprintf('|sI-A| - det\n')
disp(detL2)
fprintf('(sI-A)^-1\n')
disp(L3)
fprintf('H(s) = ')
disp(Hs)
fprintf('H(t) = ')
disp(Ht)
fprintf('\n\n***BIBO - > Manually try integral or Wolfram\n')
fprintf('fun = @(t) exp(-2*t) - t.*exp(-2*t)\n')
fprintf('q = integral(fun,0,Inf)\n')
fprintf('q = x < inf therfore BIBO Stable\n\n\n')

