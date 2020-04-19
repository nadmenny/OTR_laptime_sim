%% Calculate max entry velocity into each segment

function [Vmax_entry] = maxvel_entry(Vmax,Cd,A,m,mu,p,g,R,s)

Fs = (0.5.*p.*(Vmax.^2).*A.*Cd) + sqrt((mu.^2).*((m.*g).^2) - ((m.^2).*(Vmax.^4))./(R.^2));
Vmax_entry = sqrt((Vmax.^2) + 2.*s.*Fs./m);

end