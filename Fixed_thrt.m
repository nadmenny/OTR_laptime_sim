% Function called in program main_ft.m
function f=Fixed_thrt(t,x)
global m c f0 rw ni p etov
v=x(1); % instantaneous vehicle speed
omega=ni*v*30/rw/pi; % instantaneous engine speed (rpm)
Trq=polyval(p, omega); % engine torque at this instant
Fti=etov*Trq*ni/rw; % instantaneous tractive force at gear n(i)
f1=(Fti-f0-c*v^2)/m; % Differential equation for velocity
f2=v; % Differential equation for distance
f=[f1% functions to integrate for velocity and distance respectively  
   f2];