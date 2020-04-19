function v = v_inst(a_tract,seg,v)
v = sqrt(v.^2 - (2.*seg.*a_tract));
end