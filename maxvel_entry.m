%% Calculate max entry velocity into each segment

function [Vmax_entry, Fs] = maxvel_entry(Vmax,Cd,A,m,mu,p,g,R,seg)
Fn = m*g;
Fs = 0.5.*p.*(Vmax.^2).*A.*Cd + sqrt((mu.*Fn).^2 - (m.^2.*Vmax.^4)./(R.^2));
Vmax_entry = sqrt((Vmax.^2) + (2.*seg.*Fs)./m);

end