AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/nh2zombies/friendly.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 220
ENT.MoveType = MOVETYPE_STEP
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"} -- NPCs with the same class will be friendly to each other | Combine: CLASS_COMBINE, Zombie: CLASS_ZOMBIE, Antlions = CLASS_ANTLION
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1} -- Melee Attack Animations
ENT.MeleeAttackDistance = 48 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 64 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.4 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 0.7 -- How much time until it can use a attack again? | Counted in Seconds
ENT.MeleeAttackDamage = math.random(10,18)
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.MeleeAttackExtraTimers = {0.6} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.HasLeapAttack = true -- Should the SNPC have a leap attack?
ENT.AnimTbl_LeapAttack = {"leapstrike"} -- Melee Attack Animations
ENT.LeapDistance = 500 -- The distance of the leap, for example if it is set to 500, when the SNPC is 500 Unit away, it will jump
ENT.LeapToMeleeDistance = 200 -- How close does it have to be until it uses melee?
ENT.TimeUntilLeapAttackDamage = 0.2 -- How much time until it runs the leap damage code?
ENT.NextLeapAttackTime = math.random(3,5) -- How much time until it can use a leap attack?
ENT.NextAnyAttackTime_Leap = 0.9 -- How much time until it can use any attack again? | Counted in Seconds
ENT.LeapAttackExtraTimers = {0.6,0.8} -- Extra leap attack timers | it will run the damage code after the given amount of seconds
ENT.TimeUntilLeapAttackVelocity = 0.2 -- How much time until it runs the velocity code?
ENT.LeapAttackVelocityForward = 300 -- How much forward force should it apply?
ENT.LeapAttackVelocityUp = 220 -- How much upward force should it apply?
ENT.LeapAttackDamage = math.random(10,12)
ENT.LeapAttackDamageDistance = 100 -- How far does the damage go?
ENT.FootStepTimeRun = 0.4 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sound
ENT.CallForHelp = true -- Does the SNPC call for help?
ENT.CallForHelpDistance = 5000 -- -- How far away the SNPC's call for help goes | Counted in World Units
ENT.NextCallForHelpTime = 3.4 -- Time until it calls for help again
ENT.HasCallForHelpAnimation = true -- if true, it will play the call for help animation
ENT.AnimTbl_CallForHelp = {"idle_onfire"} -- Call For Help Animations
ENT.CallForHelpStopAnimationsTime = 2 -- How long should it stop attacks?
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 14 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"nh_demon/nhdemon_foot1.wav","nh_demon/nhdemon_foot2.wav","nh_demon/nhdemon_foot3.wav"}
ENT.SoundTbl_Idle = {"nh_demon/nhdemon_idle1.wav","nh_demon/nhdemon_idle2.wav","nh_demon/nhdemon_idle3.wav"}
ENT.SoundTbl_Alert = {"nh_demon/nhdemon_fz_alert_close1.wav","nh_demon/nhdemon_fz_alert_far1.wav"}
ENT.SoundTbl_MeleeAttack = {"nh_demon/nhdemon_claw_strike1.wav","nh_demon/nhdemon_claw_strike2.wav","nh_demon/nhdemon_claw_strike3.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"nh_demon/nhdemon_claw_miss1.wav","nh_demon/nhdemon_claw_miss2.wav"}
ENT.SoundTbl_Pain = {"nh_demon/nhdemon_breathe_loop1.wav"}
ENT.SoundTbl_Death = {"nh_demon/nhdemon_wake1.wav"}
ENT.SoundTbl_LeapAttackJump = {"nh_demon/nhdemon_leap1.wav"}
ENT.SoundTbl_LeapAttackDamage = {"nh_demon/nhdemon_claw_strike1.wav","nh_demon/nhdemon_claw_strike2.wav","nh_demon/nhdemon_claw_strike3.wav"}

ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_BeforeStartTimer()
self.HasLeapAttack = false
timer.Simple(0.6,function() if IsValid(self) then
self.HasMeleeAttack = false
timer.Simple(0.01,function() if IsValid(self) then
VJ_EmitSound(self,{"nh_demon/nhdemon_fz_frenzy1.wav"},70,math.random(80,100))	
self:VJ_ACT_PLAYACTIVITY("BR2_Roar",true,1.76,ture) end end)
timer.Simple(1.77,function() if IsValid(self) then
self.HasMeleeAttack = true
self.HasLeapAttack = true end end) end end)
 end 

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetCollisionBounds(Vector(13, 13, 50), Vector(-13, -13, 0))

end
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/