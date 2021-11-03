clc; clear; close;
%Input test parameters
L=1.25;
W=0.907;
w=(W*9.81)/L;
 
%a= [0.88 0.97 1.14 1.33 1.55 2.02]; exper
a= [0.703 0.806 0.963 1.224 1.755 2.446];
S= [0.9 0.92 0.94 0.96 0.98 0.99];
T = double.empty(0,6);
H = double.empty(0,6);
V = double.empty(0,6);

figure()

for i = 1:1:6
    bounds = 0.10+S(i)/2;
    x=[-bounds:0.01:bounds];
    B=S(i)*L/2;
    y=a(i)*cosh(x/a(i))-a(i)*cosh(B/a(i));
    T(i)=w*a(i)*cosh(B/a(i));
    H(i)=T(i)/(cosh(B/a(i)));
    V(i)=sqrt((T(i).^2-H(i).^2));

    plot(x,y)
    hold on
end

legend 0.9 0.92 0.94 0.96 0.98 0.99
grid on
xlim([-0.61, 0.61])
ylim([-0.25,0])

T
H
V