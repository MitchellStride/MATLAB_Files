% Enter a matrix for eigen value test to evaluate internal stability'
clc
syms x
%A=[0 2 0;0 0 13;0 -12 -31];
%A=[0 10;-50 -10];
sz=size(A,1);
if sz > 2
        I=x*([1 0 0; 0 1 0; 0 0 1]);
else
        I=x*([1 0; 0 1]);
end
L2=I-A;
L3=det(L2);
L4 = solve(L3, x);
e = eig(A);

fprintf('A = \n')
disp(A)
fprintf('𝜆I-A = \n')
disp(I)
fprintf('𝜆I-A = \n')
disp(L2)
fprintf('det(𝜆I-A) = (Characteristic polynomial)\n')
disp(L3)
fprintf('(𝜆-e1)(𝜆-e2)\n')
fprintf('𝜆 = \n')
disp(e);
disp(L4);
fprintf('If any 𝜆𝑖>0 then the system is unstable\nIf all 𝜆𝑖<0then the system is asymptotically stable (also implies BIBO stable)\nIf 𝑛–1 eigenvalues are negative, and just one eigenvalue is zero then\n                the system is stable, but not asymptotically stable\n')
