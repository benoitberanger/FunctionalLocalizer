function [ EP , Stimuli , Speed ] = Planning( DataStruct , Stimuli )

%% Paradigme from Localizer_Francais_HighVideoResolution
Paradigme = {
    'Video_Computation'       0.200
    'Cross_Rest'              0.200
    'Video_Computation'       0.1100
    'Cross_Rest'              0.800
    'Audio_Sinwave'           0.800
    'Horizontal_Checkerboard' 0.500
    'Left_Audio_Click'        0.1400
    'Audio_Sentences'         0.800
    'Right_Video_Click'       0.500
    'Audio_Sentences'         0.800
    'Left_Audio_Click'        0.800
    'Left_Video_Click'        0.800
    'Audio_Sentences'         0.1100
    'Vertical_Checkerboard'   0.200
    'Audio_Sinwave'           0.800
    'Audio_Sinwave'           0.800
    'Audio_Computation'       0.1400
    'Video_Sentences'         0.500
    'Video_Sentences'         0.800
    'Audio_Sinwave'           0.1100
    'Audio_Computation'       0.1100
    'Audio_Computation'       0.500
    'Cross_Rest'              0.800
    'Cross_Rest'              0.500
    'Video_Sentences'         0.1100
    'Horizontal_Checkerboard' 0.500
    'Left_Audio_Click'        0.1400
    'Cross_Rest'              0.800
    'Right_Video_Click'       0.200
    'Left_Video_Click'        0.1400
    'Video_Sentences'         0.800
    'Cross_Rest'              0.200
    'Cross_Rest'              0.800
    'Audio_Computation'       0.1400
    'Left_Audio_Click'        0.500
    'Audio_Sentences'         0.1100
    'Cross_Rest'              0.800
    'Vertical_Checkerboard'   0.800
    'Cross_Rest'              0.800
    'Cross_Rest'              0.800
    'Cross_Rest'              0.800
    'Audio_Computation'       0.200
    'Cross_Rest'              0.1100
    'Cross_Rest'              0.800
    'Left_Video_Click'        0.500
    'Audio_Sentences'         0.1100
    'Vertical_Checkerboard'   0.500
    'Video_Computation'       0.1400
    'Cross_Rest'              0.200
    'Video_Sentences'         0.1400
    'Audio_Computation'       0.500
    'Cross_Rest'              0.800
    'Audio_Computation'       0.500
    'Vertical_Checkerboard'   0.800
    'Left_Audio_Click'        0.1100
    'Audio_Sentences'         0.500
    'Horizontal_Checkerboard' 0.1400
    'Video_Computation'       0.800
    'Cross_Rest'              0.1400
    'Vertical_Checkerboard'   0.800
    'Video_Sentences'         0.800
    'Left_Audio_Click'        0.200
    'Video_Computation'       0.1100
    'Video_Sentences'         0.500
    'Left_Audio_Click'        0.1100
    'Audio_Computation'       0.800
    'Horizontal_Checkerboard' 0.800
    'Audio_Sinwave'           0.1400
    'Cross_Rest'              0.800
    'Audio_Sinwave'           0.500
    'Cross_Rest'              0.1100
    'Cross_Rest'              0.200
    'Horizontal_Checkerboard' 0.1100
    'Audio_Computation'       0.1100
    'Video_Sentences'         0.800
    'Video_Computation'       0.800
    'Video_Computation'       0.500
    'Vertical_Checkerboard'   0.1100
    'Audio_Sinwave'           0.500
    'Vertical_Checkerboard'   0.800
    'Vertical_Checkerboard'   0.500
    'Left_Video_Click'        0.800
    'Left_Video_Click'        0.800
    'Cross_Rest'              0.200
    'Horizontal_Checkerboard' 0.500
    'Video_Computation'       0.1100
    'Horizontal_Checkerboard' 0.800
    'Right_Video_Click'       0.800
    'Left_Audio_Click'        0.1100
    'Video_Computation'       0.500
    'Audio_Sentences'         0.1100
    'Cross_Rest'              0.800
    'Cross_Rest'              0.800
    'Video_Sentences'         0.200
    'Audio_Sinwave'           0.800
    'Audio_Sinwave'           0.1100
    'Horizontal_Checkerboard' 0.1100
    'Audio_Computation'       0.800
    'Cross_Rest'              0.1100
    'Left_Audio_Click'        0.500
    'Left_Audio_Click'        0.800
    'Video_Computation'       0.1400
    'Vertical_Checkerboard'   0.500
    'Horizontal_Checkerboard' 0.800
    'Audio_Sinwave'           0.500
    'Horizontal_Checkerboard' 0.800
    'Cross_Rest'              0.500
    'Right_Video_Click'       0.800
    'Vertical_Checkerboard'   0.1100
    'Cross_Rest'              0.500
    'Audio_Sentences'         0.1400
    'Video_Sentences'         0.800
    'Right_Video_Click'       0.200
    'Audio_Sentences'         0.1100
    'Audio_Sentences'         0.800
    'Cross_Rest'              0.800
    'Cross_Rest'              0.2200
    };


