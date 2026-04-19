-- x_u private v20 (Ultimate UI & Mechanics System)
local success, err = pcall(function()
print("--- x_u private Initializing ---")

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Http = game:GetService("HttpService")
local LP = Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

-- Global Config
local Config = {
    MenuKey = "RightControl", StreamProof = false, ConfigName = "default",
    
    -- Aimbot
    AimEnabled = false, AimBind = "Unbound",
    SilentAim = false, SilentAimBind = "MouseButton2",
    AimMethod = "Mouse", AimStyle = "Exponential",
    TargetMode = "Closest to Crosshair", TargetHitboxes = "Torso", Checks = "Visible Only",
    StickyAim = false,

    -- Triggerbot
    TrigEnabled = false, TrigBind = "Unbound",
    TrigDelay = 75, TrigClickDur = 50, TrigHitchance = 100, TrigMaxDist = 1000, 
    TrigPrediction = false, TrigHitboxes = "Head", TrigChecks = "Visible Only",

    -- ESP
    ESPEnabled = false, ESPBoxes = false, ESPNames = false,

    -- Main Toggle Binds
    FlyEnabled = false, FlyBind = "Unbound", FlyMethod = "Velocity", FlySpeed = 14,
    OrbitEnabled = false, OrbitBind = "Unbound", OrbitRadius = 15, OrbitSpeed = 5,
    SpeedEnabled = false, SpeedBind = "Unbound", SpeedMethod = "Velocity", SpeedValue = 50,
    WalkspeedEnabled = false, WalkspeedBind = "Unbound", WalkspeedVal = 30,
    JumppowerEnabled = false, JumppowerBind = "Unbound", JumppowerVal = 70,
    HipheightEnabled = false, HipheightBind = "Unbound", HipheightVal = 2,
    Bunnyhop = false, InfJump = false, AntiAfk = false,
    VoidSpam = false, VoidSpamBind = "Unbound", VoidSpeed = 15
}

local function SaveConfig() pcall(function() if not isfolder("xu_configs") then makefolder("xu_configs") end writefile("xu_configs/" .. Config.ConfigName .. ".json", Http:JSONEncode(Config)) print("x_u: Saved") end) end
local function LoadConfig() pcall(function() if isfile("xu_configs/" .. Config.ConfigName .. ".json") then local d = Http:JSONDecode(readfile("xu_configs/" .. Config.ConfigName .. ".json")); for k,v in pairs(d) do Config[k] = v end print("x_u: Loaded") end end) end

local k1 = {73, 104, 97, 116, 101, 121, 111, 117, 115, 111, 109, 117, 99, 104, 110, 101, 118, 101, 114, 116, 97, 108, 107, 116, 111, 109, 101}
local k2 = {118, 105, 118, 105, 100, 50, 48, 50, 54}
local function Validate(input) local function c(a) if #input ~= #a then return false end for i=1,#input do if string.byte(input, i) ~= a[i] then return false end end return true end; if c(k1) then return "vin" end if c(k2) then return "vivid" end return nil end

local Theme = { BG = Color3.fromRGB(18, 18, 18), Line = Color3.fromRGB(45, 45, 50), Accent = Color3.fromRGB(0, 180, 150), Text = Color3.fromRGB(240, 240, 240), TextDark = Color3.fromRGB(150, 150, 160), Btn = Color3.fromRGB(25, 25, 30) }
local UI = Instance.new("ScreenGui"); UI.Name = tostring(math.random(1e5, 1e6)); UI.ZIndexBehavior = Enum.ZIndexBehavior.Global; UI.ResetOnSpawn = false
pcall(function() if gethui then UI.Parent = gethui() elseif game:GetService("CoreGui") then UI.Parent = game:GetService("CoreGui") else UI.Parent = LP:WaitForChild("PlayerGui") end end)

local AuthMain = Instance.new("Frame", UI); AuthMain.Size = UDim2.new(0, 300, 0, 180); AuthMain.Position = UDim2.new(0.5, -150, 0.5, -90); AuthMain.BackgroundColor3 = Theme.BG; AuthMain.BorderSizePixel = 0; AuthMain.Active = true; Instance.new("UICorner", AuthMain).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", AuthMain).Color = Theme.Line
local AuthTitle = Instance.new("TextLabel", AuthMain); AuthTitle.Size = UDim2.new(1, 0, 0, 40); AuthTitle.BackgroundTransparency = 1; AuthTitle.Text = "PRIVATE ACCESS"; AuthTitle.Font = Enum.Font.GothamBold; AuthTitle.TextSize = 16; AuthTitle.TextColor3 = Theme.Accent; Instance.new("Frame", AuthMain).Size = UDim2.new(1, 0, 0, 1); AuthMain.Frame.Position = UDim2.new(0, 0, 0, 40); AuthMain.Frame.BackgroundColor3 = Theme.Line; AuthMain.Frame.BorderSizePixel = 0
local InputContainer = Instance.new("Frame", AuthMain); InputContainer.Size = UDim2.new(1, -40, 0, 35); InputContainer.Position = UDim2.new(0, 20, 0, 65); InputContainer.BackgroundColor3 = Theme.Btn; Instance.new("UICorner", InputContainer).CornerRadius = UDim.new(0, 4)
local FakeLabel = Instance.new("TextLabel", InputContainer); FakeLabel.Size = UDim2.new(1, -10, 1, 0); FakeLabel.Position = UDim2.new(0, 5, 0, 0); FakeLabel.BackgroundTransparency = 1; FakeLabel.Text = ""; FakeLabel.TextColor3 = Theme.Text; FakeLabel.Font = Enum.Font.Gotham; FakeLabel.TextSize = 13; FakeLabel.TextXAlignment = Enum.TextXAlignment.Left
local KeyInput = Instance.new("TextBox", InputContainer); KeyInput.Size = UDim2.new(1, -10, 1, 0); KeyInput.Position = UDim2.new(0, 5, 0, 0); KeyInput.BackgroundTransparency = 1; KeyInput.Text = ""; KeyInput.PlaceholderText = "Enter Key..."; KeyInput.TextColor3 = Theme.Text; KeyInput.TextTransparency = 1; KeyInput.Font = Enum.Font.Gotham; KeyInput.TextSize = 13; KeyInput.TextXAlignment = Enum.TextXAlignment.Left; KeyInput.ClearTextOnFocus = false; KeyInput.ZIndex = 2
KeyInput:GetPropertyChangedSignal("Text"):Connect(function() FakeLabel.Text = string.rep("*", #KeyInput.Text); if #KeyInput.Text == 0 then FakeLabel.Text = ""; KeyInput.PlaceholderText = "Enter Key..." else KeyInput.PlaceholderText = "" end end)
local AuthBtn = Instance.new("TextButton", AuthMain); AuthBtn.Size = UDim2.new(1, -40, 0, 35); AuthBtn.Position = UDim2.new(0, 20, 0, 115); AuthBtn.BackgroundColor3 = Theme.Line; AuthBtn.Text = "Login"; AuthBtn.TextColor3 = Theme.Text; AuthBtn.Font = Enum.Font.GothamMedium; AuthBtn.TextSize = 14; Instance.new("UICorner", AuthBtn).CornerRadius = UDim.new(0, 4)

local Main = Instance.new("Frame", UI); Main.Size = UDim2.new(0, 630, 0, 500); Main.Position = UDim2.new(0.5, -315, 0.5, -250); Main.BackgroundColor3 = Theme.BG; Main.BorderSizePixel = 0; Main.Active = true; Main.Visible = false; Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6); Instance.new("UIStroke", Main).Color = Theme.Line
local function make_draggable(f) local d, sp, sm; f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true; sm = i.Position; sp = f.Position end end); UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then f.Position = UDim2.new(sp.X.Scale, sp.X.Offset + (i.Position.X - sm.X), sp.Y.Scale, sp.Y.Offset + (i.Position.Y - sm.Y)) end end); f.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end) end
make_draggable(Main); make_draggable(AuthMain)

