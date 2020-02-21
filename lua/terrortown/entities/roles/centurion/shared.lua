-- Icon Materials

if SERVER then
	AddCSLuaFile()
	
	resource.AddFile('materials/vgui/ttt/dynamic/roles/icon_cent.vmt')
end

--Initializing Centurion´s Team
roles.InitCustomTeam(ROLE.name, {
	icon = "vgui/ttt/dynamic/roles/icon_cent",
	color = Color(102, 205, 170, 255)
})

-- General settings

function ROLE:PreInitialize()
	self.color = Color(102, 205, 170, 255) -- rolecolour
	
	self.abbr = 'cent' -- Abbreviation
	self.unknownTeam = false -- teamchat available
	self.defaultTeam = TEAM_CENT -- no team, own team
	self.preventFindCredits = false -- Isn´t able to find/get credits for his perfomance
	self.preventKillCredits = false -- Isn´t able to find/get credits for his perfomance
	self.preventTraitorAloneCredits = false -- Isn´t able to find/get credits for his perfomance
	self.preventWin = false -- wins with cent team
	self.scoreKillsMultiplier       =  8
    self.scoreTeamKillsMultiplier   = -16
    self.notSelectable			    = false
	
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