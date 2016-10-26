Stimuli = struct;


%% Audio files
% Stimuli.Audio.(filename) = audiosignal;

audio_content = dir([DataStruct.Parameters.Path.wav '*.wav']);
audio_name = {audio_content.name}';
audio_name = strrep(audio_name,'.wav','');

for a = 1 : length(audio_content)
    Stimuli.Audio.(audio_name{a}) = wavread( [DataStruct.Parameters.Path.wav audio_name{a} '.wav'] );
end


%% Image files
% Stimuli.Image.(filename) = texturePointer;

img_content = dir([DataStruct.Parameters.Path.img '*.bmp']);
img_name = {img_content.name}';
img_name = strrep(img_name,'.bmp','');

for i = 1 : length(img_content)
    current_img = imread([DataStruct.Parameters.Path.img img_name{i} '.bmp']);
    Stimuli.Image.(img_name{i}) = Screen( 'MakeTexture' , DataStruct.PTB.wPtr , current_img );
end


%% New method for the checkerboard : dynamic generation

[Stimuli.Checkerboard.Horitontal.Positive, Stimuli.Checkerboard.Horitontal.Negative] = Common.Checkerboard.Generate(DataStruct,'Horizontal');
[Stimuli.Checkerboard.Vertical.  Positive, Stimuli.Checkerboard.Vertical.  Negative] = Common.Checkerboard.Generate(DataStruct,'Vertical'  );
