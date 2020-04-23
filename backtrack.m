function [V_sim_new,f_brake_new] = backtrack(V_sim,m,seg,Cd,A,mu,p,g,R,f_brake)

for i = length(V_sim):-1:2
    [V_entry,Fs] = maxvel_entry(V_sim(i),Cd,A,m,mu,p,g,R(i),seg(i));
    f_brake(i) = Fs;
    if V_sim(i-1) < V_entry
        break;
    else
        V_sim(i-1) = V_entry;
    end
end
V_sim_new = V_sim;
f_brake_new = f_brake;
end


