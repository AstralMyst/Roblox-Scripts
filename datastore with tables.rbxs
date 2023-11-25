
local playerservice = game:GetService("Players")
local ds = datastore:GetDataStore("yourKeyHere")

playerservice.PlayerAdded:Connect(function(player) --When a player joins

-- initiialize the variable with name, value, and heirarchy
local ValueType1 = Instance.new("IntValue")
  ValueType1.Name = "Value1"
  ValueType1.Value = 50
  ValueType1.Parent = Player
  
-- these below are the same but with each other value
local ValueType2 = Instance.new("IntValue")
  ValueType2.Name = "Value2"
  ValueType2.Value = 50
  ValueType2.Parent = Player
local ValueType3 = Instance.new("IntValue")
  ValueType3.Name = "Value3"
  ValueType3.Value = 50
  ValueType3.Parent = Player
local ValueType4 = Instance.new("IntValue")
  ValueType4.Name = "Value4"
  ValueType4.Value = 50
  ValueType4.Parent = Player

  
-- initiialize the data, check if it exists. If yes, set the values. If no, 
local statData = ds:GetAsync(plr.UserId)
	if statData then
		ValueType1.Value = statData[1]
		ValueType2.Value = statData[2]
		ValueType3.Value = statData[3]
		ValueType4.Value = statData[4]
	else
    --retrieve the data of the storage
		ds2:GetAsync(player.UserId, {player.ValueType1.Value,player.ValueType2.Value,player.ValueType3.Value,player.ValueType4.Value})	
	end	
  
-- save the variable whenever the value of it changes
  ValueType1.Changed:Connect(function()--Saves the hunger
		ds2:SetAsync(plr.UserId, {plr.Hunger.Value,plr.Thirst.Value,plr.Energy.Value,plr.Hygiene.Value})	
	end)

-- these below are the same but with each other value
  ValueType2.Changed:Connect(function()--Saves the hunger
		ds2:SetAsync(plr.UserId, {plr.Hunger.Value,plr.Thirst.Value,plr.Energy.Value,plr.Hygiene.Value})	
	end)
  ValueType3.Changed:Connect(function()--Saves the hunger
		ds2:SetAsync(plr.UserId, {plr.Hunger.Value,plr.Thirst.Value,plr.Energy.Value,plr.Hygiene.Value})	
	end)
  ValueType4.Changed:Connect(function()--Saves the hunger
		ds2:SetAsync(plr.UserId, {plr.Hunger.Value,plr.Thirst.Value,plr.Energy.Value,plr.Hygiene.Value})	
	end)

end)
