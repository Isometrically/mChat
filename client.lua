-- client
-- @modulum || July 18th, 2016
-- [last updated on October 2nd, 2016]

----------------------------------------------

-- function documentation format goes as follows:

--- description of function
-- @param [name of parameter]: type, description

----------------------------------------------

-- @todo: update these colors
local ChatColors = { Color3.fromRGB(255, 119, 119), Color3.fromRGB(167, 214, 255),
					 Color3.fromRGB(96, 255, 162),  Color3.fromRGB(233, 153, 255),
					 Color3.fromRGB(255, 201, 156), Color3.fromRGB(255, 240, 160),
					 Color3.fromRGB(255, 189, 230), Color3.fromRGB(227, 216, 197)
				   }

local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = game.Players.LocalPlayer
local remote = game.ReplicatedStorage.remote

local detect = script.Parent.chatbar.detect
local pseudobg = script.Parent.chatbar.pseudobg

local typing = false
local t1, t2, t3

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

--[[pcall(function()
	StarterGui:SetCore("TopbarEnabled", false)
end)--]]

function GetNameValue(PlayerName)
	--snipped from github /roblox/corescripts
	local value	= 0
	for index = 1, #PlayerName do
		local cValue = string.byte(string.sub(PlayerName, index, index))
		local reverseIndex = #PlayerName - index + 1
		if #PlayerName % 2 == 1 then
			reverseIndex = reverseIndex - 1
		end
		if reverseIndex % 4 >= 2 then
			cValue = -cValue
		end
			value = value + cValue
		end
	return value
end

