% APP6 S6 
% Calculs des tensions reflêtées
% ROYA2019

function [V1r,V2r] = Calculs_V1_V2(t,V1,V2,Vreflet,tl,V)
if t == 0
    V1r = V;
    V2r = 0;
else
    if 0 == mod(t,2) 
        V1r = V1(t) - Vreflet(t+1);
        V2r = V2(t);
    else
        V1r = V1(t);
        V2r = Vreflet(t+1)*tl + V2(t);
    end
end
end

