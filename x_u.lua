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

local ran_name = function() local n = ""; for i=1,16 do n = n .. string.char(math.random(97,122)) end return n end
local crypt = function(s) local o = ""; for i=1,#s do o = o .. string.char(string.byte(s,i) + 1) end return o end -- Simple shift 1
local dc = function(s) local o = ""; for i=1,#s do o = o .. string.char(string.byte(s,i) - 1) end return o end

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
    SpeedEnabled = false, SpeedBind = "Unbound", SpeedMethod = "Velocity", SpeedValue = 50,
    WalkspeedEnabled = false, WalkspeedBind = "Unbound", WalkspeedVal = 30,
    JumppowerEnabled = false, JumppowerBind = "Unbound", JumppowerVal = 70,
    HipheightEnabled = false, HipheightBind = "Unbound", HipheightVal = 2,
    Bunnyhop = false, InfJump = false, AntiAfk = false,
    VoidSpam = false, VoidSpamBind = "Unbound", VoidSpeed = 15,
    
    -- Dropdown Defaults
    AimMethod = "Camera", AimStyle = "Linear", TargetMode = "Distance", TargetHitboxes = "Head", Checks = "Visible Only",
    
    -- Visuals
    ESPEnabled = false, NameESP = false, Skeleton = false, Chams = false, Arrows = false
}

local function SaveConfig() pcall(function() if not isfolder("xu_configs") then makefolder("xu_configs") end writefile("xu_configs/" .. Config.ConfigName .. ".json", Http:JSONEncode(Config)) print("x_u: Saved") end) end
local function LoadConfig() pcall(function() if isfile("xu_configs/" .. Config.ConfigName .. ".json") then local d = Http:JSONDecode(readfile("xu_configs/" .. Config.ConfigName .. ".json")); for k,v in pairs(d) do Config[k] = v end print("x_u: Loaded") end end) end

local k1 = {73, 104, 97, 116, 101, 121, 111, 117, 115, 111, 109, 117, 99, 104, 110, 101, 118, 101, 114, 116, 97, 108, 107, 116, 111, 109, 101}
local k2 = {118, 105, 118, 105, 100, 50, 48, 50, 54}
local function Validate(input) local function c(a) if #input ~= #a then return false end for i=1,#input do if string.byte(input, i) ~= a[i] then return false end end return true end; if c(k1) then return "vin" end if c(k2) then return "vivid" end return nil end

local Theme = { BG = Color3.fromRGB(0, 0, 0), Line = Color3.fromRGB(45, 45, 50), Accent = Color3.fromRGB(180, 0, 0), Text = Color3.fromRGB(240, 240, 240), TextDark = Color3.fromRGB(150, 150, 160), Btn = Color3.fromRGB(25, 25, 30) }
local UI = Instance.new("ScreenGui"); UI.Name = ran_name(); UI.ZIndexBehavior = Enum.ZIndexBehavior.Global; UI.ResetOnSpawn = false
pcall(function() if gethui then UI.Parent = gethui() elseif game:GetService("CoreGui") then UI.Parent = game:GetService("CoreGui") else UI.Parent = LP:WaitForChild("PlayerGui") end end)

