
local PathfindingService = game:GetService("PathfindingService")
local PlayerService = game:GetService("Players")
local TeamService = game:GetService("Teams")

local Humanoid = script.Parent.Humanoid
local Torso = script.Parent.Torso

local Target = game.Workspace.PathTarget

local path = PathfindingService:CreatePath()

path:ComputeAsync(Torso.Position, Target.Position)
local waypoints = path:GetWaypoints()

for i, wp in pairs(waypoints) do
	if wp.Action == Enum.PathWaypointAction.Jump then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
	Humanoid:MoveTo(wp.Position)
	Humanoid.MoveToFinished:Wait()
end
