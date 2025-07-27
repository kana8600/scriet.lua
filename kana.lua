-- OrionLib でスライダー付き GUI（Exploit 向け）

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({Name = "Spike Power Control", HidePremium = false, SaveConfig = true, ConfigFolder = "SpikeCFG"})

local spikePower = 100

Window:MakeTab({
    Name = "スパイク設定",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
}):AddSlider({
    Name = "スパイクパワー",
    Min = 100,
    Max = 300,
    Default = 150,
    Color = Color3.fromRGB(255,0,0),
    Increment = 10,
    ValueName = "力",
    Callback = function(Value)
        spikePower = Value
    end    
})

-- スペースキーで実行
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Space and not gameProcessed then
        local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Volleyball")
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if ball and hrp then
            local dir = (ball.Position - hrp.Position).Unit
            ball.Velocity = dir * spikePower + Vector3.new(0, 100, 0)
        end
    end
end)


