switch DataStruct.OperationMode
    case 'Acquisition'
        HideCursor;
    case 'FastDebug'
    case 'RealisticDebug'
    otherwise
end

% Flip video
Screen( 'Flip' , DataStruct.PTB.Window );

% Synchronization
StartTime = WaitForTTL( DataStruct );
