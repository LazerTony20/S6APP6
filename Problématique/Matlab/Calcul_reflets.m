% APP6 S6 
% Calculs des tensions reflêtées
% ROYA2019

function f = Calcul_reflets(t,Vreflet,Ts,Tl,V)
if t == 0
    f = V;
else
    if 0 == mod(t,2) 
        f = Vreflet(t)*Ts;
    else
        f = Vreflet(t)*Tl;
    end
end
end

