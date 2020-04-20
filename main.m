% % % Lap time simulator for OTR FSAE Electric % % %

% This is the main function to initiate a sim
clear; clc;

%% Vehicle Parameters
max_rpm = 4000;
final_dr = 3.8; %final drive ratio
drv_eff = 1; %driveline efficiency
r_wheel = 0.2286; %radius wheel
wheel_rpm = 0; %input wheel RPM
V_inst = 0; %m/s instantaenous velocity at the start
g = 9.81; % gravitational acceleration m/s^2
m = 300; %Mass kg
mu = 1.4; %friction Coefficient
Fn = m*g; % Normal Force N
Cd = 0.150; %Drag Coefficient
p = 1.225; % Density Kg/m^3
A = 1.328; %Area m^2

%% Track
% x1 = 0:1:25;
% y1 = sqrt(25.^2 - x1.^2);
% x = [-10:1:-1,x1,25,25,25];
% y = [25,25,25,25,25,25,25,25,25,25,y1,-1,-2,-3];

fid = fopen('track.txt');
data = textscan(fid,'%f%f','Delimiter',',');
fclose(fid)
x = data{1,1};
y = data{1,2};
plot(x,y)

for i = 1:length(x)-1
    seg(i) = sqrt((x(i+1)-x(i))^2 + (y(i+1)-y(i))^2); %calc segment length
end
seg(length(x)) = sqrt((x(length(x))-x(1))^2 + (y(length(x))-y(1))^2); %segment for closed track
n_seg = length(seg);

%% Max Corner Velocity at Each Point
[Vmax,R] = maxvel(x,y,Cd,A,m,mu,p,g);

%% Max Entry Velocity at Each Point
[Vmax_entry,Fs] = maxvel_entry(Vmax,Cd,A,m,mu,p,g,R,seg);
%plot(x,Vmax_entry, 'r-', x, Vmax, 'bl');

%% Simulation Main Loop
chg = 10;
V = zeros(1,n_seg+1);
Vold = Vmax; %initialize matrix for convergance
Vmax_entry(n_seg+1) = Vmax_entry(1);

% while max(abs(V - Vold)) > chg
    for i = 1:n_seg
        
        %% Powertrain Parameters
        [wp_trq,wc_trq] = emrax_dat(V_inst(i),r_wheel,final_dr,drv_eff); %peak and cont trq @wheel
        
        %% Tractive Force Caclulations
        [a_tractp,a_tractc] = f_tract(wc_trq,wp_trq,r_wheel,m,Cd,A,V_inst(i),p,max_rpm,final_dr);
        
        %% Sector Velocity
        V_inst(i+1) = v_inst(a_tractp,a_tractc,seg(i),V_inst(i));
        
        %% Lap Iteration Function
        [brake_flag] = lap_iter(V_inst(i),Vmax_entry(i+1));
        
    end
% end