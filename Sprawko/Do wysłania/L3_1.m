
    addpath('F:\SerialCommunication'); % add a path to the functions
    initSerialControl COM3 % initialise com port
   
    N = 420;
    step_response = zeros(N+1,1);
    i = 0;
    k = linspace (0,N,N+1)';
    
    while(i<=N)
        %% obtaining measurements
        measurements = readMeasurements(1:7); % read measurements from 1 to 1
        
        %% processing of the measurements and new control values calculation
        disp([measurements(1),i]);
        step_response(i+1)=measurements(1);
        
        %% sending new values of control signals
        % sendNonlinearControls(52.5)  % new corresponding control valuesdisp(measurements); % process measurements
        sendControls([ 1, 2, 3, 4, 5, 6], ... send for these elements
                     [50, 0, 0, 0, 29, 0]);
     %%   y=[y measurements(1)];
     %%   plot(y)
        
        %% synchronising with the control process
        
        i=i+1;
        step_response(i)=measurements(1);
        
        waitForNewIteration(); % wait for new batch of measurements to be ready
        
    end%     T=table(k,step_response);
%     writetable(T,'step_29_69','WriteVariableNames',false,'Delimiter','space');
     save('step_response_central.mat','step_response');

% step_response(1)=s0

% Y_40=readMeasurements(1);
% save('Y_40','Y_40');
% plot(step_response);
% save('step_response_50_40','step_response');
