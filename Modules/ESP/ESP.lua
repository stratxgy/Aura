getgenv().ESP = {
	Enabled = false,
	Color = Color3.fromRGB(255, 255, 255), 
	Rainbow = false, 
	Boxes = false, 
	Names = false, 
	Distance = false, 
	Tracers = false, 
	UnlockTracers = false, 
	Objects = setmetatable({}, {__mode = "kv"}), 
	Overrides = {}, 
	MainRenderStepped = nil
}

if not getgenv().ESP.Enabled then return end 

local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Players = cloneref(game:GetService("Players"))

local workspace2 = cloneref(game:GetService("Workspace"))
local Rainbow = 0

local function Draw(obj, props)
	local new = Drawing.new(obj)

	props = props or {}

	for i, v in next, props do
		new[i] = v
	end

	return new
end

function ESP:GetColor(obj)
	local ov = self.Overrides.GetColor

	if ov then
		return ov(obj)
	end

	local p = self:GetPlrFromChar(obj)

	return p and self.Color
end

function ESP:GetPlrFromChar(char)
	local ov = self.Overrides.GetPlrFromChar

	if ov then
		return ov(char)
	end

	return Players:GetPlayerFromCharacter(char)
end

function ESP:Toggle(bool)
	if not bool then
		for i, v in next, self.Objects do
			if v.Type == "Box" then
				if v.Temporary then
					v:Remove()
				else
					for i, v in next, v.Components do
						v.Visible = false
					end
				end
			end
		end
	end
end

function ESP:GetBox(obj)
	return self.Objects[obj]
end

function ESP:AddObjectListener(parent, options)
	local function NewListener(c)
		if type(options.Type) == "string" and c:IsA(options.Type) or options.Type == nil then
			if type(options.Name) == "string" and c.Name == options.Name or options.Name == nil then
				if not options.Validator or options.Validator(c) then
					local box = ESP:Add(c, {
						PrimaryPart = type(options.PrimaryPart) == "string" and c:WaitForChild(options.PrimaryPart) or type(options.PrimaryPart) == "function" and options.PrimaryPart(c), 
						Color = type(options.Color) == "function" and options.Color(c) or options.Color, 
						ColorDynamic = options.ColorDynamic, 
						Name = type(options.CustomName) == "function" and options.CustomName(c) or options.CustomName, 
						IsEnabled = options.IsEnabled, 
						RenderInNil = options.RenderInNil
					})

					if options.OnAdded then
						coroutine.wrap(options.OnAdded)(box)
					end
				end
			end
		end
	end

	if options.Recursive then
		parent.DescendantAdded:Connect(NewListener)

		for i, v in next, parent:GetDescendants() do
			coroutine.wrap(NewListener)(v)
		end
	else
		parent.ChildAdded:Connect(NewListener)

		for i, v in next, parent:GetChildren() do
			coroutine.wrap(NewListener)(v)
		end
	end
end

local boxBase = {}
boxBase.__index = boxBase

function boxBase:Remove()
	ESP.Objects[self.Object] = nil

	for i, v in next, self.Components do
		v.Visible = false
		v:Remove()
		self.Components[i] = nil
	end
end

