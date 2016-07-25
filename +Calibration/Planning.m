%% Prepare event

% Create and prepare
header = { 'event_name' , 'onset(s)' , 'duration(s)' };
EP     = EventPlanning(header);

% NextOnset = PreviousOnset + PreviousDuration
NextOnset = @(EP) EP.Data{end,2} + EP.Data{end,3};


%% Define a planning <--- paradigme

% --- Start ---------------------------------------------------------------

EP.AddPlanning({ 'StartTime' 0  0 });

% --- Stim ----------------------------------------------------------------

EP.AddPlanning({ 'LeftButton_instructions' NextOnset(EP) 2 });
EP.AddPlanning({ 'LeftButton_ok' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });

EP.AddPlanning({ 'RightButton_instructions' NextOnset(EP) 2 });
EP.AddPlanning({ 'RightButton_ok' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });

EP.AddPlanning({ 'Volume_instructions' NextOnset(EP) 10 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'Volume_question' NextOnset(EP) 2 });
EP.AddPlanning({ 'Volume_ok' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });
repeat_microtime = 0.1;

EP.AddPlanning({ 'Screen_instructions' NextOnset(EP) 5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'Screen_Cross' NextOnset(EP) 10 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 1 });

% --- Stop ----------------------------------------------------------------

EP.AddPlanning({ 'StopTime' NextOnset(EP)  0 });

%% Acceleration

if nargout > 0
    
    switch DataStruct.OperationMode
        
        case 'Acquisition'
            
            Speed = 1;
            
        case 'FastDebug'
            
            Speed = 10;
            
            new_onsets = cellfun( @(x) {x/Speed} , EP.Data(:,2) );
            EP.Data(:,2) = new_onsets;
            
            new_durations = cellfun( @(x) {x/Speed} , EP.Data(:,3) );
            EP.Data(:,3) = new_durations;
            
        case 'RealisticDebug'
            
            Speed = 1;
            
        otherwise
            error( 'DataStruct.OperationMode = %s' , DataStruct.OperationMode )
            
    end
    
end


%% Display

% To prepare the planning and visualize it, we can execute the function
% without output argument

if nargout < 1
    
    fprintf( '\n' )
    fprintf(' \n Total stim duration : %g seconds \n' , NextOnset(EP) )
    fprintf( '\n' )
    
    EP.Plot
    
end
