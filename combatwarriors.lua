local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local mouse = Players.LocalPlayer:GetMouse()
local nevermore_modules = rawget(require(game.ReplicatedStorage.Framework.Nevermore), "_lookupTable")
local network = rawget(nevermore_modules, "Network") -- network is the place where the remote handling shit is
local remotes_table = getupvalue(getsenv(network).GetEventHandler, 1)
local events_table = getupvalue(getsenv(network).GetFunctionHandler, 1)
local remotes = {}
local lines = {}
local texts = {}
local players = {}
local words = {
    "ez",
    "get good: get .gg/EzDK4AD5Yj",
    "trash",
    "touch grass",
    "retard",
    "i love among us",
    "the impostor?!?!?!",
    "grass? whats that",
    "having issues playing the game? get .gg/EzDK4AD5Yj",
    "is your dad spiderman? because he far from home",
    "do you ever have problems with light users parrying your ds???",
    "how are you that bad??🤣🤣😂🤣🤣",
    "EZ EZ EZ EZ EZ",
    "dont even bother insulting me 🤣🤣😂",
    "this script was brought to you by raid shadow legends!!",
    "do you like cheese?",
    "are you even trying to kill me???",
    "get rekt noobie",
    "go get .gg/EzDK4AD5Yj now",
    "imagine dying",
    ".gg/EzDK4AD5Yj on top (not really)",
    "L Bozo",
    "clapped",
    "nothing personel kid",
    "damn bro you got the whole squad laughing 😂😂🤣",
    "imagine targetting someone. but get clapped afterwards",
    "according to the rules. You should not be hacking because it can get you banned 🤓🤓🤓",
    "nerds be like: OMG LOOK AT THAT HACKER!!! LET'S GET HIM!!!🤓🤓🤓",
    "why am i still writing this? -Probably ZaneIs",
    "haha got you!!!",
    "how are you that bad??🤣😂",
    "нуб бозо",
    "my reaction to that information 😐",
    "OmG nO wAY a hACker!!!",
    "Super Idol的笑容",
    "goddamn i'm still writing -Probably ZaneIs",
    "have you ever heard the hitgame AmongUs???",
    "fr?",
    'skill issue',
    "touch grass losers",
    "this move is called 'Devious Lick'",
    "*Gorilla Sounds*",
    "What's up guys it's quandale dingle here.",
    "Bro got fake Jordans 💀",
    "Caught in 4K",
    "Turi ip ip",
    "Say goodbye to your Kneecaps"
}

local tpPlaces = {}
tpPlaces["beach"] = CFrame.new(-273.116028, 20.1849976, -80.4340057)
tpPlaces["the tower"] = CFrame.new(-94.5891647, 61.1295166, -78.1691742)
tpPlaces["the hill"] = CFrame.new(153.031464, 78.7295227, -149.325241)

getgenv().hitremote = nil
getgenv().swingremote = nil
getgenv().fallremote = nil
getgenv().ragdollremote = nil

-- will add all of these random lines into a config table later (maybe)
local walkspeed = 16
local infjump
local antidamage
local autospawn
local tracersenabled
local nofall
local textenabled
local noclip
local stompaura
local jumppower = 50
local teleport = false
local teleportCFrame
local killsay = false
local teleportPlayer
local killaura = false
local weapon
local distance = 25
local hidename = false
local autoair = false


getgenv().TracerColor = Color3.fromRGB(99, 13, 197)

-- the good ol anticheat bypass
-- combat warriors has the most retarded anticheat on earth
for i,v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "kick") then
        v.kick =  function()
            return
        end
    end

    if typeof(v) == 'table' and rawget(v, 'getIsBodyMoverCreatedByGame') then
		v.getIsBodyMoverCreatedByGame = function(among)
		    return true
		end
   end
   if typeof(v) == "table" and rawget(v, "randomDelayKick") then
    v.randomDelayKick = function()
        return wait(9e9)
    end
end
end

table.foreach(remotes_table, function(i,v)
    if rawget(v, "Remote") then
        remotes[rawget(v, "Remote")] = i
    end
end)

