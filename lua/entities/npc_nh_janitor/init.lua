AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "" -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 200
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 32 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 1 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.8 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random(18,24)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.FootStepTimeRun = 1 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.GibOnDeathDamagesTable = {"All"} -- Damages that it gibs from | "UseDefault" = Uses default damage types | "All" = Gib from any damage
ENT.Broke = false
ENT.Broke2 = true
	-- ====== Flinching Code ====== --
ENT.Flinches = 1 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"nhzombie/foot1.wav","nhzombie/foot2.wav","nhzombie/foot3.wav","nhzombie/foot4.wav"}
ENT.SoundTbl_Idle = {"nhzombie/idle1.wav","nhzombie/idle2.wav","nhzombie/idle3.wav","nhzombie/idle4.wav","nhzombie/idle5.wav","nhzombie/idle6.wav","nhzombie/idle7.wav","nhzombie/idle8.wav","nhzombie/idle9.wav","nhzombie/idle10.wav","nhzombie/idle11.wav","nhzombie/idle12.wav","nhzombie/idle13.wav","nhzombie/idle14.wav"}
ENT.SoundTbl_Alert = {"nhzombie/alert1.wav","nhzombie/alert2.wav","nhzombie/alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"nhzombie/attack01.wav","nhzombie/attack02.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"nhzombie/claw_miss1.wav","nhzombie/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"nhzombie/pain1.wav","nhzombie/pain2.wav","nhzombie/pain3.wav","nhzombie/pain4.wav","nhzombie/pain5.wav","nhzombie/pain6.wav"}
ENT.SoundTbl_Death = {"nhzombie/die1.wav","nhzombie/die2.wav","nhzombie/die3.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo,hitgroup)
if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() >= 660 then
if self.Broke == false then
local random = math.random(1,4)
if random == 1 then
self.Broke = true
self.Broke2 = false
ParticleEffectAttach("blood_impact_red_01", PATTACH_POINT_FOLLOW, self, 4)
ParticleEffectAttach("blood_impact_red_01", PATTACH_POINT_FOLLOW, self, 4)
ParticleEffectAttach("blood_impact_red_01", PATTACH_POINT_FOLLOW, self, 4)
ParticleEffectAttach("blood_advisor_puncture_withdraw", PATTACH_POINT_FOLLOW, self, 4)
		self:SetBodygroup(1,0)
                self:EmitSound(Sound("vj_gib/gibbing2.wav",189))
		self:EmitSound(Sound("vj_gib/gibbing3.wav",189))
        self:EmitSound(Sound("vj_gib/gibbing1.wav",189))
        self:EmitSound(Sound("vj_gib/bones_snapping3.wav",189))
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5,Vel=dmginfo:GetDamageForce() /90})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5,Vel=dmginfo:GetDamageForce() /90})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*-5,Vel=dmginfo:GetDamageForce() /90})

		end
end
end
end
------------------------------------------------------------------------------
function ENT:SetUpGibesOnDeath(dmginfo,hitgroup)
if self.Broke2 == true then
	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() >= 660 then
		self:SetBodygroup(1,0)
		
		if self.HasGibDeathParticles == true then
			for i=1,3 do
				ParticleEffect("blood_impact_red_01",self:GetAttachment(self:LookupAttachment("forward")).Pos,self:GetAngles())
			end
		end

                self:EmitSound(Sound("vj_gib/gibbing2.wav",189))
		self:EmitSound(Sound("vj_gib/gibbing3.wav",189))
                self:EmitSound(Sound("vj_gib/gibbing1.wav",189))
                self:EmitSound(Sound("vj_gib/bones_snapping3.wav",189))		
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_01.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5,Vel=dmginfo:GetDamageForce() /50})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_02.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*5,Vel=dmginfo:GetDamageForce() /50})
		self:CreateGibEntity("obj_vj_gib","models/gibs/humans/sgib_03.mdl",{Pos=self:GetAttachment(self:LookupAttachment("forward")).Pos+self:GetUp()*5+self:GetRight()*-5,Vel=dmginfo:GetDamageForce() /50})
		return true,{AllowCorpse=true}
	end
end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,GetCorpse)
	if hitgroup == HITGROUP_HEAD && dmginfo:GetDamageForce():Length() > 100 && self.HasGibDeathParticles == true then
		local bloodeffect = ents.Create("info_particle_system")
		bloodeffect:SetKeyValue("effect_name","blood_advisor_puncture_withdraw")
		bloodeffect:SetPos(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("forward")).Pos)
		bloodeffect:SetAngles(GetCorpse:GetAttachment(GetCorpse:LookupAttachment("forward")).Ang)
		bloodeffect:SetParent(GetCorpse)
		bloodeffect:Fire("SetParentAttachment","forward")
		bloodeffect:Spawn()
		bloodeffect:Activate()
		bloodeffect:Fire("Start","",0)
		bloodeffect:Fire("Kill","",4.5)
	end
end



---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	local randomstartskin = math.random(1,17)
	if randomstartskin == 1 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) else
	if randomstartskin == 2 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) end
	if randomstartskin == 3 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) self:SetSkin(3) end
	if randomstartskin == 4 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) self:SetSkin(2) end
	if randomstartskin == 5 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) self:SetSkin(1) end
	if randomstartskin == 6 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) end
	if randomstartskin == 7 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) end
	if randomstartskin == 8 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) self:SetSkin(3) end
	if randomstartskin == 9 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) self:SetSkin(2) end
	if randomstartskin == 10 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) self:SetSkin(1) end
	if randomstartskin == 11 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) end
	if randomstartskin == 12 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) end
	if randomstartskin == 13 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) self:SetSkin(2) end
	if randomstartskin == 14 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) self:SetSkin(1) end
	if randomstartskin == 15 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) end
	if randomstartskin == 16 then self:SetModel(Model("models/nh2zombies/janitor02.mdl")) end
	if randomstartskin == 17 then self:SetModel(Model("models/nh2zombies/janitor01.mdl")) self:SetSkin(1) end
	end
	self:SetBodygroup( 1, math.random(2,14) )
	self:SetBodygroup( 2, math.random(0,1) )
	self:SetBodygroup( 3, math.random(0,1) )
	self:SetBodygroup( 4, math.random(0,2) )
end

/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/