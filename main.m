% % % Lap time simulator for OTR FSAE Electric % % %
% This is the main function to initiate a sim

%% Vehicle Parameters
final_dr = 3.8; %final drive ratio
drv_eff = 1; %driveline efficiency
r_wheel = 0.2286; %radius wheel
wheel_rpm = 800; %input wheel RPM

%% Powertrain Parameters
[wp_trq, wc_trq] = emrax_dat(wheel_rpm, final_dr, drv_eff); %peak and cont trq @wheel

