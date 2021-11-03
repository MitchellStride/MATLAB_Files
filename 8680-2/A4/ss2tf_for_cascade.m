clc

%System 1

%System 2
A=[1.73*10^-3];
B=[1];
C=[1];
D=[0];
E=[1];
[b,a] = ss2tf(A,B,C,D);
sys=tf(b,a)