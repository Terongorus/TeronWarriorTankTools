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
function TeronAutoMark()
	local index = 0
	if UnitExists("target") then
		SetRaidTarget("target", index)
	end
end
