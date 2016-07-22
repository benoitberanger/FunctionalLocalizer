%% Prepare event

% Create and prepare
header = { 'event_name' , 'onset(s)' , 'duration(s)' };
EP     = EventPlanning(header);

% NextOnset = PreviousOnset + PreviousDuration
NextOnset = @(EP) EP.Data{end,2} + EP.Data{end,3};


%% Define a planning <--- paradigme

% --- Start ---------------------------------------------------------------

EP.AddPlanning({ 'StartTime' 0  0 });

% --- Stim ----------------------------------------------------------------

EP.AddPlanning({ 'LeftButton_instructions' NextOnset(EP) 2 });
EP.AddPlanning({ 'LeftButton_ok' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });

EP.AddPlanning({ 'RightButton_instructions' NextOnset(EP) 2 });
EP.AddPlanning({ 'RightButton_ok' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });

EP.AddPlanning({ 'Volume_instructions' NextOnset(EP) 10 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'Volume_question' NextOnset(EP) 2 });
EP.AddPlanning({ 'Volume_ok' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });
repeat_microtime = 0.1;

EP.AddPlanning({ 'Screen_instructions' NextOnset(EP) 5 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.5 });
EP.AddPlanning({ 'Screen_Cross' NextOnset(EP) 10 });
EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 1 });

% --- Stop ----------------------------------------------------------------

EP.AddPlanning({ 'StopTime' NextOnset(EP)  0 });
