function [ names , onsets , durations ] = SPMnod( DataStruct )
%SPMNOD Build 'names', 'onsets', 'durations' for SPM

try
    %% Preparation
    
    % 'names' for SPM
    switch DataStruct.Task
        
        case 'EyelinkCalibration'
            names = {'EyelinkCalibration'};
            
        case 'Calibration'
            names = {
                '';
                };
            
        case 'Instructions'
            names = {
                '';
                };
            
        case 'Session'
            names = {
                'Horizontal_Checkerboard'
                'Vertical_Checkerboard'
                'Right_Audio_Click'
                'Left_Audio_Click'
                'Right_Video_Click'
                'Left_Video_Click'
                'Audio_Computation'
                'Video_Computation'
                'Video_Sentences'
                'Audio_Sentences'
                'Audio_Sinwave'
                'Cross_Rest'
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
            
            case 'Horizontal_Checkerboard'
                onsets{1} = [onsets{1} ; EventData{event,2}];
            case 'Vertical_Checkerboard'
                onsets{2} = [onsets{2} ; EventData{event,2}];
            case 'Right_Audio_Click'
                onsets{3} = [onsets{3} ; EventData{event,2}];
            case 'Left_Audio_Click'
                onsets{4} = [onsets{4} ; EventData{event,2}];
            case 'Right_Video_Click'
                onsets{5} = [onsets{5} ; EventData{event,2}];
            case 'Left_Video_Click'
                onsets{6} = [onsets{6} ; EventData{event,2}];
            case 'Audio_Computation'
                onsets{7} = [onsets{7} ; EventData{event,2}];
            case 'Video_Computation'
                onsets{8} = [onsets{8} ; EventData{event,2}];
            case 'Video_Sentences'
                onsets{9} = [onsets{9} ; EventData{event,2}];
            case 'Audio_Sentences'
                onsets{10} = [onsets{10} ; EventData{event,2}];
            case 'Audio_Sinwave'
                onsets{11} = [onsets{11} ; EventData{event,2}];
            case 'Cross_Rest'
                onsets{12} = [onsets{12} ; EventData{event,2}];
                
        end
        
    end
    
    
    %% Durations building
    
    % +1 because Event_Like_This is one line but with duration=0
    % +1 if we incorporate the cross~=rest time a the end of each trial
    offcet = 1 ;
    
    for event = 1:size(EventData,1)
        
        switch EventData{event,1}
            
            case 'Horizontal_Checkerboard'
                durations{1} = [ durations{1} ; EventData{event+8+offcet,2}-EventData{event,2}] ;
            case 'Vertical_Checkerboard'
                durations{2} = [ durations{2} ; EventData{event+8+offcet,2}-EventData{event,2}] ;
            case 'Right_Audio_Click'
                durations{3} = [ durations{6} ; EventData{event+1+offcet,2}-EventData{event,2}] ;
            case 'Left_Audio_Click'
                durations{4} = [ durations{4} ; EventData{event+1+offcet,2}-EventData{event,2}] ;
            case 'Right_Video_Click'
                durations{5} = [ durations{5} ; EventData{event+9+offcet,2}-EventData{event,2}] ;
            case 'Left_Video_Click'
                durations{6} = [ durations{6} ; EventData{event+9+offcet,2}-EventData{event,2}] ;
            case 'Audio_Computation'
                durations{7} = [ durations{7} ; EventData{event+1+offcet,2}-EventData{event,2}] ;
            case 'Video_Computation'
                durations{8} = [ durations{8} ; EventData{event+8+offcet,2}-EventData{event,2}] ;
            case 'Video_Sentences'
                durations{9} = [ durations{9} ; EventData{event+8+offcet,2}-EventData{event,2}] ;
            case 'Audio_Sentences'
                durations{10} = [ durations{10} ; EventData{event+1+offcet,2}-EventData{event,2}] ;
            case 'Audio_Sinwave'
                durations{11} = [ durations{11} ; EventData{event+6+offcet,2}-EventData{event,2}] ;
            case 'Cross_Rest'
                durations{12} = [ durations{12} ; EventData{event+1+offcet,2}-EventData{event,2}] ;
                
        end
        
    end
    
    
    %% Add Catch trials and Clicks
    
    if ~strcmp(DataStruct.Task,'EyelinkCalibration')
        
        n = length(names);
        
        % CLICK
        
        clic_spot.r = regexp(DataStruct.TaskData.KL.KbEvents(:,1),KbName(DataStruct.Parameters.Keybinds.Right_Blue_b_ASCII));
        clic_spot.r = ~cellfun(@isempty,clic_spot.r);
        clic_spot.r = find(clic_spot.r);
        
        clic_spot.l = regexp(DataStruct.TaskData.KL.KbEvents(:,1),KbName(DataStruct.Parameters.Keybinds.Left_Yellow_y_ASCII));
        clic_spot.l = ~cellfun(@isempty,clic_spot.l);
        clic_spot.l = find(clic_spot.l);
        
        count = 0 ;
        sides = {'r' ; 'l'};
        for side = 1:length(sides)
            
            count = count + 1 ;
            
            switch side
                case 1
                    names{n+count} = 'CLICK_right';
                case 2
                    names{n+count} = 'CLICK_left';
            end
            
            if ~isempty(DataStruct.TaskData.KL.KbEvents{clic_spot.(sides{side}),2})
                clic_idx = cell2mat(DataStruct.TaskData.KL.KbEvents{clic_spot.(sides{side}),2}(:,2)) == 1;
                clic_idx = find(clic_idx);
                % the last click can be be unfinished : button down + end of stim = no button up
                if isempty(DataStruct.TaskData.KL.KbEvents{clic_spot.(sides{side}),2}{clic_idx(end),3})
                    DataStruct.TaskData.KL.KbEvents{clic_spot.(sides{side}),2}{clic_idx(end),3} =  DataStruct.Taskdata.er.data{end,2} - DataStruct.TaskData.KL.KbEvents{clic_spot.(sides{side}),2}{clic_idx(end),1};
                end
                onsets{n+count}    = cell2mat(DataStruct.TaskData.KL.KbEvents{clic_spot.(sides{side}),2}(clic_idx,1));
                durations{n+count} = cell2mat(DataStruct.TaskData.KL.KbEvents{clic_spot.(sides{side}),2}(clic_idx,3));
            else
                onsets{n+count}    = [];
                durations{n+count} = [];
            end
            
        end
        
    end
    
catch err
    
    sca
    rethrow(err)
    
end

end
