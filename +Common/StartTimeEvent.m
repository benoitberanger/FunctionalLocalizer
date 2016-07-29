switch DataStruct.OperationMode
    case 'Acquisition'
        HideCursor;
    case 'FastDebug'
    case 'RealisticDebug'
    otherwise
end

Common.DrawFixation;

% Flip video
Screen( 'Flip' , DataStruct.PTB.wPtr );

% Synchronization
StartTime = WaitForTTL( DataStruct );