local AuthMain = Instance.new("Frame", UI); AuthMain.Name = ran_name(); AuthMain.Size = UDim2.new(0, 300, 0, 180); AuthMain.Position = UDim2.new(0.5, -150, 0.5, -90); AuthMain.BackgroundColor3 = Color3.fromRGB(0, 0, 0); AuthMain.BorderSizePixel = 0; AuthMain.Active = true; local C1 = Instance.new("UICorner", AuthMain); C1.Name = ran_name(); C1.CornerRadius = UDim.new(0, 6); local S1 = Instance.new("UIStroke", AuthMain); S1.Name = ran_name(); S1.Color = Theme.Line
local AuthTitle = Instance.new("TextLabel", AuthMain); AuthTitle.Name = ran_name(); AuthTitle.Size = UDim2.new(1, 0, 0, 40); AuthTitle.BackgroundTransparency = 1; AuthTitle.Text = dc("QSJWBUF!BDDFTT"); AuthTitle.Font = Enum.Font.GothamBold; AuthTitle.TextSize = 16; AuthTitle.TextColor3 = Theme.Accent; local F_Line = Instance.new("Frame", AuthMain); F_Line.Name = ran_name(); F_Line.Size = UDim2.new(1, 0, 0, 1); F_Line.Position = UDim2.new(0, 0, 0, 40); F_Line.BackgroundColor3 = Theme.Line; F_Line.BorderSizePixel = 0
local InputContainer = Instance.new("Frame", AuthMain); InputContainer.Name = ran_name(); InputContainer.Size = UDim2.new(1, -40, 0, 35); InputContainer.Position = UDim2.new(0, 20, 0, 65); InputContainer.BackgroundColor3 = Theme.Btn; local C2 = Instance.new("UICorner", InputContainer); C2.Name = ran_name(); C2.CornerRadius = UDim.new(0, 4)
local FakeLabel = Instance.new("TextLabel", InputContainer); FakeLabel.Name = ran_name(); FakeLabel.Size = UDim2.new(1, -10, 1, 0); FakeLabel.Position = UDim2.new(0, 5, 0, 0); FakeLabel.BackgroundTransparency = 1; FakeLabel.Text = ""; FakeLabel.TextColor3 = Theme.Text; FakeLabel.Font = Enum.Font.Gotham; FakeLabel.TextSize = 13; FakeLabel.TextXAlignment = Enum.TextXAlignment.Left
local KeyInput = Instance.new("TextBox", InputContainer); KeyInput.Name = ran_name(); KeyInput.Size = UDim2.new(1, -10, 1, 0); KeyInput.Position = UDim2.new(0, 5, 0, 0); KeyInput.BackgroundTransparency = 1; KeyInput.Text = ""; KeyInput.PlaceholderText = dc("Foufs!Lfz///"); KeyInput.TextColor3 = Theme.Text; KeyInput.TextTransparency = 1; KeyInput.Font = Enum.Font.Gotham; KeyInput.TextSize = 13; KeyInput.TextXAlignment = Enum.TextXAlignment.Left; KeyInput.ClearTextOnFocus = false; KeyInput.ZIndex = 2
KeyInput:GetPropertyChangedSignal("Text"):Connect(function() FakeLabel.Text = string.rep("*", #KeyInput.Text); if #KeyInput.Text == 0 then FakeLabel.Text = ""; KeyInput.PlaceholderText = dc("Foufs!Lfz///") else KeyInput.PlaceholderText = "" end end)
local AuthBtn = Instance.new("TextButton", AuthMain); AuthBtn.Name = ran_name(); AuthBtn.Size = UDim2.new(1, -40, 0, 35); AuthBtn.Position = UDim2.new(0, 20, 0, 115); AuthBtn.BackgroundColor3 = Theme.Line; AuthBtn.Text = dc("Mphjo"); AuthBtn.TextColor3 = Theme.Text; AuthBtn.Font = Enum.Font.GothamMedium; AuthBtn.TextSize = 14; local C3 = Instance.new("UICorner", AuthBtn); C3.Name = ran_name(); C3.CornerRadius = UDim.new(0, 4)

local Main = Instance.new("Frame", UI); Main.Name = ran_name(); Main.Size = UDim2.new(0, 630, 0, 500); Main.Position = UDim2.new(0.5, -315, 0.5, -250); Main.BackgroundColor3 = Theme.BG; Main.BorderSizePixel = 0; Main.Active = true; Main.Visible = false; local C4 = Instance.new("UICorner", Main); C4.Name = ran_name(); C4.CornerRadius = UDim.new(0, 6); local S2 = Instance.new("UIStroke", Main); S2.Name = ran_name(); S2.Color = Theme.Line
local function make_draggable(f) local d, sp, sm; f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true; sm = i.Position; sp = f.Position end end); UIS.InputChanged:Connect(function(i) if d and i.UserInputType == Enum.UserInputType.MouseMovement then f.Position = UDim2.new(sp.X.Scale, sp.X.Offset + (i.Position.X - sm.X), sp.Y.Scale, sp.Y.Offset + (i.Position.Y - sm.Y)) end end); f.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end) end
make_draggable(Main); make_draggable(AuthMain)

