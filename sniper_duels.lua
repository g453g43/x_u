-- x_u private | Sniper Duels
-- Engineered by x_u dev

local ENV = getgenv and getgenv() or _G
if ENV.XU_Private then ENV.XU_Private:Destroy() end

local XU = {
    Connections = {},
    Drawings = {},
    Instances = {},
    Settings = {
        Theme = { Accent = Color3.fromRGB(150, 0, 255) },
        Combat = {
            Aimbot = false,
            AimPart = "Head",
            Smoothing = 1,
            FOV = false,
            FOVSides = 30,
            FOVRadius = 100,
            FOVColor = Color3.fromRGB(255, 255, 255),
            WallCheck = true,
            Triggerbot = false,
            TriggerKey = "MouseButton2", -- Default
        },
        Visuals = {
            ESPEnabled = false,
            Boxes = false,
            Names = false,
            Distance = false,
            Health = false,
            Tracers = false,
            TracerOrigin = "Bottom",
            Chams = false,
            ChamsFill = Color3.fromRGB(255, 0, 0),
            ChamsOutline = Color3.fromRGB(255, 255, 255),
            TeamCheck = true,
            MaxDistance = 2000,
        },
        Misc = {
            AutoBhop = false,
            InfJump = false
        }
    }
}
ENV.XU_Private = XU

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()

function XU:Destroy()
    for _, c in pairs(self.Connections) do c:Disconnect() end
    for _, d in pairs(self.Drawings) do d:Remove() end
    for _, i in pairs(self.Instances) do i:Destroy() end
    self.Connections = {}
    self.Drawings = {}
    self.Instances = {}
end

