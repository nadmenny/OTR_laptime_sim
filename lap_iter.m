%% Lap Iteration Function

function [V,t] = lap_iter(chg, V_inst, Vmax_entry)

%Initialize
n_seg = length(V_inst);
Vmax_entry = Vmax_entry';
V_inst = V_inst';
V = V_inst;
Vi = zeros(n_seg,1);
loop = 0;

%Main Loop
while max(abs(V - Vi)) > chg
    loop = loop + 1;
    
    for i = n_seg:-1:1
        if Vmax_entry(i+1) < V_inst(i)
            Vi(i) = Vmax_entry(i);
        else
            Vi(i) = V_inst(i);
        end
    end
        
end

V = Vi;