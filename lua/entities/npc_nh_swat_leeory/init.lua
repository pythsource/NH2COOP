AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/SWAT/group01/male_04.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want 
ENT.StartHealth = 300
ENT.HullType = HULL_HUMAN
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_SWAT"} -- NPCs with the same class with be allied to each other
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.PlayerFriendly = true -- Makes the SNPC friendly to the player and HL2 Resistance
ENT.FriendsWithAllPlayerAllies = true -- Should this SNPC be friends with all other player allies that are running on VJ Base?
ENT.BecomeEnemyToPlayer = true -- Should the friendly SNPC become enemy towards the player if it's damaged by a player?
ENT.BecomeEnemyToPlayerLevel = 6 -- How many times does the player have to hit the SNPC for it to become enemy?
ENT.HasFootStepSound = true -- Should the SNPC make a footstep sound when it's moving?
ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.SquadName = "SWAT" -- Squad name, console error will happen if two groups that are enemy and try to squad!
ENT.FollowPlayer = true -- Should the SNPC follow the player when the player presses a certain key?
ENT.DisableCallForBackUpOnDamageAnimation = true -- Disables the animation when the CallForBackUpOnDamage function is called
ENT.HasOnPlayerSight = true -- Should do something when it sees the enemy? Example: Play a sound
ENT.OnPlayerSightDispositionLevel = 1 -- 0 = Run it every time | 1 = Run it only when friendly to player | 2 = Run it only when enemy to player
ENT.DamageByPlayerDispositionLevel = 1 -- 0 = Run it every time | 1 = Run it only when friendly to player | 2 = Run it only when enemy to player
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"meleeattack01"} -- Melee Attack Animations
ENT.MeleeAttackDamage = math.random(18,24)
ENT.MeleeAttackDistance = 30 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 120 -- How far the damage goes
ENT.TimeUntilMeleeAttackDamage = 0.5 -- This counted in seconds | This calculates the time until it hits something
ENT.NextAnyAttackTime_Melee = 1.1
ENT.HasGrenadeAttack = true -- Should the SNPC have a grenade attack?
ENT.NextThrowGrenadeTime1 = 10 -- Time until it runs the throw grenade code again | The first # in math.random
ENT.NextThrowGrenadeTime2 = 15 -- Time until it runs the throw grenade code again | The second # in math.random
ENT.ThrowGrenadeChance = 3 -- Chance that it will throw the grenade | Set to 1 to throw all the time
ENT.GrenadeAttackAttachment = "anim_attachment_LH" -- The attachment that the grenade will spawn at
ENT.DisableGrenadeAttackAnimation = false -- if true, it will disable the animation code when doing grenade attack
ENT.AnimTbl_GrenadeAttack = {"Throw1"} -- Grenade Attack Animations
ENT.GrenadeAttackEntity = "obj_vj_grenade" -- The entity that the SNPC throws
ENT.TimeUntilGrenadeIsReleased = 0.8 -- Time until the grenade is released
	-- ====== Flinching Code ====== --
