--OnClick function for the button (enable/disable the "PWS remove" function)
function TeronPWSRemoverButton_OnClick()
	Toggle_PWSRemove = not Toggle_PWSRemove;
    if Toggle_PWSRemove then
        UIErrorsFrame:Clear();
		--Green colour for enabled mode
        UIErrorsFrame:AddMessage("|cff00ff00Power Word: Shield Remover Enabled|r"); 
        TeronPWSRemoverButton:SetNormalTexture("Interface\\Addons\\TeronWarriorTankTools\\Spell_Holy_PowerWordShield_enabled")
    else
        UIErrorsFrame:Clear();
		--Red colour for disabled mode
        UIErrorsFrame:AddMessage("|cffff0000Power Word: Shield Remover Disabled|r"); 
        TeronPWSRemoverButton:SetNormalTexture("Interface\\Addons\\TeronWarriorTankTools\\Spell_Holy_PowerWordShield_disabled")
        return
    end
end

function TeronPWSRemoverButton_Init()
	if(TeronPWSRemover_Config.ButtonShow == false) then
		TeronPWSRemoverButtonFrame:Hide();
	end
end

--Updates the position of the minimap button
function TeronPWSRemoverButton_UpdatePosition()
	TeronPWSRemoverButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		52 - (80 * cos(TeronPWSRemover_Config.ButtonPos)),
		(80 * sin(TeronPWSRemover_Config.ButtonPos)) - 52
	);
end