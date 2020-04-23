%% Calculate max entry velocity into each segment

function [V_entry,Fs] = maxvel_entry(V,Cd,A,m,mu,p,g,R,seg)

% V_entry : Maximum entry speed that can be attained based on exit speed,
% corner radius, braking force and segment length as well as vehicel
% parameters
% V : exit speed
% R : track radius
% seg : segment length

Fn = m*g; % normal force
Fs = 0.5.*p.*(V.^2).*A.*Cd + sqrt((mu.*Fn).^2 - (m^2.*V.^4)./(R.^2)); % max braking force at a given instant
V_entry = sqrt((V.^2) + (2.*seg.*Fs)./m); % Max or required entry speed to brake and get V(exit speed) of a sector on the track

end