local IsAuth = false
AuthBtn.MouseButton1Click:Connect(function() local u = Validate(KeyInput.Text); if u then IsAuth = true; InputContainer.Visible = false; for i = 1, 3 do AuthBtn.Text = "Welcome " .. u .. string.rep(".", i); task.wait(0.3) end; AuthMain:Destroy(); Main.Visible = true; LoadConfig(); if InitHooks then InitHooks() end else KeyInput.Text = ""; FakeLabel.Text = ""; KeyInput.PlaceholderText = "Invalid Key!"; task.wait(1.5); KeyInput.PlaceholderText = "Enter Key..." end end)

local Title = Instance.new("TextLabel", Main); Title.Size = UDim2.new(0, 150, 0, 50); Title.Position = UDim2.new(0, 20, 0, 0); Title.BackgroundTransparency = 1; Title.Text = "x_u private"; Title.Font = Enum.Font.GothamBold; Title.TextSize = 20; Title.TextColor3 = Theme.Accent; Title.TextXAlignment = Enum.TextXAlignment.Left
local F1 = Instance.new("Frame", Main); F1.Size = UDim2.new(1, 0, 0, 1); F1.Position = UDim2.new(0, 0, 0, 50); F1.BackgroundColor3 = Theme.Line; F1.BorderSizePixel = 0
local F2 = Instance.new("Frame", Main); F2.Size = UDim2.new(0, 1, 1, -50); F2.Position = UDim2.new(0, 140, 0, 50); F2.BackgroundColor3 = Theme.Line; F2.BorderSizePixel = 0

