clear variables
%close all
Umax = 1;
Umin = -1;
U0 = 0;
Y0 = 0;
start = 10;
n=1000;
U = U0*ones(1,n);
Y = Y0*ones(1,n);
Yz = Y;
Yz(1:150) = 0.1;
Yz(151:300)= 1;
Yz(301:500)= 5;
Yz(501:700)= -0.1;
Yz(701:end)=3;
e = zeros(1,n);
Tp = 1;
kp = 0.1;
Ti = 5;
Td = 0.5;
r1 = kp*(1+Tp/(2*Ti)+Td/Tp);
r2 = kp*(Tp/(2*Ti)-2*Td/Tp-1);
r3 = kp*Td/Tp;

for k = start:n
    % symulacja
    Y(k) = symulacja_obiektu4y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    % uchyb
    e(k) = Yz(k) - Y(k);
    
    U(k)=U(k-1)+r1*e(k)+r2*e(k-1)+r3*e(k-2);
    U(k) = max(min(U(k),Umax),Umin);
end
plot(Y);
hold on;
plot(Yz,'--r');