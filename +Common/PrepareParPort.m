switch DataStruct.ParPort
    
    case 'On'
        
        % Open parallel port
        OpenParPort;
        
        % Set pp to 0
        WriteParPort(0)
        
    case 'Off'
        
end

% Prepare messages
switch DataStruct.Task
    
    case 'Calibration'
        
        
    case 'Instructions'
        
        
    case 'Session'
        
    otherwise
        
end

msg.catch                = bin2dec('0 1 0 0 0 0 0 0');
msg.click                = bin2dec('1 0 0 0 0 0 0 0');

% Pulse duration
msg.duration             = 0.005; % seconds

TaskData.ParPortMessages = msg;
