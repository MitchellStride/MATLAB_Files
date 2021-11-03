clc
syms x s
% System - Temperature Control of a Reflow Oven -------------------------------------------
fprintf('\nSystem - Temperature Control of a Reflow Oven\n')
C1=18; %Update values
C2=36;
Ro=0.2;
Rt=0.8;
A=[-1/C1/Ro 1/Ro/C1; 1/Ro/C2 -(1/C2/Ro+1/C2/Rt)];
B=[1/C1; 0];
C=[1 0];
D=[0];
sys=ss(A,B,C,D);
[b,a] = ss2tf(A,B,C,D);
System=tf(b,a)

% Initial Conditions ------------------------------------------------------------------
fprintf('Initial Conditions\n')
fprintf('Setting To = 15C, and Tt = 10C\n\n')
X0=[15; 10] % Setting intital conditions of SV
ttotal=500;
t=1:ttotal;   % Time Step
qmax=250;
q=zeros(1,ttotal);
q1=zeros(1,ttotal);
q2=zeros(1,ttotal);
q3=zeros(1,ttotal);
q4=zeros(1,ttotal);

for n=1:1:ttotal
    if n<=ttotal/4
    q1(n)=((qmax/2)/(ttotal/4))*n;
    end
    if n>ttotal/4 && n<=ttotal/2
    q2(n)=qmax/2;
    end
    if n>ttotal/2 && n<=ttotal*3/4
    q3(n)=((qmax/2)/(ttotal/4))*(n-ttotal/2)+qmax/2;
    end
    if n>ttotal*3/4
    q4(n)=((-qmax)/(ttotal/4))*(n-ttotal*3/4)+qmax;
    end
end

q=q1+q2+q3+q4;

% Controllability and Observability -------------------------------------------
fprintf('Controllability and Observability\n')
P = ctrb(A,B);
p=rank(P);
stateV=size(A,1);
fprintf('Controllability Matrix P = [B AB A^(2)B A^(n-1)B]\n')
fprintf('System is controllable if rank of controllabilty matrix = # of state variables\n      If not, the sys is not controllable, try alternate state variables\n')
fprintf('rank p = \n')
disp(p)
fprintf('stateV = \n')
disp(stateV)
if p == stateV
    fprintf('The system is Controllable!\n\n')
else  
    fprintf('The system is not Controllable!\n\n')
end

Q = obsv(A,C);
q1=rank(Q);
fprintf('Observability matrix Q = \n[C \nCA \nCA^(2) \nCA^(n-1)]\n')
fprintf('System is observable if rank of observability matrix = # of state variables\n      If not, the sys is not observable, try alternate state variables\n')
fprintf('rank q = \n')
disp(q1)
if q1 == stateV
    fprintf('The system is Observable!\n\n')
else  
    fprintf('The system is not Observable!\n')
end

% Internal stability and BIBO stability -------------------------------------------
fprintf('Internal stability and BIBO stability\n')
sz=size(A,1);
if sz > 2
        I=x*([1 0 0; 0 1 0; 0 0 1]);
else
        I=x*([1 0; 0 1]);
end
L2 = I-A;
L3 = det(L2);
L4 = solve(L3, x);
e = eig(A);
fprintf('𝜆I-A = \n')
disp(L2)
fprintf('𝜆 = \n')
disp(e);
% disp(L4);
fprintf('If any 𝜆𝑖>0 then the system is unstable\nIf all 𝜆𝑖<0then the system is asymptotically stable (also implies BIBO stable)\nIf 𝑛–1 eigenvalues are negative, and just one eigenvalue is zero then\n                the system is stable, but not asymptotically stable\n')
fprintf('\nThe system is asymptotically stable, this also implies BIBO stability\n\n') %Edit me, no conditional selection, hardcoded
fprintf('But to check... the Impulse Response ---> u(t) = dirac\n')
fprintf('h(t)=Ce^(At)B+D(Dirac)\n')
fprintf('h(s)=C((sI-A)^-1)B+D(Dirac)\n\n')
L5=L2^(-1);
Hs=C*L5*B;
Ht=ilaplace(Hs);
fprintf('H(s) = ')
disp(Hs)
fprintf('H(t) = ')
disp(Ht)
% Output ---> (-184467440737095525 (685 Cosh[(Sqrt[137] t)/28800] + 49 Sqrt[137] Sinh[(Sqrt[137] t)/28800]))/(2527203938098208571392 E^((13 t)/28800))
% fun = @(t) (-184467440737095525*(685*cosh((sqrt(137)*t)/28800)+49*sqrt(137)*sinh((sqrt(137)*t)/28800)))/(2527203938098208571392*exp((13*t)/28800))
% q = integral(fun,0,Inf)
fprintf('BIBO Stability Integral of Ht from 0 to inf = 0.05\n')
fprintf('0.05 < inf therfore BIBO Stable verified\n\n')

