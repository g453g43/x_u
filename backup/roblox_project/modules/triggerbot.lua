local Triggerbot = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

Triggerbot.Enabled = false
Triggerbot.Mode = "Hold" -- "Hold", "Toggle", "Always"
Triggerbot.Keybind = Enum.KeyCode.V
Triggerbot.TeamCheck = false

local active = false

function Triggerbot:Init()
    local function IsEnemy(target)
        if not target then return false end
        local character = target:FindFirstAncestorOfClass("Model")
        if not character then return false end
        local player = Players:GetPlayerFromCharacter(character)
        
        if player and player ~= LocalPlayer then
            if Triggerbot.TeamCheck and player.Team == LocalPlayer.Team then
                return false
            end
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                return true
            end
        end
        return false
    end

    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Triggerbot.Keybind then
            if Triggerbot.Mode == "Hold" then
                active = true
            elseif Triggerbot.Mode == "Toggle" then
                active = not active
            end
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Triggerbot.Keybind and Triggerbot.Mode == "Hold" then
            active = false
        end
    end)

    RunService.RenderStepped:Connect(function()
        if not Triggerbot.Enabled then return end
        
        local isWorking = false
        if Triggerbot.Mode == "Always" then
            isWorking = true
        else
            isWorking = active
        end

        if isWorking and IsEnemy(Mouse.Target) then
            mouse1click() -- Standard exploit function for clicking
        end
    end)
end

return Triggerbot