local TopTabCont = Instance.new("Frame", Main); TopTabCont.Size = UDim2.new(0, 400, 0, 50); TopTabCont.Position = UDim2.new(0, 160, 0, 0); TopTabCont.BackgroundTransparency = 1; Instance.new("UIListLayout", TopTabCont).FillDirection = Enum.FillDirection.Horizontal; TopTabCont.UIListLayout.Padding = UDim.new(0, 15); TopTabCont.UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
local SideTabCont = Instance.new("Frame", Main); SideTabCont.Size = UDim2.new(0, 140, 1, -50); SideTabCont.Position = UDim2.new(0, 0, 0, 50); SideTabCont.BackgroundTransparency = 1; Instance.new("UIListLayout", SideTabCont).Padding = UDim.new(0, 2); SideTabCont.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local ContentCont = Instance.new("Frame", Main); ContentCont.Size = UDim2.new(1, -140, 1, -50); ContentCont.Position = UDim2.new(0, 140, 0, 50); ContentCont.BackgroundTransparency = 1

local Tabs = {}
local function SelectTab(tn, sn) pcall(function() for _, t in pairs(Tabs) do t.SCont.Visible = false; t.Btn.TextColor3 = Theme.TextDark; if t.Btn:FindFirstChild("Line") then t.Btn.Line.Visible = false end; for _, s in pairs(t.Sides) do s.Page.Visible = false; s.Btn.TextColor3 = Theme.TextDark; if s.Btn:FindFirstChild("Line") then s.Btn.Line.Visible = false end end end; local top = Tabs[tn]; top.Btn.TextColor3 = Theme.Text; if top.Btn:FindFirstChild("Line") then top.Btn.Line.Visible = true end; top.SCont.Visible = true; local side = top.Sides[sn]; side.Btn.TextColor3 = Theme.Text; if side.Btn:FindFirstChild("Line") then side.Btn.Line.Visible = true end; side.Page.Visible = true end) end
local function CreateTopTab(nm) local B = Instance.new("TextButton", TopTabCont); B.Size = UDim2.new(0, 70, 0, 50); B.BackgroundTransparency = 1; B.Text = nm; B.Font = Enum.Font.GothamMedium; B.TextSize = 13; B.TextColor3 = Theme.TextDark; local L = Instance.new("Frame", B); L.Name = "Line"; L.Size = UDim2.new(1, 0, 0, 2); L.Position = UDim2.new(0, 0, 1, -2); L.BackgroundColor3 = Theme.Accent; L.BorderSizePixel = 0; L.Visible = false; local SC = Instance.new("Frame", SideTabCont); SC.Size = UDim2.new(1, 0, 1, 0); SC.BackgroundTransparency = 1; SC.Visible = false; Instance.new("UIListLayout", SC).Padding = UDim.new(0, 2); SC.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center; Tabs[nm] = { Btn = B, Sides = {}, SCont = SC }; B.MouseButton1Click:Connect(function() local f = next(Tabs[nm].Sides) if f then SelectTab(nm, f) end end); return nm end
local function CreateSideTab(tn, nm) local B = Instance.new("TextButton", Tabs[tn].SCont); B.Size = UDim2.new(1, -15, 0, 35); B.BackgroundTransparency = 1; B.Text = "  " .. nm; B.Font = Enum.Font.Gotham; B.TextSize = 13; B.TextColor3 = Theme.TextDark; B.TextXAlignment = Enum.TextXAlignment.Left; local L = Instance.new("Frame", B); L.Name = "Line"; L.Size = UDim2.new(0, 3, 1, -12); L.Position = UDim2.new(0, 0, 0, 6); L.BackgroundColor3 = Theme.Accent; L.BorderSizePixel = 0; L.Visible = false; local P = Instance.new("ScrollingFrame", ContentCont); P.Size = UDim2.new(1, -40, 1, -40); P.Position = UDim2.new(0, 20, 0, 20); P.BackgroundTransparency = 1; P.Visible = false; P.ScrollBarThickness = 2; local UIL = Instance.new("UIListLayout", P); UIL.Padding = UDim.new(0, 6); UIL.SortOrder = Enum.SortOrder.LayoutOrder; UIL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() P.CanvasSize = UDim2.new(0,0,0,UIL.AbsoluteContentSize.Y + 10) end); Tabs[tn].Sides[nm] = { Btn = B, Page = P }; B.MouseButton1Click:Connect(function() SelectTab(tn, nm) end); return P end

