switch DataStruct.RecordVideo
    case 'On'
        moviePtr = Screen('CreateMovie', DataStruct.PTB.Window, DataStruct.VideoName ,[], [], DataStruct.PTB.FPS,':CodecType=theoraenc EncodingQuality=1 numChannels=1');
    case 'Off'
    otherwise
        error('DataStruct.RecordVideo ?')
end
