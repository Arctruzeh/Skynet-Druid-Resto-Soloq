function Any()

  --who to focus
  if not UnitExists("focus") then
    FocusUnit("party1")
  end

  --PvP Trinket
  for i=1, #TrinketList do
    if UnitDebuffID("player", TrinketList[i]) then
      UseItemByName("Medallion of the Horde")
    end
  end

  --Every Man for Himself, without priest
  if UnitClass("party1") ~= "Priest"
  and UnitClass("party1") ~= "Priest" 
  and getHp(lowest) < 50 then
    for i=1, #HardCCList do
      local name, rank, _, count, dispelType, duration, expires, _, _, _, spellID = UnitDebuffID("player", HardCCList[i])
      if spellID == HardCCList[i]
      and duration > 2 then
        UseItemByName("Medallion of the Horde")
      end
    end
  end

  --Cancel Tree form on banish cast
  for _, unit in ipairs(EnemyList) do
    if ValidUnit(unit, "enemy") then
      local spellName, _, _, _, startCast, endCast, _, _, canInterrupt = UnitCastingInfo(unit) 
      if GetSpellInfo(18647) == spellName then
        if ((endCast/1000) - GetTime()) < .6 then
          CancelShapeshiftForm()
        end
      end
    end
  end

  --Barkskin
  if getHp("player") <= 50 then
    _castSpell(22812)
  end

  --Bauble Arena
  if getHp(lowest) < 40 then
    for i=1, #SilenceList do
      if UnitDebuffID("player", 51514) --hex
      or UnitDebuffID("player", SilenceList[i])
      or cdRemains(48825) ~= 0
      then
        UseItemByName("Bauble of True Blood", lowest)
      end
    end
  end

  --Remove Curse P1
  if UnitExists("party1") == 1 
  and CanHeal("party1") then
    for i=1, #CurseList do
      if UnitDebuffID("party1", CurseList[i]) then
        _castSpell(4987, "party1")
      end
    end
  end

  --Remove Curse P2
  if UnitExists("party2") == 1 
  and CanHeal("party2") then
    for i=1, #CurseList do
      if UnitDebuffID("party2", CurseList[i]) then
        _castSpell(4987, "party2")
      end
    end
  end

  --Shapeshift Morph
  if UnitExists("player") == 1 
  and CanHeal("player") then
    for i=1, #MorphList do
      if UnitDebuffID("player", MorphList[i]) then
        _castSpell(33891)
      end
    end
  end

  --Shapeshift Root
  if UnitDebuffID("player", 64695) --Earthbind Root
  or UnitDebuffID("player", 63685) --enhance nova
  or UnitDebuffID("player", 42917) --frost nova
  or UnitDebuffID("player", 12494) --frost bite
  or UnitDebuffID("player", 33395) --pet nova
  or UnitDebuffID("player", 53313) --nature's grasp
  or UnitDebuffID("player", 53308) --entangling roots
  or UnitDebuffID("player", 64804) --entrapment
  then 
    _castSpell(33891)
  end

  --Clone priest/hpal/druid
  for _, unit in ipairs(EnemyList) do
    if ValidUnit(unit, "enemy") 
    and getHp(unit) > 95 then 
      if UnitClass(unit) == "Priest" 
      or UnitClass(unit) == "Druid" 
      or UnitSpec(unit) == "Holy" then
        if UnitDebuffID("target", 33786) then
          nextclone = GetTime() + 30
        end
        if nextclone ~= nil
        and GetTime() > nextclone then
          nextclone = nil
        end
        if nextclone == nil 
        and not UnitDebuffID("arena1", 33786)
        and not UnitDebuffID("arena2", 33786)
        and not UnitDebuffID("arena3", 33786)
        and getHp(lowest) > 90
        and not UnitDebuffID(unit, 33786) then
          _castSpell(33786, unit)
        end
      end
    end
  end

  --[[Clone arena1 if not party1target or party2target
    if ValidUnit("arena1", "enemy") 
    and getHp("arena1") > 95 then 
      if UnitDebuffID("target", 33786) then
        clonearena1 = GetTime() + 20
      end
      if clonearena1 ~= nil
      and GetTime() > clonearena1 then
        clonearena1 = nil
      end
      if clonearena1 == nil 
      and UnitName("arena1") ~= UnitName("party1target")
      and UnitName("arena1") ~= UnitName("party2target") then
        _castSpell(33786, "arena1")
      end
    end]]


  --Mana Innervate
  local PlayerMana = 100 * UnitPower("player") / UnitPowerMax("player")

  if PlayerMana <= 50  then
    _castSpell(29166, "player")
  end

  --Nature's Grasp
  for _, unit in ipairs(EnemyList) do
    if meleehittingme(unit) then
      _castSpell(53312)
    end
  end

  --War Stomp
  for _, unit in ipairs(EnemyList) do
    if meleehittingme(unit) 
    and cdRemains(53312) > 1
    and not UnitBuffID("player", 53312) then
      _castSpell(20549)
    end
  end

  --Heal Pets
  if getHp(lowestpet) < 85
  and getHp(lowestpet) < getHp(lowest) then 
    --Swiftmend
    if UnitBuffID(lowestpet, 48441) then
      _castSpell(18562, lowestpet)
    end
    --Rejuvenation
    if not UnitBuffID(lowestpet, 48441) then
      _castSpell(48441, lowestpet)
    end
    --Wild Growth
    if not UnitBuffID(lowestpet, 53251) then 
      _castSpell(53251, lowestpet)
    end
    --Life Bloom
    if not UnitBuffID(lowestpet, 48451) then 
      _castSpell(48451, lowestpet)
    end
    --Regrowth
    if not UnitBuffID(lowestpet, 48443) then 
      _castSpell(48443, lowestpet)
    end
  end
