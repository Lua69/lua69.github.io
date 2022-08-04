local vroomvroomKeyCode = Enum.KeyCode.V
local upKeyCode = Enum.KeyCode.Space
local downKeyCode = Enum.KeyCode.LeftControl
_G.speed = 60
local speed = _G.speed
local vroom = false
local players = game:GetService("Players")
local input = game:GetService("UserInputService")
local plr = players.LocalPlayer
local chr = plr.Character
local root = chr.HumanoidRootPart
local hum = chr:FindFirstChildWhichIsA("Humanoid")
local run = game:GetService("RunService").Heartbeat
local switch = false
local bodySus
local ballPos

if not game:GetService("RunService"):IsStudio() then
	game.Players:Chat("/setac false")
end

task.spawn(function()
	while true do
		if vroom then
			if switch then
				switch = false
			else
				switch = true
			end
			root.Velocity = root.CFrame.UpVector * -(speed)
			task.wait(.5 * speed / 100)
		end
		task.wait()
	end
end)

run:Connect(function()
	if vroom then
		if switch then
			hum:ChangeState(Enum.HumanoidStateType.Freefall)
		else
			hum:ChangeState(Enum.HumanoidStateType.Landed)
		end
		root.Velocity = root.CFrame.LookVector * (speed)
		--root.Velocity = Vector3.new(root.CFrame.X, ballPos, root.CFrame.Z)
	end
end)

input.InputBegan:Connect(function(key, balls)
	if key.KeyCode == upKeyCode and not balls then
		if vroom then
			if bodySus ~= nil then
				bodySus.Velocity = Vector3.new(0, (speed * 4), 0)
			end
		end
	end
	if key.KeyCode == downKeyCode and not balls then
		if vroom then
			if bodySus ~= nil then
				bodySus.Velocity = Vector3.new(0, -(speed * 4), 0)
			end
		end
	end
	if key.KeyCode == vroomvroomKeyCode and not balls then
		if vroom then
			root.Velocity = Vector3.new(0, 0, 0)
			vroom = false
			if bodySus ~= nil then
				bodySus:Destroy()
			end
		else
			repeat
				wait()
			until plr.Character ~= nil
			chr = plr.Character
			root = chr.HumanoidRootPart
			hum = chr:FindFirstChildWhichIsA("Humanoid")
			ballPos = root.CFrame.Y
			bodySus = Instance.new("BodyVelocity", root)
			bodySus.Velocity = Vector3.new(0, 0, 0)
            speed = _G.speed
			vroom = true
		end
	end
end)

input.InputEnded:Connect(function(key, balls)
	if key.KeyCode == upKeyCode and not balls then
		if vroom then
			if bodySus ~= nil then
				bodySus.Velocity = Vector3.new(0, 0, 0)
			end
		end
	end
	if key.KeyCode == downKeyCode and not balls then
		if vroom then
			if bodySus ~= nil then
				bodySus.Velocity = Vector3.new(0, 0, 0)
			end
		end
	end
end)