% Inicjalizacja polaczenia
addpath('F:\SerialCommunication'); % add a path to the functions
initSerialControl COM3 % initialise com port

% Typ regulatora
regulator=1;         

% Inicjalizacja parametrow
K=[10 10 20];
Ti=[60 60 60];
Td=[0 0 0];
T=1; 
% Inicjalizacja wskaznika jakosci
error=0;
% Inicjalizacja czasu trwania symluacji
sim_len=900;

% Parametry dyskretnego PIDa
for i=1:3
r0(i)=K(i)*(1+T/(2*Ti(i))+Td(i)/T);
r1(i)=K(i)*(T/(2*Ti(i))-2*Td(i)/T-1);
r2(i)=K(i)*Td(i)/T;
end

% Inicjalizacja
Y=zeros(sim_len,1);
U=zeros(sim_len,1);
e=zeros(sim_len,1);
y=zeros(sim_len,1);
u=zeros(sim_len,1);
Yzad=zeros(sim_len,1);
kk=linspace(1,sim_len,sim_len)';

% Zakladamy ze przed rozpoczeciem symulacji obiekt znajdowal sie w punktu pracy
Ypp=readMeasurements(1);
Upp=29;
Y(1:30)=Ypp;
U(1:30)=Upp;

% Inicjalizacja horyzontu wartosci zadanych
Yzad(1:sim_len/3-1)=Ypp+5;
Yzad(sim_len/3:2*sim_len/3-1)=Ypp+15;
Yzad(2*sim_len/3:sim_len)=Ypp;

% Ograniczenia U
Umin=0;
Umax=100;
umin=Umin-Upp;
umax=Umax-Upp;

% Glowna petla programu
for i=31:sim_len
% Odczyt wartosci temperatury
measurements = readMeasurements(1:7); 
Y(k)=measurements(1)
% Rzutowanie wzgledem wartosci punktu pracy
y(k)=Y(k)-Ypp;
% Liczenie uchybu i uaktualnienie wskaznika jakosci
e(k)=Yzad(k)-Y(k);
error=error+e(k)^2;
% Wyliczenia wartosci funkcji aktywacji
w=f_przyn(U(k-1));

% Uzycie PIDa to wyliczenia strerowania
if regulator==1                      %Jesli regulator jest nierozmyty przyjmujemy pierwsze elementy macierzy jako parametry
u_wyliczone=r2(1)*e(k-2)+r1(1)*e(k-1)+r(1)*e(k)+u(k-1);

else
    for q=1:3
        u_wyliczone=u_wyliczone+w(q)*(r2(q)*e(k-2)+r1(q)*e(k-1)+r0(q)*e(k)+u(k-1));
    end
end

% Rzutowanie ograniczen na wartosc sterowania
if u_wyliczone<umin
u_wyliczone=umin;
elseif u_wyliczone>umax
u_wyliczone=umax;
end
u(k)=u_wyliczone;
% Rzutowanie sterowania wzgledem punktu pracy
U(k)=u_wyliczone+Upp;
% Wyslanie sterowania do regulatora
sendNonlinearControls(U(k))
end
