return {
    version = "v3.0.0 - The Command Update",
    
    -- This is the actual code that will execute in the game
    init = function()
        -- 1. Print a success message on login
        sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Cloud payload injected! Type {FFFF00}/cloudhelp", -1)
        
        -- ==========================================
        -- INJECTED COMMANDS
        -- ==========================================

        -- Command 1: A help menu to see what we have
        sampRegisterChatCommand("cloudhelp", function()
            sampAddChatMessage("{00FF00}--- Cloud Commands ---", -1)
            sampAddChatMessage("{FFFF00}/cweather [0-20] {FFFFFF}- Change your local weather.", -1)
            sampAddChatMessage("{FFFF00}/ctime [0-23] {FFFFFF}- Change your local time.", -1)
            sampAddChatMessage("{FFFF00}/cfix {FFFFFF}- Instantly repair your current vehicle.", -1)
        end)

        -- Command 2: Change local weather dynamically based on what you type
        sampRegisterChatCommand("cweather", function(arg)
            local weatherId = tonumber(arg)
            if weatherId then
                forceWeatherNow(weatherId)
                sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Weather changed to " .. weatherId, -1)
            else
                sampAddChatMessage("{FF0000}[Cloud] {FFFFFF}Usage: /cweather [0-20]", -1)
            end
        end)

        -- Command 3: Change local time
        sampRegisterChatCommand("ctime", function(arg)
            local time = tonumber(arg)
            if time and time >= 0 and time <= 23 then
                -- forceTimeOfDay requires hours and minutes
                forceTimeOfDay(time, 0) 
                sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Time changed to " .. time .. ":00", -1)
            else
                sampAddChatMessage("{FF0000}[Cloud] {FFFFFF}Usage: /ctime [0-23]", -1)
            end
        end)

        -- Command 4: Repair the car you are currently sitting in
        sampRegisterChatCommand("cfix", function()
            -- Check if the player is actually in a car first so we don't crash
            if isCharInAnyCar(PLAYER_PED) then
                -- Grab the car the player is in
                local car = storeCarCharIsInNoSave(PLAYER_PED)
                -- Fix it locally
                fixCar(car)
                sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Vehicle repaired!", -1)
            else
                sampAddChatMessage("{FF0000}[Cloud] {FFFFFF}You are not in a vehicle!", -1)
            end
        end)
    end
}
