-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('reorganizer-lib.lua')
    coroutine.schedule(function()
        send_command('lua l reorganizer')
        send_command('gs reorg')
    end, 2)
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    lockstyleset = 3
    send_command('wait 8; input /lockstyleset ' .. lockstyleset)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal','Dispelga', 'PDT', 'CP')
    state.Auto_Kite = M(false, 'Auto_Kite')

    send_command('lua l gearinfo')
    send_command('bind @w gs c WeaponLock') --Call function WeaponLock (do not call toggle)
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
        main="Malignance Pole", --20DT
        ammo="Staunch Tathlum +1", --3DT
        head="Bunzi's Hat", --10, 7DT
        body="Inyanga Jubbah +2", --14
        hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Song spellcasting time -4%',}}, --7, 4PDT
        legs="Ayanmo Cosciales +2", --6, 5DT
        feet=gear.Telchine_ENH_feet, --5
        neck="Cleric's Torque +1", --8
        waist="Embla Sash", --5
        left_ear="Malignance Earring", --4
        right_ear="Enchntr. Earring +1", --2
        left_ring="Weather. Ring", --5
        right_ring="Kishar Ring", --4
        back=gear.WHM_FC_Cape,--10, 10PDT
    } --80 FC, 35DT, 14PDT

    -- sets.precast.FC = {main="Daybreak"}
        
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
        -- head="Umuthi Hat"
    })

    sets.precast.FC.Arise = set_combine(sets.precast.FC,{
        waist="Witful Belt", --3%
        back="Perimede Cape", --4%
        ammo="Impatiens", --2%
        -- ring1="Lebeche Ring", --2%
    }) --10% cap

    sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
        ear2="Mendicant's earring", --5 (-2FC)
        legs = "Ebers pantaloons +1", --12 (-6FC)
        feet="Vanya Clogs", --7 (-5FC)
    }) --32 CC (-13)

    sets.precast.FC.StatusRemoval = set_combine(sets.precast.FC,{range=empty, ammo="Impatiens"})

    sets.precast.FC.Cure = sets.precast.FC['Healing Magic']
    sets.precast.FC.Curaga = sets.precast.FC['Healing Magic']
    sets.precast.FC.CureSolace = sets.precast.FC['Healing Magic']
    -- CureMelee spell map should default back to Healing Magic.
    
    -- Precast sets to enhance JAs
    sets.precast.JA.Benediction = {
        -- body="Piety Briault"
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        -- head="Nahtirah Hat",ear1="Roundel Earring",
        -- body="Vanir Cotehardie",hands="Yaoyotl Gloves",
        -- back="Refraction Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"
    }
    
    
    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    -- gear.default.weaponskill_neck = "Asperity Necklace"
    -- gear.default.weaponskill_waist = ""
    -- sets.precast.WS = {
    --     head="Nahtirah Hat",neck=gear.ElementalGorget,ear1="Bladeborn Earring",ear2="Steelflash Earring",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
    --     back="Refraction Cape",waist=gear.ElementalBelt,legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    -- sets.precast.WS['Flash Nova'] = {
    --     head="Nahtirah Hat",neck="Stoicheion Medal",ear1="Friomisi Earring",ear2="Hecate's Earring",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Strendu Ring",
    --     back="Toro Cape",waist="Thunder Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        head = "Nyame Helm",
        body="Nyame Mail",
        hands = "Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        ring1 = "Epaminondas's Ring",
        ring2="Metamorph Ring +1",
        ear2 = "Regal Earring",
        ear1 = "Moonshade Earring",
        -- ammo="Aurgelmir Orb +1",
        -- ammo="Ginsen", --Sub
        neck="Duelist's Torque +2",
        waist="Sailfi Belt +1",
        back="Aurist's Cape +1",
        -- ring1="Rufescent Ring",
    })

    -- Midcast Sets
    sets.midcast.FastRecast = sets.precast.FC
    
    -- Cure sets

    --TODO: Update this set
    sets.midcast.CureSolace = {
        -- main="Tamaxchi",sub="Genmei Shield",ammo="Incantor Stone",
        -- head="Gendewitha Caubeen",neck="Orison Locket",ear1="Lifestorm Earring",ear2="Orison Earring",
        -- body="Orison Bliaud +2",hands="Theophany Mitts",ring1="Prolix Ring",ring2="Sirona's Ring",
        -- back="Tuilha Cape",waist=gear.ElementalObi,legs="Orison Pantaloons +2",feet="Piety Duckbills +1"
    }

    sets.midcast.CureNormal = { --Cure Pot cap +50%
        --50% CP, 26 DT, 27PDT, -18 Enmity, 93SIRD (+10 merits)
        -- neck="Loricate Torque +1",  --0Pot      , 6DT  ,0Enm,   5SIRD
        -- head="Nyame Helm",          --          , 7DT
        -- ear2="Mendi. Earring",      --5Pot      

        --52% CP, 20 DT, 27PDT, -18 Enmity, 93SIRD (+10 merits)
        head="Bunzi's Hat",         --+0Pot     , 7DT  ,-7Enm
        neck="Cleric's Torque +1",  --+7Pot     , 0DT  ,-20Enm
        ear2="Halasz Earring",      --+0Pot     , 0DT  ,-3Enm,  5SIRD
        main="Daybreak",            --30Pot (count only 10 in this slot due to Chatoyant)
        sub="Genmei Shield",       --+5CP (aug), 10PDT
        sub="Sors Shield",          --3Pot,     , 0DT  ,-5Enm
        ammo="Staunch tathlum +1",  --+0Pot     , 3DT  , 0Enm,  11SIRD
        hands=gear.Chironic_SIRD_hands,--+0Pot  , 0DT  ,-4Enm,  30SIRD
        back=gear.WHM_FC_Cape,      --+10Pot     , 10PDT,-0Enm,
        body="Ebers Bliaut +1",     --Afflatus +14
        legs="Ebers pantaloons +1", --6% cure mp return
        feet="Theo. Duckbills +3",  --+0Pot     , 0DT  ,-0Enm,  29SIRD
        ear1="Magnetic Earring",    --+0Pot     , 0DT, , 0Enm,  8SIRD
        -- waist="Sanctuary Obi +1",   --+0Pot     , 0DT  ,-4Enm,  10SIRD
        waist="Rumination Sash",    --0Pot      , 0DT  ,-0Enm,  10SIRD
        ring1="Gelatinous Ring +1", --+HP       , 7PDT
        ring2="Defending Ring",     --+0Pot     , 10DT
    }

    sets.midcast.Curaga = set_combine(sets.midcast.CureNormal,{
        body="Bunzi's Robe",        --+15Pot,   , 10DT ,-10Enm
    })

    sets.midcast.CureSIRD = { --Incomplete. Not sure how often used this will be to justify the gear room

    }--50% CP, 20 DT, 17PDT, -43 Enmity, 103SIRD (+10 merits)

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        --Removed chatoyant due to big loss of CP and PDT
        -- main="Chatoyant Staff",
        -- sub="Achaq grip",           --+0FC      , 0DT, ,-4Enm
        -- back="Twilight Cape",
        waist="Hachirin-no-Obi",
    })--52% CP, 20 DT, 27PDT, -38 Enmity, 93SIRD (+10 merits)

    --TODO: Update this set
    sets.midcast.CureMelee = {
        -- ammo="Incantor Stone",
        -- head="Gendewitha Caubeen",neck="Orison Locket",ear1="Lifestorm Earring",ear2="Orison Earring",
        -- body="Vanir Cotehardie",hands="Bokwus Gloves",ring1="Prolix Ring",ring2="Sirona's Ring",
        -- back="Tuilha Cape",waist=gear.ElementalObi,legs="Orison Pantaloons +2",feet="Piety Duckbills +1"
    }

    --Maximize cure skill + cursna gear
    sets.midcast.Cursna = set_combine(sets.midcast.CureNormal, {
        ring1="Ephedra Ring", --10
        ring2="Ephedra Ring", --10
        hands="Fanatic Gloves", --15
        back=gear.WHM_FC_Cape, --25
        feet="Vanya Clogs", --5
    }) --65

    sets.midcast.StatusRemoval = {
        -- head="Orison Cap +2",
        main={ name="Grioavolr", augments={'MND+9','Mag. Acc.+30','"Dbl.Atk."+2','Magic Damage +8',}}, --4FC
        sub="Achaq grip",           --+0FC      , 0DT, ,-4Enm
        ammo="Staunch tathlum +1",  --+0FC      , 3DT
        hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Song spellcasting time -4%',}}, --7, 4PDT
        neck="Cleric's Torque +1",  --+7FC      , 0DT  ,-20Enm
        back=gear.WHM_FC_Cape,      --+10FC     , 10PDT
        head="Bunzi's Hat",         --+10FC     , 7DT  ,-7Enm
        body="Bunzi's Robe",        --+0FC      , 10DT ,-10Enm
        legs="Ayanmo Cosciales +2", --+6FC      , 5DT
        feet=gear.Telchine_ENH_feet,    --5FC,     ,      ,-4Enm  
        left_ear="Malignance Earring",  --4FC,  
        right_ear="Enchntr. Earring +1",--2FC
        ear2="Odnowa Earring +1",   --+0FC      , 3DT/2MDT
        waist="Luminary Sash",      --10MND,Conserve MP+4
        ring1="Gelatinous Ring +1", --+HP        , 7PDT
        ring2="Defending Ring",     --+0FC      ,10 DT
        -- ammo="Impatiens",
    } --45 Enm, 38DT, 21PDT, 49FC

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
    sets.midcast['Enhancing Magic'] = {
        main="Gada", --18
        sub="Ammurapi Shield",
        head="Befouled Crown", --16
        neck="Incanter's Torque", --10
        ring1={name="Stikini Ring +1",bag="wardrobe3"}, --8
        ring2={name="Stikini Ring +1",bag="wardrobe4"}, --8
        ear1="Mimir earring", --10
        ear2="Andoaa earring", --5
        -- hands=gear.Chironic_RF_hands, --15
        hands="Dynasty mitts", --18 and dur+5
        legs=gear.Telchine_ENH_legs,
        body=gear.Telchine_RGN_body, --12
        waist="Embla Sash",
        feet=gear.Telchine_ENH_feet, --9
    } --114

    --Focus on DT, and Recast time. Works out to be same as recast set.
    --In Odyssey endgame, no tank so WHM needs to be able to tank when spamming this.
    sets.midcast.Blink = { --Blink used as defensive while in combat. Focus on DT, MEVA, and Duration
        main="Malignance Pole", --20DT
        ammo="Staunch Tathlum +1", --3DT
        head="Bunzi's Hat", --10, 7DT
        body="Inyanga Jubbah +2", --14
        hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -4%','Song spellcasting time -4%',}}, --7, 4PDT
        legs="Ayanmo Cosciales +2", --6, 5DT
        feet=gear.Telchine_ENH_feet, --5, 10dur
        neck="Cleric's Torque +1", --8
        waist="Siegel Sash", --20, 8FC
        left_ear="Malignance Earring", --4
        right_ear="Enchntr. Earring +1", --2
        left_ring="Weather. Ring", --5
        right_ring="Kishar Ring", --4
        back=gear.WHM_FC_Cape,--10, 10PDT
    } --80 FC, 35DT, 14PDT

    --Focus on SS pot, DT, and Recast time.
    --In Odyssey endgame, no tank so WHM needs to be able to tank when spamming this.
    sets.midcast.Stoneskin = {
        main="Malignance Pole", --20DT
        sub="Achaq Grip",
        ammo="Staunch tathlum +1", --3DT
        head="Bunzi's Hat", --7DT, 10FC
        neck="Nodens Gorget", --30, -10PDT
        hands="Stone Mufflers", --30
        legs="Shedir Seraweels", --35
        body="Inyanga Jubbah +2", --14FC
        feet="Nyame Sollerets", --7DT
        waist="Siegel Sash", --20
        ear1="Earthcry Earring", --10
        ear2="Odnowa Earring +1", --3DT, 2MDT
        left_ring="Weather. Ring", --5FC
        right_ring="Defending Ring", --10DT
        back=gear.WHM_FC_Cape, --10 PDT, 10FC
    }--50DT, 10PDT (-10PDT Nodens), 39FC

    sets.midcast.Auspice = set_combine(sets.midcast['Enhancing Magic'],{
        feet="Ebers Duckbills +1",
    })

    sets.midcast.Arise = sets.precast.FC

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{
        -- main="Beneficus",
        sub="Genmei Shield",
    --     head="Orison Cap +2",neck="Colossus's Torque",
    --     body="Orison Bliaud +2",hands="Orison Mitts +2",
    --     back="Mending Cape",
        waist="Olympus Sash",
        -- legs="Piety Pantaloons",
        feet="Ebers Duckbills +1",
    })

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
        main="Bolelabunga",
        legs=gear.Telchine_RGN_legs,
        -- sub="Genmei Shield",
        -- body="Piety Briault",
        -- hands="Orison Mitts +2",
        -- legs="Theophany Pantaloons",
    })

    -- sets.midcast.Protectra = {ring1="Sheltered Ring",feet="Piety Duckbills +1"}

    -- sets.midcast.Shellra = {ring1="Sheltered Ring",legs="Piety Pantaloons"}


    -- sets.midcast['Divine Magic'] = {main="Bolelabunga",sub="Genmei Shield",
    --     head="Nahtirah Hat",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
    --     back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

    -- sets.midcast['Dark Magic'] = {main="Bolelabunga", sub="Genmei Shield",
    --     head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
    --     back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    -- Custom spell classes

    sets.midcast.MndEnfeebles = {
        main="Daybreak",
        sub="Sors Shield",
        ammo="Pemphredo tathlum",
        head="Inyanga tiara +2",
        body="Ayanmo corazza +2",
        hands="Kaykaus Cuffs +1",
        legs=gear.Chironic_MACC_legs,
        feet="Ayanmo gambieras +2",
        neck="Incanter's Torque",
        ring1={name="Stikini Ring +1",bag="wardrobe3"}, 
        ring2={name="Stikini Ring +1",bag="wardrobe4"}, 
        waist="Acuity Belt +1",
        back="Aurist's Cape +1",
        -- ear1="Regal Earring",
        ear1="Malignance Earring",
        ear2="Vor Earring",
    }

    --Max Macc. Duration flat 120 + dur gear
    sets.midcast.Silence = {        
        main="Daybreak",
        ammo="Pemphredo tathlum",
        head="Inyanga tiara +2",
        body="Inyanga Jubbah +2",
        hands="Kaykaus Cuffs +1",
        legs="Inyanga shalwar +2",
        feet="Inyanga crackows +2",
        neck="Sanctity Necklace",
        ring1={name="Stikini Ring +1",bag="wardrobe3"}, 
        ring2={name="Stikini Ring +1",bag="wardrobe4"}, 
        waist="Acuity Belt +1",
        back="Aurist's Cape +1",
        -- ear1="Regal Earring",
        ear1="Malignance Earring",
        ear2="Vor Earring",
    }

    -- sets.midcast.IntEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
    --     head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
    --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Sangoma Ring",
    --     back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    -- sets.resting = {main=gear.Staff.HMP, 
    --     body="Gendewitha Bliaut",hands="Serpentes Cuffs",
    --     waist="Austerity Belt",legs="Nares Trews",feet="Chelona Boots +1"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {--DT 50%, Max Refresh
        main="Daybreak", --1RF
        head="Nyame Helm", --7
        body="Nyame Mail", --9
        hands="Nyame Gauntlets", --7
        legs="Nyame Flanchard", --8
        feet="Nyame Sollerets", --7
        ring1={name="Stikini Ring +1",bag="wardrobe3"}, --1RF
        ring2={name="Stikini Ring +1",bag="wardrobe4"}, --1RF
        ear1="Etiolation Earring", --Resist Silence+15
        ear2="Dominance earring +1", --Resist Stun+11
        neck="Loricate Torque +1", --6
        back=gear.WHM_FC_Cape, --10PDT
        ammo="Homiliary", --1RF
        waist="Embla Sash",
    } --44DT, 10PDT, 5 latent RF

    sets.idle.Dispelga = set_combine(sets.idle, {
        main="Daybreak",
        head="Nyame Helm", --7DT
        ring1="Defending Ring", --10DT
        waist="Flume Belt +1", --3DT
    })

    -- sets.idle.PDT = {main="Bolelabunga", sub="Genmei Shield",ammo="Incantor Stone",
    --     head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Defending Ring",ring2=gear.DarkRing.physical,
    --     back="Umbra Cape",waist="Witful Belt",legs="Gendewitha Spats",feet="Herald's Gaiters"}

    -- sets.idle.Town = {main="Bolelabunga", sub="Genmei Shield",ammo="Incantor Stone",
    --     head="Gendewitha Caubeen",neck="Wiglen Gorget",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Bliaut",hands="Gendewitha Gages",ring1="Sheltered Ring",ring2="Paguroidea Ring",
    --     back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Herald's Gaiters"}
    
    -- sets.idle.Weak = {main="Bolelabunga",sub="Genmei Shield",ammo="Incantor Stone",
    --     head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
    --     body="Gendewitha Bliaut",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Meridian Ring",
    --     back="Umbra Cape",waist="Witful Belt",legs="Nares Trews",feet="Gendewitha Galoshes"}
    
    -- Defense sets

    sets.defense.EmergencyDT = {
        main="Malignance Pole", --30
        sub="", --Include since if it's not disabled it will take off main
        neck="Loricate Torque +1", --6
        ring1="Defending Ring", --10
        back=gear.WHM_FC_Cape, --5
    } --51

    sets.Kiting = {feet="Herald's Gaiters"}

    sets.latent_refresh = {
        waist="Fucho-no-obi"
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {
        -- head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        -- body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
        -- back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"
    }


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {
        -- hands="Orison Mitts +2",back="Mending Cape"
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1={name="Saida Ring", bag="wardrobe4"}, --15
        ring2={name="Saida Ring", bag="wardrobe4"}, --15
        -- ring1="Eshmun's Ring", --20
        -- ring2="Eshmun's Ring", --20
        waist="Gishdubar Sash", --10
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end


function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            else
                return 'CureNormal'
            end
        end
        --TODO: Don't currently have CureSolace set
        -- if default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
        --     return "CureSolace"
        -- else
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.IdleMode.value == 'CP' then
        idleSet = set_combine(idleSet, sets.CP)
    end
    if state.Auto_Kite.value == true then
        idleSet = set_combine(idleSet, sets.Kiting)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
        local needsArts = 
            player.sub_job:lower() == 'sch' and
            not buffactive['Light Arts'] and
            not buffactive['Addendum: White'] and
            not buffactive['Dark Arts'] and
            not buffactive['Addendum: Black']
            
        if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
            if needsArts then
                send_command('@input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
            else
                send_command('@input /ja "Afflatus Solace" <me>')
            end
        end
    end
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function equip_set_and_disable_slots(set)
    if set then
        equip(set)
        for slot,_ in pairs(set) do
            print("Disabling "..slot)
            disable(slot)
        end
    end
    
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    --print("called job handle equipping gear")
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function check_gear()
    if char_check_gear ~= nil then
        char_check_gear()
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(4, 14)
end

function job_self_command(cmdParams, eventArgs)
    silibs.self_command(cmdParams, eventArgs)
    ----------- Non-silibs content goes below this line -----------
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'emergencydt' then
        print("Equipping emergency dt")
        equip_set_and_disable_slots(sets.defense.EmergencyDT)
    end
    if cmdParams[1] == 'WeaponLock' then
        handle_toggle(cmdParams)
        weapon_lock(state.WeaponLock.value)
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        -- print('gearinfo[2]: '..cmdParams[2])
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            -- print(DW_needed)
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