--end heal pets

  --Nature's Swiftness
  if getHp(lowest) < 30 then
    _castSpell(17116)
  end

  --Healing Touch
  if UnitBuffID("player", 17116)  
  and getHp(lowest) < 30 then
    _castSpell(48378, lowest)
  end

  --Swiftmend
  if UnitBuffID(lowest, 48441)  
  and getHp(lowest) < 65 then
    _castSpell(18562, lowest)
  end

  --Nourish
  if ( UnitBuffID(lowest, 48443) or UnitBuffID(lowest, 48451) or UnitBuffID(lowest, 53251) or UnitBuffID(lowest, 48441) )
  and getHp(lowest) < 50 then 
    _castSpell(50464, lowest)
  end

  --Rejuvenation 
  if not UnitBuffID(lowest, 48441)  
  and getHp(lowest) < 95 then
    _castSpell(48441, lowest)
  end

  --Abolish Poison
  for _, unit in ipairs(PartyList) do
    if not UnitBuffID(unit, 2893) then 
      for i=1, #PoisonList do
        if UnitDebuffID(unit, PoisonList[i]) then
          _castSpell(2893, unit)
        end
      end
    end
  end

  --Wild Growth
  if not UnitBuffID(lowest, 53251)  
  and getHp(lowest) < 90 then
    _castSpell(53251, lowest)
  end

  --Lifebloom
  if UnitBuffID(lowest, 48451) == nil
  and getHp(lowest) < 85 then
    _castSpell(48451, lowest)
  end

  --Lifebloom
  local _,_,_,stacks = UnitBuffID(lowest, 48451)
  if UnitBuffID(lowest, 48451) ~= nil 
  and stacks < 3
  and getHp(lowest) < 85 then
    _castSpell(48451, lowest)
  end

  --Regrowth
  if not UnitBuffID(lowest, 48443) 
  and getHp(lowest) < 80 then 
    _castSpell(48443, lowest)
  end

  --Nourish
  if ( UnitBuffID(lowest, 48443) or UnitBuffID(lowest, 48451) or UnitBuffID(lowest, 53251) or UnitBuffID(lowest, 48441) )
  and getHp(lowest) < 75 then 
    _castSpell(50464, lowest)
  end

  --Faerie Fire
  for _, unit in ipairs(EnemyList) do
    if ( UnitClass(unit) == "Rogue" or UnitClass(unit) == "Druid" )
    and not UnitDebuffID(unit, 770)
    and not UnitBuffID(unit, 31224) then
      _castSpell(770, unit)
    end
  end

  --[[Moonfire
  if UnitExists("focustarget") == 1
  and UnitDebuffID("focustarget", 51724) == nil --sap
  and UnitDebuffID("focustarget", 33786) == nil --cyclone
  and UnitDebuffID("focustarget", 12826) == nil --poly
  and UnitBuffID("focustarget", 45438) == nil --ice block
  and UnitBuffID("focustarget", 642) == nil --bubble
  and UnitBuffID("focustarget", 19263) == nil --deterrance
  and UnitBuffID("focustarget", 31224) == nil --cloak of shadows
  and UnitBuffID("focustarget", 48707) == nil --AMS
  and not UnitDebuffID("focustarget", 48463)
  then
    _castSpell(48463,"focustarget")
  end]]

  --Tree Form
  if not UnitBuffID("player", 33891)
  and not UnitBuffID("player", 32727)
  and IsMounted() == nil then
    _castSpell(33891)
  end

  --Pre-HoT
  --Rejuvenation
  for _, unit in ipairs(PartyList) do
    if not UnitBuffID(unit, 48441)
    and UnitPower("player") >= 5000 
    and not UnitBuffID("player", 32727)then 
      _castSpell(48441, unit)
    end
  end
  --[[Lifebloom
  for _, unit in ipairs(PartyList) do
    if not UnitBuffID(unit, 48451)
    and UnitPower("player") >= 5000 
    and not UnitBuffID("player", 32727) then 
      _castSpell(48451, unit)
    end
  end]]

  --Buff Wild
  for _, unit in ipairs(PartyList) do
    if not UnitBuffID(unit, 48469)
    and UnitPower("player")>=5000 then 
      _castSpell(48469, unit)
    end
  end

  --Buff Thorns
  for _, unit in ipairs(PartyList) do
    if not UnitBuffID(unit, 53307)
    and UnitPower("player")>=5000 then 
      _castSpell(53307, unit)
    end
  end

  --Mount in prep
  if UnitExists("party2")
  and UnitBuffID("party2", 48469)
  and UnitBuffID("party2", 53307)
  --and UnitBuffID("player", ) 
  and IsMounted() == nil 
  and UnitBuffID("player", 32727) then
    CallCompanion("MOUNT", 1)
    CallCompanion("MOUNT", 2)
  end

  --[[Mount in arena
  if UnitExists("party2")
  and UnitBuffID("party2", 48469)
  and UnitBuffID("party2", 53307)
  --and UnitBuffID("player", ) 
  and IsMounted() == nil 
  --and UnitBuffID("player", 32727) 
  and UnitAffectingCombat("player") ~= 1
  then
    CallCompanion("MOUNT", 1)
    CallCompanion("MOUNT", 2)
  end]]

end