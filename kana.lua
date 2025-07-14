-- ServerScriptService の Script の先頭で一度だけ作成されるように
local ReplicatedStorage = game:GetService("ReplicatedStorage")

if not ReplicatedStorage:FindFirstChild("ChasePlayerEvent") then
	local RemoteEvent = Instance.new("RemoteEvent")
	RemoteEvent.Name = "ChasePlayerEvent"
	RemoteEvent.Parent = ReplicatedStorage
end

