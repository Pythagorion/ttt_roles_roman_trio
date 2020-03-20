-- Icon Materials
local rspwn_time = GetConVar("ttt_cent_gladiator_time_of_respawn"):GetInt()

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
	self.defaultTeam = TEAM_CENTURION -- no team, own team
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
		credits = 3, -- the starting credits of a specific role
		shopFallback = SHOP_FALLBACK_TRAITOR, -- Uses traitor-shop
		togglable = true, -- option to toggle a role for a client if possible (F1 menu)
		random = 50
	}
end

function ROLE:GiveRoleLoadout( ply, isRoleChange )
	ply:GiveEquipmentWeapon("weapon_ttt_incridibilisgun")
end

function ROLE:RemoveRoleLoadout( ply, isRoleChange )
	ply:StripWeapon("weapon_ttt_incridibilisgun")
end

if SERVER then
	local function ClearCenturios()
		local plys = player.GetAll()

		for i = 1, #plys do
			local ply = plys[i]
			ply.centurio_data = nil
		end
	end

	hook.Add("TTTEndRound","ttt2_role_centurion_dpd_roundend", function()
		ClearCenturios()
	end)

	hook.Add("TTTBeginRound","ttt2_role_centurion_roundbegin", function()
		ClearCenturios()
	end)

	hook.Add("TTTPrepareRound","ttt2_role_centurion_roundprep", function()
		ClearCenturios()
	end)

	hook.Add("DoPlayerDeath", "SetRightInflictorOnDeath_Centurion_ICH_MAG_KEKSE_UND_ICH_HOFFE_DIESE_HOOK_EXISTIERT_SO_NICHT_BUH", function (ply, attacker, dmg)
		if dmg:GetDamageType() == 8194 then
			if attacker:IsPlayer() then
				local weapon = attacker:GetActiveWeapon()
				if weapon ~= nil then
					ply.centurio_data = weapon
				end
			end
		end
	end)

	hook.Add("PlayerDeath", "ReviveANewGladi", function(victim, inflictor, attacker)
		local weapon = victim.centurio_data
		if attacker:GetRole() == ROLE_CENTURION and victim:GetTeam() ~= TEAM_CENTURION and weapon ~= nil and weapon:GetClass() == "weapon_ttt_incridibilisgun" then
			victim.centurio_data = nil
			victim:Revive(rspwn_time, function(p)
				p:SetRole( ROLE_GLADIATOR )
			end)
		end
	end)
end