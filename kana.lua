local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
-- OrionLib読み込み
local OrionLib = loadstring(game:HttpGet("https://pastebin.com/raw/WRUyYTdY"))()
local Window = OrionLib:MakeWindow({Name = "wos script", HidePremium = false, SaveConfig = true, ConfigFolder = "WOS_Config"})
local MainTab = Window:MakeTab({ Name = "メイン", Icon = "rbxassetid://4483345998", PremiumOnly = false })

-- 新しいタブ「チェスト」を作成
local ChestTab = Window:MakeTab({
    Name = "チェスト",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
