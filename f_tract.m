%% Tractive Force Equations

function [f_net] = f_tract(cont_trq, peak_trq, r_wheel, Cd,A,m,mu,p,g)

f_tractp = (peak_trq./r_wheel);
f_tractc = (cont_trq./r_wheel);
f_net = 0;

end