function ComputeChatColor(PlayerName)
	--snipped from github /roblox/corescripts
	return ChatColors[(GetNameValue(PlayerName) % #ChatColors) + 1]
end

local function sanitize(ustring)
	--- remove additonal spaces, tabs, et cetera
	-- @param [ustring]: string, string to sanetize
	local nstring = string.gsub(ustring, "%s+", " ")
	if nstring ~= nil then
		return nstring
	else
		return nil
	end
end

local function release()
	--- releases the textbox for input
	typing = false
	pseudobg:TweenPosition(UDim2.new(0, 0, 1, 0), "Out", "Quart", 0.25, true)
	detect.Visible = true
	
	local input = pseudobg.input.Text
	if input ~= nil then
		pseudobg.input:ReleaseFocus()
		
		local sinput = sanitize(input)
		if sinput ~= "" and sinput ~= string.char(32) then
			if sinput == "/sc" then
				remote.chat:FireServer("ROOT")
			elseif string.sub(sinput, 0, 2) == "/w" then
				local ps = string.sub(sinput, 4)
				local fs = string.find(ps, string.char(32))
				local fn = string.sub(ps, 0, fs - 1)
				local ms = string.sub(ps, fs + 1)
				
				if ps ~= nil and game.Players:FindFirstChild(fn) and ms ~= nil and game.Players[fn] ~= LocalPlayer then
					remote.whisper:FireServer(game.Players[fn], ms)
				end
			else
				remote.chat:FireServer(sinput)
			end
		end
	end
end

local function focus()
	--- focuses the textbox for input
	typing = true
	detect.Visible = false
	pseudobg:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quart", 0.25, true)
	pseudobg.input:CaptureFocus()
end

local function clear(object)
	--- tweens an object out of the container and then destroys it
	-- @param [object]: TextLabel, textlabel to tween then destroy
	object:TweenPosition(UDim2.new(0, 0, 1, -(18*10)), "Out", "Quad", 0.25, true)
	object:Destroy()
end

local function cmsg(plr, input, special)
	--- creates a new message
	-- @param [input]: string, message the player sent
	-- @param [special]: string, special sender
	local c = script.Parent.logs:GetChildren()
	local t = script.temp:Clone()
	
	if special == "mod" then
		t.msg.TextColor3 = Color3.fromRGB(255, 223, 94) --255, 219, 89
	elseif special == "sys" then
		t.plr.TextColor3 = Color3.fromRGB(0, 215, 136)
		t.plr.Text = "[SYSTEM]: "
		t.plr.Size = UDim2.new(0, t.plr.TextBounds.X, 0, t.plr.TextBounds.Y)
		t.msg.Position = UDim2.new(0, t.plr.TextBounds.X + 5, 0, 0)
	elseif special == "whisper" then
		t.plr.Font = Enum.Font.SourceSansItalic
		t.plr.Text = "[whisper] " .. plr .. ": "
	end
	
	if (plr == nil and special == "sys") or (plr ~= nil and special == "sys") then
		wait()
		t.Parent = script.Parent.logs
		t.Size = UDim2.new(1, 0, 0, 18)
		t.msg.Text = input
		repeat wait() until t.plr.TextBounds.X ~= 0
		t.plr.Size = UDim2.new(0, t.plr.TextBounds.X, 0, t.plr.TextBounds.Y)
		t.msg.Size = UDim2.new(5, 0, 0, t.msg.TextBounds.Y)
		t.msg.Position = UDim2.new(0, t.plr.TextBounds.X + 5, 0, 0)
	else
		wait()
		t.Parent = script.Parent.logs
		t.Size = UDim2.new(1, 0, 0, 18)
		t.plr.Text = plr .. ": "
		t.msg.Text = input
		t.plr.Size = UDim2.new(0, t.plr.TextBounds.X, 0, t.plr.TextBounds.Y)
		t.msg.Size = UDim2.new(5, 0, 0, t.msg.TextBounds.Y)
		t.msg.Position = UDim2.new(0, t.plr.TextBounds.X + 5, 0, 0)
		t.plr.TextColor3 = ComputeChatColor(plr)
	end
	
	if t.msg.Size.Y.Offset <= 54 then
		if t.msg.TextBounds.X > 1050 then
			t.msg.Size = UDim2.new(t.msg.Size.X.Scale, t.msg.Size.X.Offset, t.msg.Size.Y.Scale, 54)
			t.Size = UDim2.new(t.Size.X.Scale, t.Size.X.Offset, t.Size.Y.Scale, t.msg.Size.Y.Offset)
		elseif t.msg.TextBounds.X > 700 then
			t.msg.Size = UDim2.new(t.msg.Size.X.Scale, t.msg.Size.X.Offset, t.msg.Size.Y.Scale, 36)
			t.Size = UDim2.new(t.Size.X.Scale, t.Size.X.Offset, t.Size.Y.Scale, t.msg.Size.Y.Offset)
		elseif t.msg.TextBounds.X > 350 then
			t.msg.Size = UDim2.new(t.msg.Size.X.Scale, t.msg.Size.X.Offset, t.msg.Size.Y.Scale, 18)
			t.Size = UDim2.new(t.Size.X.Scale, t.Size.X.Offset, t.Size.Y.Scale, t.msg.Size.Y.Offset)
		end
		--t.msg.Size = UDim2.new(0, 400 - (t.plr.Size.X.Offset + 5), 0, t.msg.TextBounds.Y)
		t.msg.Size = UDim2.new(0, 400 - (t.plr.Size.X.Offset + 5), 1, 0)
	end

	if #c > 8 then	
		t.Name = "1"
		script.Parent.logs["1"].Name = "2"
		script.Parent.logs["2"].Name = "3"
		script.Parent.logs["3"].Name = "4"
		script.Parent.logs["4"].Name = "5"
		script.Parent.logs["5"].Name = "6"
		script.Parent.logs["6"].Name = "7"
		script.Parent.logs["7"].Name = "8"
		script.Parent.logs["8"].Name = "9"
		clear(script.Parent.logs["9"])
	else
		t.Name = "1"
		for _,v in pairs(script.Parent.logs:GetChildren()) do
			if v.Name ~= "temp" then
				v.Name = tonumber(v.Name + 1)
			end
		end
		t.Name = "1"
	end
	
	t.Visible = true
	
	-- POSITIONING STARTS HERE --
	
	local lc = t.Size.Y.Offset / 18
	local sv
	
	for i = 1, 3 do
		sv = 0.15 * lc
	end
	
	for _,v in pairs(script.Parent.logs:GetChildren()) do
		if v.Name ~= "temp" then
			v:TweenPosition(UDim2.new(0, 0, v.Position.Y.Scale - sv, -v.Size.Y.Offset), "Out", "Quart", 0.25, true)
		end
		t:TweenPosition(UDim2.new(0, 0, 1, -t.Size.Y.Offset), "Out", "Quart", 0.25, true)
	end
	
	-- POSITIONING ENDS HERE --
end

remote.chat.OnClientEvent:connect(function(plr, input, special)	
	if special == "sys" then
		cmsg("[SYSTEM]", input, special)
	else
		cmsg(plr.Name, input, special)
	end
end)

remote.whisper.OnClientEvent:connect(function(plr, msg, sor)
	if sor == "send" then
		cmsg("To " .. "[" .. plr.Name .. "]", msg, "whisper")
	elseif sor == "recieve" then
		cmsg("From " .. "[" .. plr.Name .. "]", msg, "whisper")
	end
end)

UserInputService.InputBegan:connect(function(input, gpe)
	if not gpe then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.Slash then
				focus()
			end
		end
	end
end)

pseudobg.input.FocusLost:connect(function(ep)
	if ep then
		release()
	end
end)

detect.MouseButton1Down:connect(function()
	focus()
end)
