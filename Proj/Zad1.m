n = 100;
u = zeros(n,1);
y = zeros(n,1);
for i = 1:n
    u(n) = 1;
    y = circshift(y,-1);
    y(n) = symulacja_obiektu4y(u(n-5),u(n-6),y(n-1),y(n-2));
    u = circshift(u,-1);
end
plot(y);
xlabel('k');
ylabel('y');