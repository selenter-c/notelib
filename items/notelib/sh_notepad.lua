--[[
        © Asterion Project 2021.
        This script was created from the developers of the AsterionTeam.
        You can get more information from one of the links below:
            Site - https://asterionproject.ru
            Discord - https://discord.gg/Cz3EQJ7WrF
        
        developer(s):
            Selenter - https://steamcommunity.com/id/selenter

        ——— Chop your own wood and it will warm you twice.
]]--

ITEM.name = "Notepad"
ITEM.model = Model("models/props_lab/clipboard.mdl")
ITEM.description = "The most common notepad for notes"


-- replace take functions
ITEM.functions.take = {
	tip = "takeTip",
	icon = "icon16/box.png",
	OnRun = function(item)
		local client = item.player
		local bSuccess, error = item:Transfer(client:GetCharacter():GetInventory():GetID(), nil, nil, client)

		if (!bSuccess) then
			client:NotifyLocalized(error or "unknownError")
			return false
		else
			client:EmitSound("npc/zombie/foot_slide" .. math.random(1, 3) .. ".wav", 75, math.random(90, 120), 1)

			if (item.data) then
				for k, v in pairs(item.data) do
					item:SetData(k, v)
				end
			end
		end

		return true
	end,
	OnCanRun = function(item)
		return IsValid(item.entity) and item:GetData("notelib_take", true)
	end
}