local IsAuth = false
AuthBtn.MouseButton1Click:Connect(function() local kt = KeyInput.Text; local u = Validate(kt); if u or kt == "vin" then IsAuth = true; InputContainer.Visible = false; local greet = (kt == "vin") and "Welcome Owner" or (dc("Xfmdpnf!") .. u); for i = 1, 3 do AuthBtn.Text = greet .. string.rep(".", i); task.wait(0.3) end; AuthMain:Destroy(); Main.Visible = true; LoadConfig() else KeyInput.Text = ""; FakeLabel.Text = ""; KeyInput.PlaceholderText = dc("Inwbmje!Lfz-"); task.wait(1.5); KeyInput.PlaceholderText = dc("Foufs!Lfz///") end end)

local Title = Instance.new("TextLabel", Main); Title.Name = ran_name(); Title.Size = UDim2.new(0, 150, 0, 50); Title.Position = UDim2.new(0, 20, 0, 0); Title.BackgroundTransparency = 1; Title.Text = dc("y`v!qsjwbuf"); Title.Font = Enum.Font.GothamBold; Title.TextSize = 20; Title.TextColor3 = Theme.Accent; Title.TextXAlignment = Enum.TextXAlignment.Left
local F1 = Instance.new("Frame", Main); F1.Name = ran_name(); F1.Size = UDim2.new(1, 0, 0, 1); F1.Position = UDim2.new(0, 0, 0, 50); F1.BackgroundColor3 = Theme.Line; F1.BorderSizePixel = 0
local F2 = Instance.new("Frame", Main); F2.Name = ran_name(); F2.Size = UDim2.new(0, 1, 1, -50); F2.Position = UDim2.new(0, 140, 0, 50); F2.BackgroundColor3 = Theme.Line; F2.BorderSizePixel = 0

local TopTabCont = Instance.new("Frame", Main); TopTabCont.Name = ran_name(); TopTabCont.Size = UDim2.new(0, 400, 0, 50); TopTabCont.Position = UDim2.new(0, 160, 0, 0); TopTabCont.BackgroundTransparency = 1; local L1 = Instance.new("UIListLayout", TopTabCont); L1.Name = ran_name(); L1.FillDirection = Enum.FillDirection.Horizontal; L1.Padding = UDim.new(0, 15); L1.VerticalAlignment = Enum.VerticalAlignment.Center
local SideTabCont = Instance.new("Frame", Main); SideTabCont.Name = ran_name(); SideTabCont.Size = UDim2.new(0, 140, 1, -50); SideTabCont.Position = UDim2.new(0, 0, 0, 50); SideTabCont.BackgroundTransparency = 1; local L2 = Instance.new("UIListLayout", SideTabCont); L2.Name = ran_name(); L2.Padding = UDim.new(0, 2); L2.HorizontalAlignment = Enum.HorizontalAlignment.Center
local ContentCont = Instance.new("Frame", Main); ContentCont.Name = ran_name(); ContentCont.Size = UDim2.new(1, -140, 1, -50); ContentCont.Position = UDim2.new(0, 140, 0, 50); ContentCont.BackgroundTransparency = 1

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
    local F = Instance.new("Frame", parent); F.Name = ran_name(); F.Size = UDim2.new(1, 0, 0, 35); F.BackgroundTransparency = 1
    local L = Instance.new("TextLabel", F); L.Name = ran_name(); L.Text = text; L.Font = Enum.Font.Gotham; L.TextColor3 = Theme.TextDark; L.TextSize = 12; L.Size = UDim2.new(1, 0, 0, 12); L.BackgroundTransparency = 1; L.TextXAlignment = Enum.TextXAlignment.Left; L.Position = UDim2.new(0, 10, 0, 0)
    local V = Instance.new("TextLabel", F); V.Name = ran_name(); V.Text = tostring(defaultVal); V.Font = Enum.Font.Gotham; V.TextColor3 = Theme.TextDark; V.TextSize = 12; V.Size = UDim2.new(1, -5, 0, 12); V.BackgroundTransparency = 1; V.TextXAlignment = Enum.TextXAlignment.Right
    local Tr = Instance.new("Frame", F); Tr.Name = ran_name(); Tr.Size = UDim2.new(1, -20, 0, 4); Tr.Position = UDim2.new(0, 10, 1, -10); Tr.BackgroundColor3 = Theme.Btn; local C = Instance.new("UICorner", Tr); C.CornerRadius = UDim.new(1,0)
    local Fil = Instance.new("Frame", Tr); Fil.Name = ran_name(); Fil.Size = UDim2.new((defaultVal-min)/(max-min), 0, 1, 0); Fil.BackgroundColor3 = Theme.Accent; Fil.BorderSizePixel = 0; local C2 = Instance.new("UICorner", Fil); C2.CornerRadius = UDim.new(1,0)
    local Hit = Instance.new("TextButton", F); Hit.Name = ran_name(); Hit.Size = UDim2.new(1, 0, 1, 0); Hit.BackgroundTransparency = 1; Hit.Text = ""
    local d = false
    Hit.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = true end end); UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
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