--=========================================
-- PREMIUM GLASSMORPHISM UI LIBRARY
--=========================================
local UI = {}
function UI.Create(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "xu_private"
    
    -- Stream Proofing (Roblox GUI Hiding)
    local guiParent = nil
    if gethui then
        guiParent = gethui()
    elseif syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        guiParent = game:GetService("CoreGui")
    else
        guiParent = game:GetService("CoreGui")
    end
    ScreenGui.Parent = guiParent
    table.insert(XU.Instances, ScreenGui)

    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 650, 0, 450)
    MainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0

    local UICorner = Instance.new("UICorner", MainFrame)
    UICorner.CornerRadius = UDim.new(0, 8)

    local UIStroke = Instance.new("UIStroke", MainFrame)
    UIStroke.Color = Color3.fromRGB(255, 255, 255)
    UIStroke.Transparency = 0.8
    UIStroke.Thickness = 1

    local Shadow = Instance.new("ImageLabel", MainFrame)
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://6015895133"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.4
    Shadow.ZIndex = -1
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(10, 10, 118, 118)

    local dragging, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            TweenService:Create(MainFrame, TweenInfo.new(0.1), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play()
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    local Header = Instance.new("Frame", MainFrame)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    
    local AccentLine = Instance.new("Frame", Header)
    AccentLine.Size = UDim2.new(1, 0, 0, 2)
    AccentLine.BackgroundColor3 = XU.Settings.Theme.Accent
    AccentLine.BorderSizePixel = 0
    Instance.new("UICorner", AccentLine).CornerRadius = UDim.new(0, 8)
    
    local TitleLabel = Instance.new("TextLabel", Header)
    TitleLabel.Size = UDim2.new(1, -20, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Enum.Font.GothamBlack
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    TitleLabel.TextSize = 16
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TabContainer = Instance.new("Frame", MainFrame)
    TabContainer.Size = UDim2.new(0, 150, 1, -40)
    TabContainer.Position = UDim2.new(0, 0, 0, 40)
    TabContainer.BackgroundTransparency = 1
    local TabList = Instance.new("UIListLayout", TabContainer)
    TabList.Padding = UDim.new(0, 5); TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local ContentContainer = Instance.new("Frame", MainFrame)
    ContentContainer.Size = UDim2.new(1, -160, 1, -50)
    ContentContainer.Position = UDim2.new(0, 150, 0, 40)
    ContentContainer.BackgroundTransparency = 1

    local Divider = Instance.new("Frame", MainFrame)
    Divider.Size = UDim2.new(0, 1, 1, -40)
    Divider.Position = UDim2.new(0, 149, 0, 40)
    Divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Divider.BackgroundTransparency = 0.9

    local WindowObj = { CurrentTab = nil, Tabs = {} }

    function WindowObj:CreateTab(name)
        local TabBtn = Instance.new("TextButton", TabContainer)
        TabBtn.Size = UDim2.new(0, 130, 0, 35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = name
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabBtn.TextSize = 14
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)

        local TabContent = Instance.new("ScrollingFrame", ContentContainer)
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.ScrollBarThickness = 2
        TabContent.Visible = false
        local ContentList = Instance.new("UIListLayout", TabContent)
        ContentList.Padding = UDim.new(0, 10); ContentList.SortOrder = Enum.SortOrder.LayoutOrder
        ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 20)
        end)

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(WindowObj.Tabs) do
                TweenService:Create(t.Btn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150), BackgroundTransparency = 1}):Play()
                t.Content.Visible = false
            end
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.95}):Play()
            TabContent.Visible = true
        end)

        if not WindowObj.CurrentTab then
            TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabBtn.BackgroundTransparency = 0.95
            TabContent.Visible = true
            WindowObj.CurrentTab = name
        end

        local TabObj = { Btn = TabBtn, Content = TabContent }
        table.insert(WindowObj.Tabs, TabObj)

        function TabObj:CreateToggle(text, dt, callback)
            local Frame = Instance.new("Frame", TabContent)
            Frame.Size = UDim2.new(1, -20, 0, 40)
            Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            Frame.BackgroundTransparency = 0.5
            Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel", Frame)
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Position = UDim2.new(0, 15, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.Font = Enum.Font.GothamMedium
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Switch = Instance.new("TextButton", Frame)
            Switch.Size = UDim2.new(0, 40, 0, 20)
            Switch.AnchorPoint = Vector2.new(1, 0.5)
            Switch.Position = UDim2.new(1, -15, 0.5, 0)
            Switch.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Switch.Text = ""
            Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

            local Dot = Instance.new("Frame", Switch)
            Dot.Size = UDim2.new(0, 16, 0, 16)
            Dot.Position = UDim2.new(0, 2, 0.5, -8)
            Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

            local toggled = dt
            if toggled then
                Switch.BackgroundColor3 = XU.Settings.Theme.Accent
                Dot.Position = UDim2.new(1, -18, 0.5, -8)
            end

            Switch.MouseButton1Click:Connect(function()
                toggled = not toggled
                TweenService:Create(Switch, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {BackgroundColor3 = toggled and XU.Settings.Theme.Accent or Color3.fromRGB(50, 50, 50)}):Play()
                TweenService:Create(Dot, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Position = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
                callback(toggled)
            end)
        end

        function TabObj:CreateSlider(text, min, max, dt, callback)
            local Frame = Instance.new("Frame", TabContent)
            Frame.Size = UDim2.new(1, -20, 0, 50)
            Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            Frame.BackgroundTransparency = 0.5
            Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel", Frame)
            Label.Size = UDim2.new(1, -20, 0, 25)
            Label.Position = UDim2.new(0, 15, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.Font = Enum.Font.GothamMedium
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local ValueLabel = Instance.new("TextLabel", Frame)
            ValueLabel.Size = UDim2.new(0, 50, 0, 25)
            ValueLabel.AnchorPoint = Vector2.new(1, 0)
            ValueLabel.Position = UDim2.new(1, -15, 0, 0)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(dt)
            ValueLabel.Font = Enum.Font.GothamBold
            ValueLabel.TextColor3 = XU.Settings.Theme.Accent
            ValueLabel.TextSize = 13
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

            local Bar = Instance.new("TextButton", Frame)
            Bar.Size = UDim2.new(1, -30, 0, 4)
            Bar.Position = UDim2.new(0, 15, 0, 35)
            Bar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Bar.Text = ""
            Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame", Bar)
            Fill.Size = UDim2.new((dt - min) / (max - min), 0, 1, 0)
            Fill.BackgroundColor3 = XU.Settings.Theme.Accent
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

            local isDragging = false
            local function Update(input)
                local pos = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + ((max - min) * pos))
                TweenService:Create(Fill, TweenInfo.new(0.1), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
                ValueLabel.Text = tostring(value)
                callback(value)
            end

            Bar.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = true; Update(input) end end)
            UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false end end)
            UserInputService.InputChanged:Connect(function(input) if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then Update(input) end end)
        end

        function TabObj:CreateDropdown(text, options, dt, callback)
            local current = dt
            local expanded = false
            
            local Frame = Instance.new("Frame", TabContent)
            Frame.Size = UDim2.new(1, -20, 0, 40)
            Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            Frame.BackgroundTransparency = 0.5
            Frame.ClipsDescendants = true
            Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)
            
            local MainBtn = Instance.new("TextButton", Frame)
            MainBtn.Size = UDim2.new(1, 0, 0, 40)
            MainBtn.BackgroundTransparency = 1
            MainBtn.Text = ""

            local Label = Instance.new("TextLabel", MainBtn)
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Position = UDim2.new(0, 15, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = text .. ": " .. current
            Label.Font = Enum.Font.GothamMedium
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Arrow = Instance.new("TextLabel", MainBtn)
            Arrow.Size = UDim2.new(0, 20, 0, 20)
            Arrow.AnchorPoint = Vector2.new(1, 0.5)
            Arrow.Position = UDim2.new(1, -15, 0.5, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "v"
            Arrow.Font = Enum.Font.GothamBold
            Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)

            local ItemList = Instance.new("Frame", Frame)
            ItemList.Size = UDim2.new(1, 0, 0, #options * 30)
            ItemList.Position = UDim2.new(0, 0, 0, 40)
            ItemList.BackgroundTransparency = 1

            for i, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton", ItemList)
                OptBtn.Size = UDim2.new(1, -30, 0, 26)
                OptBtn.Position = UDim2.new(0, 15, 0, (i-1)*30 + 2)
                OptBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                OptBtn.Text = opt
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                OptBtn.TextSize = 12
                Instance.new("UICorner", OptBtn).CornerRadius = UDim.new(0, 4)

                OptBtn.MouseButton1Click:Connect(function()
                    current = opt; Label.Text = text .. ": " .. current
                    expanded = false
                    TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(1, -20, 0, 40)}):Play()
                    TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
                    callback(current)
                end)
            end

            MainBtn.MouseButton1Click:Connect(function()
                expanded = not expanded
                local h = expanded and 45 + (#options * 30) or 40
                TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(1, -20, 0, h)}):Play()
                TweenService:Create(Arrow, TweenInfo.new(0.3), {Rotation = expanded and 180 or 0}):Play()
            end)
        end
        
        function TabObj:CreateButton(text, callback)
            local Frame = Instance.new("Frame", TabContent)
            Frame.Size = UDim2.new(1, -20, 0, 40)
            Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            Frame.BackgroundTransparency = 0.5
            Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

            local Btn = Instance.new("TextButton", Frame)
            Btn.Size = UDim2.new(1, 0, 1, 0)
            Btn.BackgroundTransparency = 1
            Btn.Text = text
            Btn.Font = Enum.Font.GothamMedium
            Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
            Btn.TextSize = 13

            Btn.MouseButton1Click:Connect(callback)
            
            Btn.MouseEnter:Connect(function() TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play() end)
            Btn.MouseLeave:Connect(function() TweenService:Create(Frame, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 35)}):Play() end)
        end

        return TabObj
    end

    local userInputConn = UserInputService.InputBegan:Connect(function(i,gpe)
        if not gpe and i.KeyCode == Enum.KeyCode.RightShift then MainFrame.Visible = not MainFrame.Visible end
    end)
    table.insert(XU.Connections, userInputConn)

    return WindowObj
