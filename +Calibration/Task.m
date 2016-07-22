function [ TaskData ] = Task( DataStruct )

try
    %% Tunning of the task
    
    Calibration.Planning;
    
    EP.AddPlanning({ 'empty' NextOnset(EP) 1 });
    EP.AddPlanning({ 'StopTime' NextOnset(EP) 0 });
    
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
    
    switch DataStruct.OperationMode
        case 'Acquisition'
            HideCursor;
        case 'FastDebug'
        case 'RealisticDebug'
        otherwise
    end
    
    % Flip video
    Screen( 'Flip' , DataStruct.PTB.wPtr );
    
    % Synchronization
    StartTime = GetSecs;
    
    ER.Data = EP.Data;
    ER.EventCount = EP.EventCount; %#ok<*STRNU>
    StopTime = GetSecs;
    
    
    %% Go
    
    % ---------------------------------------------------------------------
    % Left button calibration
    
    fprintf('\n')
    fprintf('Left button calibration : ? \n')
    
    txt = ' appuyer sue le bouton gauche ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    Screen('Flip',DataStruct.PTB.wPtr);
    
    while 1
        
        [keyIsDown, ~, keyCode] = KbCheck;
        if keyIsDown
            if keyCode(DataStruct.Parameters.Keybinds.Left_Yellow_y_ASCII)
                
                txt = ' appuyer sue le bouton gauche ';
                DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[0 255 0],[],[],[],2);
                Screen('Flip',DataStruct.PTB.wPtr);
                fprintf('Left button calibration : OK \n')
                
                tmax = 0.5;
                Common.While;
                
                break
                
            elseif keyCode(DataStruct.Parameters.Keybinds.RightArrow)
                
                fprintf('Left button calibration : skipped \n')
                
                break
                
            end
        end
        
    end
    
    tmax = 0.5;
    Common.FlipWhile
    
    % ---------------------------------------------------------------------
    % Right button calibration
    
    fprintf('\n')
    fprintf('Right button calibration : ? \n')
    
    txt = ' appuyer sue le bouton droit ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    Screen('Flip',DataStruct.PTB.wPtr);
    
    while 1
        
        [keyIsDown, ~, keyCode] = KbCheck;
        if keyIsDown
            if keyCode(DataStruct.Parameters.Keybinds.Right_Blue_b_ASCII)
                
                txt = ' appuyer sue le bouton droit ';
                DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[0 255 0],[],[],[],2);
                Screen('Flip',DataStruct.PTB.wPtr);
                fprintf('Right button calibration : OK \n')
                
                tmax = 0.5;
                Common.While;
                
                break
                
            elseif keyCode(DataStruct.Parameters.Keybinds.RightArrow)
                
                fprintf('Right button calibration : skipped \n')
                
                break
                
            end
        end
        
    end
    
    tmax = 0.5;
    Common.FlipWhile
    
    
    % ---------------------------------------------------------------------
    % Instructions : Sound calibration
    
    txt = ' nous allons vous faire entendre \n plusieurs fois une phrase : \n indiquez si le son est suffisement fort \n mais sans être douloureux ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    Screen('Flip',DataStruct.PTB.wPtr);
    tmax = 10;
    Common.While;
    
    tmax = 1;
    Common.FlipWhile
    
    
    % ---------------------------------------------------------------------
    % Sound calibration
    
    fprintf('\n')
    fprintf('Volume calibration : ? \n')
    
    wav_path = 'wav';
    wavefile = 'calc40.wav';
    [y, ~, ~] = wavread([wav_path filesep wavefile]);
    PsychPortAudio('FillBuffer', DataStruct.PTB.Playback_pahandle, [y y]');
    
    fprintf('Press %s to repeat sound \n',upper(KbName(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)))
    fprintf('Press %s to pass \n',upper(KbName(DataStruct.Parameters.Keybinds.TTL_t_ASCII)))
    
    calibrated = 0;
    while ~calibrated
        
        startTime = PsychPortAudio('Start', DataStruct.PTB.Playback_pahandle , 1 , 0, 1);
        PsychPortAudio('Stop', DataStruct.PTB.Playback_pahandle, 1, 1);
        
        txt = 'volume ?';
        DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
        Screen('Flip',DataStruct.PTB.wPtr);
        
        while 1
            [keyIsDown, ~, keyCode] = KbCheck;
            if keyIsDown
                
                if keyCode(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)
                    tmax = 0.1;
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
    
    tmax = 1;
    Common.FlipWhile
    
    
    % ---------------------------------------------------------------------
    % Instructions : Screen calibtration
    
    txt = ' assurez-vous que la croix rouge \n est bien au centre \n de votre champ de vision';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',DataStruct.Parameters.Text.Color,[],[],[],2);
    Screen('Flip',DataStruct.PTB.wPtr);
    tmax = 5;
    Common.While;
    
    tmax = 0.5;
    Common.FlipWhile
    
    
    % ---------------------------------------------------------------------
    % Screen calibtration
    
    fprintf('\n')
    fprintf('Screen calibration : ? \n')
    
    img_path = 'img';
    imgfile = 'mire.bmp';
    Cross.img = imread([img_path filesep imgfile]);
    if ~exist('Cross.texturePtr','var')
        Cross.texturePtr = Screen('MakeTexture', DataStruct.PTB.wPtr, Cross.img);
    else
        Screen('Close', Cross.texture)
        Cross.texturePtr = Screen('MakeTexture', DataStruct.PTB.wPtr, Cross.img);
    end
    Screen('DrawTexture', DataStruct.PTB.wPtr, Cross.texturePtr)
    Screen('Flip',DataStruct.PTB.wPtr);
    
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
    
    tmax = 1;
    Common.FlipWhile

    
    %% End of stimulation
    
    ShowCursor;
    Priority( DataStruct.PTB.oldLevel );
    Common.EndOfStimulationScript;
    
    Common.Movie.FinalizeMovie;
    
    
catch err %#ok<*NASGU>
    
    Common.Catch;
    
end

end