local T_Aim = CreateTopTab(dc("Bjncpu"))
local T_Main = CreateTopTab(dc("Nbjo"))
local T_Sett = CreateTopTab(dc("Tfuujoht"))

-- /// AIMBOT TAB /// --
local S1 = CreateSideTab(T_Aim, dc("Bjncpu"))
AddToggle(S1, dc("Fobcmf"), Config.AimEnabled, function(v) Config.AimEnabled = v end, Config.AimBind, function(v) Config.AimBind = v end)
AddToggle(S1, dc("Tjmfou!Bjn"), Config.SilentAim, function(v) Config.SilentAim = v; if v and InitHooks then InitHooks() end end, Config.SilentAimBind, function(v) Config.SilentAimBind = v end)
AddDropdown(S1, dc("Bjn!Nfuipe"), {dc("Npvtf"), dc("Dbnfsb")}, Config.AimMethod, function(v) Config.AimMethod = v end)
AddDropdown(S1, dc("Bjn!Tuzmf"), {dc("Mjofbs"), dc("Fyqpofoujbm")}, Config.AimStyle, function(v) Config.AimStyle = v end)
AddDropdown(S1, dc("Ubshfujoh!Npef"), {dc("Dmptftu!up!Dspttibjs"), dc("Ejtubodf")}, Config.TargetMode, function(v) Config.TargetMode = v end)
AddDropdown(S1, dc("Ubshfu!Ijucpyft"), {dc("Ifbe"), dc("Upstp"), dc("Sboepn")}, Config.TargetHitboxes, function(v) Config.TargetHitboxes = v end)
AddDropdown(S1, dc("Difdlt"), {dc("Wjtjcmf!Pomz"), dc("Opof")}, Config.Checks, function(v) Config.Checks = v end)
AddToggle(S1, dc("Tujdlz!Bjn"), Config.StickyAim, function(v) Config.StickyAim = v end)

-- /// TRIGGERBOT TAB /// --
local S2 = CreateSideTab(T_Aim, dc("Usjhhfscpu"))
AddToggle(S2, dc("Fobcmf"), Config.TrigEnabled, function(v) Config.TrigEnabled = v end, Config.TrigBind, function(v) Config.TrigBind = v end)
AddSlider(S2, dc("Efmbz"), Config.TrigDelay, 0, 250, function(v) Config.TrigDelay = v end)
AddSlider(S2, dc("Dmjdl!Evsbujpo!)nt*"), Config.TrigClickDur, 0, 250, function(v) Config.TrigClickDur = v end)
AddSlider(S2, dc("Ijudibodf"), Config.TrigHitchance, 0, 100, function(v) Config.TrigHitchance = v end)
AddSlider(S2, dc("Nby!Ejtubodf"), Config.TrigMaxDist, 0, 2500, function(v) Config.TrigMaxDist = v end)
AddToggle(S2, dc("Qsfejdujpo"), Config.TrigPrediction, function(v) Config.TrigPrediction = v end)
AddDropdown(S2, dc("Ijucpyft"), {dc("Ifbe"), dc("Upstp"), dc("Cpui")}, Config.TrigHitboxes, function(v) Config.TrigHitboxes = v end)
AddDropdown(S2, dc("Difdlt"), {dc("Wjtjcmf!Pomz"), dc("Opof")}, Config.TrigChecks, function(v) Config.TrigChecks = v end)

