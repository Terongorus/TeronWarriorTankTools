--[[
function TeronAutoMarkButton_OnClick()
    Toggle_AutoMark = not Toggle_AutoMark
    if Toggle_AutoMark then
        UIErrorsFrame:Clear();
		--Green colour for enabled mode
        UIErrorsFrame:AddMessage("|cff00ff00Auto Target Marking Enabled! Your primary target is skull!|r");
        TeronTankModeButton:SetNormalTexture("Interface\\Addons\\TeronWarriorTankTools\\...")
    else
        UIErrorsFrame:Clear();
		--Red colour for disabled mode
        UIErrorsFrame:AddMessage("|cffff0000Auto Target Marking Disabled!|r"); 
        TeronTankModeButton:SetNormalTexture("Interface\\Addons\\TeronWarriorTankTools\\...")
        return
    end
end

function TeronTankModeButton_Init()
	if(TeronAutoMark_Config.ButtonShow == false) then
		TeronAutoMarkButtonFrame:Hide();
	end
end

--Updates the position of the minimap button
function TeronAutoMarkButton_UpdatePosition()
	TeronAutoMarkButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		52 - (80 * cos(TeronAutoMark_Config.ButtonPos)),
		(80 * sin(TeronAutoMark_Config.ButtonPos)) - 52
	);
end
]]
local attacking;
local target_changed;
local combat;
local target_index = 0
local f = CreateFrame("Frame", "TeronAutoMarkFrame");


combat = PlayerFrame.InCombat;

f:RegisterEvent("PLAYER_ENTER_COMBAT");
f:RegisterEvent("PLAYER_TARGET_CHANGED");
f:SetScript("OnEvent", function()
	attacking = event == "PLAYER_ENTER_COMBAT";
	target_changed = event == "PLAYER_TARGET_CHANGED";
end)

function TeronAutoMark()
	if (attacking or target_changed or combat) and UnitExists("target") then
		SetRaidTarget("target", target_index)
	end
	if target_changed and UnitExists("target") then
		target_index = target_index + 1;
	end
	if target_index > 8 then
		target_index = 0;
	end
end

