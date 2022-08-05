res = include('resources')

-------------------------------------------------------------------------------
-- User Configurable Options
-------------------------------------------------------------------------------

options.ammo_warning_limit = 10


-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------

no_swap_necks = S{"Reraise Gorget", "Chocobo Pullus Torque", "Federation Stables Scarf",
        "Kingdom Stables Collar", "Republic Stables Medal", "Chocobo Whistle", "Wing Gorget", "Stoneskin Torque",
        "Airmid's Gorget", "Portafurnace"}
no_swap_earrings = S{"Raising Earring", "Signal Pearl", "Tactics Pearl", "Federation Earring", "Kingdom Earring",
        "Republic Earring", "Reraise Earring", "Mhaura Earring", "Selbina Earring", "Duchy Earring", "Kazham Earring",
        "Rabao Earring", "Empire Earring", "Norg Earring", "Safehold Earring", "Nashmau Earring", "Kocco's Earring",
        "Mamool Ja Earring"}
no_swap_rings = S{"Duck Ring", "Homing Ring", "Invisible Ring", "Reraise Ring", "Return Ring",
        "Sneak Ring", "Warp Ring", "Albatross Ring", "Pelican Ring", "Penguin Ring", "Ecphoria Ring", "Olduum Ring",
        "Tavnazian Ring", "Teleport Ring: Altep", "Teleport Ring: Dem", "Teleport Ring: Holla", "Recall Ring: Jugner",
        "Teleport Ring: Mea", "Recall Ring: Meriphataud", "Recall Ring: Pashhow", "Teleport Ring: Vahzl", "Teleport Ring: Yhoat",
        "Ceizak Ring",  "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)", "Emporox's Ring",
        "Hennetiel Ring", "Kamihr Ring", "Marjami Ring", "Morimar Ring", "Yahse Ring", "Yorcia Ring",
        "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Dem Ring", "Empress Band",
        "Emperor Band", "Anniversary Ring", "Caliber Ring", "Chariot Band", "Ducal Guard's Ring", "Decennial Ring",
        "Duodecennial Ring", "Kupofried's Ring", "Novennial Ring", "Undecennial Ring", "Allied Ring", "Resolution Ring",
        "Endorsement Ring", "Expertise Ring", "Vocation Ring"}

mp_jobs = S{"WHM", "BLM", "RDM", "PLD", "DRK", "SMN", "BLU", "GEO", "RUN", "SCH"}

elemental_ws = S{'Aeolian Edge', 'Sanguine Blade', 'Cloudsplitter', 'Seraph Blade', 'Blade: Teki', 'Blade: To', 'Blade: Chi',
        'Tachi: Jinpu', 'Tachi: Koki', 'Cataclysm', 'Wildfire', 'Trueflight', 'Leaden Salute', 'Primal Rend', 'Cyclone',
        'Burning Blade', 'Red Lotus Blade', 'Shining Blade', 'Frostbite', 'Freezebite', 'Dark Harvest', 'Shadow of Death',
        'Infernal Scythe', 'Thunder Thrust', 'Raiden Thrust', 'Blade: Ei', 'Blade: Yu', 'Tachi: Goten', 'Tachi: Kagero',
        'Shining Strike', 'Seraph Strike', 'Flash Nova', 'Rock Crusher', 'Earth Crusher', 'Starburst', 'Sunburst', 'Vidohunir',
        'Garland of Bliss', 'Omniscience', 'Flaming Arrow', 'Hot Shot'}
    
-- Spells that don't scale with skill. Overrides Mote lib.
classes.NoSkillSpells = S{'Haste', 'Haste II', 'Refresh', 'Refresh II', 'Refresh III', 'Regen', 'Regen II', 'Regen III',
        'Regen IV', 'Regen V', 'Protect', 'Protect II', 'Protect III', 'Protect IV', 'Protect V', 'Protectra', 'Protectra II',
        'Protectra III', 'Protectra IV', 'Protectra V', 'Shell', 'Shell II', 'Shell III', 'Shell IV', 'Shell V', 'Shellra',
        'Shellra II', 'Shellra III', 'Shellra IV', 'Shellra V', 'Raise', 'Raise II', 'Raise III', 'Arise', 'Reraise', 'Reraise II',
        'Reraise III', 'Reraise IV', 'Sneak', 'Invisible', 'Deodorize', 'Embrava', 'Silence', 'Aquaveil', 'Stoneskin', 'Blink'}
    
