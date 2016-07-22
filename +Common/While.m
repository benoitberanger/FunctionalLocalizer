[~, secs, ~] = KbCheck;
t0 = secs;

while secs < t0 + tmax
    
    [keyIsDown, secs, keyCode] = KbCheck;
    
    if keyIsDown && keyCode(DataStruct.Parameters.Keybinds.RightArrow)
        break
    end
    
end
