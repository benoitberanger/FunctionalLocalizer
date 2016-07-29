% Here we set the size of the arms of our fixation cross
% fixCrossDimPix = 40;
fixCrossDimPix = DataStruct.PTB.wRect(end)/50;

% Now we set the coordinates (these are all relative to zero we will let
% the drawing routine center the cross in the center of our monitor for us)
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];

% Set the line width for our fixation cross
lineWidthPix = 2;

% Draw the fixation cross in white, set it to the center of our screen and
% set good quality antialiasing
Screen('DrawLines', DataStruct.PTB.wPtr, allCoords,...
    lineWidthPix, [255 255 255], [DataStruct.PTB.CenterH DataStruct.PTB.CenterV]);
