% % % Lap time simulator for OTR FSAE Electric % % %

% This is the main function to initiate a sim

% This is the main function to initiate a sim
clear; clc;

%% Vehicle Parameters
final_dr = 3.8; %final drive ratio
drv_eff = 1; %driveline efficiency
r_wheel = 0.2286; %radius wheel
wheel_rpm = 800; %input wheel RPM

g = 9.81; % gravitational acceleration m/s^2
m = 300; %Mass kg
mu = 1.4; %friction Coefficient
Fn = m*g; % Normal Force N
Cd = 0.150; %Drag Coefficient
p = 1.225; % Density Kg/m^3
A = 1.328; %Area m^2

%% Track
x1 = 0:1:5;
y1 = sqrt(5.^2 - x1.^2);
x = [-3,-2,-1,x1,5,5,5];
y = [5,5,5,y1,-1,-2,-3];
s = 5; %track section length
plot(x,y)
for i = 2:length(x)
seg(i) = sqrt((x(i)-x(i-1))^2 + (y(i)-y(i-1))^2);
end
%% Powertrain Parameters
[wp_trq, wc_trq] = emrax_dat(wheel_rpm, final_dr, drv_eff); %peak and cont trq @wheel

%% Max Velocity at Each Point
[Vmax,R] = maxvel(x,y,Cd,A,m,mu,p,g);
% plot(x,Vmax);

%% Max Entry Velocity at Each Point
%%Vmax_entry = maxvel_entry(Vmax,Cd,A,m,mu,p,g,R,s);
% Fn = m*g;
% Fs = 0.5.*p.*(Vmax.^2).*A.*Cd + sqrt((mu.*Fn).^2 - (m.^2.*Vmax.^4)./(R.^2));
% V_entry = sqrt((Vmax.^2) + (2.*seg.*Fs)./m);

