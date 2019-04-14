load ('charStat');
S = zeros(21,99);
L = 0;
k = 100;
for i = 1:21
    u = ones(k,1)*(L*0.1-1);
    y = ones(k,1)*charStat(i);
    u(k) = u(k)+0.1;
    L = L+1;
    for j = 1:100
        y = circshift(y,-1);
        y(k)=symulacja_obiektu4y(u(k-5),u(k-6),y(k-1),y(k-2));
        u = circshift(u,-1);
        u(k) = u(k)+0.1;
    end
    y = y - charStat(i);
    y = y/0.1;
    S(L,:)=y(2:end);
end

