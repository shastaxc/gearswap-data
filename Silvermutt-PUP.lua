-- File Status: Not terrible. Gearsets are ALL wrong.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: N/A
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable RollTracker

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
  coroutine.schedule(function()
    send_command('gs c weaponset current')
    send_command('gs c petmode current')
  end, 5)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(15)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()

  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('Master', 'Pet', 'Halfsies')
  state.IdleMode:options('Normal')
  state.AttCapped = M(true, 'Attack Capped')
  state.CP = M(false, 'Capacity Points Mode')
  state.AutomaticPetTargeting = M(true, 'Automatic Pet Targeting')

  state.PetMode = M{['description']='Pet Mode', 'Tank', 'Ranged', 'RangedAcc', 'Heal', 'MeleeSpam', 'MeleeSC', 'Overdrive',}

  -- List of pet weaponskills to check for
  petWeaponskills = S{'Slapstick', 'Knockout', 'Magic Mortar', 'Chimera Ripper', 'String Clipper', 'Cannibal Blade',
      'Bone Crusher', 'String Shredder', 'Arcuballista', 'Daze', 'Armor Piercer', 'Armor Shatterer'}

  -- Default maneuvers for each pet mode. Table keys must match PetMode values. Must have 1 for each mode.
	defaultManeuvers = {
		Tank =      { Light=1, Dark=0, Fire=2, Ice=0, Wind=0, Earth=0, Lightning=0, Water=0 },
		Ranged =    { Light=0, Dark=0, Fire=0, Ice=0, Wind=3, Earth=0, Lightning=0, Water=0 },
		RangedAcc = { Light=0, Dark=0, Fire=0, Ice=0, Wind=3, Earth=0, Lightning=0, Water=0 },
		Heal =      { Light=2, Dark=1, Fire=0, Ice=0, Wind=0, Earth=0, Lightning=0, Water=0 },
		MeleeSpam = { Light=0, Dark=0, Fire=2, Ice=0, Wind=1, Earth=0, Lightning=0, Water=0 },
		MeleeSC =   { Light=0, Dark=0, Fire=2, Ice=0, Wind=1, Earth=0, Lightning=0, Water=0 },
		Overdrive = { Light=1, Dark=0, Fire=1, Ice=0, Wind=0, Earth=0, Lightning=1, Water=0 },
	}

  ---- DO NOT MODIFY BELOW ------
  Flashbulb_Timer = 45
  Strobe_Timer = 30
  Strobe_Recast = 0
  Flashbulb_Recast = 0
  Flashbulb_Time = 0
  Strobe_Time = 0
  all_maneuvers = S{'Fire Maneuver','Ice Maneuver','Wind Maneuver','Earth Maneuver','Lightning Maneuver','Water Maneuver',
      'Light Maneuver','Dark Maneuver'}
  active_maneuvers = L{}
  ---- DO NOT MODIFY ABOVE ------


  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  state.WeaponSet = M{['description']='Weapon Set', 'Verethragna', 'Kenkonken'}

  select_default_macro_book()
  set_sub_keybinds()
end