-- /// VISUALS (ESP) TAB /// --
local S_Vis = CreateSideTab(T_Main, dc("FTQ"))
AddToggle(S_Vis, dc("Fobcmf!FTQ"), Config.ESPEnabled, function(v) Config.ESPEnabled = v end)
AddToggle(S_Vis, dc("Obnf!FTQ"), Config.NameESP, function(v) Config.NameESP = v end)
AddToggle(S_Vis, dc("Tlfmfupo!FTQ"), Config.Skeleton, function(v) Config.Skeleton = v end)
AddToggle(S_Vis, dc("Dsjntpo!Dibnt"), Config.Chams, function(v) Config.Chams = v end)
AddToggle(S_Vis, dc("Pggtdsffo!Bsspxt"), Config.Arrows, function(v) Config.Arrows = v end)

-- /// INTERACT TAB /// --
local S_Spec = CreateSideTab(T_Main, dc("Tqfdubuf"))
local function UpdatePlayerList()
    for _,c in pairs(S_Spec:GetChildren()) do if not c:IsA("UIListLayout") then c:Destroy() end end
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LP then
            local row = Instance.new("Frame", S_Spec); row.Size = UDim2.new(1, 0, 0, 30); row.BackgroundTransparency = 1
            local name = Instance.new("TextLabel", row); name.Text = p.Name; name.Size = UDim2.new(1, -120, 1, 0); name.Position = UDim2.new(0, 10, 0, 0); name.BackgroundTransparency = 1; name.TextColor3 = Theme.Text; name.Font = Enum.Font.Gotham; name.TextSize = 12; name.TextXAlignment = Enum.TextXAlignment.Left
            local sp = Instance.new("TextButton", row); sp.Text = dc("Tqfd"); sp.Size = UDim2.new(0, 50, 0, 20); sp.Position = UDim2.new(1, -110, 0.5, -10); sp.BackgroundColor3 = Theme.Btn; sp.TextColor3 = Theme.Text; sp.Font = Enum.Font.Gotham; sp.TextSize = 10; Instance.new("UICorner", sp)
            local tp = Instance.new("TextButton", row); tp.Text = dc("Ufmfqpsu"); tp.Size = UDim2.new(0, 50, 0, 20); tp.Position = UDim2.new(1, -55, 0.5, -10); tp.BackgroundColor3 = Theme.Btn; tp.TextColor3 = Theme.Text; tp.Font = Enum.Font.Gotham; tp.TextSize = 10; Instance.new("UICorner", tp)
            
            sp.MouseButton1Click:Connect(function() 
                if Camera.CameraSubject == p.Character:FindFirstChild("Humanoid") then
                    if LP.Character and LP.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = LP.Character.Humanoid end
                else
                    if p.Character and p.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = p.Character.Humanoid end
                end
            end)
            tp.MouseButton1Click:Connect(function() 
                if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then 
                    LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end 
            end)
        end
    end
end
UpdatePlayerList(); Players.PlayerAdded:Connect(UpdatePlayerList); Players.PlayerRemoving:Connect(UpdatePlayerList)

-- /// MISC TAB /// --
local S_Misc = CreateSideTab(T_Main, dc("Njtd"))
local Fly_Exp = AddToggle(S_Misc, dc("Gmz"), Config.FlyEnabled, function(v) Config.FlyEnabled = v end, Config.FlyBind, function(v) Config.FlyBind = v end)
AddDropdown(Fly_Exp, dc("Fmz!Nfuipe"), {dc("Wfmpdjuz"), dc("DGsbnf")}, Config.FlyMethod, function(v) Config.FlyMethod = v end)
AddSlider(Fly_Exp, dc("Fmz!Tqffe"), Config.FlySpeed, 0, 500, function(v) Config.FlySpeed = v end)

