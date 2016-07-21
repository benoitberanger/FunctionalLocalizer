switch DataStruct.RecordVideo
    case 'On'
        Screen('AddFrameToMovie',DataStruct.PTB.Window,[],'frontBuffer',moviePtr,1);
    case 'Off'
    otherwise
        error('DataStruct.RecordVideo ?')
end
