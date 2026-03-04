BINDING_HEADER_TERONWARRIORTANKTOOLS_HEADER = "Teron Warrior Tank Tools";
BINDING_NAME_TERONWARRIORTANKTOOLS_PWSREMOVE = "Toggle PWS Remover";
BINDING_NAME_TERONWARRIORTANKTOOLS_TANKMODE = "Toggle Tank Mode";

SLASH_TOGGLE_PWS = '/pwsremove'
SlashCmdList["TOGGLE_PWS"] = function(command)
    if command == "disable" then
        Toggle_PWSRemove = false
        UIErrorsFrame:Clear();
        UIErrorsFrame:AddMessage("|cffff0000Power Word: Shield Remover Disabled|r");
    end
    if command == "enable" then
        Toggle_PWSRemove = true
        UIErrorsFrame:Clear();
        UIErrorsFrame:AddMessage("|cff00ff00Power Word: Shield Remover Enabled|r");
    end
end

local f = CreateFrame("TeronWarriorTankToolsFrame", "TeronWarriorTankToolsFrame", UIParent)
f:RegisterEvent("PLAYER_AURAS_CHANGED")
f:SetScript("OnEvent", function()
    if event == "PLAYER_AURAS_CHANGED" then 
        if Toggle_PWSRemove then
            CancelPowerWordShield();
        end
        if WarriorIsShieldEquipped() then
            CancelBlessingOfSalvation();
        end
    end
end)
TeronWarriorTankToolsFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
TeronWarriorTankToolsFrame:SetWidth(200);
TeronWarriorTankToolsFrame:SetHeight(50);
TeronWarriorTankToolsFrame:Hide();

-- creates a button to toggle tank mode on and off, the button will change its texture depending on the state of tank mode
local button_1 = CreateFrame("Button", "Tank_Mode_Button", TeronWarriorTankToolsFrame)
button_1:SetPoint("LEFT", TeronWarriorTankToolsFrame, "CENTER", 0, 0);
button_1:SetWidth(40);
button_1:SetHeight(40);
button_1:SetNormalTexture("Interface\\Icons\\");
button_1:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD");
button_1:SetScript("OnClick", function()
    TeronTankModeButton_OnClick()
end)
button_1:SetScript("OnLoad", function()
    if Toggle_TankMode then
        button_1:SetNormalTexture("Interface\\Icons\\Ability_Warrior_DefensiveStance_16x16");
    else
        button_1:SetNormalTexture("Interface\\Icons\\Ability_Warrior_OffensiveStance_16x16");
    end
end)

-- creates a button to toggle pws remover on and off, the button will change its texture depending on the state of pws remover
local button_2 = CreateFrame("Button", "PWS_Remove_Button", TeronWarriorTankToolsFrame)
button_2:SetPoint("RIGHT", TeronWarriorTankToolsFrame, "CENTER", button_1.Height, 0);
button_2:SetWidth(40);
button_2:SetHeight(40);
button_2:SetNormalTexture("Interface\\Icons\\");
button_2:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD");
button_2:SetScript("OnClick", function()
    TeronPWSRemoverButton_OnClick()
end)
button_2:SetScript("OnLoad", function()
    if Toggle_PWSRemove then
        button_2:SetNormalTexture("Interface\\Icons\\Spell_Holy_PowerWordShield_enabled");
    else
        button_2:SetNormalTexture("Interface\\Icons\\Spell_Holy_PowerWordShield_disabled");
    end
end)


function WarriorIsShieldEquipped()
	local slot = GetInventorySlotInfo("SecondaryHandSlot")
	local link = GetInventoryItemLink("player", slot)
	if link  then
		local found, _, id, name = string.find(link, "item:(%d+):.*%[(.*)%]")
		if found and id then
			local _,_,_,_,_,itemType = GetItemInfo(tonumber(id))
			if(itemType == "Shields") then
				return true
			end
		end
	end
	return false
end

function CancelPowerWordShield()
    local buff = {"Spell_Holy_PowerWordShield"}
    local counter = 0
    while GetPlayerBuff(counter) >= 0 do
        local index, untilCancelled = GetPlayerBuff(counter)
        if untilCancelled ~= 1 then
            local texture = GetPlayerBuffTexture(index)
            if texture then 
                local i = 1
                while buff[i] do
                    if string.find(texture, buff[i]) then
                        CancelPlayerBuff(index);
                        UIErrorsFrame:Clear();
                        UIErrorsFrame:AddMessage("Power Word: Shield Removed!");
                        return
                    end
                    i = i + 1
                end
            end
        end
        counter = counter + 1
    end
    return nil
end

function CancelBlessingOfSalvation()
    local buff = {"Spell_Holy_SealOfSalvation"}
    local counter = 0
    while GetPlayerBuff(counter) >= 0 do
        local index, untilCancelled = GetPlayerBuff(counter)
        if untilCancelled ~= 1 then
            local texture = GetPlayerBuffTexture(index)
            if texture then 
                local i = 1
                while buff[i] do
                    if string.find(texture, buff[i]) then
                        CancelPlayerBuff(index);
                        UIErrorsFrame:Clear();
                        UIErrorsFrame:AddMessage("Blessing of Salvation Removed!", 1.0, 1.0, 0.0, 1.0);
                        return
                    end
                    i = i + 1
                end
            end
        end
        counter = counter + 1
    end
    return nil
end

