local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function getNearestEnemy()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
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

local function slideToEnemy(enemy)
    if not enemy or not enemy:FindFirstChild("HumanoidRootPart") then return end

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local root = character:WaitForChild("HumanoidRootPart")

    local goalPosition = enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

    local tweenInfo = TweenInfo.new(
        0.5, -- 所要時間（秒）
        Enum.EasingStyle.Quad, -- 動きの種類（滑らか）
        Enum.EasingDirection.Out -- 動きの終わり方
    )

    local tween = TweenService:Create(
        root,
        tweenInfo,
        {CFrame = CFrame.new(goalPosition)}
    )

    tween:Play()
end

-- 実行
local enemy = getNearestEnemy()
if enemy then
    slideToEnemy(enemy)
    print("滑らかに移動中：" .. enemy.Name)
else
    print("敵が見つかりませんでした。")
end