table.foreach(events_table, function(i,v)
    if rawget(v, "Remote") then
        remotes[rawget(v, "Remote")] = i
    end
end)


-- the retards at combat warriors detect if you make changes to the names so this is the second best method
local pog
pog = hookmetamethod(game, "__index", function(self, key)
    if (key == "Name" or key == "name") and remotes[self] then
       return remotes[self]
    end

    return pog(self, key)
end)


local function getRemote(name)
    for i,v in pairs(remotes) do
        if i.Name == name then
            return i
        end
    end
end

-- took this from devforums
local function getClosest()
    local hrp = Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position
    local closest_distance = math.huge
    local closest

    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Character ~= nil and v ~= Players.LocalPlayer and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v.Character:FindFirstChild("Humanoid").Health > 0 then
            local plr_pos = v.Character.HumanoidRootPart.Position
            local plr_distance = (hrp - plr_pos).Magnitude

            if plr_distance < distance then
                closest_distance = plr_distance
                closest = v
            end
        end
    end

    return closest
end


getgenv().hitremote = getRemote("MeleeDamage")
getgenv().swingremote = getRemote("MeleeSwing")
getgenv().fallremote = getRemote("TakeFallDamage")

for i,v in pairs(getgc(true)) do
    if typeof(v) == "table" and rawget(v, "connectCharacter") then
        v.connectCharacter = function(among)
            return
        end
    end
end



pcall(function()
    getRemote("TakeFallDamage"):FireServer(150)

    for i = 1,25 do
        getRemote("StartFastRespawn"):FireServer()
        getRemote("CompleteFastRespawn"):FireServer()
        wait()
    end
end)

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local window = Material.Load({
    Title = "Combat Warriors Script,
    Style = 3,
    SizeX = 400,
    SizeY = 300,
    Theme = "Dark"
})

window.Banner({
    Text = "false#7598"
})

local main = window.New({
    Title = "main"
})

local player = window.New({
    Title = "player"
})

local combat = window.New({
    Title = "combat"
})
local misc = window.New({
    Title = "misc"
})

local tp = window.New({
    Title = "teleports"
})

local visuals = window.New({
    Title = "visuals"
})


local plrTP = tp.Dropdown({
    Text = "player teleport",
    Callback = function(v)
        teleport = true
        teleportPlayer = v
        Players.LocalPlayer.Character.Humanoid.Health = 0
    end,
    Options = {}
})

plrTP:SetOptions(players)


Players.PlayerRemoving:Connect(function(v)
    if table.find(players, v.Name) then
        table.remove(players, players[v.Name])
    end
    plrTP:SetOptions(players)
end)

Players.LocalPlayer.leaderstats.Score.Changed:Connect(function()
    if killsay then
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(words[math.random(1, #words)])
    end
end)

for i,v in pairs(game.Players:GetPlayers()) do
    if v ~= Players.LocalPlayer then
        table.insert(players, v.Name)
        if v.Character then
            local line = Drawing.new("Line")
            line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
            line.Color = TracerColor
            line.Thickness = 2
            lines[v] = line

            local text = Drawing.new("Text")
            text.Text = v.Name
            text.Size = 20
            text.Outline = true
            text.OutlineColor = Color3.new(0,0,0)
            text.Center = true
            texts[v] = text
        end
        v.CharacterAdded:Connect(function()
            local line = Drawing.new("Line")
            line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
            line.Color = TracerColor
            line.Thickness = 2
            lines[v] = line

            local text = Drawing.new("Text")
            text.Text = v.Name
            text.Size = 20
            text.Outline = true
            text.OutlineColor = Color3.new(0,0,0)
            text.Center = true
            texts[v] = text
        end)
        v.CharacterRemoving:Connect(function()
            lines[v]:Remove()
            lines[v] = nil
            texts[v]:Remove()
            texts[v] = nil
        end)
    end
end

Players.PlayerAdded:Connect(function(v)
    table.insert(players, v.Name)
    plrTP:SetOptions(players)
    v.CharacterAdded:Connect(function()
        local line = Drawing.new("Line")
        line.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
        line.Color = TracerColor
        line.Thickness = 2
        lines[v] = line

        local text = Drawing.new("Text")
        text.Text = v.Name
        text.Size = 20
        text.Outline = true
        text.OutlineColor = Color3.new(0,0,0)
        text.Center = true
        texts[v] = text
    end)

    v.CharacterRemoving:Connect(function()
        lines[v]:Remove()
        lines[v] = nil
        texts[v]:Remove()
        texts[v] = nil
    end)
end)


main.Button({
    Text = "get all emotes",
    Callback = function()
        for i,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "gamepassIdRequired") then
                if v.gamepassIdRequired ==  "danceEmotes" then
                    v.gamepassIdRequired = nil
                elseif v.gamepassIdRequired == "toxicEmotes" then
                    v.gamepassIdRequired = nil
                elseif v.gamepassIdRequired == "respectEmotes" then
                    v.gamepassIdRequired = nil
                end
            end
        end
    end
})

main.Toggle({
    Text = "disable jump cooldown",
    Callback = function(val)
        for i,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "getCanJump") then
                local old = v.getCanJump
                if val then
                    v.getCanJump = function()
                        return true
                    end
                else
                    return old()
                end
            end
        end
    end
})

main.Toggle({
    Text = "infinite stamina",
    Callback = function(val)
        for i,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "_setStamina") then
                local old = v._setStamina
                v._setStamina = function(among, us)
                    if val then
                        among._stamina = math.huge
                        among._staminaChangedSignal:Fire(150)
                    else
                        return old(among, us)
                    end
                end
            end
         end
    end
})

