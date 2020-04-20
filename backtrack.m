function V_inst = backtrack(V_inst,m,seg,Cd,A,mu,p,g,R)


for i = length(V_inst)-1:-1:2
    F_brake = (V_inst(i)^2-V_inst(i-1)^2)*m/(2*seg(i));
    Fs = maxvel_entry(V_inst(i),Cd,A,m,mu,p,g,R(i),seg(i));
    if abs(F_brake) < Fs
        break;
    else
        V_inst(i-1) = sqrt((V_inst(i).^2) + (2.*seg(i).*Fs)./m);
    end
end
end


