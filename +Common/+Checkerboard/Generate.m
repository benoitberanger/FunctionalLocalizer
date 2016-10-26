function [ PositivePtr, NegativePtr ] = Generate( DataStruct, Orientation )

%%

% Shortcuts ---------------------------------------------------------------

wPtr  = DataStruct.PTB.wPtr;
wRect = DataStruct.PTB.wRect;

ScreenBackgroundColor = DataStruct.Parameters.Video.ScreenBackgroundColor;

CenterH = DataStruct.PTB.CenterH;
CenterV = DataStruct.PTB.CenterV;

% Parameters --------------------------------------------------------------

PixelPerDegree = Common.va2pix( 1 , DataStruct.Parameters.Video.SubjectDistance , DataStruct.Parameters.Video.ScreenWidthM , DataStruct.Parameters.Video.ScreenWidthPx );


% Checkerboard
Checkerboard.segements = 48; % angles
Checkerboard.alternance = 30; % radius
Checkerboard.innerLimit = PixelPerDegree*0.1; % Pixel

% Wedge
Wedge.arcAngle = 125; % Length of the arc (degrees)
% Orientation = 'vertical'; % for tests
% Orientation = 'horizontal'; % for tests
switch lower(Orientation)
    case 'vertical'
        Wedge.startAngle = (180 - Wedge.arcAngle)/2; % Start angle at which we would like our mask to begin (degrees)
    case 'horizontal'
        Wedge.startAngle = ( 0  - Wedge.arcAngle)/2; % Start angle at which we would like our mask to begin (degrees)
end
Wedge.arcRect = CenterRectOnPoint([0 0 wRect(4) wRect(4)],CenterH,CenterV); % The rect in which we will define our arc


% Prepare coordinates -----------------------------------------------------

a = linspace(0 , 360*( 1 - (1/Checkerboard.segements)) , Checkerboard.segements)';
da = diff(a);

% r = linspace(Checkerboard.innerLimit , wRect(4) , Checkerboard.alternance+1)';
r = logspace(log10(Checkerboard.innerLimit), log10(wRect(4)) , Checkerboard.alternance+1)';

dr = diff(r)/2;
r(1) = [];


% Create the checkerboard -------------------------------------------------

innerCircle = NaN(length(r),4);
for osef = 1:length(r)
    innerCircle(osef,:) = CenterRectOnPoint([0 0 r(osef) r(osef)],CenterH,CenterV);
end

% *** POSITIVE ***

bumper = 0;
for angle = 1 : length(a)
    bumper = bumper + 1;
    for radius = 1 : length(r)
        bumper = bumper + 1;
        Screen('FrameArc',wPtr, 255*mod(bumper,2),innerCircle(radius,:),a(angle),da(1),dr(radius));
    end
end

% Draw our masks
Screen('FillArc', wPtr, ScreenBackgroundColor, Wedge.arcRect, Wedge.startAngle, Wedge.arcAngle)
Screen('FillArc', wPtr, ScreenBackgroundColor, Wedge.arcRect, Wedge.startAngle + 180, Wedge.arcAngle)

Screen('DrawingFinished', wPtr);

Positive.Image=Screen('GetImage', wPtr,[],'backBuffer');
Screen('FillRect', wPtr, ScreenBackgroundColor); % clean the buffer


% *** NEGATIVE ***

bumper = 1;
for angle = 1 : length(a)
    bumper = bumper + 1;
    for radius = 1 : length(r)
        bumper = bumper + 1;
        Screen('FrameArc',wPtr, 255*mod(bumper,2),innerCircle(radius,:),a(angle),da(1),dr(radius));
    end
end

% Draw our masks
Screen('FillArc', wPtr, ScreenBackgroundColor, Wedge.arcRect, Wedge.startAngle, Wedge.arcAngle)
Screen('FillArc', wPtr, ScreenBackgroundColor, Wedge.arcRect, Wedge.startAngle + 180, Wedge.arcAngle)

Screen('DrawingFinished', wPtr);

Negative.Image=Screen('GetImage', wPtr,[],'backBuffer');
Screen('FillRect', wPtr, ScreenBackgroundColor); % clean the buffer

% figure; image(Positive.Image)


% Generate PTB texture ----------------------------------------------------

if exist('Positive.Texture','var')
    Screen('Close', Positive.Texture);
end
if exist('Negative.Texture','var')
    Screen('Close', Negative.Texture);
end
Positive.Texture=Screen('MakeTexture', wPtr, Positive.Image);
Negative.Texture=Screen('MakeTexture', wPtr, Negative.Image);

PositivePtr = Positive.Texture;
NegativePtr = Negative.Texture;


% Test drawing ------------------------------------------------------------

% Screen('DrawTexture',wPtr,Positive.Texture);
% Screen('DrawingFinished', wPtr);
% Screen('Flip', wPtr);


end
