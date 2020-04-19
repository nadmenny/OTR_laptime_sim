%% Tractive Force Equations

function [a_tractc, a_tractp] = f_tract(wc_trq, wp_trq, r_wheel,m, Cd,A,V_inst,p)

f_tractp = (wp_trq./r_wheel);
f_tractc = (wc_trq./r_wheel);
f_drag = 0.5.*p.*(V_inst.^2).*A.*Cd;
f_netc = f_tractc - f_drag;
f_netp = f_tractp - f_drag;
a_tractc = f_netc/m;
a_tractp = f_netp/m;

end