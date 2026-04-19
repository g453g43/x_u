-- x_u v18 (Safe Masking Edition)
local success, err = pcall(function()
print("--- x_u v18 (STABLE) Initializing ---")

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

-- // Obfuscated Keys
local k1 = {73, 104, 97, 116, 101, 121, 111, 117, 115, 111, 109, 117, 99, 104, 110, 101, 118, 101, 114, 116, 97, 108, 107, 116, 111, 109, 101}
local k2 = {118, 105, 118, 105, 100, 50, 48, 50, 54}

local function Validate(input)
    local function check(arr)
        if #input ~= #arr then return false end
        for i=1,#input do if string.byte(input, i) ~= arr[i] then return false end end
        return true
    end
    if check(k1) then return "vin" end
    if check(k2) then return "vivid" end
    return nil
end

local Theme = {
    BG = Color3.fromRGB(0, 0, 0), Line = Color3.fromRGB(35, 35, 40), Accent = Color3.fromRGB(157, 107, 255),
    Text = Color3.fromRGB(250, 250, 250), TextDark = Color3.fromRGB(120, 120, 130), Btn = Color3.fromRGB(20, 20, 24)
}

local UI = Instance.new("ScreenGui")
UI.Name = tostring(math.random(1e5, 1e6)); UI.ZIndexBehavior = Enum.ZIndexBehavior.Global; UI.ResetOnSpawn = false
pcall(function()
    if gethui then UI.Parent = gethui() elseif game:GetService("CoreGui") then UI.Parent = game:GetService("CoreGui") else UI.Parent = LP:WaitForChild("PlayerGui") end
end)

-- // AUTH UI
local AuthMain = Instance.new("Frame", UI)
AuthMain.Size = UDim2.new(0, 300, 0, 180); AuthMain.Position = UDim2.new(0.5, -150, 0.5, -90)
AuthMain.BackgroundColor3 = Theme.BG; AuthMain.BorderSizePixel = 0; AuthMain.Active = true
Instance.new("UICorner", AuthMain).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", AuthMain).Color = Theme.Line

local AuthTitle = Instance.new("TextLabel", AuthMain); AuthTitle.Size = UDim2.new(1, 0, 0, 40); AuthTitle.BackgroundTransparency = 1
AuthTitle.Text = "PRIVATE ACCESS"; AuthTitle.Font = Enum.Font.GothamBold; AuthTitle.TextSize = 16; AuthTitle.TextColor3 = Theme.Accent
Instance.new("Frame", AuthMain).Size = UDim2.new(1, 0, 0, 1); AuthMain.Frame.Position = UDim2.new(0, 0, 0, 40); AuthMain.Frame.BackgroundColor3 = Theme.Line; AuthMain.Frame.BorderSizePixel = 0

-- Masking Setup (Crash-Proof)
local InputContainer = Instance.new("Frame", AuthMain)
InputContainer.Size = UDim2.new(1, -40, 0, 35); InputContainer.Position = UDim2.new(0, 20, 0, 65)
InputContainer.BackgroundColor3 = Theme.Btn
Instance.new("UICorner", InputContainer).CornerRadius = UDim.new(0, 4)

-- The Fake Label (Shows Asterisks)
local FakeLabel = Instance.new("TextLabel", InputContainer)
FakeLabel.Size = UDim2.new(1, -10, 1, 0); FakeLabel.Position = UDim2.new(0, 5, 0, 0)
FakeLabel.BackgroundTransparency = 1; FakeLabel.Text = ""; FakeLabel.TextColor3 = Theme.Text
FakeLabel.Font = Enum.Font.Gotham; FakeLabel.TextSize = 13; FakeLabel.TextXAlignment = Enum.TextXAlignment.Left

-- The Real Input (Invisible Text)
local KeyInput = Instance.new("TextBox", InputContainer)
KeyInput.Size = UDim2.new(1, -10, 1, 0); KeyInput.Position = UDim2.new(0, 5, 0, 0)
KeyInput.BackgroundTransparency = 1; KeyInput.Text = ""; KeyInput.PlaceholderText = "Enter Key..."
KeyInput.TextColor3 = Theme.Text; KeyInput.TextTransparency = 1 -- Hide the real text!
KeyInput.Font = Enum.Font.Gotham; KeyInput.TextSize = 13; KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false; KeyInput.ZIndex = 2

KeyInput:GetPropertyChangedSignal("Text"):Connect(function()
    FakeLabel.Text = string.rep("*", #KeyInput.Text)
    if #KeyInput.Text == 0 then
        FakeLabel.Text = ""
        KeyInput.PlaceholderText = "Enter Key..."
    else
        KeyInput.PlaceholderText = ""
    end
end)

local AuthBtn = Instance.new("TextButton", AuthMain)
AuthBtn.Size = UDim2.new(1, -40, 0, 35); AuthBtn.Position = UDim2.new(0, 20, 0, 115)
AuthBtn.BackgroundColor3 = Theme.Line; AuthBtn.Text = "Login"; AuthBtn.TextColor3 = Theme.Text; AuthBtn.Font = Enum.Font.GothamMedium; AuthBtn.TextSize = 14
Instance.new("UICorner", AuthBtn).CornerRadius = UDim.new(0, 4)

-- // MAIN CHEAT UI (v15 Base)
local Main = Instance.new("Frame", UI)
Main.Size = UDim2.new(0, 600, 0, 450); Main.Position = UDim2.new(0.5, -300, 0.5, -225)
Main.BackgroundColor3 = Theme.BG; Main.BorderSizePixel = 0; Main.Active = true; Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", Main).Color = Theme.Line

local function make_draggable(frame)
    local dragging, start_pos, start_mouse
    frame.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; start_mouse = input.Position; start_pos = frame.Position end end)
    UIS.InputChanged:Connect(function(input) if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then frame.Position = UDim2.new(start_pos.X.Scale, start_pos.X.Offset + (input.Position.X - start_mouse.X), start_pos.Y.Scale, start_pos.Y.Offset + (input.Position.Y - start_mouse.Y)) end end)
    frame.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
end
make_draggable(Main); make_draggable(AuthMain)

local IsAuthenticated = false
AuthBtn.MouseButton1Click:Connect(function()
    local user = Validate(KeyInput.Text)
    if user then
        IsAuthenticated = true
        InputContainer.Visible = false -- Hide the input bar
        for i = 1, 4 do
            AuthBtn.Text = "Welcome " .. user .. string.rep(".", i % 4)
            task.wait(0.35)
        end
        AuthMain:Destroy(); Main.Visible = true
    else
        KeyInput.Text = ""; FakeLabel.Text = ""; KeyInput.PlaceholderText = "Invalid Key!"; task.wait(1.5); KeyInput.PlaceholderText = "Enter Key..."
    end
end)

-- (Rest of the script follows v15 logic exactly)
local Config = { ToggleKey = Enum.KeyCode.RightControl, SilentAim = false, HardLock = false, Prediction = 0.165, Smoothing = 0.5, TargetPart = "Head", ESPEnabled = false, ESPBoxes = false, ESPNames = false, ShowFOV = false, FOVRadius = 100, SpeedEnabled = false, SpeedValue = 50, SpeedKey = Enum.KeyCode.V, FlyEnabled = false, FlySpeed = 50, FlyKey = Enum.KeyCode.X, VoidHide = false, RapidFire = false }
local Title = Instance.new("TextLabel", Main); Title.Size = UDim2.new(0, 150, 0, 50); Title.Position = UDim2.new(0, 20, 0, 0); Title.BackgroundTransparency = 1; Title.Text = "x_u private"; Title.Font = Enum.Font.GothamBold; Title.TextSize = 20; Title.TextColor3 = Theme.Accent; Title.TextXAlignment = Enum.TextXAlignment.Left
local F1 = Instance.new("Frame", Main); F1.Size = UDim2.new(1, 0, 0, 1); F1.Position = UDim2.new(0, 0, 0, 50); F1.BackgroundColor3 = Theme.Line; F1.BorderSizePixel = 0
local F2 = Instance.new("Frame", Main); F2.Size = UDim2.new(0, 1, 1, -50); F2.Position = UDim2.new(0, 140, 0, 50); F2.BackgroundColor3 = Theme.Line; F2.BorderSizePixel = 0
local TopTabCont = Instance.new("Frame", Main); TopTabCont.Size = UDim2.new(0, 400, 0, 50); TopTabCont.Position = UDim2.new(0, 160, 0, 0); TopTabCont.BackgroundTransparency = 1; Instance.new("UIListLayout", TopTabCont).FillDirection = Enum.FillDirection.Horizontal; TopTabCont.UIListLayout.Padding = UDim.new(0, 15); TopTabCont.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
local SideTabCont = Instance.new("Frame", Main); SideTabCont.Size = UDim2.new(0, 140, 1, -50); SideTabCont.Position = UDim2.new(0, 0, 0, 50); SideTabCont.BackgroundTransparency = 1; Instance.new("UIListLayout", SideTabCont).Padding = UDim.new(0, 2); SideTabCont.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local ContentCont = Instance.new("Frame", Main); ContentCont.Size = UDim2.new(1, -140, 1, -50); ContentCont.Position = UDim2.new(0, 140, 0, 50); ContentCont.BackgroundTransparency = 1
local Tabs = {}
local function SelectTab(topName, sideName) pcall(function() for _, t in pairs(Tabs) do t.SideCont.Visible = false; t.TopBtn.TextColor3 = Theme.TextDark; if t.TopBtn:FindFirstChild("Line") then t.TopBtn.Line.Visible = false end; for _, s in pairs(t.Sides) do s.Page.Visible = false; s.Btn.TextColor3 = Theme.TextDark; if s.Btn:FindFirstChild("Line") then s.Btn.Line.Visible = false end end end; local top = Tabs[topName]; top.TopBtn.TextColor3 = Theme.Text; if top.TopBtn:FindFirstChild("Line") then top.TopBtn.Line.Visible = true end; top.SideCont.Visible = true; local side = top.Sides[sideName]; side.Btn.TextColor3 = Theme.Text; if side.Btn:FindFirstChild("Line") then side.Btn.Line.Visible = true end; side.Page.Visible = true end) end
local function CreateTopTab(name) local Btn = Instance.new("TextButton", TopTabCont); Btn.Size = UDim2.new(0, 70, 0, 50); Btn.BackgroundTransparency = 1; Btn.Text = name; Btn.Font = Enum.Font.GothamMedium; Btn.TextSize = 13; Btn.TextColor3 = Theme.TextDark; local Line = Instance.new("Frame", Btn); Line.Name = "Line"; Line.Size = UDim2.new(1, 0, 0, 2); Line.Position = UDim2.new(0, 0, 1, -2); Line.BackgroundColor3 = Theme.Accent; Line.BorderSizePixel = 0; Line.Visible = false; local SCont = Instance.new("Frame", SideTabCont); SCont.Size = UDim2.new(1, 0, 1, 0); SCont.BackgroundTransparency = 1; SCont.Visible = false; Instance.new("UIListLayout", SCont).Padding = UDim.new(0, 2); SCont.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; Tabs[name] = { TopBtn = Btn, Sides = {}, SideCont = SCont }; Btn.MouseButton1Click:Connect(function() local f = next(Tabs[name].Sides) if f then SelectTab(name, f) end end); return name end
local function CreateSideTab(topName, name) local Btn = Instance.new("TextButton", Tabs[topName].SideCont); Btn.Size = UDim2.new(1, -15, 0, 35); Btn.BackgroundTransparency = 1; Btn.Text = "  " .. name; Btn.Font = Enum.Font.Gotham; Btn.TextSize = 13; Btn.TextColor3 = Theme.TextDark; Btn.TextXAlignment = Enum.TextXAlignment.Left; local Line = Instance.new("Frame", Btn); Line.Name = "Line"; Line.Size = UDim2.new(0, 3, 1, -12); Line.Position = UDim2.new(0, 0, 0, 6); Line.BackgroundColor3 = Theme.Accent; Line.BorderSizePixel = 0; Line.Visible = false; local Page = Instance.new("Frame", ContentCont); Page.Size = UDim2.new(1, -40, 1, -40); Page.Position = UDim2.new(0, 20, 0, 20); Page.BackgroundTransparency = 1; Page.Visible = false; Instance.new("UIListLayout", Page).Padding = UDim.new(0, 12); Tabs[topName].Sides[name] = { Btn = Btn, Page = Page }; Btn.MouseButton1Click:Connect(function() SelectTab(topName, name) end); return Page end
local function AddToggle(parent, text, default, callback) local Frame = Instance.new("TextButton", parent); Frame.Size = UDim2.new(1, 0, 0, 25); Frame.BackgroundTransparency = 1; Frame.Text = ""; local L = Instance.new("TextLabel", Frame); L.Text = text; L.Font = Enum.Font.Gotham; L.TextColor3 = Theme.Text; L.TextSize = 13; L.Size = UDim2.new(1, -45, 1, 0); L.BackgroundTransparency = 1; L.TextXAlignment = Enum.TextXAlignment.Left; local BG = Instance.new("Frame", Frame); BG.Size = UDim2.new(0, 32, 0, 16); BG.Position = UDim2.new(1, -32, 0.5, -8); BG.BackgroundColor3 = default and Theme.Accent or Theme.Btn; Instance.new("UICorner", BG).CornerRadius = UDim.new(1,0); local Knob = Instance.new("Frame", BG); Knob.Size = UDim2.new(0, 12, 0, 12); Knob.Position = default and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6); Knob.BackgroundColor3 = Color3.fromRGB(245,245,255); Instance.new("UICorner", Knob).CornerRadius = UDim.new(1,0); local s = default; Frame.MouseButton1Click:Connect(function() pcall(function() s = not s; TS:Create(BG, TweenInfo.new(0.2), {BackgroundColor3 = s and Theme.Accent or Theme.Btn}):Play(); TS:Create(Knob, TweenInfo.new(0.2), {Position = s and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6)}):Play(); callback(s) end) end) end
local function AddSlider(parent, text, default, min, max, callback) local F = Instance.new("Frame", parent); F.Size = UDim2.new(1, 0, 0, 30); F.BackgroundTransparency = 1; local L = Instance.new("TextLabel", F); L.Text = text; L.Font = Enum.Font.Gotham; L.TextColor3 = Theme.Text; L.TextSize = 12; L.Size = UDim2.new(1, 0, 0, 12); L.BackgroundTransparency = 1; L.TextXAlignment = Enum.TextXAlignment.Left; local V = Instance.new("TextLabel", F); V.Text = tostring(default); V.Font = Enum.Font.Gotham; V.TextColor3 = Theme.TextDark; V.TextSize = 12; V.Size = UDim2.new(1, 0, 0, 12); V.BackgroundTransparency = 1; V.TextXAlignment = Enum.TextXAlignment.Right; local Track = Instance.new("TextButton", F); Track.Size = UDim2.new(1, 0, 0, 2); Track.Position = UDim2.new(0, 0, 1, -6); Track.BackgroundColor3 = Theme.Btn; Track.Text = ""; local Fill = Instance.new("Frame", Track); Fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); Fill.BackgroundColor3 = Theme.Accent; Fill.BorderSizePixel = 0; local d = false; Track.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true end end); UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end); UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then pcall(function() local p = math.clamp((i.Position.X-Track.AbsolutePosition.X)/Track.AbsoluteSize.X,0,1); Fill.Size = UDim2.new(p,0,1,0); local val = math.floor(min+(max-min)*p); V.Text = tostring(val); callback(val) end) end end) end
local ESPObjects = {}
local function ClearESP(p) if ESPObjects[p] then pcall(function() ESPObjects[p].Box:Remove(); ESPObjects[p].Text:Remove(); end) ESPObjects[p] = nil end end
local function SetupESP(p) if p == LP then return end ClearESP(p) pcall(function() local box = Drawing.new("Square"); box.Visible = false; box.Thickness = 1; box.Color = Theme.Accent; local text = Drawing.new("Text"); text.Visible = false; text.Size = 13; text.Center = true; text.Outline = true; text.Color = Theme.Text; ESPObjects[p] = { Box = box, Text = text } end) end
Players.PlayerAdded:Connect(SetupESP); Players.PlayerRemoving:Connect(ClearESP); for _, p in pairs(Players:GetPlayers()) do SetupESP(p) end
local function get_near() local near, d = nil, math.huge pcall(function() for _, p in pairs(Players:GetPlayers()) do if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 and p.Character:FindFirstChild(Config.TargetPart) then local pos, vis = Camera:WorldToViewportPoint(p.Character[Config.TargetPart].Position) if vis then local m_d = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude if m_d < d and m_d <= Config.FOVRadius then d = m_d; near = p end end end end end) return near end
local hooked = false
local function ApplyHook() if hooked then return end pcall(function() local old; old = hookmetamethod(LP:GetMouse(), "__index", newcclosure(function(self, index) if not checkcaller() and Config.SilentAim and target and target.Character then if index == "Hit" then return target.Character[Config.TargetPart].CFrame + (target.Character[Config.TargetPart].Velocity * Config.Prediction) elseif index == "Target" then return target.Character[Config.TargetPart] end end return old(self, index) end)); hooked = true end) end
local T1 = CreateTopTab("Aim"); local T2 = CreateTopTab("Visuals"); local T3 = CreateTopTab("Utility")
local S1 = CreateSideTab(T1, "Combat"); AddToggle(S1, "Silent Aim", false, function(v) Config.SilentAim = v; if v then ApplyHook() end end); AddToggle(S1, "Hard Aimlock", false, function(v) Config.HardLock = v end); AddSlider(S1, "Prediction", 165, 0, 400, function(v) Config.Prediction = v/1000 end)
local S2 = CreateSideTab(T2, "ESP"); AddToggle(S2, "Enable ESP", false, function(v) Config.ESPEnabled = v end); AddToggle(S2, "Show Boxes", false, function(v) Config.ESPBoxes = v end); AddToggle(S2, "Show Names", false, function(v) Config.ESPNames = v end)
local S3 = CreateSideTab(T3, "Spectate")
local SScroll = Instance.new("ScrollingFrame", S3); SScroll.Size = UDim2.new(1,0,1,0); SScroll.BackgroundTransparency = 1; SScroll.ScrollBarThickness = 2; Instance.new("UIListLayout", SScroll).Padding = UDim.new(0,5)
local function UpdateList() for _, c in pairs(SScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end for _, p in pairs(Players:GetPlayers()) do if p ~= LP then local B = Instance.new("TextButton", SScroll); B.Size = UDim2.new(1,-10,0,30); B.BackgroundColor3 = Theme.Btn; B.Text = p.Name; B.TextColor3 = Theme.Text; B.Font = Enum.Font.Gotham; B.TextSize = 12; Instance.new("UICorner", B); B.MouseButton1Click:Connect(function() pcall(function() if cur_spec == p then cur_spec = nil; Camera.CameraSubject = LP.Character.Humanoid; B.TextColor3 = Theme.Text else cur_spec = p; Camera.CameraSubject = p.Character.Humanoid; B.TextColor3 = Theme.Accent; for _, x in pairs(SScroll:GetChildren()) do if x:IsA("TextButton") and x ~= B then x.TextColor3 = Theme.Text end end end end) end) end end SScroll.CanvasSize = UDim2.new(0,0,0,SScroll.UIListLayout.AbsoluteContentSize.Y) end
UpdateList(); Players.PlayerAdded:Connect(UpdateList); Players.PlayerRemoving:Connect(UpdateList)
local S4 = CreateSideTab(T3, "Misc"); AddToggle(S4, "Rapid Fire", false, function(v) Config.RapidFire = v end); AddToggle(S4, "Void Hide", false, function(v) Config.VoidHide = v end)
local S6 = CreateSideTab(T3, "Movement"); AddToggle(S6, "Fly Toggle", false, function(v) Config.FlyEnabled = v end); AddToggle(S6, "Speed Toggle", false, function(v) Config.SpeedEnabled = v end)
local T4 = CreateTopTab("Config"); local S5 = CreateSideTab(T4, "Main"); local Unload = Instance.new("TextButton", S5); Unload.Size = UDim2.new(1, 0, 0, 30); Unload.BackgroundColor3 = Color3.fromRGB(50, 20, 20); Unload.Text = "Unload"; Unload.TextColor3 = Color3.fromRGB(240, 100, 100); Unload.Font = Enum.Font.GothamBold; Unload.Parent = S5; Unload.MouseButton1Click:Connect(function() UI:Destroy() end)
RS.RenderStepped:Connect(function() if not UI.Parent or not IsAuthenticated then return end target = get_near(); if Config.HardLock and target and target.Character then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, target.Character[Config.TargetPart].Position), Config.Smoothing) end; for p, h in pairs(ESPObjects) do local char = p.Character; local hum = char and char:FindFirstChild("Humanoid") if Config.ESPEnabled and char and hum and hum.Health > 0 and char:FindFirstChild("HumanoidRootPart") then local pos, vis = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position) if vis then local s = 1000/pos.Z; h.Box.Visible = Config.ESPBoxes; h.Box.Size = Vector2.new(4,6)*s; h.Box.Position = Vector2.new(pos.X-h.Box.Size.X/2, pos.Y-h.Box.Size.Y/2); h.Text.Visible = Config.ESPNames; h.Text.Text = p.Name; h.Text.Position = Vector2.new(pos.X, pos.Y-h.Box.Size.Y/2-15) else h.Box.Visible = false; h.Text.Visible = false end else h.Box.Visible = false; h.Text.Visible = false end end; if Config.VoidHide and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then local hrp = LP.Character.HumanoidRootPart; local t = tick()*15; hrp.CFrame = CFrame.new(hrp.Position.X+math.sin(t)*15, -100000, hrp.Position.Z+math.cos(t)*15); hrp.Velocity = Vector3.new(0,0,0) end end)
task.spawn(function() while true do RS.Heartbeat:Wait() if Config.RapidFire and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and IsAuthenticated then local t = LP.Character and LP.Character:FindFirstChildOfClass("Tool") if t then for i=1,5 do task.spawn(function() pcall(function() t:Activate() end) end) end end end end end)
UIS.InputBegan:Connect(function(i, g) if not g and IsAuthenticated then if i.KeyCode == Config.ToggleKey then Main.Visible = not Main.Visible end end end)
SelectTab(T1, "Combat")
print("--- x_u v18 (STABLE MASK) Ready ---")
end)
if not success then warn("Crit Error: ", err) end
