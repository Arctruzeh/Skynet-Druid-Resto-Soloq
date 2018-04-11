if not funcs then funcs = true

  ------------------
  --ROTATION START--
  ------------------
  function Rotation()

--Que + prep/after prep movement
    General()

--Comp specific rotation
    if GetMinimapZoneText() == "Nagrand Arena"
    or GetMinimapZoneText() == "Blade's Edge Arena"
    or GetMinimapZoneText() == "Dalaran Arena"
    or GetMinimapZoneText() == "Ruins of Lordaeron" then

      if UnitClass("player") == "Druid" then
        if ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Hunter" or UnitClass("party2") == "Hunter" ) then 
          --DKHunter()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Mage" or UnitClass("party2") == "Mage" ) then 
          --DKMage()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Paladin" or UnitClass("party2") == "Paladin" ) then 
          --DKPaladin()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Priest" or UnitClass("party2") == "Priest" ) then 
          --DKPriest_Shadow()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Rogue" or UnitClass("party2") == "Rogue" ) then 
          --DKRogue()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Shaman" or UnitClass("party2") == "Shaman" )
        and UnitBuffID("player", 51470) then 
          --DKShaman_Elemental()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Shaman" or UnitClass("party2") == "Shaman" )
        and UnitBuffID("player", 30809) then 
          --DKShaman_Enhancement()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Warlock" or UnitClass("party2") == "Warlock" ) then 
          --DKWarlock()
          Any()
        elseif ( UnitClass("party1") == "Death Knight" or UnitClass("party2") == "Death Knight" )
        and ( UnitClass("party1") == "Warrior" or UnitClass("party2") == "Warrior" ) then 
          --DKWarrior()
          Any()
        elseif ( UnitClass("party1") == "Hunter" or UnitClass("party2") == "Hunter" )
        and ( UnitClass("party1") == "Warlock" or UnitClass("party2") == "Warlock" ) then 
          --HunterWarlock()
          Any()
        elseif ( UnitClass("party1") == "Hunter" or UnitClass("party2") == "Hunter" )
        and ( UnitClass("party1") == "Warrior" or UnitClass("party2") == "Warrior" ) then
          --HunterWarrior()
          Any()
        else
          Any()
        end
      end
    end

  end
  ----------------
  --ROTATION END--
  ----------------

  rate_counter = 0    
  ahk_rate = 0.20
  enabled = true

  frame = CreateFrame("Frame", nil, UIParent)
  frame:Show()    
  frame:SetScript("OnUpdate", function(self, elapsed)        
      rate_counter = rate_counter + elapsed
      if enabled and rate_counter > ahk_rate then            
        Rotation()            
        rate_counter = 0        
      end    
    end
  )

  -- Disable the rotation
  function Disable()
    enabled = false print("Disabled") AcceptBattlefieldPort(1)
  end

  -- Enable the rotation     
  function Enable()
    enabled = true print("Enabled")
  end

  function Toggle()
    if enabled then Disable() else Enable() end 
  end

  print("Skynet Druid Resto Soloq")

end

--Disable on initial load
if enabled then Disable() else Enable() end