loadstring(game:HttpGet("https://raw.githubusercontent.com/zee-7654/UI/refs/heads/main/UI.lua"))() -- This adds globals "UI" and "Flags" (matcha please add loadstring returning)

local Window = UI:Window({
	Title = "Window Title",
	Size = Vector2.new(700, 500),
	Flags = {},
})

local FlagsTab = Window:Tab({ Title = "Flags" })
local FlagTests = FlagsTab:Section({ Title = "Flag Tests" })

FlagTests:Label({ Title = "Window Flags" })
FlagTests:Checkbox({ Title = "No Collapse Window" }, function(bool)
	Window.Flags.Set(Flags.Window.NoCollapse, bool)
end)

FlagTests:Checkbox({ Title = "No Move Window" }, function(bool)
	Window.Flags.Set(Flags.Window.NoMove, bool)
end)

FlagTests:Label({ Title = "Tab Flags" })
FlagTests:Button({ Title = "Set Inactive (3s)" }, function()
	FlagsTab.Flags.Set(Flags.Tab.Inactive, true)
	--wait(3) -- wait is currently broken in matcha, replacing with a custom wait of 180 frames (also only 3 seconds in 60fps pretty sure lol)
	local counter = 0
	repeat
		task.wait()
		counter += 1
	until counter >= 180
	FlagsTab.Flags.Set(Flags.Tab.Inactive, false)
end)
FlagTests:Checkbox({ Title = "No Scroll Tab" }, function(bool)
	FlagsTab.Flags.Set(Flags.Tab.NoScroll, bool)
end)

FlagTests:Label({ Title = "Section Flags" })
FlagTests:Button({ Title = "Set Inactive (3s)" }, function()
	FlagTests.Flags.Set(Flags.Section.Inactive, true)
	--wait(3) -- wait is currently broken in matcha, replacing with a custom wait of 180 frames (also only 3 seconds in 60fps pretty sure lol)
	local counter = 0
	repeat
		task.wait()
		counter += 1
	until counter >= 180
	FlagTests.Flags.Set(Flags.Section.Inactive, false)
end)
FlagTests:Checkbox({ Title = "No Collapse Section" }, function(bool)
	FlagTests.Flags.Set(Flags.Section.NoCollapse, bool)
end)

FlagTests:Label({ Title = "Widgets" })
local Keybind = FlagTests:Keybind({ Title = "Keybind Flags" }, function() end, function(key) end)

FlagTests:Checkbox({ Title = "No Keybind Change" }, function(bool)
	Keybind.Flags.Set(Flags.Widgets.Keybind.NoChange, bool)
end)

local FlagsTests2 = FlagsTab:Section({ Title = "Alot of Widgets" })
for i = 1, 100 do
	if math.random() > 0.5 then
		FlagsTests2:Button()
	else
		FlagsTests2:Label()
	end
end

local Showcase = Window:Tab({
	Title = "Showcase",
})

local ShowcaseSection = Showcase:Section({ Title = "Showcase", Collapsed = true })

ShowcaseSection:Button({ Title = "Unload" }, function()
	Window:Unload()
end)

ShowcaseSection:Keybind({ Title = "Toggle Window", Key = Enum.KeyCode.Q }, function()
	Window:Toggle()
end)

ShowcaseSection:Label({ Title = "Label Text" })

ShowcaseSection:Button({ Title = "Click Me!" }, function()
	print("You clicked me!")
end)

ShowcaseSection:Checkbox({ Title = "Checkbox" }, function(bool)
	print("Checkbox", bool)
end)

ShowcaseSection:Slider({ Title = "Slider", Min = -100, Max = 100, Step = 0.1, Default = 50, Suffix = "" }, function(number)
	print("Slider", number)
end)

ShowcaseSection:Slider({ Title = "Suffix Slider", Min = 0, Max = 1000, Step = 50, Default = 100, Suffix = "px" }, function(number)
	print("Suffix Slider", number)
end)

ShowcaseSection:Dropdown({ Title = "Dropdown", Options = { "a", "b", "c" }, Default = "b" }, function(selected)
	print(selected)
end)

ShowcaseSection:MultiDropdown({ Title = "MultiDropdown", Options = { "x", "y", "z" }, Default = { "y", "z" } }, function(selected)
	for index, str in selected do
		print(index, str)
	end
end)

ShowcaseSection:Keybind({ Title = "Keybind", Key = Enum.KeyCode.X }, function()
	print("Clicked the key")
end, function(key)
	print("Keybind Changed", key)
end)

local Adding = Window:Tab({
	Title = "Scroll Test",
})

local Add = Adding:Section({ Title = "Adding Elements" })
local Scroll = Adding:Section({ Title = "Scroll" })

local Amount = Add:Slider({ Title = "Amount", Min = 1, Max = 100, Default = 1 }, function(n) end)

Add:Button({ Title = "Add 'Amount' amount of things" }, function()
	for i = 1, Amount:Get() do
		Scroll:Label({ Title = "Label: " .. i })
	end
end)

local References = Window:Tab({
	Title = "Referencing",
})

