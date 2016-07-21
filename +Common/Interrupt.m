% Escape ?
[ ~ , secs , keyCode ] = KbCheck;

if keyCode(DataStruct.Parameters.Keybinds.Stop_Escape_ASCII)
    
    % Flag
    Exit_flag = 1;
    
    % Stop time
    StopTime = GetSecs;
    
    % Record StopTime
    ER.AddStopTime( 'StopTime' , StopTime - StartTime );
    RR.AddEvent( { 'StopTime' , StopTime - StartTime , 0 } );
    
    ShowCursor;
    Priority( DataStruct.PTB.oldLevel );
    
    break
    
end
