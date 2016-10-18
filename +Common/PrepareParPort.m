switch DataStruct.ParPort
    
    case 'On'
        
        % Open parallel port
        OpenParPort;
        
        % Set pp to 0
        WriteParPort(0)
        
    case 'Off'
        
end

% Prepare messages
msg.cross       = 2^0; % 1
msg.blackscreen = 2^1; % 2
msg.word        = 2^2; % 4
msg.img         = 2^3; % 8
msg.wav         = 2^4; % 16

% Pulse duration
msg.duration             = 0.005; % seconds

TaskData.ParPortMessages = msg;