function boxBase:Update()
	if not self.PrimaryPart then
		return self:Remove()
	end

	local color

	local allow = true

	if ESP.Overrides.UpdateAllow and not ESP.Overrides.UpdateAllow(self) then
		allow = false
	end

	if self.Player and not ESP.Enabled then
		allow = false
	end

	if self.IsEnabled and (type(self.IsEnabled) == "string" and not ESP[self.IsEnabled] or type(self.IsEnabled) == "function" and not self:IsEnabled()) then
		allow = false
	end

	if not workspace2:IsAncestorOf(self.PrimaryPart) and not self.RenderInNil then
		allow = false
	end

	if not allow then
		for i, v in next, self.Components do
			v.Visible = false
			self.Components.Quad.Thickness = 0
		end

		return
	end

	local locs = {
		TopLeft = CFrame.new(self.PrimaryPart.CFrame.Position, workspace2.CurrentCamera.CFrame.Position) * CFrame.new(self.Size.X / 2, self.Size.Y / 2, 0), 
		TopRight = CFrame.new(self.PrimaryPart.CFrame.Position, workspace2.CurrentCamera.CFrame.Position) * CFrame.new(-self.Size.X / 2, self.Size.Y / 2, 0), 
		BottomLeft = CFrame.new(self.PrimaryPart.CFrame.Position, workspace2.CurrentCamera.CFrame.Position) * CFrame.new(self.Size.X / 2, -self.Size.Y / 2, 0), 
		BottomRight = CFrame.new(self.PrimaryPart.CFrame.Position, workspace2.CurrentCamera.CFrame.Position) * CFrame.new(-self.Size.X / 2, -self.Size.Y / 2, 0), 
		TagPos = CFrame.new(self.PrimaryPart.CFrame.Position, workspace2.CurrentCamera.CFrame.Position) * CFrame.new(0, self.Size.Y / 2, 0), 
		Torso = CFrame.new(self.PrimaryPart.CFrame.Position, workspace2.CurrentCamera.CFrame.Position)
	}

	if ESP.Boxes then
		local TopLeft, Vis1 = workspace2.CurrentCamera.WorldToViewportPoint(workspace2.CurrentCamera, locs.TopLeft.Position)
		local TopRight, Vis2 = workspace2.CurrentCamera.WorldToViewportPoint(workspace2.CurrentCamera, locs.TopRight.Position)
		local BottomLeft, Vis3 = workspace2.CurrentCamera.WorldToViewportPoint(workspace2.CurrentCamera, locs.BottomLeft.Position)
		local BottomRight, Vis4 = workspace2.CurrentCamera.WorldToViewportPoint(workspace2.CurrentCamera, locs.BottomRight.Position)

		if self.Components.Quad then
			if Vis1 or Vis2 or Vis3 or Vis4 then
				self.Components.Quad.Visible = true
				self.Components.Quad.Thickness = 2
				self.Components.Quad.PointA = Vector2.new(TopRight.X, TopRight.Y)
				self.Components.Quad.PointB = Vector2.new(TopLeft.X, TopLeft.Y)
				self.Components.Quad.PointC = Vector2.new(BottomLeft.X, BottomLeft.Y)
				self.Components.Quad.PointD = Vector2.new(BottomRight.X, BottomRight.Y)
				self.Components.Quad.Color = ESP.Rainbow and Color3.fromHSV(Rainbow, 1, 1) or ESP.Color
			else
				self.Components.Quad.Visible = false
				self.Components.Quad.Thickness = 0
			end
		end
	else
		self.Components.Quad.Visible = false
		self.Components.Quad.Thickness = 0
	end

	if ESP.Names then
		local TagPos, Vis5 = workspace2.CurrentCamera.WorldToViewportPoint(workspace2.CurrentCamera, locs.TagPos.Position)

		if Vis5 then
			self.Components.Name.Visible = true
			self.Components.Name.Position = Vector2.new(TagPos.X, TagPos.Y)
			self.Components.Name.Text = self.Name
			self.Components.Name.Color = ESP.Rainbow and Color3.fromHSV(Rainbow, 1, 1) or ESP.Color
		else
			self.Components.Name.Visible = false
		end
	else
		self.Components.Name.Visible = false
	end

	if ESP.Distance then
		local TagPos, Vis7 = workspace2.CurrentCamera.WorldToViewportPoint(workspace2.CurrentCamera, locs.TagPos.Position)

		if Vis7 then
			self.Components.Distance.Visible = true
			self.Components.Distance.Position = Vector2.new(TagPos.X, TagPos.Y + 14)
			self.Components.Distance.Text = math.round((workspace2.CurrentCamera.CFrame.Position - CFrame.new(self.PrimaryPart.CFrame.Position, workspace2.CurrentCamera.CFrame.Position).Position).Magnitude) .. "m away"
			self.Components.Distance.Color = ESP.Rainbow and Color3.fromHSV(Rainbow, 1, 1) or ESP.Color
		else
			self.Components.Distance.Visible = false
		end
	else
		self.Components.Distance.Visible = false
	end

	if ESP.Tracers then
		local TorsoPos, Vis6 = workspace2.CurrentCamera.WorldToViewportPoint(workspace2.CurrentCamera, locs.Torso.Position)

		if Vis6 then
			self.Components.Tracer.Visible = true
			self.Components.Tracer.To = Vector2.new(TorsoPos.X, TorsoPos.Y)

			if ESP.UnlockTracers then
				self.Components.Tracer.From = UserInputService:GetMouseLocation()
			else
				self.Components.Tracer.From = Vector2.new(workspace2.CurrentCamera.ViewportSize.X / 2, workspace2.CurrentCamera.ViewportSize.Y)
			end

			self.Components.Tracer.Color = ESP.Rainbow and Color3.fromHSV(Rainbow, 1, 1) or ESP.Color
		else
			self.Components.Tracer.Visible = false
		end
	else
		self.Components.Tracer.Visible = false
	end
