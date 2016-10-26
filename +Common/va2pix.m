function [ Pixels ] = va2pix( VisualAngle , SubjectDistance , ScreenWidthM , ScreenWidthPx )
% example : va2pix( 1 , 1.200 , 0.400 , 768 )
%
% VisualAngle     in degrees : [0  360]
% SubjectDistance in meters  : [0 +Inf]
% ScreenWidthM    in meters  : [0 +Inf]
% ScreenWidthPx   in pixels  : [0 +Inf]
%

Pixels = SubjectDistance * tan(VisualAngle*pi/180) / (ScreenWidthM/ScreenWidthPx);

end