tp_bonus_weapons = {
    ['main']={
        ['Aeneas'] = 500,
        ['Anguta'] = 500,
        ['Arasy Tabar'] = 100,
        ['Arasy Tabar +1'] = 150,
        ['Centovente'] = 1000,
        ['Chango'] = 500,
        ['Chastisers'] = 300,
        ['Dojikiri Yasutsuna'] = 500,
        ['Fusetto +2'] = 1000,
        ['Fusetto +3'] = 1000,
        ['Godhands'] = 500,
        ['Heishi Shorinken'] = 500,
        ['Khatvanga'] = 500,
        ['Lionheart'] = 500,
        ['Lycurgos'] = 200,
        ['Machaera +2'] = 1000,
        ['Machaera +3'] = 1000,
        ['Sequence'] = 500,
        ['Thibron'] = 1000,
        ['Tishtrya'] = 500,
        ['Tri-edge'] = 500,
        ['Trishula'] = 500,
    },
    ['sub']={
        ['Arasy Tabar'] = 100,
        ['Arasy Tabar +1'] = 150,
        ['Centovente'] = 1000,
        ['Fusetto +2'] = 1000,
        ['Fusetto +3'] = 1000,
        ['Machaera +2'] = 1000,
        ['Machaera +3'] = 1000,
        ['Thibron'] = 1000,
    },
    ['range']={
        ['Accipiter'] = 1000,
        ['Anarchy +2'] = 1000,
        ['Anarchy +3'] = 1000,
        ['Ataktos'] = 1000,
        ['Fail-Not'] = 500,
        ['Fomalhaut'] = 500,
        ['Sparrowhawk +2'] = 1000,
        ['Sparrowhawk +3'] = 1000,
    }
}
      
locked_neck = false -- Do not modify
locked_ear1 = false -- Do not modify
locked_ear2 = false -- Do not modify
locked_ring1 = false -- Do not modify
locked_ring2 = false -- Do not modify

silibs_equippable_bags = L{'inventory','wardrobe','wardrobe2','wardrobe3',
        'wardrobe4','wardrobe5','wardrobe6','wardrobe7','wardrobe8'}

-------------------------------------------------------------------------------
-- Helper functions
-------------------------------------------------------------------------------

-- item_name: string, name of item to search
-- bags_to_search: List (optional), list of bags to search through
-- is_temp_item: boolean (optional), indicates if item is temporary item
function silibs_has_item(item_name, bags_to_search, is_temp_item)
    if item_name and item_name ~= '' then
        local bags
        if is_temp_item then
            bags = L{'temporary'}
        else
            bags = bags_to_search or L{'inventory','safe','storage','locker',
                'satchel','sack','case','wardrobe','safe2','wardrobe2','wardrobe3',
                'wardrobe4','wardrobe5','wardrobe6','wardrobe7','wardrobe8'}
        end
        for bag,_ in bags:it() do
            if player[bag] and player[bag][item_name] then
                return true
            end
        end
    end
    
    return false
end

