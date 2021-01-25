%Convert TF to SS Controller Canonical Form and display by rotating
clc
  A=[0 1 0; 0 0 1; -1 -3 -10]
  B=[0; 0; 1]
  C=[1 0 0]
  D=[0]
[b,a] = ss2tf(A,B,C,D);
sys=tf(b,a)




%Meth 2
% b=[1 1 -2];
% a=[1 2 -4 -8];
% sys=tf(b,a)
% ss(sys);
% [A,B,C,D] = tf2ss(b,a);
% fprintf('SS Controller Canonical Form\n')
% A=rot90(A,2)
% B=rot90(B,2)
% C=rot90(C,2)
% D=rot90(D,2)


% impulse(sys);
 step(sys);
 S = stepinfo(sys)

