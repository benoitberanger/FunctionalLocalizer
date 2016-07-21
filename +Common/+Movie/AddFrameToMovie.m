switch DataStruct.RecordVideo
    case 'On'
        Screen('AddFrameToMovie',DataStruct.PTB.wPtr,[],'frontBuffer',moviePtr,1);
    case 'Off'
    otherwise
        error('DataStruct.RecordVideo ?')
end
