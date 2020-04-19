%% paramsmu = 1.4;%Friction Coefficient
g = 9.81; % gravitational acceleration m/s^2
m = 300; %Mass kg
mu = 1.4; %friction Coefficient
Fn = m*g; % Normal Force N
Cd = 0.150; %Drag Coefficient
p = 1.225; % Density Kg/m^3
A = 1.328; %Area m^2

%test track
x1 = 0:1:5;
y1 = sqrt(5^2 - x1.^2);
x = [-3,-2,-1,x1,5,5,5];
y = [5,5,5,y1,-1,-2,-3];


 %% Test
k = efrad(x,y)
Vmax = maxcv(k,Cd,A,m,mu,p,g)
plot(x,Vmax);




