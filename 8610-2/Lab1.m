clc
syms x s
clear

% Enter numerator and denominator of desired TF
n=[((10000*pi)^2)];
d=[1 20000*pi/3 (10000*pi)^2];
sys_SallenKey=tf(n,d)
figure(1)
bode(sys_SallenKey)
figure(2)
step(sys_SallenKey)

n=[(-1.25*(10000*pi)^2)];
d=[1 5000*pi (10000*pi)^2];
sys_Raunch=tf(n,d)
figure(3)
bode(sys_Raunch)
figure(4)
step(sys_Raunch)

n=[952598689.2];
d=[1 15432 952598689.2];
sys_SallenKey=tf(n,d)
figure(5)
bode(sys_SallenKey)
figure(6)
step(sys_SallenKey)

n=[-1.22*(1182033097)];
d=[1 17886 1182033097];
sys_Raunch=tf(n,d)
figure(7)
bode(sys_Raunch)
figure(8)
step(sys_Raunch)