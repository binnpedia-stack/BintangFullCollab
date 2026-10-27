-- BINTANGHUB V28 ULTIMATE | Violence District
-- Full Merge Leenz + W424 | Auto-Mapping Features

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==========================================
-- 1. INJECT LEENZ (Luarmor Bypass)
-- ==========================================
print("[*] Injecting Leenz66...")
local original_loadstring = loadstring or load
local SandboxEnv = setmetatable({}, {__index = getfenv()})
local captured_payload = nil

SandboxEnv.loadstring = function(code, name) 
    if type(code) == "string" and #code > 100 then captured_payload = code end 
    return original_loadstring(code, name) 
end
SandboxEnv.HttpGet = function(url) return "return function() end" end
SandboxEnv.HttpPost = function(opts) return {Body = '{"success":true}', StatusCode = 200} end

local loaderCode = game:HttpGet("https://api.luarmor.net/files/v4/loaders/82419a6df8b5b0d7c91a6affe9f3fb04.lua")
local fn = original_loadstring(loaderCode)
if fn then setfenv(fn, SandboxEnv); pcall(fn) end

if not captured_payload then
    local payloadUrl = loaderCode:match('https://api%.luarmor%.net/files/v4/protected_scripts/[^"]+') 
    if payloadUrl then captured_payload = game:HttpGet(payloadUrl) end
end
if captured_payload then 
    local realFn = original_loadstring(captured_payload)
    if realFn then pcall(realFn) end 
end
task.wait(2)

-- ==========================================
-- 2. INJECT W424 (Luraph Hook)
-- ==========================================
print("[*] Injecting W424...")
local old_getfenv = getfenv
local function hook_env(env)
    local fake_env = setmetatable({}, {
        __index = env,
        __newindex = function(t, k, v)
            if type(k) == "string" then getgenv()[k] = v end
            rawset(t, k, v)
        end
    })
    return fake_env
end

getfenv = function(level) return hook_env(old_getfenv(level)) end
pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/willrev-424/W424HUB/refs/heads/main/W424Hub_VD.lua"))() end)
getfenv = old_getfenv
task.wait(2)

-- ==========================================
-- 3. CLEANUP UI ASLI
-- ==========================================
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui:IsA("ScreenGui") then
        local name = gui.Name:lower()
        if name:find("w424") or name:find("leenz") or name:find("hub") or name:find("vd") then
            gui:Destroy() 
        end
    end
end

-- ==========================================
-- 4. BINTANGHUB UI (FULL PREMIUM)
-- ==========================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "BINTANGHUB | V28 ULTIMATE",
   LoadingTitle = "BINTANGHUB",
   LoadingSubtitle = "Leenz x W424",
   KeySystem = false, Theme = "Crimson"
})

local TabSurvivor = Window:CreateTab("Survivor", 4483362458)
local TabKiller = Window:CreateTab("Killer", 4483362458)
local TabESP = Window:CreateTab("ESP & Visuals", 4483362458)
local TabCam = Window:CreateTab("Camera", 4483362458)

-- SURVIVOR TAB (Full Features)
TabSurvivor:CreateSection("Skillcheck")
TabSurvivor:CreateToggle({Name = "Enable Auto Skillcheck", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.AutoSkill = v end
    if getgenv().Config then getgenv().Config.AutoSkill = v end
    if getgenv().SkillCheck then getgenv().SkillCheck = v end
end})
TabSurvivor:CreateDropdown({Name = "Skillcheck Mode", Options = {"Legit", "Normal", "Instan"}, CurrentOption = {"Normal"}, Callback = function(o) 
    if getgenv().W424HUB then getgenv().W424HUB.SkillMode = o[1] end
    if getgenv().SkillMode then getgenv().SkillMode = o[1] end
end})

TabSurvivor:CreateSection("Auto Parry (Full Settings)")
TabSurvivor:CreateToggle({Name = "Enable Auto Parry", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.AutoParry = v end
    if getgenv().AutoParry then getgenv().AutoParry = v end
end})
TabSurvivor:CreateDropdown({Name = "Parry Mode", Options = {"Safe", "Agresif"}, CurrentOption = {"Safe"}, Callback = function(o) 
    if getgenv().W424HUB then getgenv().W424HUB.ParryMode = o[1] end
    if getgenv().ParryMode then getgenv().ParryMode = o[1] end
end})
TabSurvivor:CreateSlider({Name = "Parry Radius", Range = {5, 50}, Increment = 1, CurrentValue = 20, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.ParryRadius = v end
    if getgenv().ParryRadius then getgenv().ParryRadius = v end
end})
TabSurvivor:CreateToggle({Name = "Anti-Fake Hit", CurrentValue = true, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.AntiFake = v end
    if getgenv().AntiFake then getgenv().AntiFake = v end
end})

TabSurvivor:CreateSection("Movement & Abilities")
TabSurvivor:CreateToggle({Name = "Fast Vault (Unlimited)", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.FastVault = v end
    if getgenv().FastVault then getgenv().FastVault = v end
    if getgenv().UnlimitedVault then getgenv().UnlimitedVault = v end
end})
TabSurvivor:CreateToggle({Name = "Auto Dodge Abyss", CurrentValue = false, Callback = function(v) 
    if getgenv().AutoDodge then getgenv().AutoDodge = v end
end})
TabSurvivor:CreateToggle({Name = "Gene Boost", CurrentValue = false, Callback = function(v) 
    if getgenv().GeneBoost then getgenv().GeneBoost = v end
end})