local ReferenceSection = References:Section({
	Title = "References",
	Collapsed = true,
})

local AnotherReferenceSection = References:Section({
	Title = "On Other Sections",
	Collapsed = true,
})

local ReferenceExample = {
	Checkbox = { TestKey = false, Key2 = true },
	Slider = { SliderTest = 50 },
}

ReferenceSection:Label({
	Title = "Checkbox",
})
ReferenceSection:Checkbox({ Title = "Reference 1 - 1", Reference = {
	Table = ReferenceExample.Checkbox,
	Key = "TestKey",
} }, function(bool)
	print("1 - 1", bool)
end)

ReferenceSection:Checkbox({ Title = "Reference 1 - 2", Reference = {
	Table = ReferenceExample.Checkbox,
	Key = "TestKey",
} }, function(bool)
	print("1 - 2", bool)
end)

ReferenceSection:Checkbox({ Title = "Reference 1 - 3", Reference = {
	Table = ReferenceExample.Checkbox,
	Key = "TestKey",
} }, function(bool)
	print("1 - 3", bool)
end)

ReferenceSection:Checkbox({ Title = "Reference 2 - 1", Reference = {
	Table = ReferenceExample.Checkbox,
	Key = "Key2",
} }, function(bool)
	print("2 - 1", bool)
end)

ReferenceSection:Checkbox({ Title = "Reference 2 - 2", Reference = {
	Table = ReferenceExample.Checkbox,
	Key = "Key2",
} }, function(bool)
	print("2 - 2", bool)
end)

ReferenceSection:Slider({ Title = "Reference 1 - 1", Min = 0, Max = 100, Step = 5, Reference = {
	Table = ReferenceExample.Slider,
	Key = "SliderTest",
} }, function(number)
	print("1 - 1", number)
end)

ReferenceSection:Slider({ Title = "Reference 1 - 2", Min = 0, Max = 100, Step = 5, Reference = {
	Table = ReferenceExample.Slider,
	Key = "SliderTest",
} }, function(number)
	print("1 - 2", number)
end)

AnotherReferenceSection:Checkbox({ Title = "Reference Other - Checkbox", Reference = {
	Table = ReferenceExample.Checkbox,
	Key = "Key2",
} }, function(bool)
	print("Other - Checkbox", bool)
end)

local SettingGettingTab = Window:Tab({ Title = "Set & Get" })
local SettingGetting = SettingGettingTab:Section({ Title = "Setting & Getting", Collapsed = true })

local StartRunTime = os.clock()
local Runtime = SettingGetting:Label({ Title = "Runtime: 0" })

SettingGetting:Label({ Title = "Checkbox" })
local SGCheckboxLabel = SettingGetting:Label({ Title = "Checkbox Value: " })
local SGCheckbox = SettingGetting:Checkbox({ Title = "Checkbox" }, function(bool) end)
SettingGetting:Button({ Title = "Toggle" }, function()
	SGCheckbox:Set(not SGCheckbox:Get())
end)

SettingGetting:Label({ Title = "Slider" })
local SGSliderLabel = SettingGetting:Label({ Title = "Slider Value: " })
local SGSlider = SettingGetting:Slider({ Title = "Slider", Min = -100, Max = 100, Default = 0, Suffix = "" })
SettingGetting:Button({ Title = "Set to Random" }, function()
	SGSlider:Set(math.random(-100, 100))
end)

SettingGetting:Label({ Title = "Dropdown" })
local SGDropdownLabel = SettingGetting:Label({ Title = "Dropdown Value: " })
local SGDropdown = SettingGetting:Dropdown({ Title = "Dropdown", Options = { "One", "Two", "Three" }, Default = "One" })
SettingGetting:Button({ Title = "Set to Next" }, function()
	local options = SGDropdown.Options.Options
	local index = table.find(options, SGDropdown:Get())

	index = (index and index < #options) and index + 1 or 1
	SGDropdown:Set(options[index])
end)

SettingGetting:Label({ Title = "MultiDropdown" })
local SGMultiDropdownLabel = SettingGetting:Label({ Title = "MultiDropdown Value: " })
local SGMultiDropdown = SettingGetting:MultiDropdown({ Title = "MultiDropdown", Options = { "One", "Two", "Three" }, Default = {} })

SettingGetting:Button({ Title = "Toggle Random Option" }, function()
	local options = SGMultiDropdown.Options.Options
	local option = options[math.random(#options)]

	SGMultiDropdown:Toggle(option)
end)

while Window.Internal.Running do
	wait()
	Runtime:Set("Runtime: " .. math.round((os.clock() - StartRunTime) * 10) / 10)
	SGCheckboxLabel:Set("Checkbox Value: " .. tostring(SGCheckbox:Get()))
	SGSliderLabel:Set("Slider Value: " .. SGSlider:Get())
	SGDropdownLabel:Set("Dropdown Value: " .. SGDropdown:Get())
	SGMultiDropdownLabel:Set("MultiDropdown Value: " .. table.concat(SGMultiDropdown:Get(), ", "))
end
