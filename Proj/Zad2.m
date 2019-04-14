k = 100;
Y = zeros(21,1);
I = 1;
S = zeros(21,100);
for i = -1:0.1:1
    u = zeros(k,1);
    y = u;
    u(k) = i;
    for j = 1:k
        y = circshift(y,-1);
        y(k)=symulacja_obiektu4y(u(k-5),u(k-6),y(k-1),y(k-2));
        u = circshift(u,-1);
        u(k) = i;
    end
    Y(I) = y(k);
    S(I,:)=y;
    I = I+1;
end
plot(-1:0.1:1,Y);
%hold off;
%plot(y);
%xlabel('k');
%ylabel('y(k), u(k)');
%legend('y','u');
%saveas(gcf,'odp_skok_u.pdf','pdf');
%save('odp_skok_u.mat','y');