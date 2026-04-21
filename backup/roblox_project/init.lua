-- Elite Sovereign: Sniper Duels Edition
-- Built by Antigravity

local UI = loadstring(readfile("roblox_project/modules/ui_library.lua"))()
local ESP = loadstring(readfile("roblox_project/modules/esp_manager.lua"))()
local Triggerbot = loadstring(readfile("roblox_project/modules/triggerbot.lua"))()

-- Initialize Modules
ESP:Init()
Triggerbot:Init()

-- UI Setup
local Window = UI:CreateWindow("ELITE SOVEREIGN | SNIPER DUELS")

-- Visuals Tab
Window:CreateToggle("Enable ESP", function(state)
    ESP.Enabled = state
end)

Window:CreateToggle("Team Check", function(state)
    ESP.TeamCheck = state
end)

Window:CreateSlider("Max Distance", 0, 2000, 500, function(val)
    ESP.MaxDistance = val
end)

-- Combat Tab
Window:CreateToggle("Enable Triggerbot", function(state)
    Triggerbot.Enabled = state
end)

Window:CreateToggle("Triggerbot Team Check", function(state)
    Triggerbot.TeamCheck = state
end)

Window:CreateDropdown("Triggerbot Mode", {"Hold", "Toggle", "Always"}, function(mode)
    Triggerbot.Mode = mode
end)

-- Load Notice
print("Elite Sovereign Loaded | Sniper Duels Edition")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Elite Sovereign",
    Text = "Script Loaded Successfully",
    Duration = 5
})
