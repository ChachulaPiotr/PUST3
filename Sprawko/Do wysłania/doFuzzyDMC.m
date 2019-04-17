
% Zaladowanie odpowiedzi skokwej
load('step_response_70_80_approx');
load('step_response_20_30_approx');
load('step_response_central_approx');
% Inicjalizacja komunikacji z obiektem
addpath('F:\SerialCommunication'); 
initSerialControl COM3 

% Ustalenie maksymalnych przedzialow sterowania
Umax=100;
Umin=0;

%Ustalenie iloscie regulatorow lokalnych
il = 3;

% Ustawienie parametrow regulatora
D = 320;
N=D;
Nu=D;
lambda = [100 200 100];
    
% Inicjalizacja macierzy przechowujacych zmienne
ku = zeros(il,D-1);
ke = zeros(1,il);
deltaup=zeros(1,D-1);
deltauk = zeros(il,1);
DELTAuk = zeros(il,1);
% Zaladowanie odpowiedzi skokwych
S(:,1)=step_response_20_30_approx(1:D);
S(:,2)=step_response_central_approx(1:D);
S(:,3)=step_response_70_80_approx(1:D);

% Stworzenie macierzy M, Mp oraz wyliczenie paratmetrow ku oraz ke dla
% kazdego regulatora lokalnego
for r = 1:il
    s = S(:,r);
    
    M=zeros(N,Nu);
    for i=1:N
       for j=1:Nu
          if (i>=j)
             M(i,j)=s(i-j+1);
          end
       end
    end

    MP=zeros(N,D-1);
    for i=1:N
       for j=1:D-1
          if i+j<=D
             MP(i,j)=s(i+j)-s(j);
          else
             MP(i,j)=s(D)-s(j);
          end    
       end
    end

    I=eye(Nu);
    K=((M'*M+lambda(r)*I)^-1)*M';
    ku(r,:)=K(1,:)*MP;
    ke(r)=sum(K(1,:));
end


% Ustalenie punktu pracy
U0 = 29;
Y0 = readMeasurements(1);

% Ustalenie czasu symulacji
start = 10;
n=750;

% Inicjacja macierzy przechowujacej wyjscia, sterowanie oraz uchyby
U = U0*ones(1,n);
Y = Y0*ones(1,n);
e = zeros(1,n);

% Utworzenie horyzontu wartosci zadanej
Yz = Y;
Yz(1:10)=Y0;
Yz(11:n/3) = Y0+5;
Yz(n/3+1:2*n/3)=Y0+15;
Yz(2*n/3+1:end)=Y0;

% Petla glowna regulatora
for k = start:n
    % Odczyt wartosci wyjscia
    Y(k) = readMeasurements(1);
    % Policzenie wartosci uchybu
    e(k) = Yz(k) - Y(k);

    % Dla regulatora nierozmytego liczymy jedno sterowanie
    if regulator==1
        % Prawo regulacji
        DELTAuk(i)=ke(1)*e(k)-ku(1,:)*deltaup';   
    else
    
    % Dla regulatora rozmytego liczymy sterowanie dla kazdego regulatora
    % lokalnego
    for i = 1:il
        deltauk(i) = ke(i)*e(k)-ku(i,:)*deltaup';       
    end   
    % Polczenie wartosci funkcji aktywacji dla kazdego regulatora lokalnego
    w = f_przyn(U(k-1));
    % Przemnozenie sterowan regulatorow lokalnych przez ich wartosci
    % funkcji aktywacji
    DELTAuk = w*deltauk/sum(w);
    end
    % Przesuniecie wektora dUp
    for i = D-1:-1:2
      deltaup(i) = deltaup(i-1);
    end
    % I wpisanie do niego wyliczonego elementu
    deltaup(1) = DELTAuk;
    % Wyliczenie obecnej wartosci sterowania
    U(k) = U(k-1)+deltaup(1);
    % Uwzglednienie ograniczen na wartosc sterowania
    U(k) = max(min(U(k),Umax),Umin);
    % Korekta zmiany wartosci sterowania
    deltaup(1)=U(k)-U(k-1);
    % Wyslanie sterowania do obiektu
    sendNonlinearControls(U(k))
    
    disp([Y(k),U(k)]);
    waitForNewIteration();
end
plot(Y);
hold on;
plot(Yz,'--r');
hold off;

save('FuzzyDMCY','Y');
save('FuzzyDMCYzad','Yz');
save('FuzzyDMCU','U');