%% Timings

% Horizontal_Checkerboard
Stimuli.Timing.Horizontal_Checkerboard.Flic = 0.200;
Stimuli.Timing.Horizontal_Checkerboard.Flac = 0.200;
Stimuli.Timing.Horizontal_Checkerboard.Duration = ...
    4 * Stimuli.Timing.Horizontal_Checkerboard.Flic + ...
    4 * Stimuli.Timing.Horizontal_Checkerboard.Flac;

% Vertical_Checkerboard
Stimuli.Timing.Vertical_Checkerboard.Flic = 0.200;
Stimuli.Timing.Vertical_Checkerboard.Flac = 0.200;
Stimuli.Timing.Vertical_Checkerboard.Duration = ...
    4 * Stimuli.Timing.Vertical_Checkerboard.Flic + ...
    4 * Stimuli.Timing.Vertical_Checkerboard.Flac;

% Video_Computation
Stimuli.Timing.Video_Computation.Word        = 0.250;
Stimuli.Timing.Video_Computation.BlackScreen = 0.100;
Stimuli.Timing.Video_Computation.Duration    = ...
    4 * Stimuli.Timing.Video_Computation.Word + ...
    4 * Stimuli.Timing.Video_Computation.BlackScreen;

% Right_Audio_Click
Stimuli.Timing.Right_Audio_Click.Duration = 2.200;

% Left_Audio_Click
Stimuli.Timing.Left_Audio_Click.Duration = 2.200;

% Right_Video_Click
Stimuli.Timing.Right_Video_Click.Word        = 0.250;
Stimuli.Timing.Right_Video_Click.BlackScreen = 0.100;
Stimuli.Timing.Right_Video_Click.Cross       = 0.800; % response
Stimuli.Timing.Right_Video_Click.Duration    = ...
    4 * Stimuli.Timing.Right_Video_Click.Word        + ...
    4 * Stimuli.Timing.Right_Video_Click.BlackScreen + ...
    1 * Stimuli.Timing.Right_Video_Click.Cross ;

% Left_Video_Click
Stimuli.Timing.Left_Video_Click.Word        = 0.250;
Stimuli.Timing.Left_Video_Click.BlackScreen = 0.100;
Stimuli.Timing.Left_Video_Click.Cross       = 0.800; % response
Stimuli.Timing.Left_Video_Click.Duration    = ...
    4 * Stimuli.Timing.Left_Video_Click.Word        + ...
    4 * Stimuli.Timing.Left_Video_Click.BlackScreen + ...
    1 * Stimuli.Timing.Left_Video_Click.Cross ;

% Audio_Computation
Stimuli.Timing.Audio_Computation.Duration = 2.200;

% Video_Computation
Stimuli.Timing.Video_Computation.Word        = 0.250;
Stimuli.Timing.Video_Computation.BlackScreen = 0.100;
Stimuli.Timing.Video_Computation.Duration    = ...
    4 * Stimuli.Timing.Video_Computation.Word + ...
    4 * Stimuli.Timing.Video_Computation.BlackScreen;

% Video_Sentences
Stimuli.Timing.Video_Sentences.Word        = 0.250;
Stimuli.Timing.Video_Sentences.BlackScreen = 0.100;
Stimuli.Timing.Video_Sentences.Duration    = ...
    4 * Stimuli.Timing.Video_Sentences.Word + ...
    4 * Stimuli.Timing.Video_Sentences.BlackScreen;

% Audio_Sentences
Stimuli.Timing.Audio_Sentences.Duration = 2.200;

% Audio_Sinwave
Stimuli.Timing.Audio_Sinwave.Sin      = 0.400;
Stimuli.Timing.Audio_Sinwave.Duration = ...
    6 * Stimuli.Timing.Audio_Sinwave.Sin;

% Cross_Rest
Stimuli.Timing.Cross_Rest.Duration = 2.200;


%% Define a planning <--- paradigme


% Create and prepare
header = { 'event_name' , 'onset(s)' , 'duration(s)' };
EP     = EventPlanning(header);

% NextOnset = PreviousOnset + PreviousDuration
NextOnset = @(EP) EP.Data{end,2} + EP.Data{end,3};


% --- Start ---------------------------------------------------------------

EP.AddPlanning({ 'StartTime' 0  0 });

% --- Stim ----------------------------------------------------------------

for p = 1 : size(Paradigme,1)
    
    EP.AddPlanning({ Paradigme{p,1} NextOnset(EP) Stimuli.Timing.(Paradigme{p,1}).Duration });
    EP.AddPlanning({ 'Cross_Rest'   NextOnset(EP) Paradigme{p,2}                         });
    
end


% --- Stop ----------------------------------------------------------------

EP.AddPlanning({ 'StopTime' NextOnset(EP) 0 });


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
