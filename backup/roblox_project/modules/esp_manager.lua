local ESP = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

ESP.Enabled = false
ESP.TeamCheck = false
ESP.MaxDistance = 500
ESP.Objects = {}

local function CreateESP(player)
    if player == LocalPlayer then return end
    
    local function SetupCharacter(character)
        local root = character:WaitForChild("HumanoidRootPart", 5)
        if not root then return end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "EliteESP"
        highlight.Parent = character
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "EliteTags"
        billboard.Parent = character
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(0, 100, 0, 50)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        
        local label = Instance.new("TextLabel")
        label.Parent = billboard
        label.BackgroundTransparency = 1
        label.Size = UDim2.new(1, 0, 1, 0)
        label.Font = Enum.Font.GothamBold
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 12
        label.TextStrokeTransparency = 0
        
        ESP.Objects[player] = {
            Highlight = highlight,
            Billboard = billboard,
            Label = label,
            Character = character
        }
    end

    if player.Character then SetupCharacter(player.Character) end
    player.CharacterAdded:Connect(SetupCharacter)
end

function ESP:Init()
    for _, player in ipairs(Players:GetPlayers()) do
        CreateESP(player)
    end
    Players.PlayerAdded:Connect(CreateESP)
    Players.PlayerRemoving:Connect(function(player)
        if ESP.Objects[player] then
            ESP.Objects[player] = nil
        end
    end)

    RunService.RenderStepped:Connect(function()
        if not ESP.Enabled then
            for _, obj in pairs(ESP.Objects) do
                obj.Highlight.Enabled = false
                obj.Billboard.Enabled = false
            end
            return
        end

        local localChar = LocalPlayer.Character
        local localRoot = localChar and localChar:FindFirstChild("HumanoidRootPart")

        for player, obj in pairs(ESP.Objects) do
            local char = obj.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            
            if char and root and localRoot then
                local distance = (root.Position - localRoot.Position).Magnitude
                local isTeammate = ESP.TeamCheck and player.Team == LocalPlayer.Team
                
                if distance <= ESP.MaxDistance and not isTeammate then
                    obj.Highlight.Enabled = true
                    obj.Billboard.Enabled = true
                    obj.Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    obj.Label.Text = string.format("%s\n[%d studs]", player.Name, math.floor(distance))
                else
                    obj.Highlight.Enabled = false
                    obj.Billboard.Enabled = false
                end
            else
                obj.Highlight.Enabled = false
                obj.Billboard.Enabled = false
            end
        end
    end)
end

return ESP
