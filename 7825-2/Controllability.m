clc
% A=[1 5;8 4];
% B=[-2; 2];

P = ctrb(A,B);
% R = rref(P)
p=rank(P);
stateV=size(A,1);

fprintf('A = \n')
disp(A)
fprintf('B = \n')
disp(B)
fprintf('Controllability Matrix P = [B AB A^(2)B A^(n-1)B]\n')
B
AB=A*B
AAB=A*A*B
fprintf('P = \n')
disp(P)
fprintf('System is controllable if rank of controllabilty matrix = # of state variables\n      If not, the sys is not controllable, try alternate state variables\n')
% fprintf('Row Echelon R = \n')
% disp(R)
fprintf('rank p = \n')
disp(p)
fprintf('stateV = \n')
disp(stateV)
