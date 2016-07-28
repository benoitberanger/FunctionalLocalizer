% Fixation duration handeling
switch DataStruct.Task
    case 'Calibration'
        StopTime = GetSecs;
    otherwise
        StopTime = WaitSecs('UntilTime', StartTime + ER.Data{ER.EventCount,2} + EP.Data{evt-1,3} );
end

% Record StopTime
ER.AddStopTime( 'StopTime' , StopTime - StartTime );
RR.AddEvent( { 'StopTime' , StopTime - StartTime , 0 } );

ShowCursor;
Priority( DataStruct.PTB.oldLevel );
