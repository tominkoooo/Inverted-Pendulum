%Autor: Tomasz Ciborowski 165501 AiR
%{
l - odleg³oœæ wzd³u¿ wahad³a do œrodka ciê¿koœci
L - d³ugoœæ wahad³a
X - macierz zmiennych stanu
m - masa wahad³a
M - masa wózka
g - sta³a grawitacyjna
b - wspó³czynnik tarcia
%}
function wahadlo_odwrotne(x0,xk,theta0,checkbox,czas_symulacji,handles)
clc;
M = 7.1234;
m = 1.624;
L = 2.12;
l = (M*0.64/2+m*(0.64/2+L))/(M+m);
b = 2.146;
g = 9.80665;

%zakladam, ze srodek masy jest w srodku ciezkosci, wiec I=0

%X = [x; dx; theta; dtheta]

if(checkbox{1,1}==1) %dó³
    gora_dol = -1;
    kat_koncowy = pi;
elseif(checkbox{1,1}==0)
    gora_dol=1; %góra
    kat_koncowy = 0;
else
end

A=[0 1 0 0; 
0 -b/M -m*g/M 0;
0 0 0 1; 
0 gora_dol*b/l/M gora_dol*(M+m)*g/M/l 0];

B=[0 1/M 0 -gora_dol/M/l].';
bieguny = [-1.13 -1.14 -1.15 -1.16]; 
% rlocus(ss(A,B,[1 1 1 1],0))
wzmocnienie_w_petli_sprzezenia_zwrotnego = place(A,B,bieguny);
theta0 = degtorad(theta0);
czas = 0:.001:czas_symulacji;
X0 = [x0; 0; kat_koncowy+theta0; 0]; 
Xk = [xk; 0; kat_koncowy; 0];
%{
X0 - wartoœci pocz¹tkowe stanu
Xk - wartoœci, do których ma d¹¿yæ stan
wzmocnienie jest wyliczane na podstawie biegunów okreœlonych przy pomocy
linii pierwiastkowych
%}
%przypadek, gdy wahadlo jest na dole
if(gora_dol==-1)
    [czas,X] = ode45(@(czas,X)dX(X,m,M,l,b,-wzmocnienie_w_petli_sprzezenia_zwrotnego*(X-Xk)),czas,X0);
    %przypadek, gdy wahadlo jest na górze
elseif(gora_dol == 1)
    [czas,X] = ode45(@(czas,X)dX(X,m,M,l,b,-wzmocnienie_w_petli_sprzezenia_zwrotnego*(X-Xk)),czas,X0);
else
end

axes(handles.polozenie);
plot(czas,X(:,1));
title('Zmiana po³o¿enia');
xlabel('czas [s]');
ylabel('x');
axes(handles.kat);
plot(czas,radtodeg(X(:,3)));
title('Zmiana k¹ta');
xlabel('czas [s]');
ylabel('theta [stopnie]');
axes(handles.wahadlo);
for zakres=1:100:length(czas)
    rysowanie(L,X(zakres,:));
end
end