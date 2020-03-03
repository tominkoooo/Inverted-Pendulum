%Autor: Tomasz Ciborowski 165501 AiR
%{
l - odleg�o�� wzd�u� wahad�a do �rodka ci�ko�ci
L - d�ugo�� wahad�a
X - macierz zmiennych stanu
m - masa wahad�a
M - masa w�zka
g - sta�a grawitacyjna
b - wsp�czynnik tarcia
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

if(checkbox{1,1}==1) %d�
    gora_dol = -1;
    kat_koncowy = pi;
elseif(checkbox{1,1}==0)
    gora_dol=1; %g�ra
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
X0 - warto�ci pocz�tkowe stanu
Xk - warto�ci, do kt�rych ma d��y� stan
wzmocnienie jest wyliczane na podstawie biegun�w okre�lonych przy pomocy
linii pierwiastkowych
%}
%przypadek, gdy wahadlo jest na dole
if(gora_dol==-1)
    [czas,X] = ode45(@(czas,X)dX(X,m,M,l,b,-wzmocnienie_w_petli_sprzezenia_zwrotnego*(X-Xk)),czas,X0);
    %przypadek, gdy wahadlo jest na g�rze
elseif(gora_dol == 1)
    [czas,X] = ode45(@(czas,X)dX(X,m,M,l,b,-wzmocnienie_w_petli_sprzezenia_zwrotnego*(X-Xk)),czas,X0);
else
end

axes(handles.polozenie);
plot(czas,X(:,1));
title('Zmiana po�o�enia');
xlabel('czas [s]');
ylabel('x');
axes(handles.kat);
plot(czas,radtodeg(X(:,3)));
title('Zmiana k�ta');
xlabel('czas [s]');
ylabel('theta [stopnie]');
axes(handles.wahadlo);
for zakres=1:100:length(czas)
    rysowanie(L,X(zakres,:));
end
end