% APP6 S6
close all
clear
clc


%% Valeurs
Zc = 50;
R1 = 20;
R2 = 1e6;
Vg = 5;
Thigh = 5;
periode = 10;   % En ns

h = 1.6e-3;
w = 2.9e-3;
Er = 4.6;


%% Calculs
% ErP = ((Er + 1)/2) + ((Er - 1)/2)*((1 + 12*(h/w)).^(-0.5));
% Z0 = ((120*pi)/ErP)*(((w/h) + 1.393 + 0.667*log((w/h) + 1.444)).^-1);
Vplus = Vg*(Zc/(R1+Zc));
Vmoins = -Vplus;
Ts = (R1 - Zc)/(R1 + Zc);
ts = 1 + Ts;
Tl = (R2 - Zc)/(R2 + Zc);
tl = 1 + Tl;

Vreflet_plus = zeros(1,21);
Vreflet_moins = zeros(1,21);
V1_plus = zeros(1,21);
V1_moins = zeros(1,21);
V2_plus = zeros(1,21);
V2_moins = zeros(1,21);
V1_1pulse = zeros(1,21);
V2_1pulse = zeros(1,21);
Vref = [5 5 5 5 5 0 0 0 0 0 5 5 5 5 5 0 0 0 0 0 0];
time = 0: 1: 20;
 for t = 0: 1: 20
     Vreflet_plus(t+1) = Calcul_reflets(t,Vreflet_plus,Ts,Tl,Vplus);
     Vreflet_moins(t+1) = Calcul_reflets(t,Vreflet_moins,Ts,Tl,Vmoins);
     [V1_plus(t+1),V2_plus(t+1)] = Calculs_V1_V2(t,V1_plus,V2_plus,Vreflet_plus,tl,Vplus);
     [V1_moins(t+1),V2_moins(t+1)] = Calculs_V1_V2(t,V1_moins,V2_moins,Vreflet_moins,tl,Vmoins);
 end
 
V1_1pulse = V1_plus;
V1_1pulse(6:end) = V1_plus(6:end) + V1_moins(1:(end-5));
V2_1pulse = V2_plus;
V2_1pulse(6:end) = V2_plus(6:end) + V2_moins(1:(end-5));
 
V1_complet = V1_1pulse;
V1_complet(11:end) = V1_complet(11:end) + V1_1pulse(1:(end-10));
V2_complet = V2_1pulse;
V2_complet(11:end) = V2_complet(11:end) + V2_1pulse(1:(end-10));

figure('Name','V1 et V2')
hold on
stairs(time,Vref,'k','LineWidth',1)
stairs(time,V1_complet,'r','LineWidth',1.25)
stairs(time,V2_complet,'b','LineWidth',1.25)
legend('Vref','V1','V2','Location','SouthWest')
yticks(-4:1:8)
xticks(0:1:20)
xlabel('time (ns)')
ylabel('Voltage')
title('Représentation théorique des signaux V1 et V2')
grid on
