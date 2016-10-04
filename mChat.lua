-- client
-- @modulum || October 2nd, 2016

local remote = game.ReplicatedStorage.remote

remote.chat.OnServerEvent:connect(function(plr, input)
	if plr.UserId == 142762267 then
		remote.chat:FireAllClients(plr, input, "mod")
	else
		remote.chat:FireAllClients(plr, input)
	end
end)

remote.whisper.OnServerEvent:connect(function(plr, musr, str)
	remote.whisper:FireClient(plr, musr, str, "send")
	remote.whisper:FireClient(musr, plr, str, "recieve")
end)

game.Players.PlayerAdded:connect(function(plr)
	remote.chat:FireAllClients(plr, plr.Name .. " has joined the game.", "sys")
end)
