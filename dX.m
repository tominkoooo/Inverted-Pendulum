function dX = dX(X,m,M,l,b,wejscie)
g = 9.80665;
mianownik = M+m*(sin(X(3)))^2;
s = sin(X(3));
c = cos(X(3));
dx = X(2);
dth = X(4);
dX(1,1)=X(2); %dx
dX(2,1)=(wejscie+m*l*s*dth^2-b*dx-m*g*s*c)/mianownik; %ddx
dX(3,1)=X(4); %dtheta
dX(4,1)=((M+m)*g*s-wejscie*c-m*l*s*c*dth^2+b*c*dx)/mianownik/l; %ddtheta
end