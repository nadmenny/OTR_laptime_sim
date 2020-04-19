%% Powertrain calculations for the OT_Retards Lap Time Simulator - 

function [peak_trq, cont_trq] = emrax_dat(wheel_rpm, final_dr, drv_eff)

mtr_rpm = wheel_rpm*final_dr;
peak_trq = (-3.1935e-10*(mtr_rpm^3) + 1.8005e-06*(mtr_rpm^2) - 3.6212e-03*mtr_rpm + 1.4044e+02)*final_dr*drv_eff;
cont_trq = (3.5648e-11*(mtr_rpm^3) - 1.3838e-06*(mtr_rpm^2) + 6.1343e-03*mtr_rpm + 5.9997e+01)*final_dr*drv_eff;

end

%% Power Calculations - 
