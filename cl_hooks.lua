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

local PLUGIN = PLUGIN

surface.CreateFont("ixNoteLibFont", {
	font = "Roboto",
	size = 20,
	extended = true,
	weight = 100
})

surface.CreateFont("ixNoteLibFontMin", {
	font = "Roboto",
	size = 15,
	extended = true,
	weight = 100
})

netstream.Hook("OpenNoteLib", function(data)
	if not data then return end

	local notelib = vgui.Create("NoteLibOpen")
	notelib:SetInfo(data)
end)

netstream.Hook("EditNoteLib", function(data)
	if not data then return end

	local notelib = vgui.Create("NoteLibEdit")
	notelib:SetInfo(data)
end)