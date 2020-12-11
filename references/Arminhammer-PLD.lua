-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--include('Mote-Include.lua')
--include('Mote-Globals.lua')
--print("Ran pld get_sets()")
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
    "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    lockstyleset = 10
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    -- state.PhysicalDefenseMode:options('PDT', 'HP', 'Reraise', 'Charm')
    -- state.MagicalDefenseMode:options('MDT', 'HP', 'Reraise', 'Charm')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield')

    send_command('lua l gearinfo')
    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
    select_default_macro_book()
    set_lockstyle()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
    send_command('lua u gearinfo')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.Enmity = {
        hands = "Yorium Gauntlets",
        legs = "Brontes Cuisses",
        feet = "Eschite Greaves",
        ring1 = "Apeile Ring +1",
        ring2 = "Apeile Ring",
        ear1 = "Cryptic earring",
        back = "Rudianos's Mantle",
        waist = "Creed Baudrier",
        ammo = "Paeapua"
    }
    sets.precast.JA['Invincible'] = sets.Enmity
    sets.precast.JA['Holy Circle'] = sets.Enmity
    sets.precast.JA['Shield Bash'] = sets.Enmity
    sets.precast.JA['Sentinel'] = sets.Enmity
    sets.precast.JA['Rampart'] = sets.Enmity
    sets.precast.JA['Fealty'] = sets.Enmity
    sets.precast.JA['Divine Emblem'] = sets.Enmity
    sets.precast.JA['Cover'] = sets.Enmity

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = set_combine(sets.Enmity,{
        head="Reverence Coronet +1",
        body="Reverence Surcoat +1",hands="Reverence Gauntlets +1",ring1="Leviathan Ring",ring2="Aquasoul Ring",
        back="Weard Mantle",legs="Reverence Breeches +1",feet="Whirlpool Greaves"})
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Reverence Coronet +1",
        body="Gorney Haubert +1",hands="Reverence Gauntlets +1",ring2="Asklepian Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Reverence Breeches +1",feet="Whirlpool Greaves"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}, --14
        chest="Odyss. Chestplate", --5+6
        feet="Odyssean Greaves", --5+5
        hands="Leyline Gloves", --5
        ear1="Enchntr. Earring +1", --2
        ear2="Loquacious Earring", --2
        ring1="Weather. Ring", --5/(4)
    }

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear2="Mendicant's Earring", --+5 (-5 cast time)
    })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Ginsen",
        head="Otomi Helm",
        neck=gear.ElementalGorget,
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Gorney Haubert +1",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="Cho'j Band",
        back="Atheling Mantle",
        waist=gear.ElementalBelt,
        legs="Cizin Breeches",
        feet="Whirlpool Greaves",
    }

    sets.precast.WS.Acc = {
        ammo="Ginsen",
        head="Yaoyotl Helm",
        neck=gear.ElementalGorget,
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Gorney Haubert +1",
        hands="Buremte Gloves",
        ring1="Rajas Ring",
        ring2="Patricius Ring",
        back="Atheling Mantle",
        waist=gear.ElementalBelt,
        legs="Cizin Breeches",
        feet="Whirlpool Greaves",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ring1="Leviathan Ring",ring2="Aquasoul Ring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Leviathan Ring"})

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {hands="Buremte Gloves",waist="Zoran's Belt"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {waist="Zoran's Belt"})

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ginsen",
        head="Reverence Coronet +1",
        neck="Eddy Necklace",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Reverence Surcoat +1",
        hands="Reverence Gauntlets +1",
        ring1="Shiva Ring",
        ring2="K'ayres Ring",
        back="Toro Cape",
        waist="Caudata Belt",
        legs="Reverence Breeches +1",
        feet="Reverence Leggings +1",
    }
    
    sets.precast.WS['Atonement'] = {
        ammo="Iron Gobbet",
        head="Reverence Coronet +1",
        neck=gear.ElementalGorget,
        ear1="Creed Earring",
        ear2="Steelflash Earring",
        body="Reverence Surcoat +1",
        hands="Reverence Gauntlets +1",
        ring1="Rajas Ring",
        ring2="Vexer Ring",
        back="Fierabras's Mantle",
        waist=gear.ElementalBelt,
        legs="Reverence Breeches +1",
        feet="Caballarius Leggings",
    }
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Reverence Coronet +1",
        body="Reverence Surcoat +1",
        hands="Reverence Gauntlets +1",
        waist="Zoran's Belt",
        legs="Enif Cosciales",
        feet="Reverence Leggings +1"
    }
        
    sets.midcast.Enmity = {
        -- ammo="Iron Gobbet",
        -- head="Reverence Coronet +1",
        -- neck="Invidia Torque",
        -- body="Reverence Surcoat +1",
        -- hands="Reverence Gauntlets +1",
        -- ring1="Vexer Ring",
        -- back="Fierabras's Mantle",
        -- waist="Goading Belt",
        -- legs="Reverence Breeches +1",
        -- feet="Caballarius Leggings"
        hands = "Yorium Gauntlets",
        legs = "Odyssean Cuisses",
        feet = "Eschite Greaves",
        ring1 = "Apeile Ring +1",
        ring2 = "Apeile Ring",
        back = "Rudianos's Mantle",
        waist = "Creed Baudrier",
        ammo = "Paeapua"
    }

    sets.midcast['Phalanx'] = set_combine(sets.midcast.EnhancingDuration, {
        back = gear.PLD_PHL_Cape
    })

    sets.midcast.Flash = set_combine(sets.midcast.Enmity, {legs="Enif Cosciales"})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
        ammo="Iron Gobbet",
        head="Adaman Barbuta",
        neck="Invidia Torque",
        ear1="Hospitaler Earring",
        ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",
        hands="Buremte Gloves",
        ring1="Kunaji Ring",
        ring2="Asklepian Ring",
        back="Fierabras's Mantle",
        waist="Chuq'aba Belt",
        legs="Reverence Breeches +1",
        feet="Caballarius Leggings"
    }

    sets.midcast['Enhancing Magic'] = {neck="Colossus's Torque",waist="Olympus Sash",legs="Reverence Breeches +1"}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Creed Collar",
        ring1="Sheltered Ring",ring2="Paguroidea Ring",
        waist="Austerity Belt"}
    

    -- Idle sets
    sets.idle = {
        main="Naegling",
        sub="Ochain", --6
        ammo="Ginsen",
        head="Souv. Schaller +1", --5
        body="Souv. Cuirass +1", --8
        hands="Souv. Handsch. +1", --4
        legs="Souv. Diechlings +1", --6
        feet="Souveran Schuhs +1", --3
        neck="Loricate torque", --5
        ear1="Loquacious earring",
        ear2="Moonshade earring",
        ring1="Balrahn's Ring",
        ring2="Apeile Ring +1",
        back=gear.PLD_ENM_Cape, --3
        waist="Cetl Belt"
    }

    sets.idle.Town = set_combine(sets.idle,{
        main="Anahera Sword",
        ammo="Incantor Stone",
        head="Reverence Coronet +1",
        neck="Creed Collar",
        ear1="Creed Earring",
        ear2="Bloodgem Earring",
        body="Souv. Cuirass +1",
        hands="Reverence Gauntlets +1",
        ring1="Sheltered Ring",
        ring2="Meridian Ring",
        back="Fierabras's Mantle",
        waist="Flume Belt",
        feet="Reverence Leggings +1",
    })
    
    sets.idle.Weak = set_combine({
        ammo="Iron Gobbet",
        head="Reverence Coronet +1",
        neck="Creed Collar",
        ear1="Creed Earring",
        ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",
        hands="Reverence Gauntlets +1",
        ring1="Sheltered Ring",
        ring2="Meridian Ring",
        back="Fierabras's Mantle",
        waist="Flume Belt",
        legs="Crimson Cuisses",
        feet="Reverence Leggings +1",
    })
    
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)

    sets.latent_refresh = {
        ring1 = "Apeile ring +1",
        ring2 = "Apeile ring",
        waist="Fucho-no-obi",
        ammo="Homiliary",
    }


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Creed Collar",waist="Flume Belt"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Naegling",sub="Ochain"}
    sets.MagicalShield = {main="Naegling",sub="Aegis"}

    -- Basic defense sets.
        
    sets.defense.PDT = {
        -- ammo="Iron Gobbet",
        -- head="Reverence Coronet +1",
        -- neck="Twilight Torque",
        -- ear1="Creed Earring",
        -- ear2="Buckler Earring",
        -- body="Reverence Surcoat +1",
        -- hands="Reverence Gauntlets +1",
        -- ring2=gear.DarkRing.physical,
        -- back="Shadow Mantle",
        -- waist="Flume Belt",
        -- legs="Reverence Breeches +1",
        -- feet="Reverence Leggings +1",
        ammo="Ginsen",
        head="Souv. Schaller +1", --5
        body="Souv. Cuirass +1", --8
        hands="Souv. Handsch. +1", --4
        legs="Souv. Diechlings +1", --6
        feet="Souveran Schuhs +1", --3
        neck="Loricate torque", --5
        ear1="Loquacious earring",
        ear2="Moonshade earring",
        ring1="Apeile Ring",
        ring1="Defending Ring",
        back=gear.PLD_ENM_Cape, --3
        waist="Cetl Belt",
        
    }

    sets.defense.HP = {
        ammo="Iron Gobbet",
        head="Reverence Coronet +1",
        neck="Twilight Torque",
        ear1="Creed Earring",
        ear2="Bloodgem Earring",
        body="Reverence Surcoat +1",
        hands="Reverence Gauntlets +1",
        ring1="Defending Ring",
        ring2="Meridian Ring",
        back="Weard Mantle",
        waist="Creed Baudrier",
        legs="Reverence Breeches +1",
        feet="Reverence Leggings +1",
    }

    sets.defense.Reraise = {
        ammo="Iron Gobbet",
        head="Twilight Helm",
        neck="Twilight Torque",
        ear1="Creed Earring",
        ear2="Bloodgem Earring",
        body="Twilight Mail",
        hands="Reverence Gauntlets +1",
        ring1="Defending Ring",
        ring2=gear.DarkRing.physical,
        back="Weard Mantle",
        waist="Nierenschutz",
        legs="Reverence Breeches +1",
        feet="Reverence Leggings +1",
    }
    
    sets.defense.Charm = {
        ammo="Iron Gobbet",
        head="Reverence Coronet +1",
        neck="Lavalier +1",
        ear1="Creed Earring",
        ear2="Buckler Earring",
        body="Reverence Surcoat +1",
        hands="Reverence Gauntlets +1",
        ring1="Defending Ring",
        ring2=gear.DarkRing.physical,
        back="Shadow Mantle",
        waist="Flume Belt",
        legs="Reverence Breeches +1",
        feet="Reverence Leggings +1",
    }
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.MDT = {
        -- ammo="Demonry Stone",
        -- head="Reverence Coronet +1",
        -- neck="Twilight Torque",
        -- ear1="Creed Earring",
        -- ear2="Bloodgem Earring",
        -- body="Reverence Surcoat +1",
        -- hands="Reverence Gauntlets +1",
        -- ring2="Shadow Ring",
        -- back="Engulfer Cape",
        -- waist="Creed Baudrier",
        -- legs="Osmium Cuisses",
        -- feet="Reverence Leggings +1",
        ammo="Ginsen",
        head="Souv. Schaller +1", --5
        body="Souv. Cuirass +1", --8
        hands="Souv. Handsch. +1", --4
        legs="Souv. Diechlings +1", --6
        feet="Souveran Schuhs +1", --3
        neck="Loricate torque", --5
        ear1="Loquacious earring",
        ear2="Moonshade earring",
        ring1="Apeile Ring",
        ring1="Defending Ring",
        back=gear.PLD_ENM_Cape, --3
        waist="Cetl Belt",
    }


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    --Engaged set should be a balance of DT and Emnity
    sets.engaged = {
        ammo="Ginsen",
        -- head="Otomi Helm",
        -- neck="Asperity Necklace",
        -- ear1="Bladeborn Earring",
        -- ear2="Steelflash Earring",
        -- body="Gorney Haubert +1",
        -- hands="Cizin Mufflers",
        -- ring1="Rajas Ring",
        -- ring2="K'ayres Ring",
        -- back="Atheling Mantle",
        -- waist="Cetl Belt",
        -- legs="Cizin Breeches",
        -- feet="Whirlpool Greaves"
        main="Naegling",
        sub="Ochain", --6
        ammo="Ginsen",
        head="Souv. Schaller +1", --5
        body="Souv. Cuirass +1", --8
        hands="Souv. Handsch. +1", --4
        legs="Souv. Diechlings +1", --6
        feet="Souveran Schuhs +1", --3
        neck="Loricate torque", --5
        ear1="Loquacious earring",
        ear2="Moonshade earring",
        ring1="Rajas Ring",
        ring2="Nguruve Ring",
        back=gear.PLD_ENM_Cape, --3
        waist="Cetl Belt",
    }

    sets.engaged.Enmity = {
        
    }

    sets.engaged.Acc = {
        ammo="Ginsen",
        head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Gorney Haubert +1",
        hands="Buremte Gloves",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
        back="Weard Mantle",
        waist="Zoran's Belt",
        legs="Cizin Breeches",
        feet="Whirlpool Greaves"
    }

    sets.engaged.DW = {ammo="Ginsen",
        head="Otomi Helm",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        body="Gorney Haubert +1",
        hands="Cizin Mufflers",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
        back="Atheling Mantle",
        waist="Cetl Belt",
        legs="Cizin Breeches",
        feet="Whirlpool Greaves"
    }

    sets.engaged.DW.Acc = {ammo="Ginsen",
        head="Yaoyotl Helm",
        neck="Asperity Necklace",
        ear1="Dudgeon Earring",
        ear2="Heartseeker Earring",
        body="Gorney Haubert +1",
        hands="Buremte Gloves",
        ring1="Rajas Ring",
        ring2="K'ayres Ring",
        back="Weard Mantle",
        waist="Zoran's Belt",
        legs="Cizin Breeches",
        feet="Whirlpool Greaves"
    }

    sets.engaged.PDT = set_combine(sets.engaged,{
        body="Reverence Surcoat +1",
        neck="Twilight Torque",
        ring1="Defending Ring"
    })

    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc,
        {body="Reverence Surcoat +1",
        neck="Twilight Torque",
        ring1="Defending Ring"
    })
    
    sets.engaged.Reraise = set_combine(sets.engaged,sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc,sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.DW,{
        body="Reverence Surcoat +1",
        neck="Twilight Torque",
        ring1="Defending Ring"
    })
    
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc,{
        body="Reverence Surcoat +1",
        neck="Twilight Torque",
        ring1="Defending Ring"
    })
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}
    sets.Kiting = {legs="Carmine Cuisses +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    --print("called job handle equipping gear")
    check_gear()
    check_moving()
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
    handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 81 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
        idleSet = set_combine(idleSet, sets.Kiting)
    end
    if state.TreasureMode.value == 'Fulltime' then
        idleSet = set_combine(idleSet, sets.TreasureHunter)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(idleSet, sets.TreasureHunter)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        -- print(state.DefenseMode.current..'Shield')
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and not moving then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    -- Need for smeagol, myhome, and dim addons
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        --print('enabling ring 1')
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        --print('enabling ring 2')
        enable("ring2")
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(5, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(3, 2)
    else
        set_macro_page(2, 20)
    end
end

function set_lockstyle()
    send_command('wait 8; input /lockstyleset ' .. lockstyleset)
end