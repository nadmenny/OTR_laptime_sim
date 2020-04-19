%% Calculate max velocity into each segment

function [Vmax,R] = maxvel(x,y,Cd,A,m,mu,p,g)

R = efrad(x,y); % Calculating effective corner radius
R(:,1:2) = Inf;
Fn = m*g;%Normal Force
eqn = (mu.*Fn).^2./((m./R).^2 + (0.5.*p.*A.*Cd).^2);%Main Equation Body
Vmax = nthroot(eqn,4);%Max Velocity for corner

end





