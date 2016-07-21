%% Prepare event record

% Create
ER = EventRecorder( { 'event_name' , 'onset(s)' } , size(EP.Data,1) );

% Prepare
ER.AddStartTime( 'StartTime' , 0 );


%% Response recorder

% Create
RR = EventRecorder( { 'event_name' , 'onset(s)' , 'duration(s)' } , 50000 ); % high arbitrary value : preallocation of memory

% Prepare
RR.AddEvent( { 'StartTime' , 0 , 0 } );


%% Prepare the logger of MRI triggers

KbName('UnifyKeyNames');

allKeys = struct2array(DataStruct.Parameters.Keybinds);

KL = KbLogger( allKeys , KbName(allKeys) );

% Start recording events
KL.Start;
