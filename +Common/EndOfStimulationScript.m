%% End of stimulation

% EventRecorder
ER.ClearEmptyEvents;
ER.ComputeDurations;
ER.BuildGraph;
TaskData.ER = ER;

% Response Recorder
RR.ClearEmptyEvents;
RR.MakeBlocks;
RR.BuildGraph;
TaskData.RR = RR;

% KbLogger
KL.GetQueue;
KL.Stop;
switch DataStruct.OperationMode
    case 'Acquisition'
    case 'FastDebug'
        TR = 2.400; % seconds
        nbVolumes = ceil( EP.Data{end,2} / TR ) ; % nb of volumes for the estimated time of stimulation
        KL.GenerateMRITrigger( TR , nbVolumes , StartTime );
    case 'RealisticDebug'
        TR = 2.400; % seconds
        nbVolumes = ceil( EP.Data{end,2} / TR ); % nb of volumes for the estimated time of stimulation
        KL.GenerateMRITrigger( TR , nbVolumes , StartTime );
    otherwise
end
KL.ScaleTime;
KL.ComputeDurations;
KL.BuildGraph;
TaskData.KL = KL;

% Save some values
TaskData.StartTime = StartTime;
TaskData.StopTime  = StopTime;


%% Send infos to base workspace

assignin('base','EP',EP)
assignin('base','ER',ER)
assignin('base','RR',RR)
assignin('base','KL',KL)

assignin('base','TaskData',TaskData)


%% Close all movies / textures / audio devices

% Close all textures
Screen('Close');

% Close the audio device
PsychPortAudio('Close')


%% Close parallel port

switch DataStruct.ParPort
    
    case 'On'
        
        try
            CloseParPort;
        catch err % just try to colse it, but we don't want an error
            disp(err)
        end
        
    case 'Off'
        
end


%% Diagnotic

switch DataStruct.OperationMode
    case 'Acquisition'
        
    case 'FastDebug'
        plotDelay
        
    case 'RealisticDebug'
        plotDelay
        
end
