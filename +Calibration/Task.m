function [ TaskData ] = Task( DataStruct )

try
    %% Tunning of the task
    
    Calibration.Planning;
    
    EP.AddPlanning({ 'cw' NextOnset(EP) .1 });
    EP.AddPlanning({ 'ccw' NextOnset(EP) .1 });
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
    
    
    %% Go

    % ---------------------------------------------------------------------
    % Presentation slide
    
    DrawFormattedText(DataStruct.PTB.wPtr, 'calibration son/audio' , 'center', 'center');

    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    
    WaitSecs(1);
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    %%
    % ---------------------------------------------------------------------
    % Instructions : audio
    
    txt = ' nous allons vous faire entendre \n plusieurs fois une phrase : \n indiquez si le son est suffisement fort \n mais sans être douloureux ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[],[],[],[],2);

    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    %%
    % ---------------------------------------------------------------------
    % Sound calibration
    
    fprintf('\n')
    fprintf('Volume calibration : ? \n')
    
    wav_path = 'wav';
    wavefile = 'calc40.wav';
    [y, Fs, nbits] = wavread([wav_path filesep wavefile]);

    PsychPortAudio('FillBuffer', DataStruct.PTB.Playback_pahandle, [y y]');
    
    
    
    fprintf('Press %s to repeat sound \n',upper(KbName(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)))
    fprintf('Press %s to pass \n',upper(KbName(DataStruct.Parameters.Keybinds.TTL_t_ASCII)))
    
    calibrated = 0;
    while ~calibrated
        
        startTime = PsychPortAudio('Start', DataStruct.PTB.Playback_pahandle , 1 , 0, 1);
        
        PsychPortAudio('Stop', DataStruct.PTB.Playback_pahandle, 1, 1);
        
        txt = 'volume ?';
        DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[],[],[],[],2);
        vbl = Screen('Flip',DataStruct.PTB.wPtr);
        
        keyIsDown = 0;
        while ~keyIsDown
            
            [keyIsDown, secs, keyCode] = KbCheck;
            
            if keyIsDown
                
                if keyCode(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)
                    vbl = Screen('Flip',DataStruct.PTB.wPtr);
                    WaitSecs(0.1);
                    
                elseif keyCode(DataStruct.Parameters.Keybinds.TTL_t_ASCII)
                    calibrated = 1;
                    fprintf('Volume calibration : OK \n')
                end
                
            end
            
        end
        
    end
        
    WaitSecs(1);
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    
    
     %%
    % ---------------------------------------------------------------------
    % Instructions : Cross
    
    txt = ' assurez-vous que la croix rouge \n est bien au centre \n de votre champ de vision';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[],[],[],[],2);
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    %%
    
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
    
    vbl = Screen('Flip',DataStruct.PTB.wPtr);

    
    fprintf('Press %s to pass \n',upper(KbName(DataStruct.Parameters.Keybinds.TTL_t_ASCII)))
    
    while 1
        
        [keyIsDown, secs, keyCode] = KbCheck;
        
        if keyIsDown
            
            if keyCode(DataStruct.Parameters.Keybinds.TTL_t_ASCII)
                
                fprintf('Screen calibration : OK \n')
                break
            end
            
        end
        
    end
    
    
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    %%
    
    % ---------------------------------------------------------------------
    % Left button calibration :
    
    fprintf('\n')
    fprintf('Left button calibration : ? \n')
    
    txt = ' appuyer sue le bouton gauche ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[],[],[],[],2);

    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    
    while 1
        
        [keyIsDown, secs, keyCode] = KbCheck;
        
        if keyIsDown
            
            if keyCode(DataStruct.Parameters.Keybinds.Left_Yellow_y_ASCII)
                
                fprintf('Right button calibration : OK \n')
                break
                
            end
            
        end
        
    end
    
    
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    % ---------------------------------------------------------------------
    % Right button calibration :
    
    fprintf('\n')
    fprintf('Right button calibration : ? \n')
    
    txt = ' appuyer sue le bouton droit ';
    DrawFormattedText(DataStruct.PTB.wPtr, txt , 'center', 'center',[],[],[],[],2);

    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    
    while 1
        
        [keyIsDown, secs, keyCode] = KbCheck;
        
        if keyIsDown
            
            if keyCode(DataStruct.Parameters.Keybinds.Right_Blue_b_ASCII)
                
                fprintf('Right button calibration : OK \n')
                break
                
            end
            
        end
        
    end
    
    vbl = Screen('Flip',DataStruct.PTB.wPtr);
    WaitSecs(1);
    
    %% debug
    
    Common.StartTimeEvent;
    ER.Data = EP.Data;
    ER.EventCount = EP.EventCount;
    StopTime = GetSecs;
    
    ShowCursor;
    Priority( DataStruct.PTB.oldLevel );
    
    
    %% End of stimulation
    
    Common.EndOfStimulationScript;
    
    Common.Movie.FinalizeMovie;
    
    
catch err %#ok<*NASGU>
    
    Common.Catch;
    
end

end
