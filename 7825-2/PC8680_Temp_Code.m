% System - Temperature Control of a Reflow Oven
C1=180000;
C2=360000;
Rr=0.01;
Rw=0.04;
A=[-1/C1/Rr 1/Rr/C1; 1/Rr/C2 -(1/C2/Rr+1/C2/Rw)];
B=[1/C1; 0];
C=[1 0];
D=[0];
E=[0; 1/Rw/C2];
[b,a] = ss2tf(A,B,C,D);
sys=tf(b,a)

% Using room and wall temperature as state variables
figure(1)
step(A,B,C,D); grid; title('Step Change in Heat Input'); 
figure(2)
step(A,E,C,D); grid; title('Step Change in the Outside Temperature');

% Plot both room and wall temperature
C=[1 1];
figure(3)
step(A,B,C,D); grid; title('Step Change in Heat Input'); 
figure(4)
step(A,E,C,D); grid; title('Step Change in the Outside Temperature');

% Input is too small
t=0:1000;
q=500*ones(0,1000);
X0=[15; 10]; % Setting intital conditions
sys1=ss(A,B,C,D);
Tout=0*ones(1,1000);
sys2=ss(A,E,C,D);

% Plot Systems
figure(5)
lsim(sys1,q,t,X0); grid; title('1000W input Response'); 
figure(6)
lsim(sys2,Tout,t,X0); grid; title('5C Outside Temperature Response'); 






