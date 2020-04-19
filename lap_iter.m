%% Lap Iteration Function

function [brake_flag] = lap_iter(V_inst,Vmax_entry)

if Vmax_entry < V_inst
    brake_flag = 1; %yes braking
else
    brake_flag = 0; %no braking
end