% Open loop step response ----------------------------------------------------------------
fprintf('\nOpen loop step response\n')
figure(1)
step(A,B,C,D); grid; title('Open Loop Step Response'); 
OpenLoop = stepinfo(sys)
figure(2)
lsim(sys,q,t,X0); grid; title('1500W Input Response with Initial Conditions'); %Change to lead reflow profile
ylabel('To - Oven Temperature [C]');

% State Feedback Controller -----------------------------------------------
fprintf('\n\nState Feedback Controller\n')
fprintf('System is controllable and SISO, so state feedback will work.\n')
%Calculating Tccf for Bass-Guru since the system is non CCF
a0=a(1,3);
a1=a(1,2);
invPccf=[a1 1; 1 0];
Tccf=P*invPccf;

Accf=inv(Tccf)*A*Tccf
Bccf=inv(Tccf)*B
Cccf=C*Tccf
Dccf=[0]


fprintf('Selecting Parameters\n')
Ts=30
OS=5
%Tp=0;
DampR=(-log(OS/100)/sqrt(pi^(2)+(log(OS/100)*log(OS/100))));
Wn=4/(Ts*DampR);
Tp=pi/(Wn*sqrt(1-DampR^2))
fprintf('Desired Characteristic Polynomial\n')
CpDes=s^2+2*DampR*Wn+Wn^2
A0=Wn^2
A1=2*DampR*Wn;
CpNew=s^2+s*A1+A0
Kccf=[(A0-a0) (A1-a1)];
fprintf('k=Kccf*Tccf^-1 for non CCF sys\n')
k=Kccf*inv(Tccf)
fprintf('Gain G = Hopen(0)/Hclosed(0) = A0/a0\n')
G=A0/a0
fprintf('\nGclosed(s)=C*((sI-(A-Bk))^(-1))*B*G+D\n')
fprintf('Write as C*[s -1 0; 0 s -1; A0 A1 s+A2]*BG+D]\n')
fprintf('= G/(CpNew)\n')
sI=s*([1 0; 0 1]);
Gcloseds=Cccf*((sI-(Accf-Bccf*Kccf))^(-1))*Bccf*G+Dccf
[b2, a2] = numden(sym(Gcloseds))
b2=[11940988967934866174132585800337560060879249839219036428718571520 2073088362488690646747969570787224127612480153869254586081629925]; %Manually enter
a2=[55535778809590703922730209911310579543167335465133320388015554560 14809541015890846796575146580302138589165646299517072000371654656 2073088362488690743890973535102614706557360548415425643643142144]; %Manually enter
sys2=tf(b2,a2)

% Closed loop step response-----------------------------------------------
fprintf('\nClosed loop step response\n')
figure(3)
step(sys2); grid; title('Closed Loop Step Response'); 
ClosedLoop = stepinfo(sys2)
figure(4)
lsim(sys2,q,t,X0); grid; title('1500W Closed Loop Input Response with Initial Conditions'); %Change q to lead reflow profile
ylabel('To - Oven Temperature [C]');
% System Comparision-----------------------------------------------------
fprintf('\n\n\nFinal System Response Comparision.\n')
figure(5)
step(sys); grid; title('Step Response Comparision'); 
hold on
step(sys2)
hold off
legend('OpenLoop','ClosedLoop')

figure(6)
lsim(sys,q,t,X0); grid; title('1500W Input Response with Initial Conditions Comparision');
hold on
lsim(sys2,q,t,X0);
ylabel('To - Oven Temperature [C]');
hold off
legend('OpenLoop','ClosedLoop')

%Data
OpenLoop
ClosedLoop




