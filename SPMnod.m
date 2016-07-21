function [ names , onsets , durations ] = SPMnod( DataStruct )
%SPMNOD Build 'names', 'onsets', 'durations' for SPM

try
    %% Preparation
    
    % 'names' for SPM
    switch DataStruct.Task
        
        case 'EyelinkCalibration'
            names = {'EyeLinkCalibration'};
            
        case 'Calibration'
            names = {
                '';
                };
            
        case 'Instruction'
            names = {
                '';
                };
            
        case 'Session'
            names = {
                '';
                };
            
    end
    
    % 'onsets' & 'durations' for SPM
    onsets    = cell(size(names));
    durations = cell(size(names));
    
    % Shortcut
    EventData = DataStruct.TaskData.ER.Data;
    
    
    %% Onsets building
    
    for event = 1:size(EventData,1)
        
        switch EventData{event,1}
            
            case ''
                onsets{2} = [onsets{2} ; EventData{event,2}];
                
        end
        
    end
    
    
    %% Duratins building
    
    for event = 1:size(EventData,1)
        
        switch EventData{event,1}
            
            case ''
                durations{2} = [ durations{2} ; EventData{event+1,2}-EventData{event,2}] ;
                
        end
        
    end
    
    
    %% Add Catch trials and Clicks
    
    if ~strcmp(DataStruct.Task,'EyelinkCalibration')
        
        N = length(names);
        
        % CLICK
        
        clic_spot.R = regexp(DataStruct.TaskData.KL.KbEvents(:,1),KbName(DataStruct.Parameters.Keybinds.Right_Blue_b_ASCII));
        clic_spot.R = ~cellfun(@isempty,clic_spot.R);
        clic_spot.R = find(clic_spot.R);
        
        clic_spot.L = regexp(DataStruct.TaskData.KL.KbEvents(:,1),KbName(DataStruct.Parameters.Keybinds.Right_Blue_y_ASCII));
        clic_spot.L = ~cellfun(@isempty,clic_spot.L);
        clic_spot.L = find(clic_spot.L);
        
        count = 0 ;
        for side = {'R' ; 'L'}
            
            count = count + 1 ;
            
            switch side
                case 'R'
                    names{N+count} = 'CLICK right';
                case 'L'
                    names{N+count} = 'CLICK left';
            end
            
            if ~isempty(DataStruct.TaskData.KL.KbEvents{clic_spot.(side),2})
                clic_idx = cell2mat(DataStruct.TaskData.KL.KbEvents{clic_spot.(side),2}(:,2)) == 1;
                clic_idx = find(clic_idx);
                % The last click can be be unfinished : button down + end of stim =
                % no button up
                if isempty(DataStruct.TaskData.KL.KbEvents{clic_spot.(side),2}{clic_idx(end),3})
                    DataStruct.TaskData.KL.KbEvents{clic_spot.(side),2}{clic_idx(end),3} =  DataStruct.TaskData.ER.Data{end,2} - DataStruct.TaskData.KL.KbEvents{clic_spot.(side),2}{clic_idx(end),1};
                end
                onsets{N+count}    = cell2mat(DataStruct.TaskData.KL.KbEvents{clic_spot.(side),2}(clic_idx,1));
                durations{N+count} = cell2mat(DataStruct.TaskData.KL.KbEvents{clic_spot.(side),2}(clic_idx,3));
            else
                onsets{N+count}    = [];
                durations{N+count} = [];
            end
            
        end
        
    end
    
catch err
    
    sca
    rethrow(err)
    
end

end
