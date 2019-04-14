il = 1;
Ur = [0:(2/(il+1)):((il+1)*2/(il+1))];
Ur = Ur -1;
Ur = round(Ur,1);
c = zeros(1,il);
s = zeros(1,il);
for j = 1:il
    c(j) = charStat(Ur(j+1)*10+11);
    s(j) = (charStat(Ur(j+1)*10+11) - charStat(Ur(j)*10+11))*100;
end
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

