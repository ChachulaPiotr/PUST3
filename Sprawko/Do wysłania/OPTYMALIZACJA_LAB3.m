
close all;

x0=[11,1,0.3,2];

options = optimoptions('fmincon','Display','iter');

approx_params=fmincon(@aprox_error,x0,[],[],[],[],[-100,-100,-100,0],[100,100,100,100],[],options);

error=aprox_error(approx_params);

% save('aprox_params_central.mat','approx_params');
% save('error.mat','error');

load ('approx.mat');
N=length(Y);


for i=1:N+1
    if (Y(i)>=0.995*Y(end))
        step_response_70_80_approx = Y(1:i);       
        break;
    end
end

save('step_response_70_80_approx','step_response_70_80_approx');

% 
% Dz=length(cut_step_response_Z);
% 
% k=linspace(0,Dz-1,Dz)';
% T=table(k,cut_step_response_Z);
% writetable(T,'cut_step_response_Z','WriteVariableNames',false,'Delimiter','space');
% 
% 
% step_responsez_20=step_responsez_20(1:361);
% step_responsez_20=(step_responsez_20-step_responsez_20(1))/20;
% 
% save ('cut_step_response_Z.mat','cut_step_response_Z');
% 
% figure()
% plot(cut_step_response_Z);
% hold on;
% plot(step_responsez_20(1:Dz));
% hold off;
% xlabel('k');
% ylabel('y');
% legend('Aproksymacja','Domyúlna odpowiedü','Location','NorthWest');
% saveas(gcf,'LAB12_AproxedZ.eps','epsc');


