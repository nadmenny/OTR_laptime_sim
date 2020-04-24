% % % Lap time simulator for OTR FSAE Electric % % %

% This is the main function to initiate a sim
clear; clc;

%% Vehicle Parameters
max_rpm = 5000; %Max motor rpm
final_dr = 3.8; %final drive ratio
drv_eff = 1; %driveline efficiency
r_wheel = 0.2286; %radius wheel
wheel_rpm = 0; %input wheel RPM
g = 9.81; % gravitational acceleration m/s^2
m = 300; % Mass kg
mu = 1.4; % friction Coefficient
Fn = m*g; % Normal Force N
Cd = 0.150; %Drag Coefficient
p = 1.225; % Density Kg/m^3
A = 1.328; % Area m^2

%% Track data
fid = fopen('track3.txt');
data = textscan(fid,'%f%f','Delimiter',' ');
fclose(fid);
scale = 1000;
x = data{1,1}.*scale;
y = data{1,2}.*scale;

%% track data processing
%calc length between each point
seg = zeros(1,length(x)); %initialize array size
for i = 1:length(x)-1
    seg(i) = sqrt((x(i+1)-x(i))^2 + (y(i+1)-y(i))^2); %calc segment length
end
seg(length(x)) = sqrt((x(length(x))-x(1))^2 + (y(length(x))-y(1))^2); %segment for closed track
n_seg = length(seg); %length of array for 'for' loops down stream
dist = cumsum(seg); %cummulative distance of each sector on the track

%% max speed based on max motor rpm
max_speed = ones(1,length(x)).*(max_rpm*(2*pi/(60*final_dr))*r_wheel);

%% Max Corner Velocity and point Radius
[Vmax_allow,R] = maxvel(x,y,Cd,A,m,mu,p,g); %calculates the maximum allowable cornering speed on each point of the track

%% Max Entry Velocity at Each Point
[V_entry,F_maxbrake] = maxvel_entry(Vmax_allow,Cd,A,m,mu,p,g,R,seg); %based on maximum velocity allowable at each point on the track
% ******Note********** : this part may not be needed for sim

%% Simulation Main Loop
V_sim = zeros(1,length(x)); % initialize simulation velocity array
f_brake = zeros(1,length(x)); % initialize braking force array
acceleration = zeros(1,length(x)); %initialize acceleration array

for i = 1:n_seg-1
    
    %% Powertrain Parameters
    [wp_trq,wc_trq] = emrax_dat(V_sim(i),r_wheel,final_dr,drv_eff); %peak and cont trq @wheel
    
    %% Tractive Force Caclulations
    [a_tractp,a_tractc] = f_tract(wc_trq,wp_trq,r_wheel,m,Cd,A,V_sim(i),p,max_rpm,final_dr); %outputs tractive acceleration
    
    %% acceleration
    acceleration(i) = a_tractc/g; % get tractive acceleration
    
    %% Sector Velocity
    V_sim(i+1) = v_inst(a_tractp,a_tractc,seg(i),V_sim(i)); %outputs exit speed from entry speed V_sim(i)
    
    %% Lap Iteration Function
    [brake_flag] = lap_iter(V_sim(i+1),Vmax_allow(i+1)); % compares sim exit speed to max attainable exit speed at a point on the track
    if brake_flag == 1 %if exit speed is greater than max allowable speed then back track and apply braking
        V_sim(i+1) = Vmax_allow(i+1); % assign exit speed equal to max allowable speed
        [V_sim(1:i+1),f_brake(1:i+1),acceleration(1:i+1)] = backtrack(V_sim(1:i+1),m,seg,Cd,A,mu,p,g,R,f_brake(1:i+1),acceleration(1:i+1)); %array is redefined with braking zones
    end
end

%% Total Time
time = transpose(zeros(1,length(x)));
for i = 1:n_seg
    coeff = [0.5*acceleration(i) V_sim(i) -seg(i)];
    root = transpose(roots(coeff));
    pos_root = root.*(root>=0);
    time(i,1:2) = pos_root;

%     pos_root = root.*(root>=0);
%     time(i) = pos_root(i);
end
total_time = sum(time);
laptime = total_time(1,2);

%% plot data:

%track plot with velocity heat map
figure(1)
subplot(2,2,1)
z = V_sim.*3.6;
surf([x(:) x(:)], [y(:) y(:)], [z(:) z(:)], ...  % Reshape and replicate data
    'FaceColor', 'none', ...    % Don't bother filling faces with color
    'EdgeColor', 'interp', ...  % Use interpolated color for edges
    'LineWidth', 4);            % Make a thicker line
view(2);   % Default 2-D view
colorbar;
colormap(flipud(jet))% Add a colorbar
title('Velocity Map (Km/h)');

%track plot with Acceleration heat map
figure(1)
subplot(2,2,3)
z = acceleration;
surf([x(:) x(:)], [y(:) y(:)], [z(:) z(:)], ...  % Reshape and replicate data
    'FaceColor', 'none', ...    % Don't bother filling faces with color
    'EdgeColor', 'interp', ...  % Use interpolated color for edges
    'LineWidth', 4);            % Make a thicker line
view(2);   % Default 2-D view
colorbar;
colormap(flipud(jet))% Add a colorbar
title('Accel(g)');

%Velocity Vs Accel Vs Dist
subplot(2,2,2)
plot(dist,V_sim.*3.6,'b-');
title('Velocity Vs Dist')
xlabel('Distance (m)');
ylabel('Velocity (Km/h)')

% Braking force Vs Dist
subplot(2,2,4)
plot(dist,acceleration,'g-');
title('Acceleration Vs Dist');
xlabel('Distance (m)');
ylabel('Acceleration (G)')


