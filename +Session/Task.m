function [ TaskData ] = Task( DataStruct )

try
    %% Load and prepare all stimuli
    
    Session.LoadStimuli;
    Session.PrepareStimuli;
    
    
    %% Tunning of the task
    
    [ EP , Stimuli , Speed ] = Session.Planning( DataStruct , Stimuli ); %#ok<NODEF>
    
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
    
    event_onset = 0;
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
                
                % In the planning we have events with duration=0. So, they
                % don't get go inside the whileloop. But we still need to
                % record their occurence with a fake onset : we modify it
                % latter
                if ~(event_onset < StartTime + EP.Data{evt+1,2} - DataStruct.PTB.slack * 1)
                    ER.AddEvent({ EP.Data{evt,1} [] })
                end
                
                while event_onset < StartTime + EP.Data{evt+1,2} - DataStruct.PTB.slack * 1
                    
                    frame_counter = frame_counter + 1;
                    
                    % ESCAPE key pressed ?
                    Common.Interrupt;
                    
                    switch EP.Data{evt,1}
                        
                        case 'cross'
                            Common.DrawFixation;
                            event_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'blackscreen'
                            event_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'word'
                            DrawFormattedText(DataStruct.PTB.wPtr,EP.Data{evt,4},'center','center');
                            event_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'img'
                            Screen('DrawTexture',DataStruct.PTB.wPtr,EP.Data{evt,4});
                            event_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'wav'
                            DrawFormattedText(DataStruct.PTB.wPtr,'wavefile readung','center','center');
                            event_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'Cross_Rest'
                            event_onset = GetSecs;
                        case 'Horizontal_Checkerboard'
                            event_onset = GetSecs;
                        case 'Vertical_Checkerboard'
                            event_onset = GetSecs;
                        case 'Right_Audio_Click'
                            event_onset = GetSecs;
                        case 'Left_Audio_Click'
                            event_onset = GetSecs;
                        case 'Right_Video_Click'
                            event_onset = GetSecs;
                        case 'Left_Video_Click'
                            event_onset = GetSecs;
                        case 'Audio_Computation'
                            event_onset = GetSecs;
                        case 'Video_Computation'
                            event_onset = GetSecs;
                        case 'Video_Sentences'
                            event_onset = GetSecs;
                        case 'Audio_Sentences'
                            event_onset = GetSecs;
                        case 'Audio_Sinwave'
                            event_onset = GetSecs;
                            
                            
                        otherwise
                            error('Unrecognzed condition : %s',EP.Data{evt,1})
                            
                    end
                    
                    Common.Movie.AddFrameToMovie;
                    
                    if frame_counter == 1
                        % Modification of the onset of the events with
                        % duration=0. We force them to have the same real
                        % onset, and still a duration of 0.
                        if EP.Data{evt-1,3} == 0
                            ER.Data{evt-1,2} = event_onset-StartTime;
                        end
                        % Save onset
                        ER.AddEvent({ EP.Data{evt,1} event_onset-StartTime })
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
