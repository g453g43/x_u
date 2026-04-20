-- Elite Sovereign: Sniper Duels Edition
-- Single-file version for easy GitHub hosting

local Modules = {}

-- UI Library Module
Modules.UI = function()
    local UI = {}
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")

    local function MakeDraggable(topbar, menu)
        local dragging, dragInput, dragStart, startPos
        topbar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = menu.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        topbar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                menu.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    function UI:CreateWindow(title)
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "EliteSovereign"
        ScreenGui.Parent = CoreGui
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Parent = ScreenGui
        MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        MainFrame.BorderSizePixel = 0
        MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
        MainFrame.ClipsDescendants = true

        local Border = Instance.new("Frame")
        Border.Name = "Border"
        Border.Parent = MainFrame
        Border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Border.BorderSizePixel = 0
        Border.Size = UDim2.new(1, 0, 0, 2)
        
        local BorderBottom = Border:Clone()
        BorderBottom.Parent = MainFrame
        BorderBottom.Position = UDim2.new(0, 0, 1, -2)

        RunService.RenderStepped:Connect(function()
            local hue = tick() % 5 / 5
            local color = Color3.fromHSV(hue, 1, 1)
            Border.BackgroundColor3 = color
            BorderBottom.BackgroundColor3 = color
        end)

        local TopBar = Instance.new("Frame")
        TopBar.Name = "TopBar"
        TopBar.Parent = MainFrame
        TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        TopBar.BorderSizePixel = 0
        TopBar.Size = UDim2.new(1, 0, 0, 30)
        MakeDraggable(TopBar, MainFrame)

        local Title = Instance.new("TextLabel")
        Title.Parent = TopBar
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0, 10, 0, 0)
        Title.Size = UDim2.new(1, -20, 1, 0)
        Title.Font = Enum.Font.GothamBold
        Title.Text = title
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 14
        Title.TextXAlignment = Enum.TextXAlignment.Left

        local Container = Instance.new("ScrollingFrame")
        Container.Name = "Container"
        Container.Parent = MainFrame
        Container.BackgroundTransparency = 1
        Container.BorderSizePixel = 0
        Container.Position = UDim2.new(0, 5, 0, 35)
        Container.Size = UDim2.new(1, -10, 1, -40)
        Container.ScrollBarThickness = 2
        Container.CanvasSize = UDim2.new(0, 0, 0, 0)

        local Layout = Instance.new("UIListLayout")
        Layout.Parent = Container
        Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Layout.Padding = UDim.new(0, 5)

        Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Container.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
        end)

        local Elements = {}

        function Elements:CreateToggle(name, callback)
            local enabled = false
            local ToggleFrame = Instance.new("TextButton")
            ToggleFrame.Parent = Container
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
            ToggleFrame.Text = ""
            ToggleFrame.AutoButtonColor = false

            local Label = Instance.new("TextLabel")
            Label.Parent = ToggleFrame
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -50, 1, 0)
            Label.Font = Enum.Font.Gotham
            Label.Text = name
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Indicator = Instance.new("Frame")
            Indicator.Parent = ToggleFrame
            Indicator.AnchorPoint = Vector2.new(1, 0.5)
            Indicator.Position = UDim2.new(1, -10, 0.5, 0)
            Indicator.Size = UDim2.new(0, 20, 0, 20)
            Indicator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Indicator.BorderSizePixel = 0

            ToggleFrame.MouseButton1Click:Connect(function()
                enabled = not enabled
                TweenService:Create(Indicator, TweenInfo.new(0.3), {BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(40, 40, 40)}):Play()
                callback(enabled)
            end)
        end

        function Elements:CreateSlider(name, min, max, default, callback)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Parent = Container
            SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Size = UDim2.new(1, 0, 0, 50)

            local Label = Instance.new("TextLabel")
            Label.Parent = SliderFrame
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 5)
            Label.Size = UDim2.new(1, -20, 0, 20)
            Label.Font = Enum.Font.Gotham
            Label.Text = name .. ": " .. default
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local BarBG = Instance.new("Frame")
            BarBG.Parent = SliderFrame
            BarBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            BarBG.BorderSizePixel = 0
            BarBG.Position = UDim2.new(0, 10, 0, 30)
            BarBG.Size = UDim2.new(1, -20, 0, 10)

            local Fill = Instance.new("Frame")
            Fill.Parent = BarBG
            Fill.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            Fill.BorderSizePixel = 0
            Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)

            local function UpdateValue()
                local mousePos = UserInputService:GetMouseLocation().X
                local barPos = BarBG.AbsolutePosition.X
                local barSize = BarBG.AbsoluteSize.X
                local percent = math.clamp((mousePos - barPos) / barSize, 0, 1)
                local value = math.floor(min + (max - min) * percent)
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                Label.Text = name .. ": " .. value
                callback(value)
            end

            local dragging = false
            BarBG.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    UpdateValue()
                end
            end)
            Table_Insert_Service = {UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end),
            UserInputService.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then UpdateValue() end end)}
        end

        function Elements:CreateDropdown(name, list, callback)
            local current = list[1]
            local expanded = false
            local DropFrame = Instance.new("Frame")
            DropFrame.Parent = Container
            DropFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            DropFrame.BorderSizePixel = 0
            DropFrame.Size = UDim2.new(1, 0, 0, 35)
            DropFrame.ClipsDescendants = true

            local MainButton = Instance.new("TextButton")
            MainButton.Parent = DropFrame
            MainButton.BackgroundTransparency = 1
            MainButton.Size = UDim2.new(1, 0, 0, 35)
            MainButton.Text = ""
            
            local Label = Instance.new("TextLabel")
            Label.Parent = MainButton
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -20, 1, 0)
            Label.Font = Enum.Font.Gotham
            Label.Text = name .. ": " .. current
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local ItemHolder = Instance.new("Frame")
            ItemHolder.Parent = DropFrame
            ItemHolder.BackgroundTransparency = 1
            ItemHolder.Position = UDim2.new(0, 0, 0, 35)
            ItemHolder.Size = UDim2.new(1, 0, 0, #list * 30)

            for i, item in ipairs(list) do
                local ItemBtn = Instance.new("TextButton")
                ItemBtn.Parent = ItemHolder
                ItemBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
                ItemBtn.BorderSizePixel = 0
                ItemBtn.Position = UDim2.new(0, 5, 0, (i-1) * 30)
                ItemBtn.Size = UDim2.new(1, -10, 0, 25)
                ItemBtn.Font = Enum.Font.Gotham
                ItemBtn.Text = item
                ItemBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
                ItemBtn.TextSize = 12
                ItemBtn.MouseButton1Click:Connect(function()
                    current = item
                    Label.Text = name .. ": " .. current
                    expanded = false
                    TweenService:Create(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 35)}):Play()
                    callback(current)
                end)
            end

            MainButton.MouseButton1Click:Connect(function()
                expanded = not expanded
                local targetSize = expanded and 35 + (#list * 30) + 5 or 35
                TweenService:Create(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, targetSize)}):Play()
            end)
        end
        return Elements
    end
    return UI
