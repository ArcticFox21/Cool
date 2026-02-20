return {
    version = "v2.0.0 - The Storm Update",
    
    -- This is the actual code that will execute in the game
    init = function()
        -- 1. Print messages in the SAMP chat
        sampAddChatMessage("{FF00FF}[Cloud] GitHub code successfully injected!", -1)
        sampAddChatMessage("{FF00FF}[Cloud] Enjoy the stormy weather!", -1)
        
        -- 2. Print a huge GTA-style text on the middle of the screen for 3 seconds
        printStringNow("~y~Cloud Script Loaded", 3000)
        
        -- 3. Force the local game weather to 8 (Stormy/Thunder)
        forceWeatherNow(8)
    end
}
