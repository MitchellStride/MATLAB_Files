clc
% A=[1 5;8 4];
% C=[2 2];


Q = obsv(A,C);
q=rank(Q);
stateV=size(A,1);

fprintf('A = \n')
disp(A)
fprintf('C = \n')
disp(C)
fprintf('Observability matrix Q = \n[C \nCA \nCA^(2) \nCA^(n-1)]\n')
C
CA=C*A
CAA=C*A*A
fprintf('Q = \n')
disp(Q)
fprintf('System is observable if rank of observability matrix = # of state variables\n      If not, the sys is not observable, try alternate state variables\n')
fprintf('rank q = \n')
disp(q)
fprintf('stateV = \n')
disp(stateV)
