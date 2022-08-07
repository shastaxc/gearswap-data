-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
    
    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
    Haste = 0
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal','Acc')
    state.WeaponskillMode:options('Normal','Acc')
    state.HybridMode:options('Normal', 'PDT', 'Counter')
    state.PhysicalDefenseMode:options('PDT', 'MDT')

    select_default_macro_book()	
	
    update_combat_form()
    update_melee_groups()

end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head="Herculean Helm", --7
        body="Samnuha Coat", --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Voltsurge Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Weather. Ring +1", --6(4)
        ring2="Kishar Ring", --4
        }
		
	-- Precast sets to enhance JAs
	sets.precast.JA['Focus'] = {}
	sets.precast.JA['Counterstance'] = {}
	sets.precast.JA['Dodge'] = {}
	sets.precast.JA['Mantra'] = {}	
	sets.precast.JA['Impetus'] = {}	
	sets.precast.JA['Chakra'] = {body="Anch. Cyclas +2", hands="Hes. Gloves +1"}
	sets.precast.JA['Hundred Fists'] = {}	
	sets.precast.JA['Inner Strength'] = {}
	sets.precast.JA['Boost'] = {}	
	sets.precast.JA['Footwork'] = {feet="Shukuyu Sune-Ate"}		
	sets.precast.JA['Chi Blast'] = {body="Volte Jupon", waist="Chaac Belt"}	

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
    ammo="Knobkierrie",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Anchor. Gloves +2",
    legs="Hiza. Hizayoroi +2",
    feet="Nyame Sollerets",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Moonshade Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}} -- default set
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {right_ring="Regal Ring"})
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS, {})
									
									
	sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    body="Mpaca's Doublet",
    hands="Ryuo Tekko +1",
    legs="Hiza. Hizayoroi +2",
    feet="Mpaca's Boots",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Moonshade Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Regal Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}})
	sets.precast.WS['Victory Smite'].Acc = set_combine(sets.precast.WS, {})
	
	
	sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Raging Fists'].Acc = set_combine(sets.precast.WS, {})
	
	
	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Cataclysm'] = {
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body="Nyame Mail",
    hands="Leyline Gloves",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear="Moonshade Earring",
    left_ring="Archon Ring",
    right_ring="Epaminondas's Ring",
    back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}}	

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.idle = {
    ammo="Coiste Bodhar",
    head="Adhemar Bonnet +1", 
    body="Volte Jupon",
    hands="Adhemar Wrist. +1", 
    legs="Mpaca's Hose",
    feet="Herald's Gaiters",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Mache Earring +1",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}}

	sets.idle.Town = {
    ammo="Coiste Bodhar",
    head="Adhemar Bonnet +1",
    body="Councilor's Garb",
    hands="Adhemar Wrist. +1",
    legs="Mpaca's Hose",
    feet="Herald's Gaiters",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Mache Earring +1",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}}

	sets.idle.Weak = {}

    sets.idle.Town = sets.idle

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {feet ="Herald's Gaiters"}

	sets.ExtraRegen = {}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

	sets.engaged = {
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body="Mpaca's Doublet",
    hands="Ryuo Tekko +1",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Schere Earring",
    right_ear="Sherida Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}}
	
	sets.engaged.Impetus = {
    ammo="Coiste Bodhar",
    head="Blistering Sallet +1",
    body="Bhikku Cyclas +1",
    hands="Ryuo Tekko +1",
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Mnk. Nodowa +1",
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Odr Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Epona's Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}}
	
	sets.engaged.Acc = {}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------
	
	sets.engaged.PDT = {
    ammo="Coiste Bodhar",
    head="Mpaca's Cap",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Mpaca's Boots",
    neck={ name="Mnk. Nodowa +1", augments={'Path: A',}},
    waist="Moonbow Belt +1",
    left_ear="Sherida Earring",
    right_ear="Schere Earring",
    left_ring="Niqmaddu Ring",
    right_ring="Defending Ring",
    back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}}
	
	sets.engaged.Acc.PDT = {}
	sets.engaged.Counter = {}
	sets.engaged.Acc.Counter = {}


    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {})


    -- Footwork combat form
    sets.engaged.Footwork = {}
    sets.engaged.Footwork.Acc = {}
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Bhikku Cyclas +1"}
    sets.footwork_kick_feet = {feet="Shukuyu Sune-Ate"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            if (state.OffenseMode.current == 'Normal' and info.impetus_hit_count > 5) or (info.impetus_hit_count > 8) then
                equip(sets.impetus_body)
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp > 2500 then
            equip(sets.precast.MaxTP)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    check_moving()
    update_combat_form()
    update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end

function check_moving()
    if state.DefenseMode.value == 'None' then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
	
  
end

function select_default_macro_book()
    set_macro_page(3, 14)
end