end

--=========================================
-- MODULES (ESP, COMBAT, MISC)
--=========================================

local function CreateDraw(class, props)
    local obj = Drawing.new(class)
    for i, v in pairs(props) do obj[i] = v end
    table.insert(XU.Drawings, obj)
    return obj
end

-- Robust Team Check
local function IsEnemy(p)
    if p == LP then return false end
    if XU.Settings.Visuals.TeamCheck then
        -- Check both Team object and TeamColor for wide compatibility across Roblox games
        if p.Team and LP.Team and p.Team == LP.Team then return false end
        if p.TeamColor and LP.TeamColor and p.TeamColor == LP.TeamColor then return false end
    end
    return true
end

-- FOV Circle
local FOVCircle = CreateDraw("Circle", {
    Thickness = 1, Color = XU.Settings.Combat.FOVColor, Filled = false,
    NumSides = XU.Settings.Combat.FOVSides, Radius = XU.Settings.Combat.FOVRadius, Visible = false
})

local function GetClosestPlayer()
    local target, minDist = nil, XU.Settings.Combat.FOV and XU.Settings.Combat.FOVRadius or math.huge
    for _, p in ipairs(Players:GetPlayers()) do
        if IsEnemy(p) and p.Character and p.Character:FindFirstChild(XU.Settings.Combat.AimPart) then
            local part = p.Character[XU.Settings.Combat.AimPart]
            local pos, vis = Camera:WorldToViewportPoint(part.Position)
            if vis then
                if XU.Settings.Combat.WallCheck then
                    local rayParams = RaycastParams.new()
                    rayParams.FilterDescendantsInstances = {LP.Character, Camera}
                    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                    local ray = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000, rayParams)
                    if ray and not ray.Instance:IsDescendantOf(p.Character) then continue end
                end

                local dist = (Vector2.new(pos.X, pos.Y) - UserInputService:GetMouseLocation()).Magnitude
                if dist < minDist then minDist = dist; target = p.Character end
            end
        end
    end
    return target
