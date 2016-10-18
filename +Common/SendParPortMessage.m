if strcmp( DataStruct.ParPort , 'On' )
    
    pp = msg.(EP.Data{evt,1});
    
    % Send Trigger
    WriteParPort( pp );
    WaitSecs( msg.duration );
    WriteParPort( 0 );
    
end
