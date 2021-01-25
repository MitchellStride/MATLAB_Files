clc
syms x s
clear
%----------State Space Entry
A=[0 1;-16 -4]
B=[0;1]
C=[1 0]
D=[0]
sys=ss(A,B,C,D);
[b,a] = ss2tf(A,B,C,D);
System=tf(b,a)

%----------b=num a=denom #1
% b=[1];
% a=[1 9 7]; %polynomial entry
% sys=tf(b,a
%A=[0 1; -7 -9] check 

%s^3+a2s^2+a1s+a0
% Gs=1/((s+9)*(s+8)*(s+7))

%----------Factor Entry #2
% e=[-9; -8; -7] %factors
% a=poly(e);
% b=1;
% sys=tf(b,a)
% % r=roots(p)
% 
% %----------Extraction
% a0=a(1,4)
% a1=a(1,3)
% a2=a(1,2)
% A=[0 1 0; 0 0 1; -a0 -a1 -a2]
% B=[0; 0; 1]
% C=[1 0 0]
% D=[0]

