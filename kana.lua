local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🎯 ターゲット用の変数
local targetEnemyName = nil

-- 🧠 敵を探す関数（指定された名前）
local function getNearestEnemy(name)
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	local closestEnemy = nil
	local closestDistance = math.huge

	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
			if obj.Name == name then
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

-- 🚀 スライド移動処理
local function slideToEnemy(enemy)
	if not enemy or not enemy:FindFirstChild("HumanoidRootPart") then return end

	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	local goal = enemy.HumanoidRootPart.Position + Vector3.new(0, 5, 0)

	local tween = TweenService:Create(
		root,
		TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{CFrame = CFrame.new(goal)}
	)

	tween:Play()
end

-- 📦 UIを作る関数
local function createButton(enemyName, position)
	local screenGui = PlayerGui:FindFirstChild("EnemySelectorGui") or Instance.new("ScreenGui")
	screenGui.Name = "EnemySelectorGui"
	screenGui.Parent = PlayerGui

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 100, 0, 30)
	button.Position = position
	button.Text = enemyName
	button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Parent = screenGui

	button.MouseButton1Click:Connect(function()
		local enemy = getNearestEnemy(enemyName)
		if enemy then
			slideToEnemy(enemy)
			warn("スライド移動中: " .. enemyName)
		else
			warn("敵が見つかりません: " .. enemyName)
		end
	end)
end

-- 🔘 複数ボタンを作成
createButton("Bandit", UDim2.new(0, 10, 0, 100))
createButton("Brute", UDim2.new(0, 10, 0, 140))
createButton("Pirate", UDim2.new(0, 10, 0, 180))