function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  -- This set is specifically for Strobe & Flashbulb
  sets.Enmity = {
    range="Neo Animator",
    ammo="Automat. Oil +3",
    head="Heyoka Cap",
    body="Heyoka Harness",
    hands="Heyoka Mittens",
    legs="Heyoka Subligar",
    feet="Heyoka Leggings",
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    ear1="Domes. Earring",
    ear2="Rimeice Earring",
    ring1="Varar Ring",
    ring2="Thurandaut Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Your Auto starts off with Burden, to help reduce the burden equip Overload - gear. Don't forget ambu cape for Lvl+1
  sets.precast.JA['Activate'] = {
    body="Kara. Farsetto +1",
    hands="Foire Dastanas +2",
    neck="Buffoon's Collar",
    feet="Mpaca's Boots",
    ear2="Burana Earring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Haste+10','Pet: Damage taken -5%',}},
  }

  sets.precast.JA['Deus Ex Automata'] = set_combine(sets.precast.JA['Activate'], {})

  -- Equip Repair + equipment and Pet HP+ to help increase
  sets.precast.JA['Maintenance'] = {
    -- legs=gear.DesultorTassets,
    feet="Foire Babouches +2",
    ear1="Pratik Earring",
    ear2="Guignol Earring",
  }

	sets.precast.JA['Repair'] = set_combine(sets.precast.JA['Maintenance'], {})

  sets.precast.JA['Overdrive'] = {
    body="Pitre Tobe +3",
  }
  sets.precast.JA['Role Reversal'] = {
    feet="Pitre Babouches +3",
  }
  sets.precast.JA['Tactical Switch'] = {
    feet="Karagoz Scarpe +1",
  }
  sets.precast.JA['Ventriloquy'] = {
    legs="Pitre Churidars +3",
  }

  -- Put on Overload - Equipment
  sets.precast.JA.Maneuver = {
    body="Kara. Farsetto +1",
    hands="Foire Dastanas +2",
    neck="Buffoon's Collar",
    ear2="Burana Earring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }

  sets.precast.Waltz = {
    body="Passion Jacket",
  }

  sets.precast.FC = {
    head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +1%','STR+10','Mag. Acc.+11',}},
    body="Zendik Robe",
    legs=gear.Rawhide_D_legs,
    feet="Regal Pumps +1",
    neck="Voltsurge Torque",
    ear1="Loquac. Earring",
    ear2="Etiolation Earring",
    ring1="Prolix Ring",
    ring2="Weather. Ring",
    back={ name="Visucius's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}},
  }
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    neck="Magoraga Beads"
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Master WS Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Tatenashi Haramaki +1",
    hands=gear.Herc_TA_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  } -- Base WS set
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
  })

  -- Victory Smite: 80% STR, 1.5 fTP, 4 hit, can crit, ftp replicating
  -- crit dmg > TP Bonus = crit rate > multihit
  -- 1000 TP bonus = ~15% crit rate
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_DEX_CritDmg_feet,
    neck="Monk's Nodowa +2", -- PDL
    ear1="Sherida Earring",
    ear2="Odr Earring",
    ring1="Sroda Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_Crit_Cape,
    waist="Moonbow Belt +1",
    -- feet=gear.Herc_STR_CritDmg_feet,
  })
  sets.precast.WS["Victory Smite"].MaxTP = set_combine(sets.precast.WS["Victory Smite"], {
  })
  
  -- 32% STR / 32% VIT - Chance of Critical varies w/ TP (This is the Mythic Weaponskill)
  sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS['Victory Smite'], {})
  sets.precast.WS['Stringing Pummel'].MaxTP = set_combine(sets.precast.WS['Victory Smite'].MaxTP, {})
 

  -- Shijin Spiral: 100% DEX, 1.5 fTP, 5 hit, ftp replicating
  -- DEX > multihit > WSD
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    ammo="Aurgelmir Orb",
    head="Kendatsuba Jinpachi +1",
    body="Malignance Tabard",
    hands="Malignance Gloves",
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Schere Earring",
    ring1="Ilabrat Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_DEX_DA_Cape,
    waist="Moonbow Belt +1",
    -- ammo="Aurgelmir Orb +1",
  })
  sets.precast.WS["Shijin Spiral"].MaxTP = set_combine(sets.precast.WS["Shijin Spiral"], {
  })
  
  -- Asuran Fists: 15% STR / 15% VIT, 1.25 fTP, 8 hit, ftp replicating
  -- WSD > STR/VIT
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Ishvara Earring",
    ring1="Epaminondas's Ring",
    ring2="Sroda Ring",
    back=gear.MNK_STR_DA_Cape, -- WSD cape would be better
    waist="Fotia Belt",
    -- body="Bhikku Cyclas +3",
  })
  sets.precast.WS["Asuran Fists"].MaxTP = set_combine(sets.precast.WS["Asuran Fists"], {
  })

  -- Ascetic's Fury: 50% STR / 50% VIT, 1.0 fTP (2.0 w/ offhand), 1 hit (2 w/ offhand), can crit, ftp replicating
  -- Cannot crit normally - only TP bonus can increase crit rate
  -- TP Bonus > crit dmg > multihit > WSD
  sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Kendatsuba Samue +1",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_DEX_CritDmg_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Sroda Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_Crit_Cape,
    waist="Moonbow Belt +1",
    -- feet=gear.Herc_STR_CritDmg_feet,
  })
  sets.precast.WS["Ascetic's Fury"].MaxTP = set_combine(sets.precast.WS["Ascetic's Fury"], {
    head=gear.Adhemar_B_head,
    ear2="Schere Earring",
  })

  -- Raging Fists: 30% STR / 30% DEX, 1.0-3.75 fTP, 5 hit, ftp replicating
  -- TP Bonus > WSD > Multihit (assuming always used with high TP)
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Gere Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Fotia Belt",
  })
  sets.precast.WS["Raging Fists"].MaxTP = set_combine(sets.precast.WS["Raging Fists"], {
    ear2="Ishvara Earring",
    waist="Moonbow Belt +1",
    -- head="Hesychast's Crown +3",
  })

  -- Howling Fist: 50% VIT / 20% STR, 2.05-5.8 fTP, 2 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head="Mpaca's Cap",
    body="Tatenashi Haramaki +1",
    hands=gear.Herc_TA_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Monk's Nodowa +2",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Sroda Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Howling Fist"].MaxTP = set_combine(sets.precast.WS["Howling Fist"], {
    head=gear.Adhemar_B_head,
    ear2="Schere Earring",
  })

  -- Dragon Kick: 50% STR / 50% DEX, ?-5 fTP, 1 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Dragon Kick'].MaxTP = set_combine(sets.precast.WS["Howling Fist"].MaxTP, {
    feet="Anchorite's Gaiters +3",
  })

  -- Tornado Kick: 40% STR / 40% VIT, 1.68-4.575 fTP, 3 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS["Howling Fist"], {
    feet="Anchorite's Gaiters +3",
  })
  sets.precast.WS['Tornado Kick'].MaxTP = set_combine(sets.precast.WS["Howling Fist"].MaxTP, {
    feet="Anchorite's Gaiters +3",
  })

  -- Spinning Attack: 100% STR, 1.0 fTP, 1 hit (aoe-physical), ftp replicating
  -- Multihit > WSD
  sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
    ammo="Knobkierrie",
    head=gear.Adhemar_B_head,
    body="Tatenashi Haramaki +1",
    hands=gear.Adhemar_B_hands,
    legs="Mpaca's Hose",
    feet=gear.Herc_TA_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Schere Earring",
    ring1="Sroda Ring",
    ring2="Niqmaddu Ring",
    back=gear.MNK_STR_DA_Cape,
    waist="Moonbow Belt +1",
  })
  sets.precast.WS["Spinning Attack"].MaxTP = set_combine(sets.precast.WS["Spinning Attack"], {
  })

  sets.MAB = {
    ammo="Pemphredo Tathlum",       --  4
    head=gear.Nyame_B_head,         -- 30
    body=gear.Nyame_B_body,         -- 30
    hands=gear.Nyame_B_hands,       -- 30
    legs=gear.Nyame_B_legs,         -- 30
    feet=gear.Herc_MAB_feet,        -- 57
    neck="Sibyl Scarf",             -- 10
    ear1="Friomisi Earring",        -- 10
    ear2="Novio Earring",           --  7
    ring1="Shiva Ring +1",          --  3
    back="Argochampsa Mantle",      -- 12
    waist="Skrymir Cord",           --  5
    -- back=gear.PUP_MAB_Cape,      -- 10
    -- waist="Skrymir Cord +1",     --  7
  }

  -- Cataclysm: 30% STR/30% INT, 2.75-5.0 fTP, 1 hit (aoe-magical)
  -- Stack MAB > WSD
  sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS, sets.MAB, {
    ammo="Knobkierrie",             -- __, __, __,  6
    head="Pixie Hairpin +1",        -- 28, __, __, __
    neck="Fotia Gorget",            -- __, __, __, __; FTP bonus
    ear2="Moonshade Earring",       -- __, __, __, __; TP bonus
    ring2="Archon Ring",            --  5, __, __, __
    waist="Skrymir Cord",           -- __,  5, 30, __
    -- ammo="Ghastly Tathlum +1",   -- __, __, 21, __
  })
  sets.precast.WS['Cataclysm'].MaxTP = set_combine(sets.precast.WS['Cataclysm'], {
    ear2="Novio Earring",           -- __,  7, __, __
  })


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Pet WS Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.Pet.Weaponskill = {
    head="Karagoz Capello +1",
    body="Pitre Tobe +3",
    hands="Mpaca's Gloves",
    legs="Kara. Pantaloni +1",
    feet={ name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}},
    neck="Pup. Collar",
    waist="Incarnation Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }

  -- 50% VIT - Critical hit rate varies w/ TP
  sets.midcast.Pet.Weaponskill['String Shredder'] = {
    head="Pitre Taj +3",
    body="Pitre Tobe +3",
    hands="Tali'ah Gages +2",
    legs="Tali'ah Sera. +2",
    feet="Tali'ah Crackows +2",
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }

  -- 60% VIT - This has additional effect stun, may want magic acc to help with the stun effect
  sets.midcast.Pet.Weaponskill['Bone Crusher'] = {
    head="Tali'ah Turban +2",
    body="Tali'ah Manteel +2",
    hands="Mpaca's Gloves",
    legs="Tali'ah Sera. +2",
    feet="Tali'ah Crackows +2",
    neck="Adad Amulet",
    waist="Incarnation Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }

  -- 50% DEX - Provides Defense Down, may want magic acc to help it land. TP Bonus to help with duration.
  sets.midcast.Pet.Weaponskill['Armor Shatterer'] = {
    head="Tali'ah Turban +2",
    body="Tali'ah Manteel +2",
    hands="Tali'ah Gages +2",
    legs="Tali'ah Sera. +2",
    feet="Tali'ah Crackows +2",
    neck="Adad Amulet",
    waist="Incarnation Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }

  -- 60% DEX - TP Bonus WS - Damage Varies with TP
  sets.midcast.Pet.Weaponskill['Arcuballista'] = {
    head="Karagoz Capello +1",
    body="Pitre Tobe +3",
    hands="Tali'ah Gages +2",
    legs="Tali'ah Sera. +2",
    feet="Tali'ah Crackows +2",
    neck="Pup. Collar",
    waist="Incarnation Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }

  -- 60% DEX - TP Bonus - Magic Accuracy to help with Additional Effect Stun
  sets.midcast.Pet.Weaponskill['Daze'] = set_combine(sets.midcast.Pet.Weaponskill['Arcuballista'], {})

  -- 50% STR - TP Bonus
  sets.midcast.Pet.Weaponskill['Chimera Ripper'] = {
    head="Karagoz Capello +1",
    body="Pitre Tobe +3",
    hands="Karagoz Guanti +1",
    legs="Kara. Pantaloni +1",
    feet={ name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}},
    neck="Pup. Collar",
    waist="Incarnation Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

	-- 50% Cure potency
  sets.midcast['Cure'] = {
    body="Nefer Kalasiris",
    legs="Gyve Trousers",
    waist="Pythia Sash +1",
    ear2="Mendicant's Earring",
    back="Solemnity Cape",
  }
  sets.midcast['Curaga'] = set_combine(sets.midcast['Cure'], {})

  sets.midcast['Refresh'] = {}

  sets.midcast.Pet['Cure'] = {
    legs="Foire Churidars +2",
    waist="Ukko Sash",
  }

  sets.midcast.Pet['Elemental Magic'] = {
    head=gear.Rawhide_D_head,
    body="Tali'ah Manteel +2",
    hands="Tali'ah Gages +2",
    legs="Pitre Churidars +3",
    feet="Pitre Babouches +3",
    neck="Pup. Collar",
    waist="Ukko Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
  }

  sets.midcast.Pet['Enfeebling Magic'] ={
    head="Tali'ah Turban +2",
    body="Tali'ah Manteel +2",
    hands="Tali'ah Gages +2",
    legs="Pitre Churidars +3",
    feet="Pitre Babouches +3",
    neck="Adad Amulet",
    waist="Ukko Sash",
    ear1="Enmerkar Earring",
    ring1="C. Palug Ring",
  }

  sets.midcast.Pet['Dark Magic'] = set_combine(sets.midcast.Pet['Enfeebling Magic'], {})
  sets.midcast.Pet['Divine Magic'] = set_combine(sets.midcast.Pet['Enfeebling Magic'], {})
  sets.midcast.Pet['Enhancing Magic'] = set_combine(sets.midcast.Pet['Enfeebling Magic'], {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Overcapped DT to account for regain gear swap
  sets.HeavyDef = {
    range="Neo Animator",
    ammo="Automat. Oil +3",
    head=gear.Taeon_Pet_DT_head,
    body=gear.Taeon_Pet_DT_body,
    hands=gear.Taeon_Pet_DT_hands,
    legs=gear.Taeon_Pet_DT_legs,
    feet=gear.Taeon_Pet_DT_feet,
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    ear1="Domes. Earring",
    ear2="Enmerkar Earring",
    ring1="Varar Ring",
    ring2="Thurandaut Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",           --  3 {__}
    ear1="Infused Earring",           --  1 {__}
    ring1="Chirich Ring +1",          --  2 {__}
    ring2="Chirich Ring +1",          --  2 {__}
  } -- 24 Regen {10 Pet Regen}
  sets.latent_refresh = {
    ring1="Stikini Ring +1",      --  1
    -- ring2="Stikini Ring +1",   --  1
  }

  sets.resting = {}

  sets.idle = set_combine(sets.HeavyDef, {})

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.Weak = set_combine(sets.HeavyDef, {})

  sets.idle.PetEngaged = {}
  sets.idle.PetEngaged.Tank = {
    range="Neo Animator",
    ammo="Automat. Oil +3",
    head=gear.Anwig_Salade,
    body=gear.Taeon_Pet_DT_body,
    hands=gear.Taeon_Pet_DT_hands,
    legs=gear.Taeon_Pet_DT_legs,
    feet=gear.Taeon_Pet_DT_feet,
    neck="Empath Necklace",
    waist="Isa Belt",
    ear1="Rimeice Earring",
    ear2="Handler's Earring +1",
    ring1="Varar Ring",
    ring2="Thurandaut Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
  }
  sets.idle.PetEngaged.Ranged = {
    head="Tali'ah Turban +2",
    body="Pitre Tobe +3",
    hands="Tali'ah Gages +2",
    legs="Tali'ah Sera. +2",
    feet="Tali'ah Crackows +2",
    neck="Pup. Collar",
    waist="Incarnation Sash",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }
  sets.idle.PetEngaged.RangedAcc = set_combine(sets.idle.PetEngaged.Ranged, {})
  sets.idle.PetEngaged.Heal = {
    head="Pitre Taj +3",
    body={ name="Herculean Vest", augments={'INT+14','Rng.Atk.+28','"Refresh"+1',}},
    hands={ name="Herculean Gloves", augments={'STR+5','DEX+10','"Refresh"+1','Accuracy+13 Attack+13',}},
    legs=gear.Rawhide_D_legs,
    feet="Tali'ah Crackows +2",
    neck="Empath Necklace",
    waist="Isa Belt",
    ear1="Enmerkar Earring",
    ear2="Burana Earring",
    ring1="C. Palug Ring",
    ring2="Varar Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  }
  sets.idle.PetEngaged.MeleeSpam = {
    range="Neo Animator",
    ammo="Automat. Oil +3",
    head=gear.Taeon_Pet_DT_head,
    body=gear.Taeon_Pet_DT_body,
    hands=gear.Taeon_Pet_DT_hands,
    legs=gear.Taeon_Pet_DT_legs,
    feet=gear.Taeon_Pet_DT_feet,
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    ear1="Domes. Earring",
    ear2="Enmerkar Earring",
    ring1="Varar Ring",
    ring2="Thurandaut Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
  }
  sets.idle.PetEngaged.MeleeSC = set_combine(sets.idle.PetEngaged.MeleeSpam, {})
  sets.idle.PetEngaged.Overdrive = set_combine(sets.idle.PetEngaged.MeleeSpam, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    head="Nyame Helm",
    body="Mpaca's Doublet",
    hands=gear.Ryuo_A_hands,
    legs="Mpaca's Hose",
    feet="Mpaca's Boots",
    neck="Lissome Necklace",
    waist="Moonbow Belt +1",
    ear1="Mache Earring +1",
    ear2="Dedition Earring",
    ring1="Niqmaddu Ring",
    ring2="Chirich Ring +1",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
  }
  sets.engaged.Acc = set_combine(sets.engaged, {
  })

  sets.engaged.PetTank = {
  }
  sets.engaged.PetTank.Acc = set_combine(sets.engaged.PetTank, {
  })
  sets.engaged.PetRanged = {
  }
  sets.engaged.PetRanged.Acc = set_combine(sets.engaged.PetRanged, {
  })
  sets.engaged.PetRangedAcc = set_combine(sets.engaged.PetRanged, {})
  sets.engaged.PetRangedAcc.Acc = set_combine(sets.engaged.PetRanged, {})
  sets.engaged.PetHeal = {
  }
  sets.engaged.PetHeal.Acc = set_combine(sets.engaged.PetHeal, {
  })
  sets.engaged.PetMeleeSpam = {
  }
  sets.engaged.PetMeleeSpam.Acc = set_combine(sets.engaged.PetMeleeSpam, {
  })
  sets.engaged.PetMeleeSC = {
  }
  sets.engaged.PetMeleeSC.Acc = set_combine(sets.engaged.PetMeleeSC, {
  })
  sets.engaged.PetOverdrive = {
  }
  sets.engaged.PetOverdrive.Acc = set_combine(sets.engaged.PetOverdrive, {
  })

  sets.engaged.HalfsiesTank = {}
  sets.engaged.HalfsiesTank.Acc = set_combine(sets.engaged.HalfsiesTank, {
  })
  sets.engaged.HalfsiesRanged = {}
  sets.engaged.HalfsiesRanged.Acc = set_combine(sets.engaged.HalfsiesRanged, {
  })
  sets.engaged.HalfsiesRangedAcc = set_combine(sets.engaged.HalfsiesRanged, {})
  sets.engaged.HalfsiesRangedAcc.Acc = set_combine(sets.engaged.HalfsiesRanged, {})
  sets.engaged.HalfsiesHeal = {}
  sets.engaged.HalfsiesHeal.Acc = set_combine(sets.engaged.HalfsiesHeal, {
  })
  sets.engaged.HalfsiesMeleeSpam = {}
  sets.engaged.HalfsiesMeleeSpam.Acc = set_combine(sets.engaged.HalfsiesMeleeSpam, {
  })
  sets.engaged.HalfsiesMeleeSC = {}
  sets.engaged.HalfsiesMeleeSC.Acc = set_combine(sets.engaged.HalfsiesMeleeSC, {
  })
  sets.engaged.HalfsiesOverdrive = {}
  sets.engaged.HalfsiesOverdrive.Acc = set_combine(sets.engaged.HalfsiesOverdrive, {
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.PDT = {
    head="Nyame Helm",
    body="Mpaca's Doublet",
    hands="Mpaca's Gloves",
    legs="Mpaca's Hose",
    feet="Nyame Sollerets",
    neck="Shulmanu Collar",
    waist="Incarnation Sash",
    ear1="Telos Earring",
    ear2="Mache Earring +1",
    ring1="Varar Ring",
    ring2="Thurandaut Ring",
    back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
  }
  sets.engaged.PDT.Acc = set_combine(sets.engaged.PDT, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}
  sets.Special.SleepyHead = {}

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.CP = {
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }

  sets.Kiting = {
    feet="Hermes' Sandals"
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Kenkonken'] = {main="Kenkonken", sub=empty}
  sets.WeaponSet['Verethragna'] = {main="Verethragna", sub=empty}
  sets.WeaponSet['Karambit'] = {main="Karambit", sub=empty}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs) 
  if spell.type == 'WeaponSkill' then
    -- Handle belts for elemental WS
    if elemental_ws:contains(spell.english) then
      local base_day_weather_mult = silibs.get_day_weather_multiplier(spell.element, false, false)
      local obi_mult = silibs.get_day_weather_multiplier(spell.element, true, false)
      local orpheus_mult = silibs.get_orpheus_multiplier(spell.element, spell.target.distance)
      local has_obi = true -- Change if you do or don't have Hachirin-no-Obi
      local has_orpheus = false -- Change if you do or don't have Orpheus's Sash
  
      -- Determine which combination to use: orpheus, hachirin-no-obi, or neither
      if has_obi and (obi_mult >= orpheus_mult or not has_orpheus) and (obi_mult > base_day_weather_mult) then
        -- Obi is better than orpheus and better than nothing
        equip({waist="Hachirin-no-Obi"})
      elseif has_orpheus and (orpheus_mult > base_day_weather_mult) then
        -- Orpheus is better than obi and better than nothing
        equip({waist="Orpheus's Sash"})
      end
    end
    
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_midcast(spell, action, spellMap, eventArgs)
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
end

-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
  if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
      handle_equipping_gear(player.status, newStatus)
  end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  elseif all_maneuvers:contains(buff) then
    -- When maneuver gained, add to queue
    if gain then
      active_maneuvers:append(buff)
    else
      for k,v in active_maneuvers:it() do
        if v == buff then
          active_maneuvers:remove(k)
          return
        end
      end
    end
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_combat_form()
  update_idle_groups()
  auto_engage_pet()
  check_maneuvers()
end

function update_combat_form()
  state.CombatForm:reset()

  if state.HybridMode.value ~= 'Master' then
    state.CombatForm:set(state.HybridMode.value..state.PetMode.value)
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Determine if attack capped
  if state.AttCapped.value then
    wsmode = 'AttCapped'
  end

  -- Calculate if need TP bonus
  local buffer = 100
  -- Start TP bonus at 0 and accumulate based on equipped gear
  local tp_bonus_from_weapons = 0
  for slot,gear in pairs(tp_bonus_weapons) do
    local equipped_item = player.equipment[slot]
    if equipped_item and gear[equipped_item] then
      tp_bonus_from_weapons = tp_bonus_from_weapons + gear[equipped_item]
    end
  end
  local buff_bonus = T{
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  if player.tp > 3000-tp_bonus_from_weapons-buff_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in defensive mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end

  if pet.status == 'Engaged' then
    idleSet = set_combine(idleSet, sets.idle.PetEngaged[state.PetMode.value])
  end

  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then idleSet = set_combine(idleSet, { neck=player.equipment.neck }) end
  if locked_ear1 then idleSet = set_combine(idleSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then idleSet = set_combine(idleSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then idleSet = set_combine(idleSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then idleSet = set_combine(idleSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end

  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    meleeSet = set_combine(meleeSet, sets.Special.SleepyHead)
  end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    defenseSet = set_combine(defenseSet, sets.Special.SleepyHead)
  end

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

function user_customize_idle_set(idleSet)
  -- Any non-silibs modifications should go in customize_idle_set function
  return silibs.customize_idle_set(idleSet)
end

function user_customize_melee_set(meleeSet)
  -- Any non-silibs modifications should go in customize_melee_set function
  return silibs.customize_melee_set(meleeSet)
end

function user_customize_defense_set(defenseSet)
  -- Any non-silibs modifications should go in customize_defense_set function
  return silibs.customize_defense_set(defenseSet)
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local m_msg = state.OffenseMode.value
  m_msg = m_msg .. '/' ..state.HybridMode.value

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

  local i_msg = state.IdleMode.value

  local pet_msg = state.PetMode.current

  local msg = ''
  if state.TreasureMode.value ~= 'None' then
    msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
  end
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee: ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Pet: ' ..string.char(31,001)..pet_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  elseif cycle_dir == 'reset' then
    state.WeaponSet:reset()
  end

  add_to_chat(141, 'Weapon set to '..string.char(31,1)..state.WeaponSet.current)
  equip(sets.WeaponSet[state.WeaponSet.current])
end

function cycle_pet_mode(cycle_dir)
  if pet.isvalid then
    add_to_chat(123, 'Cannot update attachments while pet is active.')
  else
    if cycle_dir == 'forward' then
      state.PetMode:cycle()
    elseif cycle_dir == 'back' then
      state.PetMode:cycleback()
    elseif cycle_dir == 'reset' then
      state.PetMode:reset()
    end
  
    add_to_chat(141, 'Pet Mode set to '..string.char(31,1)..state.PetMode.current)
  
    -- Set automaton attachments
    local set_name = state.PetMode.current:lower()
    equip_attachments:schedule(3, set_name)
  end
end

function equip_attachments(set_name)
  if set_name == state.PetMode.current:lower() then
    send_command('input //acon equipset '..set_name)
  end
end

function auto_engage_pet()
	if areas.Cities:contains(world.area) then
    return
  end

	local abil_recasts = windower.ffxi.get_ability_recasts()

	if state.AutomaticPetTargeting.value == true and pet.isvalid and pet.status == "Idle" and player.status == 'Engaged'
      and player.target.type == "MONSTER" and abil_recasts[207] == 0 then
    windower.chat.input('/pet "Deploy" <t>')
	end
end

function pet_control(command)
  if command == 'deploy' then
    windower.chat.input('/pet "Deploy" <t>')
  elseif command == 'retrieve' then
    windower.chat.input('/pet "Retrieve" <me>')
  end
  
  if state.AutomaticPetTargeting.value == true then
    state.AutomaticPetTargeting:set(false)
    add_to_chat(141, 'Manual pet control detected. Disabling auto targeting.')
  end
end

function check_maneuvers()
  if not pet.isvalid then
    active_maneuvers = L{}
  end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if player.tp < 3000 then
      classes.CustomIdleGroups:append('Regain')
    end
    if isRegening==true and player.hpp < 100 then
      classes.CustomIdleGroups:append('Regen')
    elseif isRegening==false and player.hpp < 85 then
      classes.CustomIdleGroups:append('Regen')
    end
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if isRefreshing==true and player.mpp < 100 then
        classes.CustomIdleGroups:append('Refresh')
      elseif isRefreshing==false and player.mpp < 85 then
        classes.CustomIdleGroups:append('Refresh')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    end
  elseif cmdParams[1] == 'petmode' then
    if cmdParams[2] == 'cycle' then
      cycle_pet_mode('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_pet_mode('back')
    elseif cmdParams[2] == 'current' then
      cycle_pet_mode('current')
    elseif cmdParams[2] == 'reset' then
      cycle_pet_mode('reset')
    end
  elseif cmdParams[1] == 'petcontrol' then
    if cmdParams[2] then
      pet_control(cmdParams[2])
    else
      add_to_chat(123, 'Missing 2nd parameter for this command.')
    end
  elseif cmdParams[1] == 'maneuver' then
    use_maneuver(cmdParams[2])
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
  end
end

function use_maneuver(maneuver_element)
  if pet.isvalid then
    -- Block action if unable to use Maneuver
    if midaction() then
      return
    end
    for _,status in pairs(silibs.action_type_blockers) do
      if buffactive[status] then
        return
      end
    end
    local abil_recasts = windower.ffxi.get_ability_recasts()
    if abil_recasts[210] > 0 then
      return
    end
  
    -- Maneuver not specified, use defaults based on pet mode
    if maneuver_element == nil then
      -- Use next maneuver in the list if not all default maneuvers are active
      for element,desired_amount in pairs(defaultManeuvers[state.PetMode.value]) do
        local active = buffactive[element..' Maneuver'] or 0
        if desired_amount > active then
          windower.chat.input('/pet "'..element..' Maneuver" <me>')
          return
        end
      end
      -- If we got this far, it means all default maneuvers are active, so we need to refresh duration
      -- To find which maneuver will be updated with the next activation, check the list
      local next_maneuver = active_maneuvers[1]
      windower.chat.input('/pet "'..next_maneuver..'" <me>')
      -- Move to end of list
      active_maneuvers:remove(1)
      active_maneuvers:append(next_maneuver)
    else
      maneuver_element = maneuver_element:gsub("^%l", string.upper) -- Capitalize first letter
      if elements.list:contains(maneuver_element) then
        windower.chat.input('/pet "'..element..' Maneuver" <me>')
      else
        add_to_chat(123,'Error: Maneuver command format is wrong.')
      end
    end
  else
      add_to_chat(123,'Error: No valid pet.')
  end
end

function check_gear()
  if no_swap_necks:contains(player.equipment.neck) then
    locked_neck = true
  else
    locked_neck = false
  end
  if no_swap_earrings:contains(player.equipment.ear1) then
    locked_ear1 = true
  else
    locked_ear1 = false
  end
  if no_swap_earrings:contains(player.equipment.ear2) then
    locked_ear2 = true
  else
    locked_ear2 = false
  end
  if no_swap_rings:contains(player.equipment.ring1) then
    locked_ring1 = true
  else
    locked_ring1 = false
  end
  if no_swap_rings:contains(player.equipment.ring2) then
    locked_ring2 = true
  else
    locked_ring2 = false
  end
end

windower.register_event('zone change', function()
  if locked_neck then equip({ neck=empty }) end
  if locked_ear1 then equip({ ear1=empty }) end
  if locked_ear2 then equip({ ear2=empty }) end
  if locked_ring1 then equip({ ring1=empty }) end
  if locked_ring2 then equip({ ring2=empty }) end
end)

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(2, 15)
end

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind !z gs c toggle AutomaticPetTargeting')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^pageup gs c petmode cycle')
  send_command('bind ^pagedown gs c petmode cycleback')
  send_command('bind !pagedown gs c petmode reset')
  
  send_command('bind !` gs c maneuver')
  send_command('bind !q gs c petcontrol deploy')
  send_command('bind !w gs c petcontrol retrieve')
  send_command('bind !e input /ja "Activate" <me>')
end

function set_sub_keybinds()
  if player.sub_job == 'WAR' then
    send_command('bind ^numlock input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind ^numlock input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  end

end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind ^f8')
  send_command('unbind !z')

  send_command('unbind ^`')
  send_command('unbind @c')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')
  
  send_command('unbind !`')
  send_command('unbind !q')
  send_command('unbind !w')
  send_command('unbind !e')
  
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
end

function test()
  table.vprint(windower.ffxi.get_abilities())
end
