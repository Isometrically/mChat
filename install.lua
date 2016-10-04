local HttpService = game.HttpService
local URLs = {
	"https://raw.githubusercontent.com/m0dulum/mChat/master/client.lua",
	"https://raw.githubusercontent.com/m0dulum/mChat/master/mChat.lua"
}

local function construct(id)
	--- Constructs (mostly the gui) the chat GUI, scripts, and events.
	if id == "-- client" then
		-- make the gui
		local g  = Instance.new("ScreenGui", game.StarterGui)
		local ls = Instance.new("LocalScript", g)
		local tm = Instance.new("Frame", ls)
		local cb = Instance.new("Frame", g)
		local pb = Instance.new("Frame", cb)
		local lg = Instance.new("Frame", g)
		local ib = Instance.new("TextBox", pb)
		local dt = Instance.new("TextButton", cb)
		
		local ms = Instance.new("TextLabel", tm)
		local pl = Instance.new("TextLabel", tm)
		
		g.Name  = "chat"
		ls.Name = "client"
		tm.Name = "temp"
		cb.Name = "chatbar"
		pb.Name = "pseudobg"
		ib.Name = "input"
		dt.Name = "detect"
		lg.Name = "logs"
		
		ms.Name = "msg"
		pl.Name = "plr"
		
		cb.BackgroundTransparency = 1
		cb.Position 			  = UDim2.new(0, 0, 1, -30)
		cb.Size					  = UDim2.new(1, 0, 0, 30)
		
		pb.BackgroundTransparency = 0.5
		pb.BorderSizePixel		  = 0
		pb.Position				  = UDim2.new(0, 0, 1, 0)
		pb.Size					  = UDim2.new(1, 0, 1, 0)
		
		ib.BackgroundTransparency = 1
		ib.Position				  = UDim2.new(0.01, 0, 0, 0)
		ib.Size					  = UDim2.new(0.98, 0, 1, 0)
		ib.Font					  = Enum.Font.SourceSans
		ib.FontSize				  = Enum.FontSize.Size18
		ib.TextColor3			  = Color3.fromRGB(255, 255, 255)
		ib.TextStrokeTransparency = 1
		ib.TextXAlignment		  = Enum.TextXAlignment.Left
		ib.TextYAlignment		  = Enum.TextYAlignment.Center
		ib.Text					  = ""
		
		dt.BackgroundTransparency = 1
		dt.Position				  = UDim2.new(0.01, 0, 0, 0)
		dt.Size					  = UDim2.new(1, 0, 1, 0)
		dt.ZIndex				  = 10
		dt.Font					  = Enum.Font.SourceSans
		dt.FontSize				  = Enum.FontSize.Size18
		dt.Text					  = "Press '/' or click here to chat."
		dt.TextColor3			  = Color3.fromRGB(255, 255, 255)
		dt.TextStrokeTransparency = 1
		dt.TextXAlignment		  = Enum.TextXAlignment.Left
		dt.TextYAlignment		  = Enum.TextYAlignment.Center
		
		tm.BackgroundTransparency = 1
		tm.Position				  = UDim2.new(0, 0, 1, -18)
		tm.Size					  = UDim2.new(1, 0, 0, 18)
		tm.Visible				  = false
		
		ms.BackgroundTransparency = 1
		ms.Position				  = UDim2.new(0, 40, 0, 0)
		ms.Size					  = UDim2.new(0, 8, 0, 18)
		ms.Font					  = Enum.Font.SourceSans
		ms.FontSize				  = Enum.FontSize.Size18
		ms.Text					  = "a"
		ms.TextColor3			  = Color3.fromRGB(255, 255, 255)
		ms.TextXAlignment		  = Enum.TextXAlignment.Left
		ms.TextYAlignment		  = Enum.TextYAlignment.Top
		ms.TextStrokeTransparency = 1
		
		pl.BackgroundTransparency = 1
		pl.Position				  = UDim2.new(0, 0, 0, 0)
		pl.Size					  = UDim2.new(0, 35, 0, 18)
		pl.Font					  = Enum.Font.SourceSans
		pl.FontSize				  = Enum.FontSize.Size18
		pl.Text					  = "user:"
		pl.TextColor3			  = Color3.fromRGB(215, 197, 154)
		pl.TextXAlignment		  = Enum.TextXAlignment.Left
		pl.TextYAlignment		  = Enum.TextYAlignment.Top
		pl.TextStrokeTransparency = 1
		
		lg.BackgroundTransparency = 1
		lg.Position				  = UDim2.new(0.015, 0, 0.025, 0)
		lg.Size					  = UDim2.new(0, 400, 0, 150)
		
		return ls
	elseif id == "-- server" then
		local s = Instance.new("Script", game.ServerScriptService)
		s.Name  = "mChat"
		return s
	end
end

for i, v in pairs(URLs) do
	local loaded  	 = HttpService:GetAsync(v)
	local identifier = string.sub(loaded, 0, 9)
			
	local c  = construct(identifier)
	print(v)
	c.Source = HttpService:GetAsync(v)
	
	print("[mChat] " .. i + 1 .. "/" .. #URLs)
end

local f   = Instance.new("Folder", game.ReplicatedStorage)
local reo = Instance.new("RemoteEvent", f)
local ret = Instance.new("RemoteEvent", f)
f.Name    = "remote"
reo.Name  = "chat"
ret.Name  = "whisper"

print("[mChat] Load complete!")
