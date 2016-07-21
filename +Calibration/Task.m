function [ TaskData ] = Task( DataStruct )

try
    %% Tunning of the task
    
    Calibration.Planning;
    
    EP.AddPlanning({ 'cw' NextOnset(EP) .1 });
    EP.AddPlanning({ 'ccw' NextOnset(EP) .1 });
    EP.AddPlanning({ 'StopTime' NextOnset(EP) 0 });
    
    % End of preparations
    EP.BuildGraph;
    TaskData.EP = EP;
    
    
    %% Prepare event record and keybinf logger
    
    Common.PrepareRecorders;
    
    
    %% Record movie
    
    Common.Movie.CreateMovie;
    
    
    %% Start recording eye motions
    
    
    % no eyelink for calibration
    
    
    %% Go
    
    Common.StartTimeEvent;
    ER.Data = EP.Data;
    ER.EventCount = EP.EventCount;
    StopTime = GetSecs;
    
    ShowCursor;
    Priority( DataStruct.PTB.oldLevel );
    
    
    %% End of stimulation
    
    Common.EndOfStimulationScript;
    
    Common.Movie.FinalizeMovie;
    
    
catch err %#ok<*NASGU>
    
    Common.Catch;
    
end

end