local Spd_Exp = AddToggle(S_Misc, dc("Tqffe"), Config.SpeedEnabled, function(v) Config.SpeedEnabled = v end, Config.SpeedBind, function(v) Config.SpeedBind = v end)
AddDropdown(Spd_Exp, dc("Tqffe!Nfuipe"), {dc("Wfmpdjuz"), dc("DGsbnf")}, Config.SpeedMethod, function(v) Config.SpeedMethod = v end)
AddSlider(Spd_Exp, dc("Tqffe!Wbmvf"), Config.SpeedValue, 0, 500, function(v) Config.SpeedValue = v end)

local Ws_Exp = AddToggle(S_Misc, dc("Xbmltqffe"), Config.WalkspeedEnabled, function(v) Config.WalkspeedEnabled = v end, Config.WalkspeedBind, function(v) Config.WalkspeedBind = v end)
AddSlider(Ws_Exp, dc("Wbmvf"), Config.WalkspeedVal, 16, 500, function(v) Config.WalkspeedVal = v end)

local Jp_Exp = AddToggle(S_Misc, dc("Kvnqqpxfs"), Config.JumppowerEnabled, function(v) Config.JumppowerEnabled = v end, Config.JumppowerBind, function(v) Config.JumppowerBind = v end)
AddSlider(Jp_Exp, dc("Wbmvf"), Config.JumppowerVal, 50, 500, function(v) Config.JumppowerVal = v end)

AddToggle(S_Misc, dc("Bouj!Bgl"), Config.AntiAfk, function(v) Config.AntiAfk = v end)

local Vd_Exp = AddToggle(S_Misc, dc("Wpje!Tqbn"), Config.VoidSpam, function(v) Config.VoidSpam = v end, Config.VoidSpamBind, function(v) Config.VoidSpamBind = v end)
AddSlider(Vd_Exp, dc("Vpje!Tqffe"), Config.VoidSpeed, 1, 50, function(v) Config.VoidSpeed = v end)

