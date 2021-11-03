%SF with Bass Gura for non CCF NOT DONE DONT USE, USE ITAE CCF

%Modified C&P
clc
syms s

OS=5    %Enter Percent Overshoot (0-100)
Ts=0.2  %Settling Time

%Regular Calcs
G=1;
Bccf=B*G;
Cccf=C;
fprintf('State Feedback Controller\n')
fprintf('Go do Ctrlb\n')
fprintf('System is controllable and SISO so state feedback will work//access to all SV.')
DampR=(-log(OS/100)/sqrt(pi^(2)+(log(OS/100)*log(OS/100))))
Wn=4/(Ts*DampR)
%Tp=pi/(Wn*sqrt(1-DampR^2))
T1=s^2
T2=2*DampR*Wn*s
T3=Wn^2
Cp=Wn^2/(s^2+(2*DampR*Wn*s)+(Wn^2))
Cp1=s^2+(2*DampR*Wn*s)+(Wn^2)

fprintf('Factors from desired 2nd order sys.')
lam1=-(DampR*Wn)+i*Wn*sqrt(1-DampR^2)
lam2=-(DampR*Wn)-i*Wn*sqrt(1-DampR^2)
fprintf('Selecting lam3')
X = real(lam1);
if X > -10 %Selecting lamda 3
    lam3 = X-10
else
    lam3 = X*10
end
fprintf('Write as factors e, then calc new poly write as Cpnew')
e=[lam1; lam2; lam3]
p=poly(e)
r=roots(p)
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
fprintf('Write k=[(A0-a0) (A1-a1) (A2-a2)]')
k=[(A0-a0) (A1-a1) (A2-a2)];
Kccf=k
K1=k(1,1)
K2=k(1,2)
K3=k(1,3)
fprintf('Write k=[]\n\n')
fprintf('Gain G = Hopen(0)/Hclosed(0) = A0/a0\n')
G=A0/a0
Bccf=B*G

fprintf('\nGclosed(s)=C*((sI-(A-Bk))^(-1))*B*G+D\n')
fprintf('Write as C*[s -1 0; 0 s -1; A0 A1 s+A2]*BG+D]\n')
fprintf('= G/(CpNew), remember ccf\n')
sI=s*([1 0 0; 0 1 0; 0 0 1]);
Gcloseds=Cccf*((sI-(A-B*k))^(-1))*B*G+D


%---------------------Graphing
% Tp = 0.2 %Select Peak Time
% thetaG=acosd(DampR)
% od=4/Ts
% wd=pi/Tp
% step(sys)


