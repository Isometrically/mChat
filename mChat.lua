-- server
-- @modulum || October 4th, 2016

local remote = game.ReplicatedStorage.remote
local chat = game:GetService("Chat")
local studio = game:GetService("RunService"):IsStudio()

if not studio then
	chat = {FilterStringAsync = function(_, m) return m end}
end

remote.chat.OnServerEvent:connect(function(plr, filtered)
	filtered = not studio and chat:FilterStringAsync(filtered, plr, plr) or filtered
	
	if plr.UserId == 142762267 then
		remote.chat:FireAllClients(plr, filtered, "mod")
	elseif plr.UserId == 16826035 then
		remote.chat:FireAllClients(plr, filtered, "yellow")
	else
		remote.chat:FireAllClients(plr, filtered)
	end
end)

remote.whisper.OnServerEvent:connect(function(plr, musr, filtered)
	filtered = not studio and chat:FilterStringAsync(filtered, plr, plr) or filtered
	remote.whisper:FireClient(plr, musr, filtered, "send")
	remote.whisper:FireClient(musr, plr, filtered, "recieve")
end)

game.Players.PlayerAdded:connect(function(plr)
	remote.chat:FireAllClients(plr, plr.Name .. " has joined the game.", "sys")
end)
