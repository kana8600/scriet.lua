local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🎯 ここにターゲットの敵の名前を指定（完全一致 or 部分一致でもOK）
local targetEnemyName = "Bandit" -- ←ここを変えれば他の敵に対応可

-- 指定した敵の中で一番近いものを探す
local function getNearestTargetEnemy()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")

    local closestEnemy = nil
    local closestDistance = math.huge

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
            -- 敵の名前が一致しているか確認（部分一致にしたいなら string.find に変更）
            if obj.Name == targetEnemyName then
                local dist = (obj.HumanoidRootPart.Position - root.Position).Magnitude
                if dist < closestDistance then
                    closestDistance = dist
                    closestEnemy = obj
                end
            end
        end
    end

    return closestEnemy
end

-- スライド移動する処理
local function slideToEnemy(enemy)
    if not enemy or not enemy:FindFirstChild("HumanoidRootPart") then return end

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")

    local goalPosition = enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

    local tweenInfo = TweenInfo.new(
        0.5, -- 滑る速度（秒）
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )

    local tween = TweenService:Create(
        root,
        tweenInfo,
        {CFrame = CFrame.new(goalPosition)}
    )

    tween:Play()
end

-- 実行
local enemy = getNearestTargetEnemy()
if enemy then
    slideToEnemy(enemy)
    print("「" .. targetEnemyName .. "」にスライド移動中：" .. enemy.Name)
else
    print("指定した敵（" .. targetEnemyName .. "）が見つかりませんでした。")
end