-- UI Engine Components
local function AddToggle(parent, text, defaultVal, callback, bindKey, bindCallback)
    local MainCont = Instance.new("Frame", parent); MainCont.Size = UDim2.new(1, 0, 0, 25); MainCont.BackgroundTransparency = 1
    local F = Instance.new("TextButton", MainCont); F.Size = UDim2.new(1, 0, 1, 0); F.BackgroundTransparency = 1; F.Text = ""
    local CB = Instance.new("Frame", F); CB.Size = UDim2.new(0, 16, 0, 16); CB.Position = UDim2.new(0, 0, 0.5, -8); CB.BackgroundColor3 = defaultVal and Theme.Accent or Theme.Btn; Instance.new("UICorner", CB).CornerRadius = UDim.new(0,2)
    local L = Instance.new("TextLabel", F); L.Text = text; L.Font = Enum.Font.Gotham; L.TextColor3 = defaultVal and Theme.Text or Theme.TextDark; L.TextSize = 13; L.Size = UDim2.new(1, -110, 1, 0); L.Position = UDim2.new(0, 25, 0, 0); L.BackgroundTransparency = 1; L.TextXAlignment = Enum.TextXAlignment.Left
    
    local Exp = Instance.new("Frame", parent); Exp.Size = UDim2.new(1, 0, 0, 0); Exp.BackgroundTransparency = 1; Exp.Visible = defaultVal; Exp.ClipsDescendants = true
    local ExpL = Instance.new("UIListLayout", Exp); ExpL.Padding = UDim.new(0, 6); ExpL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() Exp.Size = UDim2.new(1, 0, 0, ExpL.AbsoluteContentSize.Y) end)
    
    local s = defaultVal
    F.MouseButton1Click:Connect(function() pcall(function() s = not s; TS:Create(CB, TweenInfo.new(0.2), {BackgroundColor3 = s and Theme.Accent or Theme.Btn}):Play(); L.TextColor3 = s and Theme.Text or Theme.TextDark; Exp.Visible = s; callback(s) end) end)
    
    if bindKey then
        local Bnd = Instance.new("TextButton", MainCont); Bnd.Size = UDim2.new(0, 70, 0, 18); Bnd.Position = UDim2.new(1, -70, 0.5, -9); Bnd.BackgroundColor3 = Theme.Btn; Bnd.Text = bindKey; Bnd.TextColor3 = Theme.TextDark; Bnd.Font = Enum.Font.Gotham; Bnd.TextSize = 11; Instance.new("UICorner", Bnd).CornerRadius = UDim.new(0, 4)
        local w = false
        Bnd.MouseButton1Click:Connect(function() w = true; Bnd.Text = "..." end)
        UIS.InputBegan:Connect(function(i) if w and (i.UserInputType == Enum.UserInputType.Keyboard or i.UserInputType.Name:match("MouseButton")) then w = false; local st = i.KeyCode.Name ~= "Unknown" and i.KeyCode.Name or i.UserInputType.Name; Bnd.Text = st; bindCallback(st) end end)
    end
    return Exp
end

