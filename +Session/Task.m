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
                        
                        case 'Horizontal_Checkerboard'
                            
                            %                             if mod(frame_counter,(Stimuli.Timing.Horizontal_Checkerboard.Flic+Stimuli.Timing.Horizontal_Checkerboard.Flac)*DataStruct.PTB.FPS) < Stimuli.Timing.Horizontal_Checkerboard.Flac*DataStruct.PTB.FPS
                            %                                 Screen('DrawTexture',DataStruct.PTB.wPtr,Stimuli.Horizontal_Checkerboard(1))
                            %                                 flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            %                             else
                            %                                 Screen('DrawTexture',DataStruct.PTB.wPtr,Stimuli.Horizontal_Checkerboard(2))
                            %                                 flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            %                             end
                            %
                            %                             if frame_counter == 1
                            %                                 recorded_onset =  flip_onset;
                            %                             end
                            
                        case 'Vertical_Checkerboard'
                            
                            %                             if mod(frame_counter,(Stimuli.Timing.Vertical_Checkerboard.Flic+Stimuli.Timing.Vertical_Checkerboard.Flac)*DataStruct.PTB.FPS) < Stimuli.Timing.Vertical_Checkerboard.Flac*DataStruct.PTB.FPS
                            %                                 Screen('DrawTexture',DataStruct.PTB.wPtr,Stimuli.Vertical_Checkerboard(1))
                            %                                 flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            %                             else
                            %                                 Screen('DrawTexture',DataStruct.PTB.wPtr,Stimuli.Vertical_Checkerboard(2))
                            %                                 flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            %                             end
                            %
                            %                             if frame_counter == 1
                            %                                 recorded_onset =  flip_onset;
                            %                             end
                            
                        case 'Right_Audio_Click'
                        case 'Left_Audio_Click'
                        case 'Right_Video_Click'
                            
                            %                             if mod(frame_counter,(Stimuli.Timing.Right_Video_Click.Word+Stimuli.Timing.Right_Video_Click.BlackScreen)*DataStruct.PTB.FPS) < Stimuli.Timing.Right_Video_Click.Word*DataStruct.PTB.FPS
                            %                                 Screen('DrawTexture',DataStruct.PTB.wPtr,Stimuli.Right_Video_Click(1))
                            %                                 flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            %                             else
                            %                                 Screen('DrawTexture',DataStruct.PTB.wPtr,Stimuli.Right_Video_Click(2))
                            %                                 flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            %                             end
                            %
                            %                             if frame_counter == 1
                            %                                 recorded_onset =  flip_onset;
                            %                             end
                        case 'Left_Video_Click'
                        case 'Audio_Computation'
                        case 'Video_Computation'
                        case 'Video_Sentences'
                        case 'Audio_Sentences'
                        case 'Audio_Sinwave'
                        case 'Cross_Rest'
                            
                            %                             Common.DrawFixation
                            %
                            %                             flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            %
                            %                             if frame_counter == 1
                            %                                 recorded_onset =  flip_onset;
                            %                             end
                            
                        otherwise
                            error('Unrecognzed condition : %s',EP.Data{evt,1})
                            
                    end
                    
                    Common.Movie.AddFrameToMovie;
                    
                    if frame_counter == 1
                        % Save onset
                        ER.AddEvent({ EP.Data{evt,1} recorded_onset-StartTime })
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
