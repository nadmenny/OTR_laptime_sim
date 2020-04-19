%% Effective Radius 25m Radius corner 1/4 circle with straight entry and exit
x1 = 0:1:5;
y1 = sqrt(5^2 - x1.^2);
x = [-3,-2,-1,x1,5,5,5];
y = [5,5,5,y1,-1,-2,-3];
plot(x,y);
for i = 3:length(x)
    a = sqrt((x(i)-x(i-2))^2 + (y(i)-y(i-2))^2);
    b = sqrt((x(i)-x(i-1))^2 + (y(i)-y(i-1))^2);
    c = sqrt((x(i-1)-x(i-2))^2 + (y(i-1)-y(i-2))^2);
    A = acosd((b^2 + c^2 - a^2)/(2*b*c));
    R(i) = a/(2*sind(180-A));
end
R
%% Max Corner Speed
%Assumptions
mu = 1.4;%Friction Coefficient
g = 9.81;
m = 560; %Mass kg
Fn = m*g; % Normal Force N
Cd = 0.150; %Drag Coefficient
p = 1.225; % Density Kg/m^3
A = 1.328; %Area m^2

% Max Vel eqn (0.5.*p.*A.*Cd).^2
eqn = (mu.*Fn).^2./((m./R).^2 + (0.5.*p.*A.*Cd).^2);
Vmax = nthroot(eqn,4)




