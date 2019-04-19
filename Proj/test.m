il = 3;
%Ur = [0:(2/(il+1)):((il+1)*2/(il+1))];
%Ur = Ur -1;
Ur = [-0.5 0.2 0.7]; 
c = zeros(1,il);
s = zeros(1,il);
for j = 1:il
    c(j) = charStat(Ur(j)*10+11);
end
s(1) = 0.1;
s(2) = 0.3;
s(3) = 1.5;
x = [-0.5:0.01:7.5];
y = zeros(size(x,1),il);
I = 1;
for j = 1:il
    for i = x
        y(I,j) = exp(-((i-c(j))/s(j))^2);
        I = I+1;
    end
    I = 1;
end
plot(x,y);

