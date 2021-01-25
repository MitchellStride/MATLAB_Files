% Wind turbine energy calculations using the Bins Method
%Data from the power 
power=[0 0 0 300 800 2000 3900 6000 8500 11100 13700 15600 17000 18200 19100 20200 20500 20000 20100 20000];
% Hourly wind speed data in a file windsj.txt
%load windsj.txt
windsj1 = importdata('windsj.txt');
windsj = windsj1.data;
wind = windsj(:,1);
clear windsj, clear windsj1
subplot(2,2,1),plot(power),grid,title('Bergey Excel-15 : WT Power Curve'),xlabel('Wind Spd [m/s]'),ylabel('Power [W]')
subplot(2,2,2),plot(wind),grid,title('One Year Wind Data'),xlabel('Measurement #'),ylabel('Wind Spd [m/s]')
mean(wind)
size(power)
subplot(2,2,3)
hr = histogram(wind,20),grid,title('Wind Histogram'),xlabel('Wind Spd [m/s]')
energy=power.*hr.Values;
subplot(2,2,4),plot(energy),grid,title('Energy Ouput'),xlabel('Wind Spd [m/s]'),ylabel('Energy [Wh]')
annualenergy=sum(energy)
energy_per_month=annualenergy/12

