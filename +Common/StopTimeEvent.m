% Fixation duration handeling
switch DataStruct.Task
    case 'Calibration'
        StopTime = GetSecs;
    otherwise
        StopTime = WaitSecs('UntilTime', StartTime + EP.Data{evt,2} );
end

% Record StopTime
ER.AddStopTime( 'StopTime' , StopTime - StartTime );
RR.AddEvent( { 'StopTime' , StopTime - StartTime , 0 } );

ShowCursor;
Priority( DataStruct.PTB.oldLevel );