main.Toggle({
    Text = "no fall damage",
    Callback = function(v)
        nofall = v
    end
})

main.Toggle({
    Text = "stomp aura",
    Callback = function(v)
        stompaura = v
    end
})

main.Toggle({
    Text = "no dash cooldown",
    Callback = function(v)
        for i,v2 in pairs(getgc(true)) do
            if typeof(v2) == "table" and rawget(v2, "DASH_COOLDOWN") then
                if v then
                    v2.DASH_COOLDOWN = 0
                else
                    v2.DASH_COOLDOWN = 3

                end
            end
        end
    end
})

main.Toggle({
    Text = "anti fire + bear trap damage",
    Callback = function(v)
        antidamage = v
    end,
    Enabled = false
})

main.Toggle({
    Text = "auto spawn",
    Callback = function(v)
        autospawn = v
    end,
    Enabled = false
})

main.Toggle({
    Text = "no ragdoll",
    Callback = function(val)
        for i,v in pairs(getgc(true)) do
            if typeof(v) == "table" and rawget(v, "toggleRagdoll") then
                local old = v.toggleRagdoll
                v.toggleRagdoll = function(among, us, irl)
                    if val then
                        return
                    else
                        return old(among, us, irl)
                    end
                end
            end
        end
    end,
    Enabled = false
})

player.Slider({
    Text = "walkspeed",
    Callback = function(v)
        walkspeed = v
    end,
    Min = 16,
    Max = 75,
    Def = 16
})

player.Slider({
    Text = "jumppower",
    Callback = function(v)
        jumppower = v
    end,
    Min = 50,
    Max = 200,
    Def = 50
})

player.Toggle({
    Text = "inf jump",
    Callback = function(v)
        infjump = v
    end,
    Enabled = false
})

player.Toggle({
    Text = "noclip",
    Callback = function(v)
        noclip = v
    end,
    Enabled = false
})

player.Toggle({
    Text = "kill say",
    Callback = function(v)
        killsay = v
    end,
    Enabled = false
})

player.Toggle({
    Text = "hide name",
    Callback = function(v)
        hidename = v
    end
})

combat.Toggle({
    Text = "kill aura",
    Callback = function(v)
        killaura = v
    end,
    Enabled = false
})

combat.Slider({
    Text = "kill aura distance",
    Callback = function(v)
        distance = v
    end,
    Min = 25,
    Max = 75,
    Def = 20
})

misc.Toggle({
    Text = "auto collect air drop",
    Callback = function(val)
        autoair = val
    end,
    Enabled = false
})


