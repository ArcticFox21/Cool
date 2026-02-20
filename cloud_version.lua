-- ==========================================
-- AI RAW CODE PAYLOAD
-- ==========================================
sampAddChatMessage("{00FF00}[Sandbox] {FFFFFF}New AI code loaded successfully!", -1)



local uiVisible = imgui.new.bool(false)
local serverTimeStr = "Fetching..."
local waitingForTime = false

sampRegisterChatCommand("cltime", function()
    uiVisible[0] = not uiVisible[0]
    if uiVisible[0] then
        waitingForTime = true
        sampSendChat("/time")
    end
end)

function sampev.onServerMessage(color, text)
    if waitingForTime then
        local clean = text:gsub("{%x+}", "")
        if clean:match("%d+:%d+") or clean:lower():find("time") then
            serverTimeStr = clean
            waitingForTime = false
            return false
        end
    end
end

imgui.OnFrame(
    function() return uiVisible[0] end,
    function()
        imgui.SetNextWindowPos(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver)
        imgui.Begin("Server Time", uiVisible, imgui.WindowFlags.AlwaysAutoResize)
        imgui.Text("Server /time:")
        imgui.TextColored(imgui.ImVec4(0.0, 1.0, 0.0, 1.0), serverTimeStr)
        
        local h, m = getTimeOfDay()
        imgui.Text(string.format("In-Game Time: %02d:%02d", h, m))
        imgui.End()
    end
)