-- Check for proper ammo when shooting or weaponskilling
function silibs_equip_ammo(spell)
    -- If throwing weapon, return empty as ammo
    if player.equipment.range and player.equipment.range ~= 'empty' then
        local weapon_stats = res.items:with('en', player.equipment.range)
        if weapon_stats.skill == 27 then
            equip({ammo='empty'})
            return
        end
    end
    
    local swapped_ammo = nil
    local default_ammo
    local magic_ammo
    local acc_ammo
    local ws_ammo
    if player.main_job == 'RNG' or player.main_job == 'THF' then
        default_ammo = player.equipment.range and DefaultAmmo[player.equipment.range]
        magic_ammo = player.equipment.range and MagicAmmo[player.equipment.range]
        acc_ammo = player.equipment.range and AccAmmo[player.equipment.range]
        ws_ammo = player.equipment.range and WSAmmo[player.equipment.range]
        qd_ammo = 'empty'
    elseif player.main_job == 'COR' then
        default_ammo = gear.RAbullet
        magic_ammo = gear.MAbullet
        acc_ammo = gear.RAccbullet
        ws_ammo = gear.WSbullet
        qd_ammo = gear.QDbullet
    end
    
    if spell.action_type == 'Ranged Attack' then
        -- If in ranged acc mode, use acc bullet (fall back to default bullet if out of acc ammo)
        if state.RangedMode.value ~= 'Normal' then
            if acc_ammo and silibs_has_item(acc_ammo, silibs_equippable_bags) then
                swapped_ammo = acc_ammo
                equip({ammo=swapped_ammo})
            elseif default_ammo and silibs_has_item(default_ammo, silibs_equippable_bags) then
                -- Fall back to default ammo, if there is any
                swapped_ammo = default_ammo
                equip({ammo=swapped_ammo})
                add_to_chat(3,"Acc ammo unavailable. Falling back to default ammo.")
            else
                -- If neither is available, empty the ammo slot
                swapped_ammo = empty
                equip({ammo=swapped_ammo})
                cancel_spell()
                add_to_chat(123, '** Action Canceled: [ Acc & default ammo unavailable. ] **')
                return
            end
        elseif default_ammo and silibs_has_item(default_ammo, silibs_equippable_bags) then
            swapped_ammo = default_ammo
            equip({ammo=swapped_ammo})
        else
            swapped_ammo = empty
            equip({ammo=swapped_ammo})
            cancel_spell()
            add_to_chat(123, '** Action Canceled: [ Default ammo unavailable. ] **')
            return
        end
    elseif spell.type == 'WeaponSkill' then
        -- Ranged WS
        if spell.skill == 'Marksmanship' or spell.skill == 'Archery' then
            -- ranged magical weaponskills
            if elemental_ws:contains(spell.english) then
                if magic_ammo and silibs_has_item(magic_ammo, silibs_equippable_bags) then
                    swapped_ammo = magic_ammo
                    equip({ammo=swapped_ammo})
                elseif default_ammo and silibs_has_item(default_ammo, silibs_equippable_bags) then
                    swapped_ammo = default_ammo
                    equip({ammo=swapped_ammo})
                    add_to_chat(3,"Magic ammo unavailable. Using default ammo.")
                else
                    swapped_ammo = empty
                    equip({ammo=swapped_ammo})
                    cancel_spell()
                    add_to_chat(123, '** Action Canceled: [ Magic & default ammo unavailable. ] **')
                    return
                end
            else -- ranged physical weaponskills
                if state.RangedMode.value ~= 'Normal' then
                    if acc_ammo and silibs_has_item(acc_ammo, silibs_equippable_bags) then
                        swapped_ammo = acc_ammo
                        equip({ammo=swapped_ammo})
                    elseif ws_ammo and silibs_has_item(ws_ammo, silibs_equippable_bags) then
                        swapped_ammo = ws_ammo
                        equip({ammo=swapped_ammo})
                        add_to_chat(3,"Acc ammo unavailable. Using WS ammo.")
                    elseif default_ammo and silibs_has_item(default_ammo, silibs_equippable_bags) then
                        swapped_ammo = default_ammo
                        equip({ammo=swapped_ammo})
                        add_to_chat(3,"Acc & WS ammo unavailable. Using default ammo.")
                    else
                        swapped_ammo = empty
                        equip({ammo=swapped_ammo})
                        cancel_spell()
                        add_to_chat(123, '** Action Canceled: [ Acc, WS, & default ammo unavailable. ] **')
                        return
                    end
                else
                    if ws_ammo and silibs_has_item(ws_ammo, silibs_equippable_bags) then
                        swapped_ammo = ws_ammo
                        equip({ammo=swapped_ammo})
                    elseif silibs_has_item(default_ammo, silibs_equippable_bags) then
                        swapped_ammo = default_ammo
                        equip({ammo=swapped_ammo})
                        add_to_chat(3,"WS ammo unavailable. Using default ammo.")
                    else
                        swapped_ammo = empty
                        equip({ammo=swapped_ammo})
                        cancel_spell()
                        add_to_chat(123, '** Action Canceled: [ WS & default ammo unavailable. ] **')
                        return
                    end
                end
            end
        else -- Melee WS
            -- melee magical weaponskills
            if elemental_ws:contains(spell.english) then
                -- If ranged weapon is accipiter/sparrowhawk and using non-ranged WS, equip WSD ammo
                local rweapon = player.equipment.range
                if rweapon and rweapon == 'Accipiter' or (rweapon:length() >= 11 and rweapon:startswith('Sparrowhawk'))
                    and silibs_has_item('Hauksbok Arrow', silibs_equippable_bags) then
                    swapped_ammo = 'Hauksbok Arrow'
                    equip({ammo=swapped_ammo})
                elseif magic_ammo and silibs_has_item(magic_ammo, silibs_equippable_bags) then
                    swapped_ammo = magic_ammo
                    equip({ammo=swapped_ammo})
                elseif default_ammo and silibs_has_item(default_ammo, silibs_equippable_bags) then
                    swapped_ammo = default_ammo
                    equip({ammo=swapped_ammo})
                    add_to_chat(3,"Magic ammo unavailable. Using default ammo.")
                else
                    swapped_ammo = empty
                    equip({ammo=swapped_ammo})
                    cancel_spell()
                    add_to_chat(123, '** Action Canceled: [ Magic & default ammo unavailable. ] **')
                    return
                end
            else -- melee physical weaponskills
                -- If ranged weapon is accipiter/sparrowhawk and using non-ranged WS, equip WSD ammo
                local rweapon = player.equipment.range
                if rweapon and rweapon == 'Accipiter' or (rweapon:length() >= 11 and rweapon:startswith('Sparrowhawk'))
                    and silibs_has_item('Hauksbok Arrow', silibs_equippable_bags) then
                    swapped_ammo = 'Hauksbok Arrow'
                    equip({ammo=swapped_ammo})
                end
            end
        end
    elseif spell.type == 'CorsairShot' then
        if qd_ammo and silibs_has_item(qd_ammo, silibs_equippable_bags) then
            swapped_ammo = qd_ammo
            equip({ammo=swapped_ammo})
        elseif silibs_has_item(default_ammo, silibs_equippable_bags) then
            swapped_ammo = default_ammo
            equip({ammo=swapped_ammo})
            add_to_chat(3,"QD ammo unavailable. Using default ammo.")
        else
            swapped_ammo = empty
            equip({ammo=swapped_ammo})
            cancel_spell()
            add_to_chat(123, '** Action Canceled: [ QD & default ammo unavailable. ] **')
            return
        end
    elseif spell.english == "Shadowbind" or spell.english == "Bounty Shot" or spell.english == "Eagle Eye Shot" then
        if silibs_has_item(default_ammo, silibs_equippable_bags) then
            swapped_ammo = default_ammo
            equip({ammo=swapped_ammo})
        else
            swapped_ammo = empty
            equip({ammo=swapped_ammo})
            cancel_spell()
            add_to_chat(123, '** Action Canceled: [ Default ammo unavailable. ] **')
            return
        end
    end

    local swapped_item = silibs_get_item(swapped_ammo)
    if player.equipment.ammo ~= 'empty' and swapped_item ~= nil and swapped_item.count < options.ammo_warning_limit
            and not S{'hauksbok arrow', 'hauksbok bullet', 'animikii bullet'}:contains(swapped_item.shortname) then
        add_to_chat(39,"*** Ammo '"..swapped_item.shortname.."' running low! *** ("..swapped_item.count..")")
    end
end

-- Returns details of item if you have it. Optional get_count boolean will
-- also return count of all instances of the item with that name that you
-- have in all wardrobes and inventory. get_count defaults to true
function silibs_get_item(item_name, --[[optional]]get_count)
    if get_count == nil then
        get_count = true
    end
    local item = nil
    local count = 0
    if item_name and item_name ~= '' then
        local bags = L{'inventory','wardrobe','wardrobe2','wardrobe3','wardrobe4','wardrobe5','wardrobe6','wardrobe7','wardrobe8'}
        for bag,_ in bags:it() do
            if player[bag] and player[bag][item_name] then
                item = player[bag][item_name]
            if not get_count then return end
                count = count + (item.count or 1)
            end
        end
    end
    if item then
        item.count = count
    end
    return item
end
  