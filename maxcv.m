function v = maxcv(R,Cd,A,m,mu,p,g) 
Fn = m*g;%Normal Force
eqn = (mu.*Fn).^2./((m./R).^2 + (0.5.*p.*A.*Cd).^2);%Main Equation Body
v = nthroot(eqn,4);%Max Velocity for corner
end