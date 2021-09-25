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

function PLUGIN:FindNotePad(client, id)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()

	if character and id then
		if client:GetEyeTrace().Entity:GetClass() == "ix_container" then
			for k, v in pairs(client:GetEyeTrace().Entity:GetInventory():GetItems()) do
				if (v:GetID() == id) then
					return v
				end
			end
		end

		for k, v in pairs(inventory:GetItems()) do
			if (v:GetID() == id) then
				return v
			end
		end

		for k, v in pairs(ents.GetAll()) do
			if v:GetClass() == "ix_item" then
				local itemID = v.ixItemID
				local item = ix.item.instances[itemID]
				if (itemID == id) then
					return item
				end
			end
		end
	end

	return false
end

function PLUGIN:OpenNotePad(client, itemID)
	local path = "notelib/" .. itemID .. ".txt"

	if not file.Exists(path, "DATA") then
		local data = {
			editors = {},
			pages = {
				[1] = {
					title = "",
					name = ""
				}
			}
		}

		data.editors[client:SteamID()] = true
		file.Write(path, util.TableToJSON(data))
	end

	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		local item = self:FindNotePad(client, itemID)

		if data and item then
			data = util.JSONToTable(data)
			data.title = item:GetData("notelib_title", "Notebook")
			data.maxpage = #data.pages
			data.page = 1
			data.itemid = itemID

			netstream.Start(client, "OpenNoteLib", data)
		end
	end
end