-- KILLER TAB
TabKiller:CreateSection("Combat")
TabKiller:CreateToggle({Name = "Auto M1 / Hit", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.AutoM1 = v end
    if getgenv().AutoHit then getgenv().AutoHit = v end
    if getgenv().AutoM1 then getgenv().AutoM1 = v end
end})
TabKiller:CreateToggle({Name = "Auto Drop Pallet", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.AutoPallet = v end
    if getgenv().AutoPallet then getgenv().AutoPallet = v end
end})
TabKiller:CreateToggle({Name = "Bypass Parry", CurrentValue = false, Callback = function(v) 
    if getgenv().BypassParry then getgenv().BypassParry = v end
end})
TabKiller:CreateToggle({Name = "Dodge Slash Abyss", CurrentValue = false, Callback = function(v) 
    if getgenv().DodgeSlash then getgenv().DodgeSlash = v end
end})

-- ESP TAB
TabESP:CreateSection("Player ESP")
TabESP:CreateToggle({Name = "ESP Survivor", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.ESPSurvivor = v end
    if getgenv().ESPSurvivor then getgenv().ESPSurvivor = v end
end})
TabESP:CreateToggle({Name = "ESP Killer", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.ESPKiller = v end
    if getgenv().ESPKiller then getgenv().ESPKiller = v end
end})

TabESP:CreateSection("Object ESP")
TabESP:CreateToggle({Name = "ESP Generator", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.ESPGen = v end
    if getgenv().ESPGen then getgenv().ESPGen = v end
end})
TabESP:CreateToggle({Name = "ESP Pallet", CurrentValue = false, Callback = function(v) 
    if getgenv().ESPPallet then getgenv().ESPPallet = v end
end})
TabESP:CreateToggle({Name = "ESP Hook", CurrentValue = false, Callback = function(v) 
    if getgenv().ESPHook then getgenv().ESPHook = v end
end})
TabESP:CreateToggle({Name = "ESP Window", CurrentValue = false, Callback = function(v) 
    if getgenv().ESPWindow then getgenv().ESPWindow = v end
end})

TabESP:CreateSection("Visuals")
TabESP:CreateToggle({Name = "Fullbright", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.Fullbright = v end
    if getgenv().Fullbright then getgenv().Fullbright = v end
    Lighting.Brightness = v and 3 or 1
    Lighting.ClockTime = v and 14 or 0
    Lighting.GlobalShadows = not v
end})

-- CAMERA TAB
TabCam:CreateSlider({Name = "Camera FOV", Range = {70, 120}, Increment = 1, CurrentValue = 70, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.CameraFOV = v end
    Camera.FieldOfView = v
end})
TabCam:CreateToggle({Name = "DBD Camera Mode", CurrentValue = false, Callback = function(v) 
    if getgenv().W424HUB then getgenv().W424HUB.CameraDBD = v end
    if getgenv().CameraDBD then getgenv().CameraDBD = v end
    if getgenv().DBDCamera then getgenv().DBDCamera = v end
end})

-- ==========================================
-- 5. FALLBACK ESP (KALAU DUA SCRIPT GAGAL)
-- ==========================================
local espCache = {}
local function ApplyHighlight(obj, color)
    if not obj then return end
    local hl = Instance.new("Highlight")
    hl.Name = "BH_Highlight"
    hl.Adornee = obj
    hl.FillColor = color
    hl.FillTransparency = 0.4
    hl.OutlineColor = color
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = obj
    return hl
end

local function IsKiller(plr)
    local char = plr.Character
    if not char then return false end
    if plr.Team and (plr.Team.Name:lower():find("killer") or plr.Team.Name:lower():find("monster")) then return true end
    if char:FindFirstChildWhichIsA("Tool") then return true end
    local backpack = plr:FindFirstChild("Backpack")
    if backpack and backpack:FindFirstChildWhichIsA("Tool") then return true end
    return false
end

RunService.RenderStepped:Connect(function()
    if not getgenv().W424HUB then
        -- Cuma jalan kalo W424 nggak nge-handle FOV
        if not getgenv().CameraFOV then Camera.FieldOfView = Config.CameraFOV end
    end
    
    -- Fallback ESP
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local isKiller = IsKiller(plr)
                local espSurv = getgenv().ESPSurvivor or (getgenv().W424HUB and getgenv().W424HUB.ESPSurvivor)
                local espKill = getgenv().ESPKiller or (getgenv().W424HUB and getgenv().W424HUB.ESPKiller)
                
                local active = (isKiller and espKill) or (not isKiller and espSurv)
                
                if active then
                    local color = isKiller and Color3.fromRGB(255, 40, 40) or Color3.fromRGB(40, 255, 40)
                    if not espCache[plr] or not espCache[plr].Parent then espCache[plr] = ApplyHighlight(char, color) end
                    espCache[plr].Enabled = true
                elseif espCache[plr] then 
                    espCache[plr].Enabled = false 
                end
            end
        end
    end
end)

print("[BINTANGHUB V28] Leenz & W424 Fully Merged.")
