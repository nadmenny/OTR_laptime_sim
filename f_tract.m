%% Tractive Force Equations

function [f_netc, f_netp, Vinst, a_tract] = f_tract(cont_trq, peak_trq, r_wheel,m, Cd,A,Vinst,p)

f_tractp = (peak_trq./r_wheel);
f_tractc = (cont_trq./r_wheel);
f_drag = 0.5.*p.*(Vinst.^2).*A.*Cd;
f_netc = f_tractc - f_drag;
f_netp = f_tractp - f_drag;
a_tractc = f_netc/m;
a_tractp = f_netp/m;
end