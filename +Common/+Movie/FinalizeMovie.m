switch DataStruct.RecordVideo
    case 'On'
        Screen('FinalizeMovie', moviePtr);
    case 'Off'
    otherwise
        error('DataStruct.RecordVideo ?')
end
