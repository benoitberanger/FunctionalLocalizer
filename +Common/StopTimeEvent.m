% Fixation duration handeling
StopTime = WaitSecs('UntilTime', StartTime + EP.Data{evt,2} );

% Record StopTime
ER.AddStopTime( 'StopTime' , StopTime - StartTime );
RR.AddEvent( { 'StopTime' , StopTime - StartTime , 0 } );

ShowCursor;
Priority( DataStruct.PTB.oldLevel );
