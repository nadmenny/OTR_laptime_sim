%% Lap Iteration Function

function [V,t] = lap_iter(chg, Vmax, Vmax_entry)

%Initialize
n_seg = length(Vmax);
Vmax_entry = Vmax_entry';
Vmax = Vmax';
V = Vmax;
Vi = zeros(n_seg,1);
loop = 0;

%Main Loop
while max(abs(V - Vi)) > chg
    loop = loop + 1;
    
    for i = n_seg:-1:1
        if Vmax_entry(i) < Vmax(i)
            Vi(i) = Vmax_entry(i);
        else
            Vi(i) = Vmax(i);
        end
    end
        
end

V = Vi;