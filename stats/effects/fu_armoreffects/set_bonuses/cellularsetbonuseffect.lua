require "/stats/effects/fu_armoreffects/setbonuses_common.lua"

setName="fu_cellularset"

weaponBonus={
	{stat = "powerMultiplier", effectiveMultiplier = 1.20}
}

armorBonus={
	{stat = "fallDamageMultiplier", effectiveMultiplier = 0.88}
}

function init()
	setSEBonusInit(setName)
	effectHandlerList.weaponBonusHandle=effect.addStatModifierGroup({})
			
	checkWeapons()

	effectHandlerList.armorBonusHandle=effect.addStatModifierGroup(armorBonus)
	effectHandlerList.regenHandler=effect.addStatModifierGroup({})
end

function update(dt)
	if not checkSetWorn(self.setBonusCheck) then
		status.removeEphemeralEffect("glowyellow2")
		effect.expire()
	else
		effect.setStatModifierGroup(effectHandlerList.armorBonusHandle,armorBonus)
		checkWeapons()	
		status.addEphemeralEffect("glowyellow2")
		
		--status.modifyResourcePercentage("health", 0.0006 * dt)
		effect.setStatModifierGroup(effectHandlerList.regenHandler,{{stat="healthRegen",amount=status.stat("maxHealth")*0.006}})
		
	end
end

function 
	checkWeapons()
	local weapons=weaponCheck({"bioweapon"})
	if weapons["either"] then
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,weaponBonus)
	else
		effect.setStatModifierGroup(effectHandlerList.weaponBonusHandle,{})
	end
end