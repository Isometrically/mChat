-- server
-- @modulum || October 4th, 2016

local remote = game.ReplicatedStorage.remote
local chat = game:GetService("Chat")

remote.chat.OnServerEvent:connect(function(plr, input)
	local filtered = chat:FilterStringAsync(input, plr, plr)
	
	if plr.UserId == 142762267 then
		remote.chat:FireAllClients(plr, filtered, "mod")
	elseif plr.UserId == 16826035 then
		remote.chat:FireAllClients(plr, filtered, "yellow")
	else
		remote.chat:FireAllClients(plr, filtered)
	end
end)

remote.whisper.OnServerEvent:connect(function(plr, musr, str)
	local filtered = chat:FilterStringAsync(str, plr, plr)
	remote.whisper:FireClient(plr, musr, str, "send")
	remote.whisper:FireClient(musr, plr, str, "recieve")
end)

game.Players.PlayerAdded:connect(function(plr)
	remote.chat:FireAllClients(plr, plr.Name .. " has joined the game.", "sys")
end)
