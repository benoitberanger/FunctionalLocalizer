function [ Parameters ] = GetParameters( DataStruct )
% GETPARAMETERS Prepare common parameters
%
% Response buttuns (fORRP 932) :
% USB
% HHSC - 1x2 - CYL
% HID NAR 12345


%% Set parameters

%%%%%%%%%%%%%%
%   Screen   %
%%%%%%%%%%%%%%
Parameters.Video.ScreenWidthPx   = 1024;  % Number of horizontal pixel in MRI video system @ CENIR
Parameters.Video.ScreenHeightPx  = 768;   % Number of vertical pixel in MRI video system @ CENIR
Parameters.Video.ScreenFrequency = 60;    % Refresh rate (in Hertz)
Parameters.Video.SubjectDistance = 0.120; % m
Parameters.Video.ScreenWidthM    = 0.040; % m
Parameters.Video.ScreenHeightM   = 0.030; % m


switch DataStruct.Task
    
    case 'Calibration'
        Parameters.Video.ScreenBackgroundColor = [0 0 0]; % [R G B] ( from 0 to 255 )
        
    case 'Instructions'
        Parameters.Video.ScreenBackgroundColor = [0 0 0]; % [R G B] ( from 0 to 255 )
        
    case 'Session'
        Parameters.Video.ScreenBackgroundColor = [0 0 0]; % [R G B] ( from 0 to 255 )
        
    case 'EyelinkCalibration'
        Parameters.Video.ScreenBackgroundColor = [128 128 128]; % [R G B] ( from 0 to 255 )
        
end


%%%%%%%%%%%%%%
%  Keybinds  %
%%%%%%%%%%%%%%

KbName('UnifyKeyNames');

Parameters.Keybinds.Right_Blue_b_ASCII   = KbName('b');
Parameters.Keybinds.Right_Yellow_y_ASCII = KbName('y');

Parameters.Keybinds.TTL_t_ASCII          = KbName('t');
Parameters.Keybinds.emulTTL_s_ASCII      = KbName('s');
Parameters.Keybinds.Stop_Escape_ASCII    = KbName('ESCAPE');


%% Echo in command window

disp('--------------------------');
disp(['--- ' mfilename ' done ---']);
disp('--------------------------');
disp(' ');


end