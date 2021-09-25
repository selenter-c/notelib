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

ITEM.name = "NoteLib Base"
ITEM.description = ""
ITEM.model = "models/Items/BoxSRounds.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.skin = 0
ITEM.category = "Library"

function ITEM:GetName()
	return self:GetData("notelib_title", self.name)
end

function ITEM:GetDescription()
	return self:GetData("notelib_description", self.description)
end

function ITEM:GetSkin()
	return self.skin or 0
end

function ITEM:PopulateTooltip(tooltip)
	local info = tooltip:AddRow("take")
	info:SetText(self:GetData("notelib_take") and "This item can be picked up." or "This item cannot be picked up.")
	info:SetBackgroundColor(self:GetData("notelib_take") and Color(91, 208, 87) or Color(252, 60, 60))
	info:SizeToContents()
end

ITEM.functions.edit = {
	name = "Read",
	icon = "icon16/pencil.png",
	OnRun = function(item)
		local client = item.player

		ix.notelib:OpenNotePad(client, item:GetID())

		return false
	end
}