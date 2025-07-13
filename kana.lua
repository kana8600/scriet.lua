-- 敵の名前（または一番近い敵を探す）
local function getNearestEnemy()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")

    local closestEnemy = nil
    local closestDistance = math.huge

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            local dist = (obj.HumanoidRootPart.Position - root.Position).Magnitude
            if dist < closestDistance then
                closestDistance = dist
                closestEnemy = obj
            end
        end
    end

    return closestEnemy
end

-- TP処理
local function teleportAboveEnemy(enemy)
    if not enemy or not enemy:FindFirstChild("HumanoidRootPart") then return end

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")

    root.CFrame = enemy.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
end

-- 実行
local enemy = getNearestEnemy()
if enemy then
    teleportAboveEnemy(enemy)
    print("敵の上にテレポートしました: " .. enemy.Name)
else
    print("敵が見つかりませんでした。")
end
