function rysowanie(L,X)
x = X(1);
theta = X(3);
dlugosc_wozek = 1.65;
wysokosc_wozek = 0.74;
r_kuleczka = .2;
srodek_wozka_y = wysokosc_wozek/2;

wah_x = L*sin(theta) + x;
wah_y = L*cos(theta) + srodek_wozka_y;
%podloga
plot([-11 11],[0 0],'red','LineWidth',2) 
hold on
%wozek
rectangle('FaceColor','white','Position',[x-dlugosc_wozek/2,0,dlugosc_wozek,wysokosc_wozek],'Curvature',.3) 
%linia_wahadla
plot([x wah_x],[srodek_wozka_y wah_y],'black','LineWidth',2.5) 
%kuleczka
rectangle('FaceColor','white','Position',[wah_x-r_kuleczka,wah_y-r_kuleczka,2*r_kuleczka,2*r_kuleczka],'Curvature',1) 
xlim([-10 10]);
ylim([-3 3.5]);
drawnow
hold off