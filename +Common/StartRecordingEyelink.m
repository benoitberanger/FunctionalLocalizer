% Eyelink mode 'On' ?
switch DataStruct.EyelinkMode
    case 'On'
        
        % Acquisition ?
        switch DataStruct.OperationMode
            
            case 'Acquisition'
                Eyelink.StartRecording( DataStruct.EyelinkFile );
                
            otherwise
                error('Task:EyelinkWithourAcquisition','\n Eyelink mode should be ''Off'' if not in Acquisition mode \n')
                
        end
        
    case 'Off'
    otherwise
end
