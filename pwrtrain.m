% Program to determine acceleration run gearing with drivetrain inertia
clc, clear all,close all; 
global m c f0 rw p ni etov % Share information with the ‘function’
% Engine torque formula is:
% te=p1*we^3+p2*we^2+p3*we^1+ p4We^0
% polynomial coefficients are in ‘p’
p=[-3.1935E-10, 1.8005E-6, -3.62124E-3,1.4044E2];%max torque curve polynomial constants
%p=[3.5648E-11,-1.3838E-6,6.1343E-3,5.9997E1];% continuous torque curve polynomial
% Enter proper vehicle parameters:
rw=0.254; fr=0.015; Cd=1.2; A=1.2; % wheel radius, rolling resistance, drag coefficient {pCdA}
P=101300; T=25; R=287;% Pressure, temperature and gas constant
c=.5*(P/R/(273+T))^2;% air density
D=75; % straight-away distance of interest [m]
ni=5.5;% final drive ratio:
% inertia Values:
m0=350; Ie=.0256; Iw=3;% Vehicle [kg]; engine, diff-axle- & wheels/brakes [kg-m^2]
x0=[eps, 0]; t0=0; tf=8; % Initial conditions vector, start & finish time
theta= 0*(pi/180); %enter road slope in degrees
etov=0.95; %overall efficiency of driveline
Wb=1.5; % wheelbase [m]
cgH=.3; % cg height [m]
Fp=.44; % front weight fraction
mu=1.2; % max friction coefficient of tire
kr=((1-Fp)*Wb-cgH*fr)/(Wb-mu*cgH);% weight transfer factor
nl=kr*mu*9.81*m0*rw/(etov*polyval(p, 0)) % lowest ratio
Mr1=Iw/(rw^2); % Equivalent mass of wheels, axles and differential
Mr2=Ie*(ni^2)/(rw^2); % equivalent mass of engine
m=Mr1+Mr2+m0; % total equivalent mass
f0=m*9.81*(fr*cos(theta)+sin(theta)); % static rolling resistance [N]
[t,x]=ode45(@Fixed_thrt, [t0 tf], x0); % Calls Fixed_thrt function
v=x(:,1); % all rows first column = velocity
s=x(:,2); %all rows 2nd column = distance
omega=ni*v*30/rw/pi;
Mrpm=interp1(s,omega,D)% interpolate rpm at specified distance
time=interp1(s,t,D) % interpolate for time to specified distance
% reconstruct acceleration, a=Dv/Dt
accl=length(t); %size of vector
    for j=2:length(t); accl(j)=(v(j)-v(j-1))/(t(j)-t(j-1));
    end
    accl(1)=accl(2);
figure (1)
plot(t,accl)
hold on
grid
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
figure (2)
plot(t,omega), hold on
grid
plot(3)
xlabel('Time (s)')
ylabel('rpm')
figure(3)
subplot(2,1,1), plot(t,v*3.6),hold on
subplot(2,1,2), plot(t,s), hold on
subplot(2,1,1)
xlabel('Time (s)')
ylabel('Velocity (kph)')
grid
subplot(2,1,2)
xlabel('Time (s)')
ylabel('Distance (m)')
grid