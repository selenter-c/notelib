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
PLUGIN.name = "NoteLib"
PLUGIN.author = "Selenter"
PLUGIN.desc = ""

PLUGIN.maxeditors = 30
PLUGIN.maxpages = 15
PLUGIN.maxchar_title = 32
PLUGIN.maxchar_text = 20000

ix.notelib = PLUGIN

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_hooks.lua")