if strcmp( DataStruct.ParPort , 'On' )
    
    % Send Trigger
    WriteParPort( pp );
    WaitSecs( msg.duration );
    WriteParPort( 0 );
    
end