end

local function IsTriggerKeyHeld()
    local keyName = XU.Settings.Combat.TriggerKey
    local inputEnum = Enum.UserInputType[keyName]
    if inputEnum then
        for _, obj in ipairs(UserInputService:GetMouseButtonsPressed()) do
            if obj.UserInputType == inputEnum then return true end
        end
    end
    
    local keyEnum = Enum.KeyCode[keyName]
    if keyEnum then
        return UserInputService:IsKeyDown(keyEnum)
    end
    return false
end

-- Core Render Loop
local RSConnect = RunService.RenderStepped:Connect(function()
    FOVCircle.Visible = XU.Settings.Combat.FOV
    FOVCircle.Position = UserInputService:GetMouseLocation()
    FOVCircle.Radius = XU.Settings.Combat.FOVRadius
    FOVCircle.Color = XU.Settings.Combat.FOVColor

    -- Aimbot
    if XU.Settings.Combat.Aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local tgt = GetClosestPlayer()
        if tgt and tgt:FindFirstChild(XU.Settings.Combat.AimPart) then
            local tPos = tgt[XU.Settings.Combat.AimPart].Position
            local aimPos = Camera:WorldToViewportPoint(tPos)
            local mouseLoc = UserInputService:GetMouseLocation()
            
            local smooth = XU.Settings.Combat.Smoothing
            mousemoverel((aimPos.X - mouseLoc.X) / smooth, (aimPos.Y - mouseLoc.Y) / smooth)
        end
    end

    -- Triggerbot
    if XU.Settings.Combat.Triggerbot and IsTriggerKeyHeld() then
        local t = Mouse.Target
        if t and t:IsDescendantOf(workspace) then
            local char = t:FindFirstAncestorOfClass("Model")
            local p = char and Players:GetPlayerFromCharacter(char)
            if p and IsEnemy(p) then mouse1click() end
        end
    end

    if XU.Settings.Misc.AutoBhop and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Jump = true end
    end
end)
table.insert(XU.Connections, RSConnect)

-- Chams Loop
local function MaintainPlayers()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local hl = p.Character:FindFirstChild("x_u_chams")
            if XU.Settings.Visuals.ESPEnabled and XU.Settings.Visuals.Chams and IsEnemy(p) then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.Name = "x_u_chams"
                    hl.Parent = p.Character
                    table.insert(XU.Instances, hl)
                end
                hl.FillColor = XU.Settings.Visuals.ChamsFill
                hl.OutlineColor = XU.Settings.Visuals.ChamsOutline
                hl.FillTransparency = 0.4
                hl.OutlineTransparency = 0
            elseif hl then hl:Destroy() end
        end
    end
