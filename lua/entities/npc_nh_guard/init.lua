AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/nh2zombies/security01.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 400
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_WIDE_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 85 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.9 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 1.2 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random(18,28)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.6 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
	-- ====== Flinching Code ====== --
ENT.Flinches = 1 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"nhguard/gear1.wav","nhguard/gear2.wav","nhguard/gear3.wav"}
ENT.SoundTbl_Idle = {"nhguard/idle1.wav","nhguard/idle2.wav","nhguard/idle3.wav","nhguard/idle4.wav"}
ENT.SoundTbl_Alert = {"nhguard/alert1.wav","nhguard/alert2.wav","nhguard/alert3.wav","nhguard/alert4.wav","nhguard/alert5.wav","nhguard/alert6.wav","nhguard/alert7.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"nhguard/attack1.wav","nhguard/attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"nhguard/claw_miss1.wav","nhguard/claw_miss2.wav"}
ENT.SoundTbl_Pain = {"nhguard/pain1.wav","nhguard/pain2.wav","nhguard/pain3.wav","nhguard/pain4.wav"}
ENT.SoundTbl_Death = {"nhguard/die1.wav","nhguard/die2.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
--------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo)
if dmginfo:GetDamageForce():Length() > 700 then
	dmginfo:ScaleDamage(0.44)
    end
end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/