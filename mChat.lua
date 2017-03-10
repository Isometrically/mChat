-- server
-- @modulum || December 10th, 2016

local remote = game.ReplicatedStorage.remote
local chat = game:GetService("Chat")
local studio = game:GetService("RunService"):IsStudio()

if studio then
	chat = {FilterStringAsync = function(_, m) return m end}
end

remote.chat.OnServerEvent:connect(function(plr, filtered)
	filtered = chat:FilterStringAsync(filtered, plr, plr)
	
	if plr.UserId == game.CreatorId then
		remote.chat:FireAllClients(plr, filtered, "mod")
	elseif plr.UserId == 16826035 then
		remote.chat:FireAllClients(plr, filtered, "yellow")
	else
		remote.chat:FireAllClients(plr, filtered)
	end
end)

remote.whisper.OnServerEvent:connect(function(plr, musr, filtered)
	filtered = chat:FilterStringAsync(filtered, plr, plr)
	remote.whisper:FireClient(plr, musr, filtered, "send")
	remote.whisper:FireClient(musr, plr, filtered, "recieve")
end)

game.Players.PlayerAdded:connect(function(plr)
	remote.chat:FireAllClients(plr, plr.Name .. " has joined the game.", "sys")
end)