-- /// SETTINGS /// --
local S4 = CreateSideTab(T_Sett, dc("Nbjo"))
AddToggle(S4, dc("Tusfbn!Qsppg"), Config.StreamProof, function(v) Config.StreamProof = v; UI.DisplayOrder = v and -100 or 100; if v then pcall(function() if gethui then UI.Parent = gethui() end end) end end)
AddToggle(S4, dc("Nfov!Lfz"), Config.MenuKey, function(v) end, Config.MenuKey, function(v) Config.MenuKey = v end)
local function cbtn(p,t,c) local b=Instance.new("TextButton",p);b.Name=ran_name();b.Size=UDim2.new(1,0,0,25);b.BackgroundColor3=Theme.Line;b.Text=t;b.TextColor3=Theme.Text;b.Font=Enum.Font.Gotham;b.TextSize=12;Instance.new("UICorner",b).CornerRadius=UDim.new(0,4);b.MouseButton1Click:Connect(c) end
cbtn(S4, dc("Vompbe!Dmjfou"), function() UI:Destroy() end)

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
    if not (LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")) then return nil end
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

local _G_sa = false
local _G_gt = nil
local _G_ih = false

getgenv().InitHooks = function()
    if _G_ih then return end
    _G_ih = true
    local _old
    _old = hookmetamethod(game, "__index", newcclosure(function(self, k)
        if not checkcaller() and type(k) == "string" then
            if _G_sa and self == Mouse and (k == "Hit" or k == "Target") and _G_gt and _G_gt.Character then
                local p = GetTargetPart(_G_gt.Character)
                if p then return (k == "Hit" and p.CFrame or p) end
            elseif k == "WalkSpeed" or k == "JumpPower" then
                local s, c = pcall(function() return _old(self, "ClassName") end)
                if s and c == "Humanoid" then
                    if k == "WalkSpeed" then return 16 end
                    if k == "JumpPower" then return 50 end
                end
            end
        end
        return _old(self, k)
    end))
end

RS.Heartbeat:Connect(function()
    if not IsAuth then return end
    
    -- Menu Key Toggle
    if UIS:GetFocusedTextBox() == nil then
        if UIS:IsKeyDown(Enum.KeyCode[Config.MenuKey]) or UIS:IsMouseButtonPressed(Enum.UserInputType[Config.MenuKey] or Enum.UserInputType.None) then
            task.wait(0.2)
            Main.Visible = not Main.Visible
        end
    end
    
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
    local speedActive = checkBind(Config.SpeedBind); if Config.SpeedBind == "Unbound" then speedActive = Config.SpeedEnabled end

    -- Active Target & Feature Logic (Optimization: Only run if tracking is actually needed)
    local tar = nil
    if aimActive or silentActive or trigActive then
        tar = get_target()

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
        _G_gt = tar
        _G_sa = silentActive

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
    else
        _G_sa = false
        _G_gt = nil
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

        if Config.WalkspeedEnabled then hum.WalkSpeed = Config.WalkspeedVal end
        if Config.JumppowerEnabled then hum.JumpPower = Config.JumppowerVal end
        if Config.HipheightEnabled then hum.HipHeight = Config.HipheightVal end

        if Config.Bunnyhop and hum:GetState() == Enum.HumanoidStateType.Landed then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        
        if Config.VoidSpam then
            local t = tick() * Config.VoidSpeed
            hrp.CFrame = CFrame.new(hrp.Position.X + math.sin(t)*30, -5000, hrp.Position.Z + math.cos(t)*30)
        end
    end

    -- Visuals Engine
    if not Config.ESPEnabled then return end

    local tgtUI = UI.Parent or UI
    local chamsFolder = tgtUI:FindFirstChild("ChamsTracker")
    if not chamsFolder then chamsFolder = Instance.new("Folder", tgtUI); chamsFolder.Name = "ChamsTracker" end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            local char = p.Character
            local hrp = char.HumanoidRootPart
            local hum = char.Humanoid
            if hum.Health > 0 then
                
                -- Chams (Adonis Bypass: Parent to CoreGui/PlayerGui, map to Adornee)
                local highlightName = "cham_" .. p.Name
                local highlight = chamsFolder:FindFirstChild(highlightName)
                if Config.Chams then
                    if not highlight then
                        highlight = Instance.new("Highlight", chamsFolder); highlight.Name = highlightName
                        highlight.Adornee = char
                        highlight.FillColor = Theme.Accent; highlight.OutlineColor = Theme.Text; highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    end
                elseif highlight then
                    highlight:Destroy()
                end
                
                -- Name ESP (Adonis Bypass: Parent to CoreGui/PlayerGui, map to Adornee)
                local nameName = "name_" .. p.Name
                local nameTag = chamsFolder:FindFirstChild(nameName)
                if Config.NameESP then
                    if not nameTag then
                        nameTag = Instance.new("BillboardGui", chamsFolder); nameTag.Name = nameName
                        nameTag.Adornee = hrp
                        nameTag.Size = UDim2.new(0, 200, 0, 50); nameTag.StudsOffset = Vector3.new(0, 3.5, 0); nameTag.AlwaysOnTop = true
                        local txt = Instance.new("TextLabel", nameTag)
                        txt.Size = UDim2.new(1, 0, 1, 0); txt.BackgroundTransparency = 1; txt.Text = p.Name; txt.TextColor3 = Theme.Text; txt.Font = Enum.Font.GothamBold; txt.TextSize = 14
                        local stroke = Instance.new("UIStroke", txt); stroke.Color = Color3.fromRGB(0,0,0); stroke.Thickness = 1
                    end
                elseif nameTag then
                    nameTag:Destroy()
                end
                
                -- Offscreen Arrows & Skeleton Logic Foundations
                if Config.Skeleton or Config.Arrows then
                    local _, vis = Camera:WorldToViewportPoint(hrp.Position)
                    if not vis and Config.Arrows then
                        -- Arrow rendering logic placeholder
                    end
                end
                
            end
        end
    end
end)

UIS.JumpRequest:Connect(function() if Config.InfJump and IsAuth and LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end)
if Config.AntiAfk then pcall(function() for _,c in pairs(getconnections(LP.Idled)) do c:Disable() end end) end

SelectTab(T_Aim, dc("Bjncpu"))
print("--- x_u private v20 Logic Built ---")
end)
if not success then warn("Crit Error: ", err) end
