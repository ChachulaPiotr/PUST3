 function [error] = Zad6(paras)
    load('stepRes');
    load('charStat');
    load('parasPID.mat');
    regulator = 1;
    il = 5;
    Umax = 1;
    Umin = -1;
    if (il == 1)
        Ur = 0.2;
        a = -Inf*ones(1,il);
        b = -Inf*ones(1,il);
        c = Inf*ones(1,il);
        d = Inf*ones(1,il);
    elseif (il == 2)
        Ur = [-0.5 0.7];
        a = -Inf*ones(1,il);
        b = -Inf*ones(1,il);
        c = Inf*ones(1,il);
        d = Inf*ones(1,il);
        c(1) = charStat(-0.1*10+11);
        d(1) = charStat(0.2*10+11);
        a(2) = charStat(0.2*10+11);
        b(2) = charStat(0.4*10+11);
    elseif(il ==3)
        Ur = [-0.5 0.2 0.7];
        a = -Inf*ones(1,il);
        b = -Inf*ones(1,il);
        c = Inf*ones(1,il);
        d = Inf*ones(1,il);
        c(1) = charStat(-0.1*10+11);
        d(1) = charStat(0.1*10+11);
        a(2) = charStat(0*10+11);
        b(2) = charStat(0.1*10+11);
        c(2) = charStat(0.2*10+11);
        d(2) = charStat(0.4*10+11);
        a(3) = charStat(0.2*10+11);
        b(3) = charStat(0.4*10+11);
    elseif(il == 4)
        Ur = [-0.5,0.1,0.3,0.7];
        a = -Inf*ones(1,il);
        b = -Inf*ones(1,il);
        c = Inf*ones(1,il);
        d = Inf*ones(1,il);
        c(1) = charStat(-0.1*10+11);
        d(1) = charStat(0.1*10+11);
        a(2) = charStat(0*10+11);
        b(2) = (charStat(0*10+11) + charStat(0.1*10+11))/2;
        c(2) = (charStat(0.1*10+11) + charStat(0.2*10+11))/2;
        d(2) = (charStat(0.2*10+11) + charStat(0.3*10+11))/2;
        a(3) = (charStat(0.1*10+11) + charStat(0.2*10+11))/2;
        b(3) = (charStat(0.2*10+11) + charStat(0.3*10+11))/2;
        c(3) = (charStat(0.4*10+11) + charStat(0.3*10+11))/2;
        d(3) = charStat(0.4*10+11);
        a(4) =  charStat(0.3*10+11);
        b(4) =  charStat(0.4*10+11);
    elseif (il == 5)
        Ur = [-0.5,0.1,0.2,0.3,0.7];
        a = -Inf*ones(1,il);
        b = -Inf*ones(1,il);
        c = Inf*ones(1,il);
        d = Inf*ones(1,il);
        c(1) = charStat(-0.1*10+11);
        d(1) = charStat(0.1*10+11);
        a(2) = charStat(0*10+11);
        b(2) = (charStat(0*10+11) + charStat(0.1*10+11))/2;
        c(2) = (charStat(0.1*10+11) + charStat(0.2*10+11))/2;
        d(2) = (charStat(0.2*10+11) + charStat(0.3*10+11))/2;
        a(3) = charStat(0.1*10+11);
        b(3) = charStat(0.2*10+11);
        c(3) = charStat(0.2*10+11);
        d(3) = charStat(0.3*10+11);
        a(4) = (charStat(0.1*10+11) + charStat(0.2*10+11))/2;
        b(4) = (charStat(0.2*10+11) + charStat(0.3*10+11))/2;
        c(4) = (charStat(0.4*10+11) + charStat(0.3*10+11))/2;
        d(4) = charStat(0.4*10+11);
        a(5) =  charStat(0.3*10+11);
        b(5) =  charStat(0.4*10+11);
    end

    if regulator==2
        %zmienne regulatora PID
        Tp = 1;
        if (il == 1)
            kp = parasPID02(1);
            Ti = parasPID02(2);
            Td = parasPID02(3);
        elseif (il == 2)
            r1 = zeros(il,1);
            r2 = zeros(il,1);
            r3 = zeros(il,1);
            kp = zeros(il,1);
            Ti = zeros(il,1);
            Td = zeros(il,1);
            kp(1) = parasPIDm05(1);
            Ti(1) = parasPIDm05(2);
            Td(1) = parasPIDm05(3);
            kp(2) = parasPID07(1);
            Ti(2) = parasPID07(2);
            Td(2) = parasPID07(3);
            
        elseif (il == 3)
            r1 = zeros(il,1);
            r2 = zeros(il,1);
            r3 = zeros(il,1);
            kp = zeros(il,1);
            Ti = zeros(il,1);
            Td = zeros(il,1);
            kp(1) = parasPIDm05(1);
            Ti(1) = parasPIDm05(2);
            Td(1) = parasPIDm05(3);
            kp(2) = parasPID02(1);
            Ti(2) = parasPID02(2);
            Td(2) = parasPID02(3);
            kp(3) = parasPID07(1);
            Ti(3) = parasPID07(2);
            Td(3) = parasPID07(3);
        elseif (il == 4)
            r1 = zeros(il,1);
            r2 = zeros(il,1);
            r3 = zeros(il,1);
            kp = zeros(il,1);
            Ti = zeros(il,1);
            Td = zeros(il,1);
            kp(1) = parasPIDm05(1);
            Ti(1) = parasPIDm05(2);
            Td(1) = parasPIDm05(3);
            kp(2) = parasPID01(1);
            Ti(2) = parasPID01(2);
            Td(2) = parasPID01(3);
            kp(3) = parasPID03(1);
            Ti(3) = parasPID03(2);
            Td(3) = parasPID03(3);
            kp(4) = parasPID07(1);
            Ti(4) = parasPID07(2);
            Td(4) = parasPID07(3);
        elseif (il == 5)
            r1 = zeros(il,1);
            r2 = zeros(il,1);
            r3 = zeros(il,1);
            kp = zeros(il,1);
            Ti = zeros(il,1);
            Td = zeros(il,1);
            kp(1) = parasPIDm05(1);
            Ti(1) = parasPIDm05(2);
            Td(1) = parasPIDm05(3);
            kp(2) = parasPID01(1);
            Ti(2) = parasPID01(2);
            Td(2) = parasPID01(3);
            kp(3) = parasPID02(1);
            Ti(3) = parasPID02(2);
            Td(3) = parasPID02(3);
            kp(4) = parasPID03(1);
            Ti(4) = parasPID03(2);
            Td(4) = parasPID03(3);
            kp(5) = parasPID07(1);
            Ti(5) = parasPID07(2);
            Td(5) = parasPID07(3);
        end
        for i = 1:il
                r1(i) = kp(i)*(1+Tp/(2*Ti(i))+Td(i)/Tp);
                r2(i) = kp(i)*(Tp/(2*Ti(i))-2*Td(i)/Tp-1);
                r3(i) = kp(i)*Td(i)/Tp;  
        end
        
    elseif(regulator == 1)

        % zmienne i macierze regulatora DMC
        D=length(S(1,:));
        %D = 15;
        N=D;
        Nu=D;
        if (il == 1)
            lambda = 100;
        elseif il == 2
            lambda = [100 100];
        elseif il == 3
            lambda = [100 100 1000];
        elseif il == 4
            lambda = [100 100 100 100];
        elseif il == 5
            lambda = [100 100 100 100 100];
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
    end
    deltauk = zeros(il,1);
    w = zeros(1,il);
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
        if (regulator == 1)
            % Prawo regulacji
            for i = 1:il
                deltauk(i) = ke(i)*e(k)-ku(i,:)*deltaup';
                if Y(k) <= a(i)
                    w(i) = 0;
                elseif Y(k) > a(i) && Y(k) < b(i)
                    w(i) = (Y(k)-a(i))/(b(i)-a(i));
                elseif Y(k) >= b(i) && Y(k) <= c(i)
                    w(i) = 1;
                elseif Y(k) > c(i) && Y(k) < d(i)
                    w(i) = (d(i)-Y(k))/(d(i)-c(i));
                else
                    w(i) = 0;
                end
            end
            DELTAuk = w*deltauk/sum(w);
            for i = D-1:-1:2
              deltaup(i) = deltaup(i-1);
            end
            U(k) = U(k-1)+DELTAuk;
            U(k) = max(min(U(k),Umax),Umin);
            deltaup(1) = U(k) - U(k-1);
        elseif(regulator == 2)
            for i = 1:il
                deltauk(i) = r1(i)*e(k)+r2(i)*e(k-1)+r3(i)*e(k-2);
                if Y(k) <= a(i)
                    w(i) = 0;
                elseif Y(k) > a(i) && Y(k) < b(i)
                    w(i) = (Y(k)-a(i))/(b(i)-a(i));
                elseif Y(k) >= b(i) && Y(k) <= c(i)
                    w(i) = 1;
                elseif Y(k) > c(i) && Y(k) < d(i)
                    w(i) = (d(i)-Y(k))/(d(i)-c(i));
                else
                    w(i) = 0;
                end
                DELTAuk = w*deltauk/sum(w);
                U(k) = U(k-1)+DELTAuk;
                U(k) = max(min(U(k),Umax),Umin);
            end
        end
    end
    error = (Yz-Y)*(Yz-Y)';
    plot(Y);
    hold on;
    plot(Yz,'--r');
end