local function AddSlider(parent, text, defaultVal, min, max, callback) 
    local F = Instance.new("Frame", parent); F.Size = UDim2.new(1, 0, 0, 30); F.BackgroundTransparency = 1
    local L = Instance.new("TextLabel", F); L.Text = text; L.Font = Enum.Font.Gotham; L.TextColor3 = Theme.TextDark; L.TextSize = 12; L.Size = UDim2.new(1, 0, 0, 12); L.BackgroundTransparency = 1; L.TextXAlignment = Enum.TextXAlignment.Left; L.Position = UDim2.new(0, 10, 0, 0)
    local V = Instance.new("TextLabel", F); V.Text = tostring(defaultVal); V.Font = Enum.Font.Gotham; V.TextColor3 = Theme.TextDark; V.TextSize = 12; V.Size = UDim2.new(1, -5, 0, 12); V.BackgroundTransparency = 1; V.TextXAlignment = Enum.TextXAlignment.Right
    local Tr = Instance.new("TextButton", F); Tr.Size = UDim2.new(1, -10, 0, 4); Tr.Position = UDim2.new(0, 10, 1, -8); Tr.BackgroundColor3 = Theme.Btn; Tr.Text = ""; Instance.new("UICorner", Tr).CornerRadius = UDim.new(1,0)
    local Fil = Instance.new("Frame", Tr); Fil.Size = UDim2.new((defaultVal-min)/(max-min), 0, 1, 0); Fil.BackgroundColor3 = Theme.Accent; Fil.BorderSizePixel = 0; Instance.new("UICorner", Fil).CornerRadius = UDim.new(1,0)
    local d = false
    Tr.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true end end); UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
    UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then pcall(function() local p = math.clamp((i.Position.X-Tr.AbsolutePosition.X)/Tr.AbsoluteSize.X,0,1); Fil.Size = UDim2.new(p,0,1,0); local val = math.floor(min+(max-min)*p); V.Text = tostring(val); callback(val) end) end end)
end

