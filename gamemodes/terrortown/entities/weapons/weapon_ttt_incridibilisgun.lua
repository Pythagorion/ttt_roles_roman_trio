AddCSLuaFile()

SWEP.HoldType = "shotgun"

if CLIENT then
    SWEP.PrintName = "Incridibilis-Shotgun"
    SWEP.Slot = 7

    SWEP.ViewModelFlip = false 
    SWEP.ViewModelFOV = 54

    SWEP.Icon = "vgui/ttt/icon_shotgun"
end

SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_EXTRA

SWEP.Primary.Ammo = "none"
SWEP.Primary.Recoil = 6
SWEP.Primary.Damage = 48
SWEP.Primary.Delay = 0.6
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 4
SWEP.Primary.ClipMax = 4
SWEP.Primary.DefaultClip = 4
SWEP.Primary.Automatic = true
SWEP.Primary.Sound = Sound("Weapon_Shotgun.Single")
SWEP.notBuyable = true

SWEP.HeadshotMultiplier = 4

SWEP.AutoSpawnable = false 
SWEP.Spawnable = false 

SWEP.UseHands = false 
SWEP.ViewModel = "models/weapons/v_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"

SWEP.IronSightsPos = Vector(-6.361, -3.701, 2.15)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.AllowDrop = false 

local rspwn_time = GetConVar("ttt_cent_gladiator_time_of_respawn"):GetInt()

function SWEP:PrimaryAttack()

    self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

    if not self:CanPrimaryAttack() then return end

    sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)

    self:ShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone())
    self:TakePrimaryAmmo(1)

    local owner = self:GetOwner()
    if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

    owner:ViewPunch(Angle(util.SharedRandom(self:GetClass(), -0.2, -0.1, 0) * self.Primary.Recoil, util.SharedRandom(self:GetClass(), -0.1, 0.1, 1) * self.Primary.Recoil, 0))
    self.BaseClass.PrimaryAttack(self)
    
end

if SERVER then
    hook.Add("PlayerDeath", "ReviveANewGladi", function(victim, inflictor, attacker)

        if attacker:GetRole() == ROLE_CENTURION and victim:GetTeam() ~= TEAM_CENTURION and inflictor:GetClass() == "weapon_ttt_incridibilisgun" then

            print("true")

            victim:Revive(rspwn_time, function(p)
                p:SetRole( ROLE_GLADIATOR )
            end)
        end
    end)
end

hook.Add("ScalePlayerDamage", "Printinfl", function(ply, hitgroup, dmginfo)
    print( dmginfo:GetInflictor():GetClass() )
end)