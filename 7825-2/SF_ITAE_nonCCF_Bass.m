%SF ITAE with Bass Gura for non CCF

%C&P------------------------------------
%StateFeedback with ITAE
%SISO, AB Controllable
%notes 5.4
clc
syms s x

% Modifyed C&P ------------------------------------------
clc

OS=5    %Enter Percent Overshoot (0-100)
Ts=1  %Settling Time

%Regular Calcs
G=1;
Bccf=B*G;
Cccf=C;
fprintf('State Feedback Controller ITAE\n')
fprintf('Go do Ctrlb\n')
fprintf('System is controllable and SISO so state feedback will work//access to all SV.')
DampR=(-log(OS/100)/sqrt(pi^(2)+(log(OS/100)*log(OS/100))))
Wn=4/(Ts*DampR)
%Tp=pi/(Wn*sqrt(1-DampR^2))

% Wn=2;
Wn

s1=0;
s2=0;
s3=s^3+1.75*Wn*s^2+2.15*Wn^2*s+Wn^3;
s3m=[1 1.75*Wn 2.15*Wn^2 Wn^3]
s4=0;
s5=0;
s6=s^6+3.25;
Cpnew=s3

% T1=s^2
% T2=2*DampR*Wn*s
% T3=Wn^2
% Cp=Wn^2/(s^2+(2*DampR*Wn*s)+(Wn^2))
% Cp1=s^2+(2*DampR*Wn*s)+(Wn^2)
% 
% fprintf('Factors from desired 2nd order sys.')
% lam1=-(DampR*Wn)+i*Wn*sqrt(1-DampR^2)
% lam2=-(DampR*Wn)-i*Wn*sqrt(1-DampR^2)
% fprintf('Selecting lam3')
% X = real(lam1);
% if X > -10 %Selecting lamda 3
%     lam3 = X-10
% else
%     lam3 = X*10
% end
% fprintf('Write as factors e, then calc new poly write as Cpnew')
% e=[lam1; lam2; lam3]
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

sz=size(A,1);
if sz > 2
        I=s*([1 0 0; 0 1 0; 0 0 1]);
else
        I=s*([1 0; 0 1]);
end
L2=I-A;
L3=det(L2);
L4 = solve(L3, x);
e = eig(A);

% fprintf('A = \n')
% disp(A)
% fprintf('𝜆I-A = \n')
% disp(I)
fprintf('sI-A = \n')
disp(L2)
fprintf('Form s^3 + a2*s^2 + a1*s + a0, manually enter\n')%Pause Here
disp(L3)
a2=9
a1=26
a0=24

fprintf('Write kccf=[(A0-a0) (A1-a1) (A2-a2)]')
Kccf=[(A0-a0) (A1-a1) (A2-a2)];
% invPccf=[a1 1; 1 0];
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

fprintf('Write out')
k=Kccf*inv(Tccf)
K1=k(1,1)
K2=k(1,2)
K3=k(1,3)
fprintf('Write k=[]\n\n')
fprintf('Gain G = Hopen(0)/Hclosed(0) = A0/a0\n')

fprintf('\nGopen(s)=C*((sI-(A))^(-1))*B\n')
fprintf('Write as dowb with sI-A as L2\n')
disp(L2)
Gopens=C*(L2)^(-1)*B*1+D
% Gcloseds=Cccf*((sI-(Accf-Bccf*Kccf))^(-1))*Bccf*G+Dccf
fprintf('Gopen(0)=top/bot qiuck = 2ish\n\n')

fprintf('\nWrite out')
fprintf('\nGclosed(s)=C*((sI-(A-Bk))^(-1))*B*G+D\n')
sI=s*([1 0 0; 0 1 0; 0 0 1]);
Gcloseds=C*((sI-(A-B*k))^(-1))*B*1+D
% Gcloseds=Cccf*((sI-(Accf-Bccf*Kccf))^(-1))*Bccf*G+Dccf

fprintf('Gain G = Hopen(0)/Hclosed(0) = A0/a0 (this might be wrong for this.\n')
G=A0/a0

%---------------------Graphing
% Tp = 0.2 %Select Peak Time
% thetaG=acosd(DampR)
% od=4/Ts
% wd=pi/Tp
% step(sys)