function r = efrad(x,y)

for i = 3:length(x) %Start from 3d point in
    a = sqrt((x(i)-x(i-2))^2 + (y(i)-y(i-2))^2); %length from end point to end point of last segment
    b = sqrt((x(i)-x(i-1))^2 + (y(i)-y(i-1))^2); % length from start point to end point of last segment
    c = sqrt((x(i-1)-x(i-2))^2 + (y(i-1)-y(i-2))^2); %length from end point to start point 
    A = acosd((b^2 + c^2 - a^2)/(2*b*c)); %angle between length b and c
    r1(i) = a/(2*sind(180-A)); %Effective Raduis
end
r = r1;

end