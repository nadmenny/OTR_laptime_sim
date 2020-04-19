function V_inst = v_inst(a_tractp,a_tractc,seg,V_inst)

V_inst = sqrt(V_inst.^2 + (2.*seg.*a_tractc));

end