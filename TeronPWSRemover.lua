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

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_AURAS_CHANGED")

f:SetScript("OnEvent", function()
        if event == "PLAYER_AURAS_CHANGED" then
            if Toggle_PWSRemove then
--                CancelBlessingOfLight();
                CancelPowerWordShield();
            end
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
                        UIErrorsFrame:AddMessage("Power Word: Shield Removed");
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

--function CancelBlessingOfLight()
--    local buff = {"Spell_Holy_PrayerOfHealing02"}
--    local counter = 0
--    while GetPlayerBuff(counter) >= 0 do
--        local index, untilCancelled = GetPlayerBuff(counter)
--        if untilCancelled ~= 1 then
--            local texture = GetPlayerBuffTexture(index)
--            if texture then 
--                local i = 1
--                while buff[i] do
--                    if string.find(texture, buff[i]) then
--                        CancelPlayerBuff(index);
--                        UIErrorsFrame:Clear();
--                        UIErrorsFrame:AddMessage("Blessing of Light Removed");
--                        return
--                    end
--                    i = i + 1
--                end
--            end
--        end
--        counter = counter + 1
--    end
--    return nil
--end

