
AddCSLuaFile()

SWEP.PrintName				= "Hatchet"
SWEP.Author					= "URAKOLOUY5 (Original: We Create Stuff)"

SWEP.Spawnable				= false

SWEP.Slot				= 0
SWEP.SlotPos				= 0

SWEP.ViewModel				= Model( "models/weapons/v_hatchet.mdl")
SWEP.WorldModel				= Model( "models/weapons/w_hatchet.mdl" )
SWEP.ViewModelFOV			= 54
SWEP.UseHands				= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.DrawAmmo			= false


SWEP.HitDistance		= 40
SWEP.HitInclination		= 0.4
SWEP.HitPushback		= -1000
SWEP.HitRate			= 1.25
SWEP.MinDamage			= 34
SWEP.MaxDamage			= 55

local DrawSound = Sound( "NH2.Hatchet_Draw" )

local SwingSound = Sound( "NH2.Hatchet_Swing1" )
local SwingSound2 = Sound( "NH2.Hatchet_Swing2" )

local HeavySwingSound = Sound( "NH2.Hatchet_HeavySwing1" )
local HeavySwingSound2 = Sound( "NH2.Hatchet_HeavySwing2" )

local SlashSound1 = Sound( "NH2.Hatchet_Slash1" )
local SlashSound2 = Sound( "NH2.Hatchet_Slash2" )

local StabSound1 = Sound( "NH2.Hatchet_Stab1" )
local StabSound2 = Sound( "NH2.Hatchet_Stab2" )

function SWEP:Initialize()

	self:SetHoldType( "melee2" )
end

function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	
	self:EmitSound( SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "swing" ) )

	timer.Create("hitdelay", 0.1, 1, function() self:Hitscan() end)

	timer.Start( "hitdelay" )

end

function SWEP:SecondaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	
	self:EmitSound( HeavySwingSound )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "heavy_swing" ) )

	timer.Create("hitdelay2", 1.3, 1, function() self:Hitscan_Secondary() end)

	timer.Start( "hitdelay2" )


end

function SWEP:OnDrop()

	
end

function SWEP:Hitscan()

	//This function calculate the trajectory
	
		local tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * self.HitDistance * 1.5 ),
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		} )
	
	//This if shot the bullets
	
		if ( tr.Hit ) then
			
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 5
			bullet.Hullsize = 0
			bullet.Distance = self.HitDistance * 1.5
			bullet.Damage = math.random( 29, 30 )
			self.Owner:FireBullets(bullet)
	
			self:EmitSound( SwingSound )

			local vm = self.Owner:GetViewModel()
	
			vm:SendViewModelMatchingSequence( vm:LookupSequence( "swing_hit" ) )
	
			if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
				local randomstab = math.random(1,2)
				
				if (randomstab == 1) then self:EmitSound( StabSound1 ) end
				if (randomstab == 2) then self:EmitSound( StabSound2 ) end		
			else
				self:EmitSound( SlashSound1 )

				local randomslash = math.random(1,2)
				
				if (randomslash == 1) then self:EmitSound( SlashSound1 ) end
				if (randomslash == 2) then self:EmitSound( SlashSound2 ) end	
			end
	
		
	//if end
			//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
			end
	
	end

function SWEP:Hitscan_Secondary()

	//This function calculate the trajectory
	
		local tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * self.HitDistance * 1.5 ),
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		} )
	
	//This if shot the bullets
	
		if ( tr.Hit ) then
			
			bullet = {}
			bullet.Num    = 1
			bullet.Src    = self.Owner:GetShootPos()
			bullet.Dir    = self.Owner:GetAimVector()
			bullet.Spread = Vector(0, 0, 0)
			bullet.Tracer = 0
			bullet.Force  = 5
			bullet.Hullsize = 0
			bullet.Distance = self.HitDistance * 4
			bullet.Damage = math.random( 80, 100 )
			self.Owner:FireBullets(bullet)

			local vm = self.Owner:GetViewModel()
	
			//vm:SendViewModelMatchingSequence( vm:LookupSequence( "heavy_swing_hit" ) )
	
			if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
				local randomstab = math.random(1,2)
				
				if (randomstab == 1) then self:EmitSound( StabSound1 ) end
				if (randomstab == 2) then self:EmitSound( StabSound2 ) end		
			else
				local randomslash = math.random(1,2)
				
				if (randomslash == 1) then self:EmitSound( SlashSound1 ) end
				if (randomslash == 2) then self:EmitSound( SlashSound2 ) end	
			end
	
		
	//if end
			//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
			end
	
	end


function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
	self.Weapon:SetNextSecondaryFire( CurTime() + 0.5 )
	
	return true
end

function SWEP:Holster()

	return true
end

function SWEP:OnRemove()
	
	timer.Remove("hitdelay")
	return true
end