-- ty len again (pro scripter https://discord.gg/Uj4ZYJungZ USE NOVA HUB!!)
misc.Button({
    Text = "fling",
    Callback = function()
        local plr = game.Players.LocalPlayer
        local oldHumanoid = plr.Character.Humanoid
        local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
        local flying = true
        local deb = true
        local ctrl = {f = 0, b = 0, l = 0, r = 0}
        local lastctrl = {f = 0, b = 0, l = 0, r = 0}
        local maxspeed = 50
        local speed = 50

        workspace.CurrentCamera.CameraSubject = torso

        local function Fly()
             local bambam = Instance.new("BodyThrust")
             bambam.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
             bambam.Force = Vector3.new(99999,0,99999)
             bambam.Location = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
             Instance.new("SelectionBox",game.Players.LocalPlayer.Character.HumanoidRootPart).Adornee = game.Players.LocalPlayer.Character.HumanoidRootPart
             local bg = Instance.new("BodyGyro", torso)
             bg.P = 9e4
             bg.maxTorque = Vector3.new(0, 0, 0)
             bg.cframe = torso.CFrame
             local bv = Instance.new("BodyVelocity", torso)
             bv.velocity = Vector3.new(0,0,0)
             bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
             repeat wait()
                 if oldHumanoid:FindFirstChildOfClass'RemoteEvent' ~= nil then
                     oldHumanoid.RagdollRemoteEvent:FireServer(true)
                 end
                 getRemote("UpdateIsCrouching"):FireServer(true)

                 if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                     speed = speed+.2
                     if speed > maxspeed then
                         speed = maxspeed
                     end
                 elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                     speed = speed-1
                     if speed < 0 then
                         speed = 0
                     end
                 end
                 if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                     bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                     lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                 elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                     bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed
                 else
                     bv.velocity = Vector3.new(0,0.1,0)
                 end

             until not flying
             ctrl = {f = 0, b = 0, l = 0, r = 0}
             lastctrl = {f = 0, b = 0, l = 0, r = 0}
             speed = 0
             bg:Destroy()
             bv:Destroy()

         end
         mouse.KeyDown:connect(function(key)
             if key:lower() == "w" then
                 ctrl.f = 1
             elseif key:lower() == "s" then
                 ctrl.b = -1
             elseif key:lower() == "a" then
                 ctrl.l = -1
             elseif key:lower() == "d" then
                 ctrl.r = 1
             end
         end)
         mouse.KeyUp:connect(function(key)
             if key:lower() == "w" then
                 ctrl.f = 0
             elseif key:lower() == "s" then
                 ctrl.b = 0
             elseif key:lower() == "a" then
                 ctrl.l = 0
             elseif key:lower() == "d" then
                 ctrl.r = 0
             elseif key:lower() == "r" then

             end
         end)
         for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
             v:Destroy()
         end -- doesnt need tools anyways
         -- hides all of ur body parts expect torso (there is a chance it doesnt work)
         wait(.1)
         oldHumanoid.RagdollRemoteEvent:FireServer(true)
         wait(.5)
         coroutine.wrap(Fly)()
         wait(.5)
         game.Players.LocalPlayer.Character.HumanoidRootPart.RootJoint.Part0 = nil
    end
})

tp.Dropdown({
    Text = "crossroads teleport",
    Callback = function(v)
        teleport = true
        teleportCFrame = tpPlaces[v]
        Players.LocalPlayer.Character.Humanoid.Health = 0
    end,
    Options = {"beach", "the tower", "the hill"}
})


visuals.ColorPicker({
    Text = "visuals color",
    Default = Color3.fromRGB(99, 13, 197),
    Callback = function(v)
        getgenv().TracerColor = v
    end
})

visuals.Toggle({
    Text = "tracers",
    Callback = function(v)
        tracersenabled = v
    end,
    Enabled = false
})

visuals.Toggle({
    Text = "text",
    Callback = function(v)
        textenabled = v
    end,
    Enabled = false
})



mouse.KeyDown:Connect(function(v)
    if infjump and v == " " then
        Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState(3)
    end
end)

-- checks if the player loaded into the game
Players.LocalPlayer.PlayerGui.RoactUI.ChildRemoved:Connect(function(v)
    if v.Name == "MainMenu" then
        if teleport and teleportCFrame ~= nil then
            -- i kinda stole this from project hook
            -- works first try so :shrug:
            teleport = false
            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = teleportCFrame
            teleportCFrame = nil
        end
        if teleport and teleportPlayer ~= nil then
            -- same as the other teleport
            teleport = false
            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Players:FindFirstChild(teleportPlayer).Character.HumanoidRootPart.CFrame
            teleportPlayer = nil
        end

    end
end)

-- ty len and nova hub
-- this is so simple i might be retarded for not figuring this out
workspace.Airdrops.ChildAdded:Connect(function(v)
    if autoair then
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:WaitForChild("Crate").Base.CFrame
        task.wait(0.2)
        fireproximityprompt(v:WaitForChild("Crate").Hitbox.ProximityPrompt)
    end
end)

-- really basic kill aura
-- lags alot but works most of the time
-- ty len
task.spawn(function()
    while task.wait(0.2) do
        if killaura then
            table.foreach(Players.LocalPlayer.Backpack:GetChildren(), function(i,v)
                if v:IsA("Tool") and v:FindFirstChild("Hitboxes") then
                    weapon = v
                end
            end)
            local succ, err = pcall(function()
                local c_player = getClosest()
                if c_player.Character:FindFirstChild("SemiTransparentShield").Transparency == 1 then
                    swingremote:FireServer(weapon, 1)
                    hitremote:FireServer(weapon,c_player.Character:FindFirstChild("HumanoidRootPart"),weapon.Hitboxes.Hitbox,c_player.Character:FindFirstChild("HumanoidRootPart").Position)
                    hitremote:FireServer(weapon,c_player.Character:FindFirstChild("HumanoidRootPart"),weapon.Hitboxes.Hitbox,c_player.Character:FindFirstChild("HumanoidRootPart").Position)
                end
            end)
        end
    end
end)

-- the main loop for shit
task.spawn(function()
    RunService.Stepped:Connect(function()

        if not UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed
        else
            Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed + 10.56
        end

        Players.LocalPlayer.Character:WaitForChild("Humanoid").JumpPower = jumppower

        if autospawn and Players.LocalPlayer.PlayerGui.RoactUI:FindFirstChild("MainMenu") then
            keypress(0x20)
            keyrelease(0x20)
        end


        -- really fuckin basic stomp aura but it works :shrug:
        if stompaura then
            for i,v in pairs(Players:GetPlayers()) do
                if v ~= Players.LocalPlayer and v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("Humanoid").Health <= 15 then
                    if (v.Character.HumanoidRootPart.Position - Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
                        keypress(0x51)
                        keyrelease(0x51)
                    end
                end
            end
        end

        if hidename then
            getRemote("UpdateIsCrouching"):FireServer(true)
        else
            getRemote("UpdateIsCrouching"):FireServer(false)
        end

        if noclip then
            for i,v in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end

        if tracersenabled then
            for player,line in pairs(lines) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local pos,visible = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                    line.Color = TracerColor
                    line.To = Vector2.new(pos.X, pos.Y)
                    -- line.Color = player.Character.Torso.Color
                    line.Visible = visible
                else
                    line.Visible = false
                end
            end
        end

        if textenabled then
            for player,text in pairs(texts) do
                if player.Character and player.Character:FindFirstChild("Head") then
                    local head, HeadVisible = workspace.CurrentCamera:WorldToViewportPoint(player.Character.Head.Position)
                    text.Position = Vector2.new(head.X, head.Y - 28)
                    text.Color = TracerColor
                    text.Visible = HeadVisible
                else
                    text.Visible = false
                end
            end
        end
    end)
end)

local methodHook
methodHook = hookmetamethod(game, "__namecall", function(self, ...)
    if not checkcaller() and getnamecallmethod() == "FireServer" and antidamage and tostring(self) == "GotHitRE" then
        return
    elseif not checkcaller() and getnamecallmethod() == "FireServer" and nofall and self.Name == fallremote.Name then
        return
    end
    return methodHook(self, ...)
end)