end

-- ESP Manager Module
Modules.ESP = function()
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
            highlight.Parent = character
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            local billboard = Instance.new("BillboardGui")
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
            ESP.Objects[player] = {Highlight = highlight, Billboard = billboard, Label = label, Character = character}
        end
        if player.Character then SetupCharacter(player.Character) end
        player.CharacterAdded:Connect(SetupCharacter)
    end

    function ESP:Init()
        for _, player in ipairs(Players:GetPlayers()) do CreateESP(player) end
        Players.PlayerAdded:Connect(CreateESP)
        RunService.RenderStepped:Connect(function()
            if not ESP.Enabled then
                for _, obj in pairs(ESP.Objects) do obj.Highlight.Enabled = false; obj.Billboard.Enabled = false end
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
                        obj.Highlight.Enabled = true; obj.Billboard.Enabled = true
                        obj.Highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        obj.Label.Text = string.format("%s\n[%d studs]", player.Name, math.floor(distance))
                    else
                        obj.Highlight.Enabled = false; obj.Billboard.Enabled = false
                    end
                else
                    obj.Highlight.Enabled = false; obj.Billboard.Enabled = false
                end
            end
        end)
    end
    return ESP
end

-- Triggerbot Module
Modules.Triggerbot = function()
    local Triggerbot = {}
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    Triggerbot.Enabled = false
    Triggerbot.Mode = "Hold"
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
                if Triggerbot.TeamCheck and player.Team == LocalPlayer.Team then return false end
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then return true end
            end
            return false
        end
        UserInputService.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if input.KeyCode == Triggerbot.Keybind then
                if Triggerbot.Mode == "Hold" then active = true
                elseif Triggerbot.Mode == "Toggle" then active = not active end
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Triggerbot.Keybind and Triggerbot.Mode == "Hold" then active = false end
        end)
        RunService.RenderStepped:Connect(function()
            if not Triggerbot.Enabled then return end
            local isWorking = (Triggerbot.Mode == "Always") or active
            if isWorking and IsEnemy(Mouse.Target) then mouse1click() end
        end)
    end
    return Triggerbot
end

-- MAIN START
local UI = Modules.UI()
local ESP = Modules.ESP()
local Triggerbot = Modules.Triggerbot()

ESP:Init()
Triggerbot:Init()

local Window = UI:CreateWindow("ELITE SOVEREIGN | SNIPER DUELS")

-- Visuals
Window:CreateToggle("Enable ESP", function(state) ESP.Enabled = state end)
Window:CreateToggle("ESP Team Check", function(state) ESP.TeamCheck = state end)
Window:CreateSlider("Max ESP Distance", 0, 2000, 500, function(val) ESP.MaxDistance = val end)

-- Combat
Window:CreateToggle("Enable Triggerbot", function(state) Triggerbot.Enabled = state end)
Window:CreateToggle("Triggerbot Team Check", function(state) Triggerbot.TeamCheck = state end)
Window:CreateDropdown("Triggerbot Mode", {"Hold", "Toggle", "Always"}, function(mode)
    Triggerbot.Mode = mode
end)

print("Elite Sovereign Loaded | Bundled Version")
