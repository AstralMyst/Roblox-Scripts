--[[
# a common loop to unanchor all parts under a model.
# assume that the 'parentmodel' has been initialized such as
local parentmodel = script.Parent.Model

]]
-- loop 1
for i,v in pairs(parentmodel:GetDescendants()) do -- check all descendants of instance 'parentmodel', a variable assumed to have been instantiated previously
	if v:IsA("BasePart") or v:IsA("Seat") or v:IsA("VehicleSeat") or v:IsA("MeshPart") or v:IsA("UnionOperation")  then -- If the descendant is any of this classes
		v.Anchored = false -- set anchored to false
	end
end

-- note that it may be possible to write as this, though I have no clue is a unionOp is considered a basepart, so more testing req.
-- loop 2
for i,v in pairs(parentmodel:GetDescendants()) do -- check all descendants of instance 'parentmodel', a variable assumed to have been instantiated previously
	if v:IsA("BasePart") then -- If the descendant is any of this classes
		v.Anchored = false -- set anchored to false
	end
end
