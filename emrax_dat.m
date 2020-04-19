%% Powertrain calculations for the OT_Retards Lap Time Simulator - 

function [peak_trq, cont_trq] = emrax_dat(V_inst, r_wheel, final_dr, drv_eff)

wheel_rpm = (V_inst*60)/(r_wheel*2*pi);
mtr_rpm = wheel_rpm*final_dr;
peak_trq = (-3.1935e-10*(mtr_rpm^3) + 1.8005e-06*(mtr_rpm^2) - 3.6212e-03*mtr_rpm + 1.4044e+02)*final_dr*drv_eff;
cont_trq = (3.5648e-11*(mtr_rpm^3) - 1.3838e-06*(mtr_rpm^2) + 6.1343e-03*mtr_rpm + 5.9997e+01)*final_dr*drv_eff;

end
