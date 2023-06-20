local function OnLootItem(event, player, item, count)
    -- Check if the looted item is a weapon (ClassID = 2, Subclass determines the type)
    if item:GetClass() == 2 then
      local itemEntry = item:GetEntry()
      local itemSubclass = item:GetSubClass()
      local weaponType = "unknown"
      
      -- Determine the weapon type based on the subclass
      if itemSubclass == 0 then
        weaponType = "One-Handed Axe"
      elseif itemSubclass == 1 then
        weaponType = "Two-Handed Axe"
      elseif itemSubclass == 2 then
        weaponType = "Bow"
      elseif itemSubclass == 3 then
        weaponType = "Gun"
      elseif itemSubclass == 4 then
        weaponType = "One-Handed Mace"
      elseif itemSubclass == 5 then
        weaponType = "Two-Handed Mace"
      elseif itemSubclass == 6 then
        weaponType = "Polearm"
      elseif itemSubclass == 7 then
        weaponType = "One-Handed Sword"
      elseif itemSubclass == 8 then
        weaponType = "Two-Handed Sword"
      elseif itemSubclass == 10 then
        weaponType = "Staff"
      elseif itemSubclass == 13 then
        weaponType = "Fist Weapon"
      elseif itemSubclass == 15 then
        weaponType = "Dagger"
      elseif itemSubclass == 16 then
        weaponType = "Thrown"
      elseif itemSubclass == 17 then
        weaponType = "Spear"
      elseif itemSubclass == 18 then
        weaponType = "Crossbow"
      elseif itemSubclass == 19 then
        weaponType = "Wand"
      elseif itemSubclass == 20 then
        weaponType = "Fishing Pole"
      end
      
      local itemTemplateQuery = WorldDBQuery("SELECT displayid, Quality FROM item_template WHERE entry = " .. itemEntry)
        
      if itemTemplateQuery then
          local displayID = itemTemplateQuery:GetUInt32(0)
          local quality = itemTemplateQuery:GetUInt32(1)
          
          -- Query the db_itemdisplayinfo_12340 table to get the InventoryIcon_1
          local displayInfoQuery = WorldDBQuery("SELECT InventoryIcon_1 FROM db_itemdisplayinfo_12340 WHERE ID = " .. displayID)
          
          if displayInfoQuery then
              local icon = displayInfoQuery:GetString(0)
              local itemName = item:GetName()
              local qualityColor = "|cffffffff" -- Default color for common quality (white)
              
              -- Set the color based on the item quality
              if quality == 0 then
                  qualityColor = "|cff9d9d9d" -- Poor (gray)
              elseif quality == 1 then
                  qualityColor = "|cffffffff" -- Common (white)
              elseif quality == 2 then
                  qualityColor = "|cff1eff00" -- Uncommon (green)
              elseif quality == 3 then
                  qualityColor = "|cff0070dd" -- Rare (blue)
              elseif quality == 4 then
                  qualityColor = "|cffa335ee" -- Epic (purple)
              elseif quality == 5 then
                  qualityColor = "|cffff8000" -- Legendary (orange)
              elseif quality == 6 then
                  qualityColor = "|cffe6cc80" -- Artifact (red)
              end
              
              local message = "You have looted " .. qualityColor .. "|TInterface\\Icons\\".. icon ..":35:35:0:0|t " .. itemName .. " (" .. weaponType .. ")"
              player:SendAreaTriggerMessage(message)
          end
      end
  end
end

RegisterPlayerEvent(32, OnLootItem)
