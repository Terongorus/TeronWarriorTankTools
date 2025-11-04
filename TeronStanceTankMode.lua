function TeronTankModeButton_OnClick()
	Toggle_TankMode = not Toggle_TankMode;
    if Toggle_TankMode then
        UIErrorsFrame:Clear();
		--Green colour for enabled mode
        UIErrorsFrame:AddMessage("|cff00ff00Tank Mode Enabled! Using Defensive Stance!|r");
        TeronTankModeButton:SetNormalTexture("Interface\\Addons\\TeronWarriorTankTools\\Icons\\Ability_Warrior_DefensiveStance_16x16")
    else
        UIErrorsFrame:Clear();
		--Red colour for disabled mode
        UIErrorsFrame:AddMessage("|cffff0000Tank Mode Disabled! Using Battle Stance!|r"); 
        TeronTankModeButton:SetNormalTexture("Interface\\Addons\\TeronWarriorTankTools\\Icons\\Ability_Warrior_OffensiveStance_16x16")
        return
    end
end

function TeronTankModeButton_Init()
	if(TeronTankMode_Config.ButtonShow == false) then
		TeronTankModeButtonFrame:Hide();
	end
end

--Updates the position of the minimap button
function TeronTankModeButton_UpdatePosition()
	TeronTankModeButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		52 - (80 * cos(TeronTankMode_Config.ButtonPos)),
		(80 * sin(TeronTankMode_Config.ButtonPos)) - 52
	);
end

function TeronTankMode()
    if Toggle_TankMode then
            CastSpellByName("Defensive Stance");
    elseif not Toggle_TankMode then
            CastSpellByName("Battle Stance");
    end
end