local function AddDropdown(parent, text, options, defaultVal, callback) 
    local F = Instance.new("Frame", parent); F.Size = UDim2.new(1, 0, 0, 25); F.BackgroundTransparency = 1
    local L = Instance.new("TextLabel", F); L.Text = text; L.Font = Enum.Font.Gotham; L.TextColor3 = Theme.TextDark; L.TextSize = 12; L.Size = UDim2.new(1, -130, 1, 0); L.BackgroundTransparency = 1; L.TextXAlignment = Enum.TextXAlignment.Left; L.Position = UDim2.new(0, 10, 0, 0)
    local B = Instance.new("TextButton", F); B.Size = UDim2.new(0, 130, 0, 20); B.Position = UDim2.new(1, -130, 0.5, -10); B.BackgroundColor3 = Theme.Line; B.Text = defaultVal; B.TextColor3 = Theme.TextDark; B.Font = Enum.Font.Gotham; B.TextSize = 11; Instance.new("UICorner", B).CornerRadius = UDim.new(0, 4)
    local idx = 1; for i,v in pairs(options) do if v == defaultVal then idx = i break end end
    B.MouseButton1Click:Connect(function() idx = idx + 1; if idx > #options then idx = 1 end; B.Text = options[idx]; callback(options[idx]) end)
end

local function GetFolderConfigs()
    local c = {"default"}
    pcall(function() if isfolder("xu_configs") then for _, f in pairs(listfiles("xu_configs")) do local nm = f:match("([^/\\]+)%.json$"); if nm then table.insert(c, nm) end end end end)
    return c
end

local T1 = CreateTopTab("Aimbot"); local T3 = CreateTopTab("Main"); local T4 = CreateTopTab("Settings")

-- /// AIMBOT TAB /// --
local S1 = CreateSideTab(T1, "Aimbot")
AddToggle(S1, "Enabled", Config.AimEnabled, function(v) Config.AimEnabled = v end, Config.AimBind, function(v) Config.AimBind = v end)
AddToggle(S1, "Silent Aim", Config.SilentAim, function(v) Config.SilentAim = v end, Config.SilentAimBind, function(v) Config.SilentAimBind = v end)
AddDropdown(S1, "Aim Method", {"Mouse", "Camera"}, Config.AimMethod, function(v) Config.AimMethod = v end)
AddDropdown(S1, "Aim Style", {"Linear", "Exponential"}, Config.AimStyle, function(v) Config.AimStyle = v end)
AddDropdown(S1, "Targeting Mode", {"Closest to Crosshair", "Distance"}, Config.TargetMode, function(v) Config.TargetMode = v end)
AddDropdown(S1, "Target Hitboxes", {"Head", "Torso", "Random"}, Config.TargetHitboxes, function(v) Config.TargetHitboxes = v end)
AddDropdown(S1, "Checks", {"Visible Only", "None"}, Config.Checks, function(v) Config.Checks = v end)
AddToggle(S1, "Sticky Aim", Config.StickyAim, function(v) Config.StickyAim = v end)

-- /// TRIGGERBOT TAB /// --
local S2 = CreateSideTab(T1, "Triggerbot")
AddToggle(S2, "Enabled", Config.TrigEnabled, function(v) Config.TrigEnabled = v end, Config.TrigBind, function(v) Config.TrigBind = v end)
AddSlider(S2, "Delay", Config.TrigDelay, 0, 250, function(v) Config.TrigDelay = v end)
AddSlider(S2, "Click Duration (ms)", Config.TrigClickDur, 0, 250, function(v) Config.TrigClickDur = v end)
AddSlider(S2, "Hitchance", Config.TrigHitchance, 0, 100, function(v) Config.TrigHitchance = v end)
AddSlider(S2, "Max Distance", Config.TrigMaxDist, 0, 2500, function(v) Config.TrigMaxDist = v end)
AddToggle(S2, "Prediction", Config.TrigPrediction, function(v) Config.TrigPrediction = v end)
AddDropdown(S2, "Hitboxes", {"Head", "Torso", "Both"}, Config.TrigHitboxes, function(v) Config.TrigHitboxes = v end)
AddDropdown(S2, "Checks", {"Visible Only", "None"}, Config.TrigChecks, function(v) Config.TrigChecks = v end)

-- /// MAIN TAB /// --
local S3 = CreateSideTab(T3, "Main")
local Fly_Exp = AddToggle(S3, "Fly", Config.FlyEnabled, function(v) Config.FlyEnabled = v end, Config.FlyBind, function(v) Config.FlyBind = v end)
AddDropdown(Fly_Exp, "Fly Method", {"Velocity", "CFrame"}, Config.FlyMethod, function(v) Config.FlyMethod = v end)
AddSlider(Fly_Exp, "Fly Speed", Config.FlySpeed, 0, 500, function(v) Config.FlySpeed = v end)

local Orb_Exp = AddToggle(S3, "Orbit Target", Config.OrbitEnabled, function(v) Config.OrbitEnabled = v end, Config.OrbitBind, function(v) Config.OrbitBind = v end)
AddSlider(Orb_Exp, "Orbit Radius", Config.OrbitRadius, 5, 100, function(v) Config.OrbitRadius = v end)
AddSlider(Orb_Exp, "Orbit Speed", Config.OrbitSpeed, 1, 50, function(v) Config.OrbitSpeed = v end)

local Spd_Exp = AddToggle(S3, "Speed", Config.SpeedEnabled, function(v) Config.SpeedEnabled = v end, Config.SpeedBind, function(v) Config.SpeedBind = v end)
AddDropdown(Spd_Exp, "Speed Method", {"Velocity", "CFrame"}, Config.SpeedMethod, function(v) Config.SpeedMethod = v end)
AddSlider(Spd_Exp, "Speed Value", Config.SpeedValue, 0, 500, function(v) Config.SpeedValue = v end)

local Ws_Exp = AddToggle(S3, "Walkspeed", Config.WalkspeedEnabled, function(v) Config.WalkspeedEnabled = v end, Config.WalkspeedBind, function(v) Config.WalkspeedBind = v end)
AddSlider(Ws_Exp, "Value", Config.WalkspeedVal, 16, 500, function(v) Config.WalkspeedVal = v end)

local Jp_Exp = AddToggle(S3, "Jumppower", Config.JumppowerEnabled, function(v) Config.JumppowerEnabled = v end, Config.JumppowerBind, function(v) Config.JumppowerBind = v end)
AddSlider(Jp_Exp, "Value", Config.JumppowerVal, 50, 500, function(v) Config.JumppowerVal = v end)

local Hh_Exp = AddToggle(S3, "Hipheight", Config.HipheightEnabled, function(v) Config.HipheightEnabled = v end, Config.HipheightBind, function(v) Config.HipheightBind = v end)
AddSlider(Hh_Exp, "Value", Config.HipheightVal, 0, 100, function(v) Config.HipheightVal = v end)

AddToggle(S3, "Bunnyhop", Config.Bunnyhop, function(v) Config.Bunnyhop = v end)
AddToggle(S3, "Infinite Jump", Config.InfJump, function(v) Config.InfJump = v end)
AddToggle(S3, "Anti Afk", Config.AntiAfk, function(v) Config.AntiAfk = v end)

local Vd_Exp = AddToggle(S3, "Void Spam", Config.VoidSpam, function(v) Config.VoidSpam = v end, Config.VoidSpamBind, function(v) Config.VoidSpamBind = v end)
AddSlider(Vd_Exp, "Spam Speed", Config.VoidSpeed, 1, 50, function(v) Config.VoidSpeed = v end)

-- /// SETTINGS /// --
local S4 = CreateSideTab(T4, "Main")
AddDropdown(S4, "Select Config", GetFolderConfigs(), "default", function(v) Config.ConfigName = v end)
local function cbtn(p,t,c) local b=Instance.new("TextButton",p);b.Size=UDim2.new(1,0,0,25);b.BackgroundColor3=Theme.Line;b.Text=t;b.TextColor3=Theme.Text;b.Font=Enum.Font.Gotham;b.TextSize=12;Instance.new("UICorner",b).CornerRadius=UDim.new(0,4);b.MouseButton1Click:Connect(c) end
cbtn(S4, "Save Config", SaveConfig)
cbtn(S4, "Load Config", LoadConfig)
cbtn(S4, "Unload Client", function() UI:Destroy() end)

local currentTarget = nil
local GetTargetPart = function(char)
    if Config.TargetHitboxes == "Head" then return char:FindFirstChild("Head") end
    if Config.TargetHitboxes == "Torso" then return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") end
    if Config.TargetHitboxes == "Random" then local p = {"Head", "HumanoidRootPart", "Left Arm", "Right Arm"} return char:FindFirstChild(p[math.random(1,#p)]) end
    return char:FindFirstChild("HumanoidRootPart")
end

local CheckVisible = function(part)
    if Config.Checks ~= "Visible Only" then return true end
    local o = RaycastParams.new(); o.FilterDescendantsInstances = {LP.Character, Camera}; o.FilterType = Enum.RaycastFilterType.Exclude
    local h = workspace:Raycast(Camera.CFrame.Position, (part.Position - Camera.CFrame.Position).Unit * 1000, o)
    return h and h.Instance and h.Instance:IsDescendantOf(part.Parent)
end

local get_target = function()
    if Config.StickyAim and currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("Humanoid") and currentTarget.Character.Humanoid.Health > 0 then
        local p = GetTargetPart(currentTarget.Character)
        if p and CheckVisible(p) then return currentTarget end
    end
    local target, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local part = GetTargetPart(p.Character)
            if part then
                local pos, vis = Camera:WorldToViewportPoint(part.Position)
                if vis and CheckVisible(part) then
                    local d = Config.TargetMode == "Closest to Crosshair" and (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude or (LP.Character.HumanoidRootPart.Position - part.Position).Magnitude
                    if d < dist then dist = d; target = p end
                end
            end
        end
    end
    if Config.StickyAim then currentTarget = target end
    return target
end

local globalSilentActive = false
local globalTarget = nil

getgenv().InitHooks = function()
    local old
    old = hookmetamethod(game, "__index", newcclosure(function(self, k)
        if not checkcaller() and globalSilentActive and self == Mouse then
            local ks = tostring(k)
            if (ks == "Hit" or ks == "Target") and globalTarget and globalTarget.Character then
                local p = GetTargetPart(globalTarget.Character)
                if p then return p.CFrame end
            end
        end
        return old(self, k)
    end))
end

RS.Heartbeat:Connect(function()
    if not IsAuth then return end
    
    -- Keyboard Bind Listener via State Memory (to allow multiple simultaneous keybinds)
    local checkBind = function(bindName)
        if bindName == "Unbound" then return false end
        if bindName:match("MouseButton") then return UIS:IsMouseButtonPressed(Enum.UserInputType[bindName]) end
        local ret = false; pcall(function() ret = UIS:IsKeyDown(Enum.KeyCode[bindName]) end); return ret
    end

    local aimActive = checkBind(Config.AimBind); if Config.AimBind == "Unbound" then aimActive = Config.AimEnabled end
    local silentActive = checkBind(Config.SilentAimBind); if Config.SilentAimBind == "Unbound" then silentActive = Config.SilentAim end
    local trigActive = checkBind(Config.TrigBind); if Config.TrigBind == "Unbound" then trigActive = Config.TrigEnabled end
    local flyActive = checkBind(Config.FlyBind); if Config.FlyBind == "Unbound" then flyActive = Config.FlyEnabled end
    local orbitActive = checkBind(Config.OrbitBind); if Config.OrbitBind == "Unbound" then orbitActive = Config.OrbitEnabled end
    local speedActive = checkBind(Config.SpeedBind); if Config.SpeedBind == "Unbound" then speedActive = Config.SpeedEnabled end

    -- Active Target
    local tar = get_target()

    -- Triggerbot
    if trigActive and tar and tar.Character then
        local p = GetTargetPart(tar.Character)
        if p then
            local pos, vis = Camera:WorldToViewportPoint(p.Position)
            local checkDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
            if vis and checkDist < (Config.TrigMaxDist / 10) then
                if math.random(1, 100) <= Config.TrigHitchance then
                    task.delay(Config.TrigDelay / 1000, function()
                        mouse1click()
                        task.delay(Config.TrigClickDur / 1000, function() mouse1click() end)
                    end)
                end
            end
        end
    end

    -- Update Global Target Cache for the Hook
    globalTarget = tar
    globalSilentActive = silentActive

    -- Aimlock & Methods
    if aimActive and tar and tar.Character then
        local t_pos = GetTargetPart(tar.Character).Position
        if Config.AimMethod == "Camera" then
            local lerpFac = Config.AimStyle == "Exponential" and 0.5 or 1
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, t_pos), lerpFac)
        elseif Config.AimMethod == "Mouse" then
            local p = Camera:WorldToScreenPoint(t_pos)
            mousemoverel((p.X - Mouse.X)*0.5, (p.Y - Mouse.Y)*0.5)
        end
    end

    local h_char = LP.Character
    if not h_char then return end    
    local hrp = h_char:FindFirstChild("HumanoidRootPart")
    local hum = h_char:FindFirstChild("Humanoid")

    -- Movement / Orbit
    if hrp and hum then
        if flyActive then
            local v = Vector3.new()
            if UIS:IsKeyDown(Enum.KeyCode.W) then v = v + Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then v = v - Camera.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then v = v - Camera.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then v = v + Camera.CFrame.RightVector end
            if Config.FlyMethod == "Velocity" then
                hrp.Velocity = v * Config.FlySpeed
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
            elseif Config.FlyMethod == "CFrame" then
                hrp.Velocity = Vector3.new()
                hrp.CFrame = hrp.CFrame + (v * (Config.FlySpeed / 50))
            end
        end
        
        if speedActive and not flyActive and hum.MoveDirection.Magnitude > 0 then
            if Config.SpeedMethod == "Velocity" then
                hrp.Velocity = Vector3.new(hum.MoveDirection.X * Config.SpeedValue, hrp.Velocity.Y, hum.MoveDirection.Z * Config.SpeedValue)
            elseif Config.SpeedMethod == "CFrame" then
                hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (Config.SpeedValue / 100))
            end
        end

        if orbitActive and tar and tar.Character and tar.Character:FindFirstChild("HumanoidRootPart") then
            local tp = tar.Character.HumanoidRootPart.Position
            local ang = tick() * Config.OrbitSpeed
            hrp.CFrame = CFrame.new(tp.X + math.sin(ang)*Config.OrbitRadius, tp.Y, tp.Z + math.cos(ang)*Config.OrbitRadius)
        end

        if Config.WalkspeedEnabled then hum.WalkSpeed = Config.WalkspeedVal end
        if Config.JumppowerEnabled then hum.JumpPower = Config.JumppowerVal end
        if Config.HipheightEnabled then hum.HipHeight = Config.HipheightVal end

        if Config.Bunnyhop and hum:GetState() == Enum.HumanoidStateType.Landed then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        
        if Config.VoidSpam then
            local t = tick() * Config.VoidSpeed
            hrp.CFrame = CFrame.new(hrp.Position.X + math.sin(t)*30, (t%2 > 1 and -100 or hrp.Position.Y), hrp.Position.Z + math.cos(t)*30)
        end
    end
end)

UIS.JumpRequest:Connect(function() if Config.InfJump and IsAuth and LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)
if Config.AntiAfk then pcall(function() for _,c in pairs(getconnections(LP.Idled)) do c:Disable() end end) end

SelectTab(T1, "Aimbot")
print("--- x_u private v20 Logic Built ---")
end)
if not success then warn("Crit Error: ", err) end
