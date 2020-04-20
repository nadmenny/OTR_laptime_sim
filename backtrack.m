function V_inst = backtrack(V_inst,Fs,m,seg)
F_maxbrake = Fs;

for i = length(V_inst):-1:2
    F_brake = (V_inst(i)^2-V_inst(i-1)^2)*m/(2*seg(i));
    if abs(F_brake) < F_maxbrake
        break;
    else
        V_inst(i-1) = sqrt((V_inst(i).^2) + (2.*seg(i).*Fs)./m);
    end
end
end


