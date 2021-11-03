fprintf('Write invPccf=[a1 a2 1;a2 1 0;1 0 0]')
invPccf=[a1 a2 1;a2 1 0;1 0 0]
fprintf('Show P calc')

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

fprintf('Write out to show')
Tccf=P*invPccf;

Accf=inv(Tccf)*A*Tccf
Bccf=inv(Tccf)*B
Cccf=C*Tccf
Dccf=[0]