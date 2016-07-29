function [ EP , Stimuli , Speed ] = Planning( DataStruct , Stimuli )

%% Paradigme from Localizer_Francais_HighVideoResolution

if nargout < 1
    
    DataStruct.Environement = 'MRI';
    
    Stimuli.Horizontal_Checkerboard = zeros(10);
    Stimuli.Vertical_Checkerboard = zeros(10);
    Stimuli.Right_Audio_Click = cell(10);
    Stimuli.Left_Audio_Click = cell(10);
    Stimuli.Right_Video_Click = cell(10);
    Stimuli.Left_Video_Click = cell(10);
    Stimuli.Audio_Computation = cell(10);
    Stimuli.Video_Computation = cell(10);
    Stimuli.Video_Sentences = cell(10);
    Stimuli.Audio_Sentences = cell(10);
    Stimuli.Audio_Sinwave = cell(10);
    
end

switch DataStruct.Environement
    
    case 'Training'
        
        rest = 0.500;
        Paradigme = {
            'Horizontal_Checkerboard' rest
            'Vertical_Checkerboard' rest
            'Right_Audio_Click' rest
            'Left_Audio_Click' rest
            'Right_Video_Click' rest
            'Left_Video_Click' rest
            'Audio_Computation' rest
            'Video_Computation' rest
            'Video_Sentences' rest
            'Audio_Sentences' rest
            'Audio_Sinwave' rest
            'Cross_Rest' rest
            };
        
    case 'MRI'
        
        Paradigme = {
            'Video_Computation'       0.200
            'Cross_Rest'              0.200
            'Video_Computation'       0.1100
            'Cross_Rest'              0.800
            'Audio_Sinwave'           0.800
            'Horizontal_Checkerboard' 0.500
            'Right_Audio_Click'       0.1400
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
            'Right_Audio_Click'       0.500
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
            'Right_Audio_Click'       0.1100
            'Audio_Sentences'         0.500
            'Horizontal_Checkerboard' 0.1400
            'Video_Computation'       0.800
            'Cross_Rest'              0.1400
            'Vertical_Checkerboard'   0.800
            'Video_Sentences'         0.800
            'Right_Audio_Click'       0.200
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
            'Right_Audio_Click'       0.1100
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
        
end

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
header = { 'event_name' , 'onset(s)' , 'duration(s)' , 'content' };
EP     = EventPlanning(header);

% NextOnset = PreviousOnset + PreviousDuration
NextOnset = @(EP) EP.Data{end,2} + EP.Data{end,3};


% --- Start ---------------------------------------------------------------

EP.AddPlanning({ 'StartTime' 0  0 [] });

% --- Stim ----------------------------------------------------------------

% Counters
Video_Computation = 0;
Audio_Computation = 0;
Video_Sentences   = 0;
Audio_Sentences   = 0;
Audio_Sinwave     = 0;

for p = 1 : size(Paradigme,1)
    
    EP.AddPlanning({ Paradigme{p,1} NextOnset(EP) 0 [] });
    
    switch Paradigme{p,1}
        
        case 'Horizontal_Checkerboard'
            for rep = 1 : 4
                EP.AddPlanning({ 'img' NextOnset(EP) Stimuli.Timing.Horizontal_Checkerboard.Flic Stimuli.Horizontal_Checkerboard(1) });
                EP.AddPlanning({ 'img' NextOnset(EP) Stimuli.Timing.Horizontal_Checkerboard.Flac Stimuli.Horizontal_Checkerboard(2) });
            end
            
        case 'Vertical_Checkerboard'
            for rep = 1 : 4
                EP.AddPlanning({ 'img' NextOnset(EP) Stimuli.Timing.Vertical_Checkerboard.Flic Stimuli.Vertical_Checkerboard(1) });
                EP.AddPlanning({ 'img' NextOnset(EP) Stimuli.Timing.Vertical_Checkerboard.Flac Stimuli.Vertical_Checkerboard(2) });
            end
            
        case 'Right_Audio_Click'
            EP.AddPlanning({ 'wav' NextOnset(EP) Stimuli.Timing.Right_Audio_Click.Duration Stimuli.Right_Audio_Click });
            
        case 'Left_Audio_Click'
            EP.AddPlanning({ 'wav' NextOnset(EP) Stimuli.Timing.Left_Audio_Click.Duration Stimuli.Left_Audio_Click });
            
        case 'Right_Video_Click'
            for word = 1 : 4
                EP.AddPlanning({ 'word'        NextOnset(EP) Stimuli.Timing.Right_Video_Click.Word        Stimuli.Right_Video_Click{word} });
                EP.AddPlanning({ 'blackscreen' NextOnset(EP) Stimuli.Timing.Right_Video_Click.BlackScreen []                              });
            end
            EP.AddPlanning({ 'cross' NextOnset(EP) Stimuli.Timing.Right_Video_Click.Cross [] });
            
        case 'Left_Video_Click'
            for word = 1 : 4
                EP.AddPlanning({ 'word'        NextOnset(EP) Stimuli.Timing.Left_Video_Click.Word        Stimuli.Left_Video_Click{word} });
                EP.AddPlanning({ 'blackscreen' NextOnset(EP) Stimuli.Timing.Left_Video_Click.BlackScreen []                             });
            end
            EP.AddPlanning({ 'cross' NextOnset(EP) Stimuli.Timing.Left_Video_Click.Cross [] });
            
        case 'Audio_Computation'
            Audio_Computation = Audio_Computation  + 1;
            EP.AddPlanning({ 'wav' NextOnset(EP) Stimuli.Timing.Audio_Computation.Duration Stimuli.Audio_Computation{Audio_Computation} });
            
        case 'Video_Computation'
            Video_Computation = Video_Computation + 1;
            for word = 1 : 4
                EP.AddPlanning({ 'word'        NextOnset(EP) Stimuli.Timing.Video_Computation.Word        Stimuli.Video_Computation{Video_Computation,word} });
                EP.AddPlanning({ 'blackscreen' NextOnset(EP) Stimuli.Timing.Video_Computation.BlackScreen []                                                });
            end
            
        case 'Video_Sentences'
            Video_Sentences = Video_Sentences + 1;
            for word = 1 : 4
                EP.AddPlanning({ 'word'        NextOnset(EP) Stimuli.Timing.Video_Sentences.Word        Stimuli.Video_Sentences{Video_Sentences,word} });
                EP.AddPlanning({ 'blackscreen' NextOnset(EP) Stimuli.Timing.Video_Sentences.BlackScreen []                                            });
            end
            
        case 'Audio_Sentences'
            Audio_Sentences = Audio_Sentences  + 1;
            EP.AddPlanning({ 'wav' NextOnset(EP) Stimuli.Timing.Audio_Sentences.Duration Stimuli.Audio_Sentences{Audio_Sentences} });
            
        case 'Audio_Sinwave'
            Audio_Sinwave = Audio_Sinwave  + 1;
            for sinwave = 1 : 6
                EP.AddPlanning({ 'wav' NextOnset(EP) Stimuli.Timing.Audio_Sinwave.Sin Stimuli.Audio_Sinwave{Audio_Sinwave,sinwave} });
            end
            
        case 'Cross_Rest'
            EP.AddPlanning({ 'cross' NextOnset(EP) Stimuli.Timing.Cross_Rest.Duration [] });
            
    end
    
    
    EP.AddPlanning({ 'cross' NextOnset(EP) Paradigme{p,2} [] });
    
end


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
