
AddCSLuaFile()

SWEP.PrintName				= "Pistol"
SWEP.Author					= "URAKOLOUY5 (Original: We Create Stuff)"

SWEP.Spawnable				= false

SWEP.Slot				= 1
SWEP.SlotPos				= 0

SWEP.Weight = 5 

SWEP.ViewModel				= Model( "models/weapons/v_colt.mdl")
SWEP.WorldModel				= Model( "models/weapons/w_colt.mdl" )
SWEP.ViewModelFOV			= 54
SWEP.UseHands				= false

SWEP.Primary.Damage = 30 --The amount of damage will the weapon do
SWEP.Primary.TakeAmmo = 1 -- How much ammo will be taken per shot
SWEP.Primary.ClipSize = 18  -- How much bullets are in the mag
SWEP.Primary.Ammo = "Pistol" --The ammo type will it use
SWEP.Primary.DefaultClip = 18 -- How much bullets preloaded when spawned
SWEP.Primary.Spread = 0.1 -- The spread when shot
SWEP.Primary.NumberofShots = 1 -- Number of bullets when shot
SWEP.Primary.Automatic = false -- Is it automatic
SWEP.Primary.Recoil = .2 -- The amount of recoil
SWEP.Primary.Delay = 0.1 -- Delay before the next shot
SWEP.Primary.Force = 10

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.DrawAmmo			= true

local DrawSound = Sound( "NH2.Hatchet_Draw" )

local SingleSound1 = Sound( "NH2.Pistol_Single1" )
local SingleSound2 = Sound( "NH2.Pistol_Single2" )
local SingleSound3 = Sound( "NH2.Pistol_Single3" )

local HeavySwingSound = Sound( "NH2.Hatchet_HeavySwing1" )
local HeavySwingSound2 = Sound( "NH2.Hatchet_HeavySwing2" )

local SlashSound1 = Sound( "NH2.Hatchet_Slash1" )
local SlashSound2 = Sound( "NH2.Hatchet_Slash2" )

local StabSound1 = Sound( "NH2.Hatchet_Stab1" )
local StabSound2 = Sound( "NH2.Hatchet_Stab2" )

function SWEP:Initialize()

	self:SetHoldType( "pistol" )
end

function SWEP:PrimaryAttack()
 
	if ( !self:CanPrimaryAttack() ) then return end
	 
	local bullet = {} 
	bullet.Num = self.Primary.NumberofShots 
	bullet.Src = self.Owner:GetShootPos() 
	bullet.Dir = self.Owner:GetAimVector() 
	bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
	bullet.Tracer = 1
	bullet.Force = self.Primary.Force 
	bullet.Damage = self.Primary.Damage 
	bullet.AmmoType = self.Primary.Ammo 

	local vm = self.Owner:GetViewModel()
	 
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "shoot" ) )

	local rnda = self.Primary.Recoil * -1 
	local rndb = self.Primary.Recoil * math.random(-1, 1) 
	 
	self:ShootEffects()
	 
	self.Owner:FireBullets( bullet ) 
	


	local randomsinglesound = math.random(1, 3)

	if (randomsinglesound == 1) then 
	self:EmitSound(SingleSound1)
	end

	if (randomsinglesound == 2) then 
		self:EmitSound(SingleSound2)
	end	

	if (randomsinglesound == 3) then 
		self:EmitSound(SingleSound3)
	end		
		
	self.Owner:ViewPunch( Angle( math.random(-0.2,0.2),rndb,rnda ) ) 
	self:TakePrimaryAmmo(self.Primary.TakeAmmo) 
	 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay ) 
	end 

function SWEP:SecondaryAttack()

end

function SWEP:Reload()
	
if (self:Ammo1() ~= 0) then

	local vm = self.Owner:GetViewModel()

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "reload" ) )
	
	self.Weapon:DefaultReload( ACT_VM_RELOAD );
else
	return 0
end
end