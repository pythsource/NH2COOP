ENT.Base 			= "npc_vj_human_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "SWAT Mike"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= "Nightmare House 2 SWAT"

if (CLIENT) then
local Name = "SWAT Mike"
local LangName = "npc_vj_nh2_swat_mike"
language.Add(LangName, Name)
killicon.Add(LangName,"HUD/killicons/default",Color(255,80,0,255))
language.Add("#"..LangName, Name)
killicon.Add("#"..LangName,"HUD/killicons/default",Color(255,80,0,255))
end