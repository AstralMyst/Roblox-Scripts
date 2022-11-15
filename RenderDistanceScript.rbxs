--Made by @NoobzStikerz
--@AstralMyst on GitHub

local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local player = PlayerService.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = game.Workspace.CurrentCamera

local maxDistanceRendering = 300 -- Maximum Distance

local RATE_PER_SECOND = 2


local DistantParts_folder = Instance.new("Folder") -- Initiallize folder for "DistantParts"
DistantParts_folder.Parent = game:GetService("Workspace")
DistantParts_folder.Name = "DistantParts"

local Source = Instance.new("Folder") -- Initiallize folder for "WorldStorage"
Source.Parent = game:GetService("ReplicatedStorage")
Source.Name = "WorldStorage"

RunService.Heartbeat:Connect(function(step) -- heartbeat function; works better than while loop because it runs ever frame
	local increment = RATE_PER_SECOND * step
	wait()
	for i, model in pairs(workspace:GetChildren()) do --check if models are too far
		if model:IsA("Model") and not PlayerService:GetPlayerFromCharacter(model) and model.Name ~= "BaseMap" then
			local ModelPos = model:GetModelCFrame() -- function gets the CFrame (coordinate frame) of the model
			if player:DistanceFromCharacter(ModelPos.Position) > maxDistanceRendering then
				local DistantPart = Instance.new("Part")
				local OriginalObVal = Instance.new("ObjectValue") -- add object value to link to model
				local colors = {} -- initiallize color table
				for i,v in pairs(model:GetDescendants()) do -- loop to get a color all of the building in a table.
					if v:IsA("BasePart") then
						table.insert(colors,v.Color)
					end
				end
				local r = 0 -- creates individual variables for each value of Color3
				local g = 0
				local b = 0
				for i,v in pairs(colors) do -- get average color
					r = r + v.r -- r,g, and b are all attributes/properties of the Color3 class
					g = g + v.g
					b = b + v.b
				end
				r = r/#colors
				g = g/#colors
				b = b/#colors
				DistantPart.Color = Color3.new(r,g,b) -- assign color
				DistantPart.Size = model:GetModelSize() -- function gets the size of a model (as name states)
				DistantPart.CFrame =  ModelPos -- sets part position to the position of the model
				DistantPart.Anchored = true -- stops from moving
				DistantPart.CanCollide = false -- disable collision
				DistantPart.Parent = DistantParts_folder -- sets parent
				DistantPart.Name = "DistantPart" -- sets name
				OriginalObVal.Parent = DistantPart -- adds object value
				OriginalObVal.Value = model -- sets value to the original model
				model.Parent = Source -- moves the model into the replicatedstorage; player does not have to render the model anymore. (note still stored in client memory)
			end
		end
	end
	for i,distantpart in pairs(DistantParts_folder:GetChildren()) do --checks if parts are close enough
		if distantpart:IsA("BasePart") then -- guarantee that it is the right class
			if player:DistanceFromCharacter(distantpart.Position) <= maxDistanceRendering then -- if close enough
				local ObVal = distantpart:FindFirstChildOfClass("ObjectValue") --search for object value
				if ObVal then --check if exists 
					ObVal.Value.Parent = game.Workspace -- set model to parent
					distantpart:Destroy() --destroy the distant part
				end
			end
		end
	end
end)




player.CharacterRemoving:Connect(function()
	for i,v in pairs(Source:GetChildren()) do
		v.Parent = game.Workspace
	end
	for i,v in pairs(DistantParts_folder:GetChildren()) do
		v:Destroy()
	end
end)

for i = 1,10 do
	if UserSettings().GameSettings.SavedQualityLevel == "Enum.SavedQualitySetting.QualityLevel".. tostring(i) then
		maxDistanceRendering = (i^3.2)+500 -- The graph of x^3.2 + 500; minimum value is 500, increases so that it reaches ~2084 by maximum graphics quality
	end																													-- basically you can see whole map
end

UserSettings().GameSettings.Changed:Connect(function()
	for i = 1,10 do
		if UserSettings().GameSettings.SavedQualityLevel == "Enum.SavedQualitySetting.QualityLevel".. tostring(i) then
			maxDistanceRendering = (i^3.2)+500 -- Literally the same as above (could turn into a function)
		end
	end
end)

