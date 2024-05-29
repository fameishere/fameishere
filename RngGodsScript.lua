local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow(
	{
		Name = "RNG Gods", 
		HidePremium = false, 
		SaveConfig = true,
		ConfigFolder = "",
		IntroEnabled = true,
		IntroText = "made by fame",
	}
)
--// 

local AFKTab = Window:MakeTab({
	Name = "AFK",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local ballsTab = Window:MakeTab({
	Name = "balls",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local autoUpgrade = false

ballsTab:AddButton({
	Name = "bring all auras (CS)",
	Callback = function()
		local user = game.Players.LocalPlayer.Name
		for i,v in ipairs(game.Workspace:GetChildren()) do
			if v.Name:find("Auras") then
				local model = v:FindFirstChildWhichIsA("Model")
				if model then
					model:Clone().Parent = game.Workspace[user.."Auras"]
				end
			end
		end
	end    
})

ballsTab:AddButton({
	Name = "destroy other auras (CS)",
	Callback = function()
		local user = game.Players.LocalPlayer.Name
		for i,v in ipairs(game.Workspace:GetChildren()) do
			if v.Name:find("Auras") then
				local model = v:FindFirstChildWhichIsA("Model")
				if model then
					if not v.Name:find(user) then
						model:Destroy()
					end
				end
			end
		end
	end    
})
local AFK = false
local Virtual = game:GetService("VirtualUser")
local Player = game.Players.LocalPlayer
local bh

AFKTab:AddToggle({
	Name = "Anti AFK",
	Default = true,
	Callback = function(Value)
		if Value then
			print("connected [ANTI AFK]")
			bh = Player.Idled:Connect(function()
				Virtual:CaptureController()
				Virtual:ClickButton2(Vector2.new())
			end)
		else
			print("disconnected [ANTI AFK]")
			if bh then
				bh:Disconnect()
				bh = nil
			end
		end
	end    
})


AFKTab:AddDropdown({
	Name = "Auto Upgrade",
	Default = "None",
	Options = {"None","Luck", "Roll Cooldown","2X Luck Rolls","5X Luck Rolls","Fruit Duration"},
	Callback = function(Value)
		autoUpgrade=false
		task.wait(.1)
		if Value == "None" then
			autoUpgrade=false
		else
			autoUpgrade = true
			print(Value.. " [AUTO UPGRADE]")
			while true do
				task.wait(.03)
				print(Value)
				game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("PurchaseUpgrade"):InvokeServer(Value)
				if not autoUpgrade then
					break
				end
			end
		end
	end;
})

OrionLib:Init()
