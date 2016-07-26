function [ TaskData ] = Task( DataStruct )

try
    %% Tunning of the task
    
    Calibration.Planning;
    
    % End of preparations
    EP.BuildGraph;
    TaskData.EP = EP;
    
    
    %% Prepare event record and keybinf logger
    
    Common.PrepareRecorders;
    
    
    %% Record movie
    
    Common.Movie.CreateMovie;
    
    
    %% Start recording eye motions
    
    % no eyelink for calibration
    
    
    %% Start
    
    Common.StartTimeEvent
    evt = 1;
    
    
    %% Go
    
    % ---------------------------------------------------------------------
    % Left button calibration
    
    fprintf('\n')
    fprintf('Left button calibration : ? \n')
    
    % DrawText
    txt = ' appuyer sue le bouton gauche ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    Calibration.AddEvent;
    
    while 1
        
        [keyIsDown, ~, keyCode] = KbCheck;
        if keyIsDown
            if keyCode(DataStruct.Parameters.Keybinds.Left_Yellow_y_ASCII)
                
                txt = ' appuyer sue le bouton gauche ';
                DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[0 255 0],[],[],[],2);
                vbl = Screen('Flip',DataStruct.PTB.wPtr);
                fprintf('Left button calibration : OK \n')
                Calibration.AddEvent;
                
                tmax = EP.Data{evt,3};
                Common.While;
                
                break
                
            elseif keyCode(DataStruct.Parameters.Keybinds.RightArrow)
                
                Calibration.AddEvent;
                fprintf('Left button calibration : skipped \n')
                
                break
                
            end
        end
        
    end
    
    tmax = EP.Data{evt+1,3};
    Common.FlipWhile
    Calibration.AddEvent;
    
    
    % ---------------------------------------------------------------------
    % Right button calibration
    
    fprintf('\n')
    fprintf('Right button calibration : ? \n')
    
    txt = ' appuyer sue le bouton droit ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    Calibration.AddEvent;
    
    while 1
        
        [keyIsDown, ~, keyCode] = KbCheck;
        if keyIsDown
            if keyCode(DataStruct.Parameters.Keybinds.Right_Blue_b_ASCII)
                
                txt = ' appuyer sue le bouton droit ';
                DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[0 255 0],[],[],[],2);
                vbl = Screen('Flip',DataStruct.PTB.wPtr);
                fprintf('Right button calibration : OK \n')
                Calibration.AddEvent;
                
                tmax = EP.Data{evt,3};
                Common.While;
                
                break
                
            elseif keyCode(DataStruct.Parameters.Keybinds.RightArrow)
                
                Calibration.AddEvent;
                fprintf('Right button calibration : skipped \n')
                
                break
                
            end
        end
        
    end
    
    tmax = EP.Data{evt+1,3};
    Common.FlipWhile
    Calibration.AddEvent;
    
    
    % ---------------------------------------------------------------------
    % Instructions : Sound calibration
    
    txt = ' nous allons vous faire entendre \n plusieurs fois une phrase : \n indiquez si le son est suffisement fort \n mais sans être douloureux ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    Calibration.AddEvent;
    tmax = EP.Data{evt,3};
    Common.While;
    
    tmax = EP.Data{evt+1,3};
    Common.FlipWhile
    Calibration.AddEvent;
    
    
    % ---------------------------------------------------------------------
    % Sound calibration
    
    fprintf('\n')
    fprintf('Volume calibration : ? \n')
    
    wavefile = 'calc40.wav';
    [y, ~, ~] = wavread([DataStruct.Parameters.wav wavefile]);
    PsychPortAudio('FillBuffer', DataStruct.PTB.Playback_pahandle, [y y]');
    
    fprintf('Press %s to repeat sound \n',upper(KbName(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)))
    fprintf('Press %s to pass \n',upper(KbName(DataStruct.Parameters.Keybinds.TTL_t_ASCII)))
    
    is_first = 1;
    
    calibrated = 0;
    while ~calibrated
        
        startTime = PsychPortAudio('Start', DataStruct.PTB.Playback_pahandle , 1 , 0, 1);
        PsychPortAudio('Stop', DataStruct.PTB.Playback_pahandle, 1, 1);
        
        txt = 'volume ?';
        DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
        vbl = Screen('Flip',DataStruct.PTB.wPtr);
        if is_first
            Calibration.AddEvent;
            is_first = 0;
        end
        
        while 1
            [keyIsDown, ~, keyCode] = KbCheck;
            if keyIsDown
                
                if keyCode(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)
                    tmax = repeat_microtime;
                    Common.FlipWhile
                    
                    break
                    
                elseif keyCode(DataStruct.Parameters.Keybinds.TTL_t_ASCII)
                    calibrated = 1;
                    fprintf('Volume calibration : OK \n')
                    break
                    
                elseif keyCode(DataStruct.Parameters.Keybinds.RightArrow)
                    calibrated = 1;
                    fprintf('Volume calibration : skipped \n')
                    break
                    
                end
                
            end
        end
        
    end
    Calibration.AddEvent
    
    tmax = EP.Data{evt+1,3};
    Common.FlipWhile
    Calibration.AddEvent
    
    
    % ---------------------------------------------------------------------
    % Instructions : Screen calibtration
    
    txt = ' assurez-vous que la croix rouge \n est bien au centre \n de votre champ de vision';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    Calibration.AddEvent
    tmax = EP.Data{evt,3};
    Common.While;
    
    tmax = EP.Data{evt+1,3};
    Common.FlipWhile
    Calibration.AddEvent
    
    
    % ---------------------------------------------------------------------
    % Screen calibtration
    
    fprintf('\n')
    fprintf('Screen calibration : ? \n')
    
    imgfile = 'mire.bmp';
    Cross.img = imread([DataStruct.Parameters.wav imgfile]);
    if ~exist('Cross.texturePtr','var')
        Cross.texturePtr = Screen('MakeTexture', DataStruct.PTB.wPtr, Cross.img);
    else
        Screen('Close', Cross.texture)
        Cross.texturePtr = Screen('MakeTexture', DataStruct.PTB.wPtr, Cross.img);
    end
    Screen('DrawTexture', DataStruct.PTB.wPtr, Cross.texturePtr)
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    Calibration.AddEvent
    
    fprintf('Press %s to pass \n',upper(KbName(DataStruct.Parameters.Keybinds.TTL_t_ASCII)))
    
    while 1
        [keyIsDown, ~, keyCode] = KbCheck;
        if keyIsDown
            if keyCode(DataStruct.Parameters.Keybinds.TTL_t_ASCII)
                
                fprintf('Screen calibration : OK \n')
                
                break
                
            elseif keyCode(DataStruct.Parameters.Keybinds.RightArrow)
                
                fprintf('Screen calibration : skipped \n')
                
                break
                
            end
        end
    end
    
    tmax = EP.Data{evt+1,3};
    Common.FlipWhile
    Calibration.AddEvent
    
    
    %% End
    
    Common.StopTimeEvent;
    
    
    %% End of stimulation
    
    
    Common.EndOfStimulationScript;
    
    Common.Movie.FinalizeMovie;
    
    
catch err %#ok<*NASGU>
    
    Common.Catch;
    
end

end
