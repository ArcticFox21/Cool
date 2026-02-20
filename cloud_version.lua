return {
    version = "v4.0.0 - The Time Freeze Update",
    
    init = function()
        sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Cloud payload v4.0.0 injected! Type {FFFF00}/cloudhelp", -1)
        
        -- We create variables to store your custom time/weather
        local customWeather = nil
        local customTime = nil

        -- This background loop runs endlessly to fight the SAMP server
        lua_thread.create(function()
            while true do
                wait(0) -- Wait 0 means it runs every single frame
                
                -- If you set a weather, constantly force it
                if customWeather ~= nil then
                    forceWeatherNow(customWeather)
                end
                
                -- If you set a time, constantly force it
                if customTime ~= nil then
                    setTimeOfDay(customTime, 0)
                end
            end
        end)

        -- ==========================================
        -- INJECTED COMMANDS
        -- ==========================================

        sampRegisterChatCommand("cloudhelp", function()
            sampAddChatMessage("{00FF00}--- Cloud Commands ---", -1)
            sampAddChatMessage("{FFFF00}/cweather [0-20] {FFFFFF}- Change & freeze local weather.", -1)
            sampAddChatMessage("{FFFF00}/ctime [0-23] {FFFFFF}- Change & freeze local time.", -1)
            sampAddChatMessage("{FFFF00}/cfix {FFFFFF}- Instantly repair your current vehicle.", -1)
        end)

        sampRegisterChatCommand("cweather", function(arg)
            local weatherId = tonumber(arg)
            if weatherId then
                customWeather = weatherId -- Set the variable so the loop freezes it
                sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Weather frozen to " .. weatherId, -1)
            else
                -- If you just type /cweather with no number, it unfreezes it
                customWeather = nil 
                sampAddChatMessage("{FF0000}[Cloud] {FFFFFF}Weather unfrozen. Usage: /cweather [0-20]", -1)
            end
        end)

        sampRegisterChatCommand("ctime", function(arg)
            local time = tonumber(arg)
            if time and time >= 0 and time <= 23 then
                customTime = time -- Set the variable so the loop freezes it
                sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Time frozen to " .. time .. ":00", -1)
            else
                customTime = nil
                sampAddChatMessage("{FF0000}[Cloud] {FFFFFF}Time unfrozen. Usage: /ctime [0-23]", -1)
            end
        end)

        sampRegisterChatCommand("cfix", function()
            if isCharInAnyCar(PLAYER_PED) then
                local car = storeCarCharIsInNoSave(PLAYER_PED)
                fixCar(car)
                sampAddChatMessage("{00FF00}[Cloud] {FFFFFF}Vehicle repaired!", -1)
            else
                sampAddChatMessage("{FF0000}[Cloud] {FFFFFF}You are not in a vehicle!", -1)
            end
        end)
    end
}
