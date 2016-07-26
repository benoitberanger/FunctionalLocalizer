%% Prepare event

% Create and prepare
header = { 'event_name' , 'onset(s)' , 'duration(s)' 'content'};
EP     = EventPlanning(header);

% NextOnset = PreviousOnset + PreviousDuration
NextOnset = @(EP) EP.Data{end,2} + EP.Data{end,3};



%% Define a planning <--- paradigme

% --- Start ---------------------------------------------------------------

EP.AddPlanning({ 'StartTime' 0  0 [] });

% --- Stim ----------------------------------------------------------------

EP.AddPlanning({ 'Horizontal_Checkerboard' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Vertical_Checkerboard' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Right_Audio_Click' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Left_Audio_Click' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Right_Video_Click' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Left_Video_Click' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Audio_Computation' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Video_Computation' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Video_Sentences' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Audio_Sentences' NextOnset(EP) 0 [] });

EP.AddPlanning({ 'Audio_Sinwave' NextOnset(EP) 0 [] });
EP.AddPlanning({ 'Cross_Rest' NextOnset(EP) 0 [] });

% --- Stop ----------------------------------------------------------------

EP.AddPlanning({ 'StopTime' NextOnset(EP) 0 [] });


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
