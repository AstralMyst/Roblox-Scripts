--basic tool interaction script, initialized outside of the script

local tool = script.Parent
local handle = tool.Handle
local anim = script:WaitForChild("Animation")
local cd = false

--variables, you change these to what you'd like
local sips = 5
local waitTime = 1.5

--real codes stuff
local track
tool.Equipped:Connect(function()
	track = script.Parent.Parent.Humanoid:LoadAnimation(anim)
	track.Priority = Enum.AnimationPriority.Action
end)

tool.Activated:Connect(function()
	if cd == false then
		cd = true
		track:Play()
		handle.drink:Play()
		sips = sips - 1
		wait(waitTime)
		if sips <= 0 then
			tool:Destroy()
		end
		cd = false
	end
end)