end
table.insert(XU.Connections, RunService.Heartbeat:Connect(MaintainPlayers))

-- Drawing ESP
local ESPObjects = {}
local function CreateDrawingESP(p)
    ESPObjects[p] = {
        Box = CreateDraw("Square", {Thickness = 1, Filled = false, Color = Color3.fromRGB(255, 255, 255)}),
        Name = CreateDraw("Text", {Size = 14, Center = true, Outline = true, Color = Color3.fromRGB(255, 255, 255)}),
        Dist = CreateDraw("Text", {Size = 13, Center = true, Outline = true, Color = Color3.fromRGB(200, 200, 200)}),
        HealthBarBg = CreateDraw("Square", {Thickness = 1, Filled = true, Color = Color3.fromRGB(0, 0, 0)}),
        HealthBar = CreateDraw("Square", {Thickness = 1, Filled = true, Color = Color3.fromRGB(0, 255, 0)}),
        Tracer = CreateDraw("Line", {Thickness = 1, Color = Color3.fromRGB(255, 255, 255)})
    }
end

for _, p in ipairs(Players:GetPlayers()) do if p ~= LP then CreateDrawingESP(p) end end
table.insert(XU.Connections, Players.PlayerAdded:Connect(function(p) CreateDrawingESP(p) end))
table.insert(XU.Connections, Players.PlayerRemoving:Connect(function(p)
    if ESPObjects[p] then
        for _, draw in pairs(ESPObjects[p]) do draw:Remove() end
        ESPObjects[p] = nil
    end
end))

table.insert(XU.Connections, RunService.RenderStepped:Connect(function()
    for p, objs in pairs(ESPObjects) do
        local vis = false
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChildOfClass("Humanoid") and XU.Settings.Visuals.ESPEnabled and IsEnemy(p) then
            local hrp = p.Character.HumanoidRootPart
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            if hum.Health > 0 and (hrp.Position - Camera.CFrame.Position).Magnitude <= XU.Settings.Visuals.MaxDistance then
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    vis = true
                    local top, _ = Camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, 3, 0)).Position)
                    local bot, _ = Camera:WorldToViewportPoint((hrp.CFrame * CFrame.new(0, -3, 0)).Position)
                    local h = bot.Y - top.Y
                    local w = h / 2
                    
                    if XU.Settings.Visuals.Boxes then
                        objs.Box.Visible = true; objs.Box.Size = Vector2.new(w, h); objs.Box.Position = Vector2.new(pos.X - w/2, top.Y)
                    else objs.Box.Visible = false end

                    if XU.Settings.Visuals.Names then
                        objs.Name.Visible = true; objs.Name.Position = Vector2.new(pos.X, top.Y - 16); objs.Name.Text = p.Name
                    else objs.Name.Visible = false end

                    if XU.Settings.Visuals.Distance then
                        objs.Dist.Visible = true; objs.Dist.Position = Vector2.new(pos.X, bot.Y + 2); objs.Dist.Text = math.floor((hrp.Position - Camera.CFrame.Position).Magnitude) .. "m"
                    else objs.Dist.Visible = false end

                    if XU.Settings.Visuals.Health then
                        local hpPct = hum.Health / hum.MaxHealth
                        objs.HealthBarBg.Visible = true; objs.HealthBar.Visible = true
                        objs.HealthBarBg.Size = Vector2.new(3, h); objs.HealthBarBg.Position = Vector2.new(pos.X - w/2 - 5, top.Y)
                        objs.HealthBar.Size = Vector2.new(1, h * hpPct); objs.HealthBar.Position = Vector2.new(pos.X - w/2 - 4, bot.Y - (h * hpPct))
                        objs.HealthBar.Color = Color3.fromHSV(hpPct * 0.3, 1, 1)
                    else objs.HealthBarBg.Visible = false; objs.HealthBar.Visible = false end

                    if XU.Settings.Visuals.Tracers then
                        objs.Tracer.Visible = true
                        objs.Tracer.To = Vector2.new(pos.X, bot.Y)
                        if XU.Settings.Visuals.TracerOrigin == "Mouse" then
                            objs.Tracer.From = UserInputService:GetMouseLocation()
                        else
                            objs.Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                        end
                    else objs.Tracer.Visible = false end
                end
            end
        end

        if not vis then
            for _, draw in pairs(objs) do draw.Visible = false end
        end
    end
