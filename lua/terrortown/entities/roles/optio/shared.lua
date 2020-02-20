-- Icon Materials

if SERVER then
	AddCSLuaFile()
	
	resource.AddFile('materials/vgui/ttt/dynamic/roles/icon_optio.vmt')
end

-- General settings

function ROLE:PreInitialize()
	self.color = Color(238, 064, 000, 255) -- rolecolour
	
	self.abbr = 'optio' -- Abbreviation
	self.unknownTeam = false -- No teamchat
	self.defaultTeam = TEAM_TRAITOR -- no team, own team
	self.preventFindCredits = false -- Is able to find/get credits for his perfomance
	self.preventKillCredits = false -- Is able to find/get credits for his perfomance
	self.preventTraitorAloneCredits = false -- Is able to find/get credits for his perfomance
	self.preventWin = false -- wins with traitor team
	self.scoreKillsMultiplier       =  8
    self.scoreTeamKillsMultiplier   = -16
	
	-- ULX convars

	self.conVarData = {
		pct = 0.17, -- necessary: percentage of getting this role selected (per player)
		maximum = 1, -- maximum amount of roles in a round
		minPlayers = 7, -- minimum amount of players until this role is able to get selected
		credits = 0, -- the starting credits of a specific role
		shopFallback = SHOP_FALLBACK_TRAITOR, -- Uses traitor-shop
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 50
	}
end