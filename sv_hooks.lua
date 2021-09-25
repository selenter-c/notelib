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

file.CreateDir("notelib")

netstream.Hook("EditNoteLib", function(client, id)
	local path = "notelib/" .. id .. ".txt"

	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		local item = PLUGIN:FindNotePad(client, id)

		if data and item then
			data = util.JSONToTable(data)
			local clientIsOwner = data.editors[client:SteamID()]

			if clientIsOwner then
				data.title = item:GetData("notelib_title", "Notebook")
				data.maxpage = #data.pages
				data.page = 1
				data.itemid = id

				netstream.Start(client, "EditNoteLib", data)
			end
		end
	end
end)

netstream.Hook("OpenNoteLib", function(client, id)
	local path = "notelib/" .. id .. ".txt"

	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		local item = PLUGIN:FindNotePad(client, id)

		if data and item then
			data = util.JSONToTable(data)
			local clientIsOwner = data.editors[client:SteamID()]

			if clientIsOwner then
				PLUGIN:OpenNotePad(client, id)
			end
		end
	end
end)

netstream.Hook("SaveNoteLib", function(client, id, save_data)
	local path = "notelib/" .. id .. ".txt"

	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		local item = PLUGIN:FindNotePad(client, id)

		if data and item then
			data = util.JSONToTable(data)
			local clientIsOwner = data.editors[client:SteamID()]

			if clientIsOwner and save_data then
				local final = true

				for k, v in pairs(save_data.pages) do
					if utf8.len(v.title) > PLUGIN.maxchar_title then final = false end

					if utf8.len(v.name) > PLUGIN.maxchar_text then final = false end
				end

				local maxEditors = table.Count(save_data.editors)
				if maxEditors > PLUGIN.maxeditors then final = false end

				local maxPages = #save_data.pages
				if maxPages > PLUGIN.maxpages then final = false end

				if final then
					file.Write(path, util.TableToJSON(save_data))
					client:Notify("You have successfully saved Page №" .. save_data.page .. ".")
				end
			end
		end
	end
end)

netstream.Hook("ChangeNoteLibName", function(client, id, name)
	local path = "notelib/" .. id .. ".txt"

	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		local item = PLUGIN:FindNotePad(client, id)

		if data and item then
			data = util.JSONToTable(data)
			local clientIsOwner = data.editors[client:SteamID()]
			name:gsub("\n", "")

			if clientIsOwner and utf8.len(name) <= 20 then
				item:SetData("notelib_title", name)

				client:Notify("You have successfully changed the title of Notepad.")
			end
		end
	end
end)

netstream.Hook("ChangeNoteLibDescription", function(client, id, desc)
	local path = "notelib/" .. id .. ".txt"

	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		local item = PLUGIN:FindNotePad(client, id)

		if data and item then
			data = util.JSONToTable(data)
			local clientIsOwner = data.editors[client:SteamID()]
			desc:gsub("\n", "")

			if clientIsOwner and utf8.len(desc) <= 64 then
				item:SetData("notelib_description", desc)

				client:Notify("You have successfully changed the description of Notepad.")
			end
		end
	end
end)

netstream.Hook("ChangeNoteLibTake", function(client, id)
	local path = "notelib/" .. id .. ".txt"

	if file.Exists(path, "DATA") then
		local data = file.Read(path, "DATA")
		local item = PLUGIN:FindNotePad(client, id)

		if data and item then
			data = util.JSONToTable(data)
			local clientIsOwner = data.editors[client:SteamID()]

			if clientIsOwner then
				if item:GetData("notelib_take", true) then
					item:SetData("notelib_take", false)
					client:Notify("You have successfully prevented picking up Notepad.")
				else
					item:SetData("notelib_take", true)
					client:Notify("You have successfully allowed picking up Notepad.")
				end
			end
		end
	end
end)