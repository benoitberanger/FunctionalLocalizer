function [ TriggerTime ] = WaitForTTL( DataStruct )

if strcmp(DataStruct.OperationMode,'Acquisition')
    
    if ~isfield(DataStruct,'StartTime') % It means wait for 1st TTL @ Begining of stimulation
        
        disp('----------------------------------')
        disp('      Waiting for trigger "t"     ')
        disp('                OR                ')
        disp('   Press "s" to emulate trigger   ')
        disp('      Press "Escape" to abort     ')
        disp('----------------------------------')
        disp(' ')
        
    else % All other cases
        
        disp('Waiting for TTL')
        
    end
    
    % Just to be sure the user is not pushing a button before
    WaitSecs(0.2); % secondes
    
    % Waiting for TTL signal
    while 1
        
        [ keyIsDown , TriggerTime, keyCode ] = KbCheck;
        
        if keyIsDown
            
            switch DataStruct.Environement
                
                case 'MRI'
                    
                    if keyCode(DataStruct.Parameters.Keybinds.TTL_t_ASCII) || keyCode(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)
                        break
                        
                    elseif keyCode(DataStruct.Parameters.Keybinds.Stop_Escape_ASCII)
                        
                        % Eyelink mode 'On' ?
                        if strcmp(DataStruct.EyelinkMode,'On')
                            Eyelink.STOP % Stop wrapper
                        end
                        
                        sca
                        stack = dbstack;
                        error('WaitingForTTL:Abort','\n ESCAPE key : %s aborted \n',stack.file)
                        
                    end
                    
                case 'Training'
                    
                    if keyCode(DataStruct.Parameters.Keybinds.Right_Blue_b_ASCII) || keyCode(DataStruct.Parameters.Keybinds.TTL_t_ASCII) || keyCode(DataStruct.Parameters.Keybinds.emulTTL_s_ASCII)
                        break
                        
                    elseif keyCode(DataStruct.Parameters.Keybinds.Stop_Escape_ASCII)
                        
                        % Eyelink mode 'On' ?
                        if strcmp(DataStruct.EyelinkMode,'On')
                            Eyelink.STOP % Stop wrapper
                        end
                        
                        sca
                        stack = dbstack;
                        error('WitingForTTL:Abort','\n ESCAPE key : %s aborted \n',stack.file)
                        
                    end
                    
            end
            
        end
        
    end
    
    
else % in DebugMod
    
    disp('Waiting for TTL : DebugMode')
    
    TriggerTime = GetSecs;
    
end

end
