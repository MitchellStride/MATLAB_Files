%StateFeedback with Integral Control
%SISO, AB Controllable, no z or p at s=0
%notes 5.6
%Manually enter ABCD if u need
clc
syms s x

fprintf('SISO, AB Controllable, no z or p at s=0\n')
fprintf('Test Controllable\n')
OS=10    %Enter Percent Overshoot (0-100)
% Tp=1  %Peak
Ts=1  %Settling Time
fprintf('0 steady state error\n')
DampR=(-log(OS/100)/sqrt(pi^(2)+(log(OS/100)*log(OS/100))))
% Wn=pi/(Tp*sqrt(1-DampR^2))
Wn=4/(Ts*DampR)



% Wn=2;
Wn

fprintf('ITAE\n')
s1=0;
s2=0;
s3=s^3+1.75*Wn*s^2+2.15*Wn^2*s+Wn^3;
s3m=[1 1.75*Wn 2.15*Wn^2 Wn^3]
s4=0;
s5=0;
s6=s^6+3.25;
Cpnew=s3

fprintf('A*=[A 0; -C 0]\n')
Astar= [A(1,1), A(1,2) 0; A(2,1) A(2,2) 0; -C(1,1) -C(1,2) 0]
fprintf('B*=[B;0]\n')
Bstar= [B(1,1);B(2,1);0]


sz=size(Astar,1);
if sz > 2
        I=s*([1 0 0; 0 1 0; 0 0 1]);
else
        I=s*([1 0; 0 1]);
end

L2=I-Astar;
L3=det(L2);
L4 = solve(L3, s);
e = eig(A);

fprintf('sI-A* = \n')
disp(L2)
fprintf('Char poly - Form s^3 + a2*s^2 + a1*s + a0, manually enter\n')%Pause Here
disp(L3)
fprintf('Write one pole one zero etc.\n')
a2=2
a1=10
a0=0

fprintf('Using ITAE')
p=s3m
r=roots(p)
fprintf('Write Alpha A0 A1 A2')
A0=p(1,4)
A1=p(1,3)
A2=p(1,2)
AX=p(1,1)
fprintf('Cpnew s^3+s^2*A2+s*A1+A0')
CpNew=s^3+s^2*A2+s*A1+A0
%Enter a0 from sys_entry.m or manually
%----------Factor Entry, b=num a=denom
%----------s^3+a2s^2+a1s+a0
%Accf=[0 1 0; 0 0 1;-A2 -A1 -A0]
fprintf('Write kccf=[(A0-a0) (A1-a1) (A2-a2)]')
Kccf=[(A0-a0) (A1-a1) (A2-a2)]
% invPccf=[a1 1; 1 0];
fprintf('Write invPccf=[a1 a2 1;a2 1 0;1 0 0]')
invPccf=[a1 a2 1;a2 1 0;1 0 0]
fprintf('Show P calc')

P = ctrb(Astar,Bstar);
% R = rref(P)
p=rank(P);
stateV=size(Astar,1);

fprintf('A = \n')
disp(A)
fprintf('B = \n')
disp(B)
fprintf('Controllability Matrix P = [B AB A^(2)B A^(n-1)B]\n')
B
AB=Astar*Bstar
AAB=Astar*Astar*Bstar
fprintf('P = \n')
disp(P)

fprintf('Write out to show')
Tccf=P*invPccf

% Accf=inv(Tccf)*A*Tccf
% Bccf=inv(Tccf)*B
% Cccf=C*Tccf
% Dccf=[0]

fprintf('Write out k*==[k |KI] where KI is last one')
kstar=Kccf*inv(Tccf)
K1=kstar(1,1)
K2=kstar(1,2)
K3=kstar(1,3)
KI=K3
% fprintf('Gain G = Hopen(0)/Hclosed(0) = A0/a0\n')
% 
% fprintf('\nGopen(s)=C*((sI-(A))^(-1))*B\n')
% fprintf('Write as dowb with sI-A as L2\n')
% disp(L2)
% Gopens=C*(L2)^(-1)*B*1+D
% % Gcloseds=Cccf*((sI-(Accf-Bccf*Kccf))^(-1))*Bccf*G+Dccf
% fprintf('Gopen(0)=top/bot qiuck = 2ish\n\n')

fprintf('\nWrite out manually---------------------calc ends here')
fprintf('\nclosed loop sys is Aprime=[A-BK B*KI; -C 0]')
fprintf('\nBKI')
fprintf('\nCprime =  1 0 0')

% fprintf('\nGclosed(s)=C*((sI-(A-Bk))^(-1))*B*G+D\n')
% sI=s*([1 0 0; 0 1 0; 0 0 1]);
% Gcloseds=C*((sI-(A-B*k))^(-1))*B*1+D
% Gcloseds=Cccf*((sI-(Accf-Bccf*Kccf))^(-1))*Bccf*G+Dccf
% 
% fprintf('Gain G = Hopen(0)/Hclosed(0) = A0/a0 (this might be wrong for this.\n')
% G=A0/a0