ENT.Flinches = 0 -- 0 = No Flinch | 1 = Flinches at any damage | 2 = Flinches only from certain damages
ENT.FlinchingChance = 12 -- chance of it flinching from 1 to x | 1 will make it always flinch
ENT.FlinchingSchedules = {SCHED_FLINCH_PHYSICS} -- If self.FlinchUseACT is false the it uses this | Common: SCHED_BIG_FLINCH, SCHED_SMALL_FLINCH, SCHED_FLINCH_PHYSICS
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/metropolice/gear1.wav","npc/metropolice/gear2.wav","npc/metropolice/gear3.wav","npc/metropolice/gear4.wav","npc/metropolice/gear5.wav","npc/metropolice/gear6.wav"}
ENT.SoundTbl_Idle = {"nh2_swat/idle/2_hangontothatflare.wav","nh2_swat/idle/2_heretheycome.wav","nh2_swat/idle/2_itssmells.wav","nh2_swat/idle/2_ithinkimgonnabesick.wav","nh2_swat/idle/2_itsallquiet.wav","nh2_swat/idle/2_itsdarkhere.wav"}
ENT.SoundTbl_Alert = {"nh2_swat/combat/2_ambush_combat.wav","nh2_swat/combat/2_fastones.wav","nh2_swat/combat/2_onedown.wav"}
ENT.SoundTbl_Suppressing = {"nh2_swat/combat/2_igotone.wav","nh2_swat/combat/2_gettothechoppadoitnaugh_combat.wav","nh2_swat/combat/2_whatthehellisthatthing_combat.wav","nh2_swat/combat/2_whatthehellisthatthing_combat.wav"}
ENT.SoundTbl_Grenade = {"nh2_swat/combat/2_getdown_combat.wav"}
ENT.SoundTbl_Pain = {"nh2_swat/pain/pain01.wav","nh2_swat/pain/pain02.wav","nh2_swat/pain/pain03.wav","nh2_swat/pain/pain04.wav","nh2_swat/pain/pain05.wav","nh2_swat/pain/pain06.wav","nh2_swat/pain/pain07.wav","nh2_swat/pain/pain08.wav","nh2_swat/pain/pain09.wav","nh2_swat/idle/2_argh.wav","nh2_swat/idle/2_argh2.wav"}
ENT.SoundTbl_Death = {"nh2_swat/pain/pain01.wav","nh2_swat/pain/pain02.wav","nh2_swat/pain/pain03.wav","nh2_swat/pain/pain04.wav","nh2_swat/pain/pain05.wav","nh2_swat/pain/pain06.wav","nh2_swat/pain/pain07.wav","nh2_swat/pain/pain08.wav","nh2_swat/pain/pain09.wav"}
ENT.SoundTbl_FollowPlayer = {"nh2_swat/idle/2_alrightletthemhaveit.wav","nh2_swat/idle/2_leadtheway.wav"}
ENT.SoundTbl_DamageByPlayer = {"nh2_swat/idle/2_stopshootingme.wav","nh2_swat/idle/2_watchit.wav"}
ENT.SoundTbl_OnPlayerSight = {"nh2_swat/3_getweapons1.wav","nh2_swat/3_getweapons2.wav","nh2_swat/3_getweapons3.wav","nh2_swat/3_getweapons4.wav","nh2_swat/3_getweapons5.wav","nh2_swat/3_holdupwedontwant.wav","nh2_swat/3_heywaitupforeverybody.wav"}

ENT.FootStepSoundLevel = 70
ENT.BreathSoundLevel = 60
ENT.IdleSoundLevel = 75
ENT.CombatIdleSoundLevel = 80
ENT.OnReceiveOrderSoundLevel = 80
ENT.FollowPlayerSoundLevel = 75
ENT.UnFollowPlayerSoundLevel = 75
ENT.BeforeHealSoundLevel = 75
ENT.AfterHealSoundLevel = 75
ENT.OnPlayerSightSoundLevel = 75
ENT.AlertSoundLevel = 80
ENT.CallForHelpSoundLevel = 80
ENT.BecomeEnemyToPlayerSoundLevel = 75
ENT.BeforeMeleeAttackSoundLevel = 75
ENT.MeleeAttackSoundLevel = 75
ENT.ExtraMeleeAttackSoundLevel = 75
ENT.MeleeAttackMissSoundLevel = 75
ENT.SuppressingSoundLevel = 80
ENT.WeaponReloadSoundLevel = 80
ENT.GrenadeAttackSoundLevel = 80
ENT.OnGrenadeSightSoundLevel = 80
ENT.PainSoundLevel = 80
ENT.ImpactSoundLevel = 60
ENT.DamageByPlayerSoundLevel = 75
ENT.DeathSoundLevel = 80
/*-----------------------------------------------
	*** Copyright (c) 2012-2016 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/