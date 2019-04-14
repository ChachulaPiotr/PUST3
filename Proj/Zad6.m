clear variables
close all
load('stepRes');
load('charStat');
il = 1;
Umax = 1;
Umin = -1;
Ur = [0:(2/(il+1)):((il+1)*2/(il+1))];
Ur = Ur -1;
Ur = round(Ur,1);
c = zeros(1,il);
b = zeros(1,il);
for j = 1:il
    c(j) = charStat(Ur(j+1)*10+11);
    b(j) = (charStat(Ur(j+1)*10+11) - charStat(Ur(j)*10+11))*0.5;
end
Ur = Ur(2:il+1);
% zmienne i macierze regulatora
%D=length(S(1,:));
D = 20;
N=D;
Nu=D;
if il == 2
    lambda = [1 1];
elseif il == 3
    lambda = [1 1 1];
elseif il == 4
    lambda = [1 1 1 1];
elseif il == 5
    lambda = [100 100 100 100 100];
elseif il == 1
    lambda = 1700;
end
ku = zeros(il,D-1);
ke = zeros(1,il);
for r = 1:il
    s = S(Ur(r)*10+11,:);
    
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
deltaup=zeros(1,D-1);
deltauk = zeros(il,1);
w = zeros(1,il);
U0 = 0;
Y0 = 0;
start = 10;
n=1000;
U = U0*ones(1,n);
Y = Y0*ones(1,n);
Yz = Y;
Yz(1:end) = 1;
e = zeros(1,n);

for k = start:n
    % symulacja
    Y(k) = symulacja_obiektu4y(U(k-5),U(k-6),Y(k-1),Y(k-2));
    % uchyb
    e(k) = Yz(k) - Y(k);
    
    % Prawo regulacji
    for i = 1:il
        deltauk(i) = ke(i)*e(k)-ku(i,:)*deltaup';
        w(i) = exp(-((Y(k)-c(i))/b(i))^2);
    end
    DELTAuk = w*deltauk/sum(w);
    for i = D-1:-1:2
      deltaup(i) = deltaup(i-1);
    end
    deltaup(1) = DELTAuk;
    U(k) = U(k-1)+deltaup(1);
    U(k) = max(min(U(k),Umax),Umin);
end
plot(Y);
hold on;
plot(Yz,'--r');