end

function ESP:Add(obj, options)
	if not obj.Parent and not options.RenderInNil then
		return warn(obj, "has no parent")
	end

	local box = setmetatable({
		Name = options.Name or obj.Name, 
		Type = "Box", 
		Color = options.Color, 
		Size = options.Size or Vector3.new(4, 6, 0), 
		Object = obj, 
		Player = options.Player or Players:GetPlayerFromCharacter(obj), 
		PrimaryPart = options.PrimaryPart or obj.ClassName == "Model" and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")) or obj:IsA("BasePart") and obj, 
		Components = {}, 
		IsEnabled = options.IsEnabled, 
		Temporary = options.Temporary, 
		ColorDynamic = options.ColorDynamic, 
		RenderInNil = options.RenderInNil
	}, boxBase)

	if self:GetBox(obj) then
		self:GetBox(obj):Remove()
	end

	box.Components["Quad"] = Draw("Quad", {
		Thickness = 2, 
		Color = ESP.Rainbow and Color3.fromHSV(Rainbow, 1, 1) or ESP.Color, 
		Filled = false, 
		Visible = self.Boxes
	})

	box.Components["Name"] = Draw("Text", {
		Text = box.Name, 
		Color = box.Color, 
		Center = true, 
		Outline = true, 
		Size = 19, 
		Visible = self.Names
	})

	box.Components["Distance"] = Draw("Text", {
		Color = box.Color, 
		Center = true, 
		Outline = true, 
		Size = 19, 
		Visible = self.Names
	})

	box.Components["Tracer"] = Draw("Line", {
		Thickness = 2, 
		Color = box.Color, 
		Visible = self.Tracers
	})

	self.Objects[obj] = box

	obj.AncestryChanged:Connect(function(_, parent)
		if parent == nil and ESP.AutoRemove ~= false then
			box:Remove()
		end
	end)

	obj:GetPropertyChangedSignal("Parent"):Connect(function()
		if obj.Parent == nil and ESP.AutoRemove ~= false then
			box:Remove()
		end
	end)

	local hum = obj:FindFirstChildOfClass("Humanoid")

	if hum then
		hum.Died:Connect(function()
			if ESP.AutoRemove ~= false then
				box:Remove()
			end
		end)
	end

	return box
end

local function CharAdded(char)
	local p = Players:GetPlayerFromCharacter(char)

	if not char:FindFirstChild("HumanoidRootPart") then
		local ev
		ev = char.ChildAdded:Connect(function(c)
			if c.Name == "HumanoidRootPart" then
				ev:Disconnect()
				ESP:Add(char, {
					Name = p.Name, 
					Player = p, 
					PrimaryPart = c
				})
			end
		end)
	else
		ESP:Add(char, {
			Name = p.Name, 
			Player = p, 
			PrimaryPart = char.HumanoidRootPart
		})
	end
end

local function PlayerAdded(p)
	p.CharacterAdded:Connect(CharAdded)
	if p.Character then
		coroutine.wrap(CharAdded)(p.Character)
	end
end

Players.PlayerAdded:Connect(PlayerAdded)
for i, v in next, Players:GetPlayers() do
	if v ~= Players.LocalPlayer then
		PlayerAdded(v)
	end
end

ESP.MainRenderStepped = RunService.RenderStepped:Connect(function()
	Rainbow = (Rainbow + 0.001) % 1

	for i, v in next, ESP.Objects do
		if v.Update then
			local s, e = pcall(v.Update, v)
		end
	end
end)

return ESP
