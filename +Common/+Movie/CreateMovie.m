switch DataStruct.RecordVideo
    case 'On'
    moviePtr = Screen('CreateMovie', DataStruct.PTB.wPtr, DataStruct.VideoName ,[], [], DataStruct.PTB.FPS,...
        [':CodecType=theoraenc AddAudioTrack=2@' num2str(DataStruct.Parameters.Audio.SamplingRate) ' EncodingQuality=1 numChannels=1']); % doesnt work (on windows)
    
    case 'Off'
    otherwise
        error('DataStruct.RecordVideo ?')
end
