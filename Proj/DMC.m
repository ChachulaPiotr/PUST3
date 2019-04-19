function [error] = DMC(paras)
    load('stepRes');
    load('charStat');
    Umax = 1;
    Umin = -1;
    % zmienne i macierze regulatora
    D=paras(1);
    %D = 15;
    N=paras(2);
    Nu=paras(3);
    lambda = paras(4);
    ku = zeros(1,D-1);
    ke = zeros(1,1);
    s = S(11,:);
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
    K=((M'*M+lambda*I)^-1)*M';
    ku=K(1,:)*MP;
    ke=sum(K(1,:));
    deltaup=zeros(1,D-1);
    deltauk = zeros(1,1);
    U0 = 0;
    Y0 = 0;
    start = 10;
    n=1000;
    U = U0*ones(1,n);
    Y = Y0*ones(1,n);
    Yz = Y;
    Yz(1:end) = 0.1;
    Yz(1:150) = 0.1;
    Yz(151:300)= 1;
    Yz(301:500)= 5;
    Yz(501:700)= -0.1;
    Yz(701:end)=3;
    e = zeros(1,n);

    for k = start:n
        % symulacja
        Y(k) = symulacja_obiektu4y(U(k-5),U(k-6),Y(k-1),Y(k-2));
        % uchyb
        e(k) = Yz(k) - Y(k);

        % Prawo regulacji
        deltauk = ke*e(k)-ku*deltaup';
        for i = D-1:-1:2
          deltaup(i) = deltaup(i-1);
        end
        U(k) = U(k-1)+deltauk;
        U(k) = max(min(U(k),Umax),Umin);
        deltaup(1) = U(k) - U(k-1);
    end
    plot(Y);
    hold on;
    plot(Yz,'--r');
end