end))

local JumpConn = game:GetService("UserInputService").JumpRequest:Connect(function()
    if XU.Settings.Misc.InfJump and LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") then
        LP.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)
table.insert(XU.Connections, JumpConn)

--=========================================
-- BUILD INTERFACE
--=========================================
local Win = UI.Create("x_u private")

local TabCombat = Win:CreateTab("COMBAT")
TabCombat:CreateToggle("Enable Aimbot (Right Click)", XU.Settings.Combat.Aimbot, function(s) XU.Settings.Combat.Aimbot = s end)
TabCombat:CreateDropdown("Aim Part", {"Head", "HumanoidRootPart", "Torso"}, XU.Settings.Combat.AimPart, function(s) XU.Settings.Combat.AimPart = s end)
TabCombat:CreateSlider("Smoothing (1 = Instant)", 1, 20, XU.Settings.Combat.Smoothing, function(s) XU.Settings.Combat.Smoothing = s end)
TabCombat:CreateToggle("Wall Check", XU.Settings.Combat.WallCheck, function(s) XU.Settings.Combat.WallCheck = s end)
TabCombat:CreateToggle("Show FOV Circle", XU.Settings.Combat.FOV, function(s) XU.Settings.Combat.FOV = s end)
TabCombat:CreateSlider("FOV Radius", 10, 500, XU.Settings.Combat.FOVRadius, function(s) XU.Settings.Combat.FOVRadius = s end)
TabCombat:CreateToggle("Triggerbot", XU.Settings.Combat.Triggerbot, function(s) XU.Settings.Combat.Triggerbot = s end)
TabCombat:CreateDropdown("Trigger Key", {"MouseButton2", "MouseButton1", "V", "E", "C", "F"}, XU.Settings.Combat.TriggerKey, function(s) XU.Settings.Combat.TriggerKey = s end)

local TabESP = Win:CreateTab("VISUALS")
TabESP:CreateToggle("Enable ESP Master", XU.Settings.Visuals.ESPEnabled, function(s) XU.Settings.Visuals.ESPEnabled = s end)
TabESP:CreateToggle("Draw Boxes", XU.Settings.Visuals.Boxes, function(s) XU.Settings.Visuals.Boxes = s end)
TabESP:CreateToggle("Player Names", XU.Settings.Visuals.Names, function(s) XU.Settings.Visuals.Names = s end)
TabESP:CreateToggle("Show Distance", XU.Settings.Visuals.Distance, function(s) XU.Settings.Visuals.Distance = s end)
TabESP:CreateToggle("Health Bars", XU.Settings.Visuals.Health, function(s) XU.Settings.Visuals.Health = s end)
TabESP:CreateToggle("Tracers", XU.Settings.Visuals.Tracers, function(s) XU.Settings.Visuals.Tracers = s end)
TabESP:CreateDropdown("Tracer Origin", {"Bottom", "Mouse"}, XU.Settings.Visuals.TracerOrigin, function(s) XU.Settings.Visuals.TracerOrigin = s end)
TabESP:CreateToggle("Chams (Glow)", XU.Settings.Visuals.Chams, function(s) XU.Settings.Visuals.Chams = s end)
TabESP:CreateToggle("Team Check", XU.Settings.Visuals.TeamCheck, function(s) XU.Settings.Visuals.TeamCheck = s end)
TabESP:CreateSlider("Max Draw Distance", 100, 5000, XU.Settings.Visuals.MaxDistance, function(s) XU.Settings.Visuals.MaxDistance = s end)

local TabMisc = Win:CreateTab("SETTINGS")
TabMisc:CreateToggle("Auto Bunny-Hop", XU.Settings.Misc.AutoBhop, function(s) XU.Settings.Misc.AutoBhop = s end)
TabMisc:CreateToggle("Infinite Jump", XU.Settings.Misc.InfJump, function(s) XU.Settings.Misc.InfJump = s end)
TabMisc:CreateButton("Unload Script", function()
    XU:Destroy()
end)

print("x_u private loaded successfully.")
