function [ TaskData ] = Task( DataStruct )

try
    %% Load and prepare all stimuli
    
    Session.LoadStimuli;
    Session.PrepareStimuli;
    
    
    %% Tunning of the task
    
    Session.Planning;
    
    % End of preparations
    EP.BuildGraph;
    TaskData.EP = EP;
    
    
    %% Prepare event record and keybinf logger
    
    Common.PrepareRecorders;
    
    
    %% Record movie
    
    Common.Movie.CreateMovie;
    
    
    %% Start recording eye motions
    
    Common.StartRecordingEyelink;
    
    
    %% Go
    
    flip_onset = 0;
    Exit_flag = 0;
    
    % Loop over the EventPlanning
    for evt = 1 : size( EP.Data , 1 )
        
        Common.CommandWindowDisplay;
        
        switch EP.Data{evt,1}
            
            case 'StartTime'
                
                Common.StartTimeEvent;
                
            case 'StopTime'
                
                Common.StopTimeEvent;
                
            otherwise
                
                frame_counter = 0;
                
                while flip_onset < StartTime + EP.Data{evt+1,2} - DataStruct.PTB.slack * 1
                    
                    frame_counter = frame_counter + 1;
                    
                    % ESCAPE key pressed ?
                    Common.Interrupt;
                    
                    switch EP.Data{evt,1}
                        
                        otherwise
                            error('Unrecognzed condition : %s',EP.Data{evt,1})
                            
                    end
                    
                    Common.Movie.AddFrameToMovie;
                    
                    if frame_counter == 1
                        % Save onset
                        ER.AddEvent({ EP.Data{evt,1} flip_onset-StartTime })
                    end
                    
                end % while
                
        end % switch
        
        if Exit_flag
            break %#ok<*UNRCH>
        end
        
        
    end % for

    %% End of stimulation
    
    
    Common.EndOfStimulationScript;
    
    Common.Movie.FinalizeMovie;
    
    
catch err %#ok<*NASGU>
    
    Common.Catch;
    
end

end
