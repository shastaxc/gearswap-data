-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('organizer-lib')
end


-- Setup vars that are user-independent.
function job_setup()
	get_combat_form()
    include('Mote-TreasureHunter')
    state.TreasureMode:set('Tag')
    
    state.CapacityMode = M(false, 'Capacity Point Mantle')
	
	-- list of weaponskills that make better use of otomi helm in low acc situations
    wsList = S{'Drakesbane'}

	state.Buff = {}
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    lockstyleset = 81
end


-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Mid', 'Acc')
	state.HybridMode:options('Normal', 'PDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'Mid', 'Acc')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
    
    war_sj = player.sub_job == 'WAR' or false
	
	select_default_macro_book(1, 16)
    send_command('bind != gs c toggle CapacityMode')
	send_command('bind ^= gs c cycle treasuremode')
    send_command('bind ^[ input /lockstyle on')
    send_command('bind ![ input /lockstyle off')
end


-- Called when this job file is unloaded (eg: job change)
function file_unload()
	send_command('unbind ^[')
	send_command('unbind ![')
	send_command('unbind ^=')
	send_command('unbind !=')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {ammo="Angon",hands={ name="Ptero. Fin. G. +1", augments={'Enhances "Angon" effect'},}}
    sets.CapacityMantle = {back="Mecistopins Mantle"}
    --sets.Berserker = {neck="Berserker's Torque"}
    sets.WSDayBonus     = { }

	sets.precast.JA.Jump ={
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands="Vishap Finger Gauntlets +3",
    legs={ name="Ptero. Brais +3", augments={'Enhances "Strafe" effect',}},
    feet="Ostro Greaves",
    neck="Shulmanu Collar",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Petrov Ring",
    right_ring="Flamma Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}},
}

	sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +1" }
	sets.TreasureHunter = {waist="Chaac Belt"}

	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA.Jump, {
		legs="Ptero. Brais +3"
    }) 
	sets.precast.JA['Soul Jump'] ={
    ammo="Knobkierrie",
    head="Flam. Zucchetto +2",
    body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
    hands="Vishap Finger Gauntlets +3",
    legs="Peltast's cuissots +1",
    feet="Ostro Greaves",
    neck="Shulmanu Collar",
    waist="Ioskeha Belt +1",
    left_ear="Telos Earring",
    right_ear="Sherida Earring",
    left_ring="Petrov Ring",
    right_ring="Flamma Ring",
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10',}},
}
	sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA.Jump, {
        feet="Pelt. Schyn. +1",
        })
	sets.precast.JA['Super Jump'] = sets.precast.JA.Jump

	sets.precast.JA['Spirit Link'] = {
        hands="Pel. Vambraces +1", 
        head="Vishap Armet +1"
    }
	sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}}
	sets.precast.JA['Deep Breathing'] = { head="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}}
    sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}}
	
	-- Healing Breath sets
	sets.HB = {
        ammo="Ginsen",
		head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
        neck="Lancer's Torque",
        ear1="Lancer's Earring",
        ear2="Bladeborn Earring",
		body="Acro Surcoat",
        hands="Despair Fin.Gaunt.",
        ring1="Dark Ring",
        ring2="K'ayres Ring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
        legs="Vishap Brais +1",
        feet="Ptero. Greaves +3"
    }

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Yaoyotl Helm",
		back="Bleating Mantle"}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
        ammo="Impatiens",
        head="Cizin Helm +1", 
        ear1="Loquacious Earring", 
        hands="Buremte Gloves",
        legs="Limbo Trousers",
        ring1="Prolix Ring"
    }
    
	-- Midcast Sets
	sets.midcast.FastRecast = {
		head="Otomi Helm",
        hands="Umuthi Gloves",
        feet="Ejekamal Boots",
    }	
		
	sets.midcast.Breath = set_combine(sets.midcast.FastRecast, { head="Vishap Armet +1" })
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined

	sets.precast.WS = {
    ammo="Knobkierrie",               -- __, __, 23, __,  6, __, ___
    head=gear.Nyame_B_head,           -- 26, 26, 60, 40, 10, __, ___
    body=gear.Nyame_B_body,           -- 35, 37, 60, 40, 12, __, ___
    hands=gear.Nyame_B_hands,         -- 17, 40, 60, 40, 10, __, ___
    legs=gear.Nyame_B_legs,           -- 43, 32, 60, 40, 11, __, ___
    feet=gear.Nyame_B_feet,           -- 23, 26, 60, 40, 10, __, ___
    neck="Dgn. Collar +1",            -- 12, __, 20, 20, __,  8, ___
    waist="Sulla Belt",               -- __, __, 30, __, __, __, ___
    left_ear="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    right_ear="Ishvara Earring",      -- __, __, __, __,  2, __, ___
    left_ring="Niqmaddu Ring",        -- 10, __, __, __, __, __, ___
    right_ring="Regal Ring",          -- 10, __, 20, __, __, __, ___
    back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
                                      -- 30, __, 20, 20, 10, __, ___
    -- 206 STR, 161 MND, 413 Attack, 244 Accuracy, 71 WSD, 8 PDL, 250 TP Bonus
}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        back="Updraft Mantle",
        head="Yaoyotl Helm",
        legs="Acro Breeches"
    })
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Raiden Thrust"] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",       --  4
    head=gear.Nyame_B_head,         -- 30
    body=gear.Nyame_B_body,         -- 30, __, 12
    hands=gear.Nyame_B_hands,       -- 30
    legs=gear.Nyame_B_legs,         -- 30, __, 11
    feet=gear.Nyame_B_feet,         -- 30
    neck="Sanctity necklace",       -- 10  --"Baetyl Pendant",          -- 13
    ear1="Friomisi Earring",        -- 10, __, __
    ear2="Novio Earring",           --  7
    ring1="Shiva Ring +1",          --  3, __, __
    ring2="Karieyh ring", --"Epaminondas's Ring",     -- __, __,  5
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
    waist="Skrymir Cord",           --  5
    -- back=gear.DRG_MAB_Cape,      -- 10
    -- waist="Skrymir Cord +1",     --  7, 35, __
  })
    sets.precast.WS["Cataclysm"] = set_combine(sets.precast.WS["Raiden Thrust"], {
    ammo="Knobkierrie",             -- __, __, __,  6
    head="Pixie Hairpin +1",        -- 28, __, __, __
    neck="Fotia Gorget",              -- __, __, __, __; FTP bonus
    ear2="Moonshade Earring",       -- __, __, __, __; TP bonus
    ring2="Archon Ring",            --  5, __, __, __
    waist="Skrymir Cord",           -- __,  5, 30, __
    back={ name="Brigantia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Damage taken-5%',}},
    -- ammo="Ghastly Tathlum +1",   -- __, __, 21, __
    -- waist="Skrymir Cord +1",     -- __,  7, 35, __
  })
	sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {
        head="Valorous mask",hands="Despair Fin. gauntlets",
        ring1="Rajas Ring",legs="Valorous hose",
		 back="Brigantia's Mantle",augments={'Acc+20','Atk+20','Weapon skill damage"+10','DEX+20'},
    })
	sets.precast.WS['Geirskogul'].Mid = set_combine(sets.precast.WS['Geirskogul'], {
        head="Acro Helm",
        back="Brigantia's Mantle",augments={'Acc+20','Atk+20','Weapon skill damage"+10','DEX+20'},
    })
	sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS.Acc, {neck="Shadow Gorget",waist="Soil Belt"})

    sets.precast.WS["Camlann's Torment"] = set_combine(sets.precast.WS, {
        waist="Windbuffet Belt",
        back="Brigantia's Mantle",
    })
	sets.precast.WS["Camlann's Torment"].Mid = set_combine(sets.precast.WS["Camlann's Torment"], {
        head="Yaoyotl Helm", 
        ear1="Bladeborn Earring", 
        ear2="Steelflash Earring", 
        back="Brigantia's Mantle",
    })
	sets.precast.WS["Camlann's Torment"].Acc = set_combine(sets.precast.WS["Camlann's Torment"].Mid, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {
        })
	sets.precast.WS['Drakesbane'].Mid = set_combine(sets.precast.WS['Drakesbane'], {
        back="Brigantia's Mantle",
        head="Yaoyotl Helm",
        })
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'].Mid, {})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
        head="Twilight Helm",
        neck="Twilight Torque",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
		body="Twilight Mail",
        hands="Cizin Mufflers +1",
        ring1="Dark Ring",
        ring2="Paguroidea Ring",
		back="Repulse Mantle",
        legs="Crimson Cuisses",
        feet="Whirlpool Greaves"
    }
	

	-- Idle sets
	sets.idle = {}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle.Town = {}
	
	sets.idle.Field = {}

    sets.idle.Regen = {}

	sets.idle.Weak = {}
	
	-- Defense sets
	sets.defense.PDT = {
    ammo="Staunch tathlum +1",      -- __, __, __, __, __ <__, __, __> [ 3/ 3, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Hjarrandi Breastplate",   -- __, 10, 53, 47, 13 <__, __, __> [12/12,  69] {__/__}
    hands="Nyame Gauntlets",        --  3, __, 60, 40, __ < 4, __, __> [ 7/ 7, 112] {__/__}
    legs="Nyame Flanchard",         --  5, __, 60, 40, __ < 5, __, __> [ 8/ 8, 150] {__/__}
    feet="Nyame Sollerets",         --  3, __, 60, 40, __ < 4, __, __> [ 7/ 7, 150] {__/__}
    neck="Anu Torque",              -- __,  7, 20, __, __ <__, __, __> [__/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    left_ring="Petrov Ring",        -- __,  5, __, __, __ < 1, __, __> [__/__, ___] {__/__}
    right_ring="Defending Ring",    -- __, __, __, __, __ <__, __, __> [10/10, ___] {__/__}
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
                                    -- __, __, 20, 20, __ <10, __, __> [ 5/ 5, ___] {__/__}
    -- 23 Haste, 38 STP, 283 Att, 258 Acc, 13 Crit Rate <39 DA, 5 TA, 0 QA> [52 PDT/52 MDT, 534 Meva] {0 PetPDT/0 PetMDT}
}

	sets.defense.Reraise = set_combine(sets.defense.PDT, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.defense.MDT = set_combine(sets.defense.PDT, {
         back="Engulfer Cape +1"
    })

	sets.Kiting = {legs="Crimson Cuisses"}

	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	sets.engaged ={
    ammo="Aurgelmir Orb",           -- __,  4,  7, __, __ <__, __, __> [__/__, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Hjarrandi Breastplate",   -- __, 10, 53, 47, 13 <__, __, __> [12/12,  69] {__/__}
    hands="Nyame Gauntlets",        --  3, __, 60, 40, __ < 4, __, __> [ 7/ 7, 112] {__/__}
    legs="Pteroslaver Brais +3",    --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    feet="Flamma Gambieras +2",     --  2,  6, __, 42, __ < 6, __, __> [__/__,  86] {__/__}
    neck="Anu Torque",              -- __,  7, 20, __, __ <__, __, __> [__/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    left_ring="Petrov Ring",        -- __,  5, __, __, __ < 1, __, __> [__/__, ___] {__/__}
    right_ring="Niqmaddu Ring",     -- __, __, __, __, __ <__, __,  3> [__/__, ___] {__/__}
    back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
                                    -- __, __, 20, 20, __ <10, __, __> [ 5/ 5, ___] {__/__}
    -- 22 Haste, 58 STP, 234 Att, 259 Acc, 13 Crit Rate <36 DA, 5 TA, 3 QA> [24 PDT/24 MDT, 415 Meva] {11 PetPDT/0 PetMDT}
}
	sets.engaged.Mid = sets.engaged

	sets.engaged.Acc = sets.engaged.Mid

    sets.engaged.PDT = set_combine(sets.engaged, {
       legs="Nyame Flanchard",
       feet="Nyame Sollerets",
       right_ring="Defending Ring",
    })
	sets.engaged.Mid.PDT = sets.engaged.Mid

	sets.engaged.Acc.PDT = sets.engaged.Acc

	sets.engaged.Reraise = set_combine(sets.engaged, {
		head="Twilight Helm",
		body="Twilight Mail"
    })

	sets.engaged.Acc.Reraise = sets.engaged.Reraise

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.english == "Spirit Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command('Jump')
        end
    elseif spell.english == "Soul Jump" then
        if not pet.isvalid then
            cancel_spell()
            send_command("High Jump")
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if player.hpp < 51 then
		classes.CustomClass = "Breath" 
	end
    if spell.type == 'WeaponSkill' then
        if state.CapacityMode.value then
            equip(sets.CapacityMantle)
        end
        end
    end



-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	    equip(sets.midcast.FastRecast)
	    if player.hpp < 51 then
		    classes.CustomClass = "Breath" 
	    end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
end

function job_pet_precast(spell, action, spellMap, eventArgs)
end
-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' or spell.english == 'Steady Wing' or spell.english == 'Smiting Breath' then
		equip(sets.HB)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if state.HybridMode.value == 'Reraise' or
    (state.HybridMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
		equip(sets.Reraise)
	end
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 90 then
        idleSet = set_combine(idleSet, sets.idle.Regen)
    end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
    if state.CapacityMode.value then
        meleeSet = set_combine(meleeSet, sets.CapacityMantle)
    end
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if string.lower(buff) == "sleep" and gain and player.hp > 200 then
        equip(sets.Berserker)
    else
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end

function job_update(cmdParams, eventArgs)
    war_sj = player.sub_job == 'WAR' or false
	classes.CustomMeleeGroups:clear()
	th_update(cmdParams, eventArgs)
	get_combat_form()
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)

end

function get_combat_form()
	--if areas.Adoulin:contains(world.area) and buffactive.ionis then
	--	state.CombatForm:set('Adoulin')
	--end

    if war_sj then
        state.CombatForm:set("War")
    else
        state.CombatForm:reset()
    end
end


-- Job-specific toggles.
function job_toggle(field)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
            equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end
-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if category == 2 or -- any ranged attack
		--category == 4 or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
    	set_macro_page(1, 12)
    elseif player.sub_job == 'NIN' then
    	set_macro_page(1, 12)
	 elseif player.sub_job == 'SAM' then
    	set_macro_page(1, 12)
	 elseif player.sub_job == 'RDM' then
    	set_macro_page(1, 12)	
    else
    	set_macro_page(1, 12)
    end
end
    function set_lockstyle()
    send_command('wait 2; input /lockstyleset ' .. lockstyleset)
    end