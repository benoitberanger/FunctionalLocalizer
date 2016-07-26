function [ TaskData ] = Task( DataStruct )

try
    %% Tunning of the task
    
    Instructions.Planning;
    
    % End of preparations
    EP.BuildGraph;
    TaskData.EP = EP;
    
    
    %% Prepare event record and keybinf logger
    
    Common.PrepareRecorders;
    
    
    %% Record movie
    
    Common.Movie.CreateMovie;
    
    
    %% Start recording eye motions
    
    % no eyelink for calibration
    
    
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
                
                while flip_onset < StartTime + EP.Data{evt+1,2} - DataStruct.PTB.slack * 2
                    
                    frame_counter = frame_counter + 1;
                    
                    % ESCAPE key pressed ?
                    Common.Interrupt;
                    
                    switch EP.Data{evt,1}
                        
                        case 'Slide'
                            DrawFormattedText(DataStruct.PTB.wPtr, EP.Data{evt,4} , 'center', 'center',[],[],[],[],2);
                            flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'SlideFixation'
                            DrawFormattedText(DataStruct.PTB.wPtr, EP.Data{evt,4} , 'center', 0,[],[],[],[],2);
                            Common.DrawFixation;
                            flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'BlackScreen'
                            flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'TextLoop' % same as 'Slide', but will be concatenated to produce 1 block
                            DrawFormattedText(DataStruct.PTB.wPtr, EP.Data{evt,4} , 'center', 'center',[],[],[],[],2);
                            flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            
                        case 'Audio'
                            if frame_counter == 1
                                PsychPortAudio('FillBuffer', DataStruct.PTB.Playback_pahandle, [EP.Data{evt,4};EP.Data{evt,4}]);
                                Screen('Flip',DataStruct.PTB.wPtr);
                                startTime = PsychPortAudio('Start', DataStruct.PTB.Playback_pahandle , 1 , 0, 1);
                                flip_onset = startTime;
                            else
                                flip_onset = Screen('Flip',DataStruct.PTB.wPtr);
                            end
                            
                        otherwise
                            error('Unrecognzed condition : %s',EP.Data{evt,1})
                            
                    end
                    
                    Common.Movie.AddFrameToMovie;
                    
                    if frame_counter == 1
                        % Save onset
                        ER.AddEvent({ EP.Data{evt,1} flip_onset-StartTime })
                    end
                    
%                     % Skip
%                     if keyCode(DataStruct.Parameters.Keybinds.RightArrow)
%                         break
%                     end
                    
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
