-- File Status: Good.

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
  end, 5)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(12)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('Normal', 'HeavyDef')
  state.IdleMode:options('Normal', 'LightDef')
  state.AttCapped = M(true, 'Attack Capped')
  state.CP = M(false, 'Capacity Points Mode')
  
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  
  wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
      'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
  wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}

  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Shining One', 'Staff'}

  update_melee_groups()
  select_default_macro_book()
  set_sub_keybinds()
end

function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- A tic must pass with the HP+ equipment still on before the HP gains are counted for the ability.
  sets.precast.JA['Spirit Surge'] = {
    body="Pteroslaver Mail +1",
    -- body="Pteroslaver Mail +3",
  }
  sets.precast.JA['Call Wyvern'] = {
    body="Pteroslaver Mail +1",
    -- body="Pteroslaver Mail +3",
  }
  sets.precast.JA['Ancient Circle'] = {
    -- legs="Vishap Brais +3",
  }

  sets.precast.JA['Spirit Link'] = {
    hands="Peltast's Vambraces +1",   -- Augments pet debuff erasure, maybe TP trasnfer/HP restoration
    feet="Pteroslaver Greaves +1",    -- Augments pet buff duration
    -- hands="Pteroslaver Vambraces +3",
  }

  -- STP > Multihit
  sets.precast.JA['Jump'] = {
    ammo="Coiste Bodhar",                 --  3, __ < 3, __, __> [__/__, ___]
    head="Flamma Zucchetto +2",           --  6, 44 <__,  5, __> [__/__,  53]
    body="Hjarrandi Breastplate",         -- 10, 47 <__, __, __> [12/12,  69]
    hands="Gleti's Gauntlets",            --  8, 55 <__, __, __> [ 7/__,  75]
    legs="Pteroslaver Brais +3",          -- 10, 39 <__, __, __> [__/__,  95]
    feet="Flamma Gambieras +2",           --  6, 42 < 6, __, __> [__/__,  86]
    neck="Vim Torque +1",                 -- 10, 15 <__, __, __> [__/__, ___]
    ear1="Telos Earring",                 --  5, 10 < 1, __, __> [__/__, ___]
    ear2="Sherida Earring",               --  5, __ < 5, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- __, __ <__, __,  3> [__/__, ___]
    ring2="Defending Ring",               -- __, __ <__, __, __> [10/10, ___]
    back=gear.DRG_STP_Cape,               -- 10, 20 <20, __, __> [10/__, ___]
    waist="Ioskeha Belt +1",              -- __, 17 < 9, __, __> [__/__, ___]
    -- 73 STP, 289 Acc <44 DA, 5 TA, 3 QA> [39 PDT/22 MDT, 378 M.Eva]
  }
  sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'], {})
  sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'], {
    feet="Peltast's Schynbalds +2",       -- __, 50 <__, __, __> [10/10, 120]; Spirit Jump TP+80
    ring2="Chirich Ring +1",              --  6, 10 <__, __, __> [__/__, ___]

    -- feet="Peltast's Schynbalds +3",    -- __, 60 <__, __, __> [11/11, 130]; Spirit Jump TP+90
    -- 73 STP, 317 Acc <38 DA, 5 TA, 3 QA> [40 PDT/23 MDT, 422 M.Eva]
  })
  sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {})
  sets.precast.JA['Super Jump'] = {}

  sets.precast.JA['Angon'] = {
    ammo="Angon",
    hands="Pteroslaver Finger Gauntlets +1",
    ear2="Dragoon's Earring",
    -- hands="Pteroslaver Finger Gauntlets +3",
  }

  -- Fast cast sets for spells
  sets.precast.FC = {
    hands=gear.Leyline_Gloves, --8
    feet=gear.Carmine_D_feet, --8
    neck="Orunmila's Torque", --5
    ear1="Loquacious Earring", --2
    ear2="Enchanter's Earring +1", --2
    -- ammo="Sapience Orb", --2
    -- head=gear.Carmine_D_head, --14
    -- body="Sacro Breastplate", --10
    -- legs="Ayanmo Cosciales +2", --6
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Knobkierrie",                 -- __, __, 23, __,  6, __
    head="Peltast's Mezail +3",         -- 36, 26, 71, 61, 12, __
    body=gear.Nyame_B_body,             -- 45, 37, 65, 40, 13, __
    hands=gear.Nyame_B_hands,           -- 17, 40, 65, 40, 11, __
    legs=gear.Nyame_B_legs,             -- 58, 32, 65, 40, 12, __
    feet=gear.Nyame_B_feet,             -- 23, 26, 65, 53, 11, __
    neck="Dragoon's Collar +2",         -- 15, __, 25, 25, __, 10
    ear1="Thrud Earring",               -- 10, __, __, __,  3, __
    ear2="Moonshade Earring",           -- __, __, __,  4, __, __; tp bonus +250
    ring1="Sroda Ring",                 -- 15, __, __, __, __,  3
    ring2="Epaminondas's Ring",         -- __, __, __, __,  5, __
    back=gear.DRG_WS2_Cape,             -- 30, __, 20, 20, 10, __
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __
    -- 264 STR, 161 MND, 414 Attack, 283 Accuracy, 83 WSD, 13 PDL
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Ishvara Earring",             -- __, __, __, __,  2, __
    -- 264 STR, 161 MND, 414 Attack, 283 Accuracy, 85 WSD, 13 PDL
  })
  sets.precast.WS.AttCapped = {
    ammo="Knobkierrie",                 -- __, __, 23, __,  6, __
    head="Peltast's Mezail +3",         -- 36, 32, 71, 61, 12, __
    body="Peltast's Plackart +3",       -- 43, 34, 74, 64, __, 10
    hands="Gleti's Gauntlets",          -- 20, 30, 70, 55, __,  7
    legs=gear.Nyame_B_legs,             -- 58, __, 65, 40, 12, __
    feet=gear.Nyame_B_feet,             -- 23, 26, 65, 53, 11, __
    neck="Dragoon's Collar +2",         -- 15, __, 25, 25, __, 10
    ear1="Moonshade Earring",           -- __, __, __,  4, __, __; tp bonus +250
    ear2="Peltast's Earring",           -- __, __, __,  6, __,  7
    ring1="Ephramad's Ring",            -- 10, __, 20, 20, __, 10
    ring2="Epaminondas's Ring",         -- __, __, __, __,  5, __
    back=gear.DRG_WS2_Cape,             -- 30, __, 20, 20, 10, __
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __
    -- 250 STR, 122 MND, 448 Att, 348 Acc, 56 WSD, 44 PDL
    
    -- ear2="Peltast's Earring +2",     -- 15, __, __, 20, __,  9
    -- 265 STR, 122 MND, 448 Att, 362 Acc, 56 WSD, 46 PDL
  }
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Thrud Earring",               -- 10, __, __, __,  3, __
    ear2="Peltast's Earring",           -- __, __, __,  6, __,  7
    -- 265 STR, 122 MND, 428 Att, 324 Acc, 59 WSD, 37 PDL
  })
  
  sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {})
  sets.precast.WS["Savage Blade"].MaxTP = set_combine(sets.precast.WS.MaxTP, {})
  sets.precast.WS["Savage Blade"].AttCapped = set_combine(sets.precast.WS.AttCapped, {})
  sets.precast.WS["Savage Blade"].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {})

  -- 85% STR; 0.75-1.75 fTP; 4 hit physical
  -- Multihit > WSD > STR
  sets.precast.WS["Stardiver"] = {
    ammo="Coiste Bodhar",               -- 10, 15, __, __, __ < 3, __, __>
    head="Pteroslaver Armet +3",        -- 37, 77, 44, __, __ <__,  4, __>
    body="Gleti's Cuirass",             -- 39, 70, 55, __,  9 <10, __, __>
    hands=gear.Nyame_B_hands,           -- 17, 65, 40, 11, __ < 5, __, __>
    legs=gear.Nyame_B_legs,             -- 58, 65, 40, 12, __ < 6, __, __>
    feet=gear.Nyame_B_feet,             -- 23, 65, 53, 11, __ < 5, __, __>
    neck="Fotia Gorget",                -- __, __, __, __, __ <__, __, __>; ftp+
    ear1="Moonshade Earring",           -- __, __,  4, __, __ <__, __, __>; tp bonus +250
    ear2="Sherida Earring",             --  5, __, __, __, __ < 5, __, __>
    ring1="Sroda Ring",                 -- 15, __, __, __,  3 <__, __, __>
    ring2="Niqmaddu Ring",              -- 10, __, __, __, __ <__, __,  3>
    back=gear.DRG_WS2_Cape,             -- 30, 20, 20, 10, __ <__, __, __>
    waist="Fotia Belt",                 -- __, __, __, __, __ <__, __, __>; ftp+
    -- 244 STR, 377 Att, 256 Acc, 43 WSD, 12 PDL <34 DA, 4 TA, 3 QA>

    -- back=gear.DRG_WS1_Cape,          -- 30, 20, 20, __, __ <10, __, __>
    -- 244 STR, 377 Att, 256 Acc, 34 WSD, 12 PDL <44 DA, 4 TA, 3 QA>
  }
  sets.precast.WS["Stardiver"].MaxTP = set_combine(sets.precast.WS["Stardiver"], {
    ear1="Brutal Earring",              -- __, __, __, __, __ < 5, __, __>
    -- 244 STR, 377 Att, 252 Acc, 34 WSD, 12 PDL <46 DA, 4 TA, 3 QA>
  })
  sets.precast.WS["Stardiver"].AttCapped = {
    ammo="Crepuscular Pebble",          --  3, __, __, __,  3 <__, __, __>
    head="Flamma Zucchetto +2",         -- 36, __, 44, __, __ <__,  5, __>
    body="Gleti's Cuirass",             -- 39, 70, 55, __,  9 <10, __, __>
    hands="Gleti's Gauntlets",          -- 20, 70, 55, __,  7 <__, __, __>
    legs="Gleti's Breeches",            -- 49, 70, 55, __,  8 <__,  5, __>
    feet="Flamma Gambieras +2",         -- 31, __, 42, __, __ < 6, __, __>
    neck="Dragoon's Collar +2",         -- 15, 25, 25, __, 10 <__, __, __>
    ear1="Moonshade Earring",           -- __, __,  4, __, __ <__, __, __>; tp bonus +250
    ear2="Peltast's Earring",           -- __, __,  6, __,  7 <__, __, __>
    ring1="Ephramad's Ring",            -- 10, 20, 20, __, 10 <__, __, __>
    ring2="Niqmaddu Ring",              -- 10, __, __, __, __ <__, __,  3>
    back=gear.DRG_WS2_Cape,             -- 30, 20, 20, 10, __ <__, __, __>
    waist="Fotia Belt",                 -- __, __, __, __, __ <__, __, __>; ftp+
    -- 243 STR, 275 Att, 326 Acc, 10 WSD, 54 PDL <16 DA, 10 TA, 3 QA>

    -- ear2="Peltast's Earring +2",     -- 15, __, 20, __,  9 <__, __, __>
    -- back=gear.DRG_WS1_Cape,          -- 30, 20, 20, __, __ <10, __, __>
    -- 258 STR, 275 Att, 340 Acc, 0 WSD, 56 PDL <26 DA, 10 TA, 3 QA>
  }
  sets.precast.WS["Stardiver"].AttCappedMaxTP = set_combine(sets.precast.WS["Stardiver"].AttCapped, {
    ear1="Brutal Earring",
    -- 233 STR, 205 Att, 272 Acc, 0 WSD, 37 PDL <31 DA, 5 TA, 3 QA>
  })

  -- 60% STR / 60% VIT; 1 hit physical; Ignores 12.5-62.5% defense based on TP
  -- WSD > STR/VIT
  sets.precast.WS["Camlann's Torment"] = {
    ammo="Knobkierrie",                 -- __, __, 23, __,  6, __
    head="Peltast's Mezail +3",         -- 36, 35, 71, 61, 12, __
    body=gear.Nyame_B_body,             -- 45, 35, 65, 40, 13, __
    hands=gear.Nyame_B_hands,           -- 17, 54, 65, 40, 11, __
    legs=gear.Nyame_B_legs,             -- 58, 30, 65, 40, 12, __
    feet=gear.Nyame_B_feet,             -- 23, 24, 65, 53, 11, __
    neck="Dragoon's Collar +2",         -- 15, 15, 25, 25, __, 10
    ear1="Thrud Earring",               -- 10, 10, __, __,  3, __
    ear2="Ishvara Earring",             -- __, __, __, __,  2, __
    ring1="Epaminondas's Ring",         -- __, __, __, __,  5, __
    ring2="Ephramad's Ring",            -- 10, __, 20, 20, __, 10
    back=gear.DRG_WS2_Cape,             -- 30, __, 20, 20, 10, __
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __
    -- 259 STR, 203 VIT, 434 Att, 299 Acc, 85 WSD, 20 PDL
    
    -- ear2="Peltast's Earring +2",     -- 15, 15, __, 20, __,  9
    -- 274 STR, 218 VIT, 434 Att, 319 Acc, 83 WSD, 29 PDL
  }
  sets.precast.WS["Camlann's Torment"].MaxTP = set_combine(sets.precast.WS["Camlann's Torment"], {})
  sets.precast.WS["Camlann's Torment"].AttCapped = {
    ammo="Knobkierrie",                 -- __, __, 23, __,  6, __
    head="Peltast's Mezail +3",         -- 36, 35, 71, 61, 12, __
    body="Peltast's Plackart +3",       -- 43, 43, 74, 64, __, 10
    hands="Gleti's Gauntlets",          -- 20, 43, 70, 55, __,  7
    legs=gear.Nyame_B_legs,             -- 58, 30, 65, 40, 12, __
    feet=gear.Nyame_B_feet,             -- 23, 24, 65, 53, 11, __
    neck="Dragoon's Collar +2",         -- 15, 15, 25, 25, __, 10
    ear1="Thrud Earring",               -- 10, 10, __, __,  3, __
    ear2="Peltast's Earring",           -- __, __, __,  6, __,  7
    ring1="Epaminondas's Ring",         -- __, __, __, __,  5, __
    ring2="Ephramad's Ring",            -- 10, __, 20, 20, __, 10
    back=gear.DRG_WS2_Cape,             -- 30, __, 20, 20, 10, __
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __
    -- 260 STR, 200 VIT, 448 Att, 344 Acc, 59 WSD, 44 PDL
    
    -- ear2="Peltast's Earring +2",     -- 15, 15, __, 20, __,  9
    -- 275 STR, 215 VIT, 448 Att, 358 Acc, 59 WSD, 46 PDL
  }
  sets.precast.WS["Camlann's Torment"].AttCappedMaxTP = set_combine(sets.precast.WS["Camlann's Torment"].AttCapped, {})

  -- 40% STR/40% DEX
  -- WSD > STR <> DEX
  sets.precast.WS["Sonic Thrust"] = {
    ammo="Knobkierrie",                 -- __, __, 23, __,  6, __
    head="Peltast's Mezail +3",         -- 36, 32, 71, 61, 12, __
    body=gear.Nyame_B_body,             -- 45, 24, 65, 40, 13, __
    hands=gear.Nyame_B_hands,           -- 17, 42, 65, 40, 11, __
    legs=gear.Nyame_B_legs,             -- 58, __, 65, 40, 12, __
    feet=gear.Nyame_B_feet,             -- 23, 26, 65, 53, 11, __
    neck="Dragoon's Collar +2",         -- 15, __, 25, 25, __, 10
    ear1="Moonshade Earring",           -- __, __, __,  4, __, __; tp bonus +250
    ear2="Thrud Earring",               -- 10, __, __, __,  3, __
    ring1="Ephramad's Ring",            -- 10, 10, 20, 20, __, 10
    ring2="Niqmaddu Ring",              -- 10, 10, __, __, __, __
    back=gear.DRG_WS2_Cape,             -- 30, __, 20, 20, 10, __
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __
    -- 269 STR, 144 DEX, 434 Att, 303 Acc, 78 WSD, 20 PDL
  }
  sets.precast.WS["Sonic Thrust"].MaxTP = set_combine(sets.precast.WS["Sonic Thrust"], {
    ear1="Ishvara Earring",             -- __, __, __, __,  2, __
    ear2="Thrud Earring",               -- 10, __, __, __,  3, __

    -- ear1="Thrud Earring",            -- 10, __, __, __,  3, __
    -- ear2="Peltast's Earring +2",     -- 15, __, __, 20, __,  9
  })
  sets.precast.WS["Sonic Thrust"].AttCapped = {
    ammo="Knobkierrie",                 -- __, __, 23, __,  6, __
    head="Peltast's Mezail +3",         -- 36, 32, 71, 61, 12, __
    body="Peltast's Plackart +3",       -- 43, 39, 74, 64, __, 10
    hands="Gleti's Gauntlets",          -- 20, 47, 70, 55, __,  7
    legs=gear.Nyame_B_legs,             -- 58, __, 65, 40, 12, __
    feet=gear.Nyame_B_feet,             -- 23, 26, 65, 53, 11, __
    neck="Dragoon's Collar +2",         -- 15, __, 25, 25, __, 10
    ear1="Moonshade Earring",           -- __, __, __,  4, __, __; tp bonus +250
    ear2="Thrud Earring",               -- 10, __, __, __,  3, __
    ring1="Ephramad's Ring",            -- 10, 10, 20, 20, __, 10
    ring2="Niqmaddu Ring",              -- 10, 10, __, __, __, __
    back=gear.DRG_WS2_Cape,             -- 30, __, 20, 20, 10, __
    waist="Sailfi Belt +1",             -- 15, __, 15, __, __, __
    -- 270 STR, 164 DEX, 448 Att, 342 Acc, 54 WSD, 37 PDL
    
    -- ear2="Peltast's Earring +2",     -- 15, __, __, 20, __,  9
    -- 275 STR, 164 DEX, 448 Att, 362 Acc, 51 WSD, 46 PDL
  }
  sets.precast.WS["Sonic Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Sonic Thrust"].AttCapped, {
    ear1="Ishvara Earring",             -- __, __, __, __,  2, __
    ear2="Thrud Earring",               -- 10, __, __, __,  3, __

    -- ear1="Thrud Earring",            -- 10, __, __, __,  3, __
    -- ear2="Peltast's Earring +2",     -- 15, __, __, 20, __,  9
  })

  -- 100% STR, 2 hit, dmg varies with TP
  -- WSD <> STR; if used with shining one, crit rate/dmg also good
  sets.precast.WS["Impulse Drive"] = {
    ammo="Knobkierrie",                 -- __, 23, __,  6, __ (__, __)
    head="Peltast's Mezail +3",         -- 36, 71, 61, 12, __ (__, __)
    body="Gleti's Cuirass",             -- 39, 70, 55, __,  9 ( 8, __)
    hands=gear.Nyame_B_hands,           -- 17, 65, 40, 11, __ (__, __)
    legs="Peltast's Cuissots +2",       -- 48, 63, 53, __, __ (__, 12)
    feet=gear.Nyame_B_feet,             -- 23, 65, 53, 11, __ (__, __)
    neck="Dragoon's Collar +2",         -- 15, 25, 25, __, 10 ( 4, __)
    ear1="Moonshade Earring",           -- __, __,  4, __, __ (__, __); tp bonus +250
    ear2="Thrud Earring",               -- 10, __, __,  3, __ (__, __)
    ring1="Ephramad's Ring",            -- 10, 20, 20, __, 10 (__, __)
    ring2="Sroda Ring",                 -- 15, __, __, __,  3 (__, __)
    back=gear.DRG_WS2_Cape,             -- 30, 20, 20, 10, __ (__, __)
    waist="Sailfi Belt +1",             -- 15, 15, __, __, __ (__, __)
    -- 258 STR, 437 Att, 331 Acc, 53 WSD, 32 PDL (12 Crit Rate, 12 Crit Dmg)

    -- legs="Peltast's Cuissots +3",    -- 53, 73, 63, __, __ (__, 13)
    -- 263 STR, 447 Att, 341 Acc, 53 WSD, 32 PDL (12 Crit Rate, 13 Crit Dmg)
  }
  sets.precast.WS["Impulse Drive"].MaxTP = set_combine(sets.precast.WS["Impulse Drive"], {
    ear1="Ishvara Earring",             -- __, __, __,  2, __ (__, __)

    -- ear1="Thrud Earring",            -- 10, __, __,  3, __ (__, __)
    -- ear2="Peltast's Earring +2",     -- 15, __, 20, __,  9 ( 6, __)
  })
  sets.precast.WS["Impulse Drive"].AttCapped = {
    ammo="Knobkierrie",                 -- __, 23, __,  6, __ (__, __)
    head="Gleti's Mask",                -- 33, 70, 55, __,  6 ( 5, __)
    body="Gleti's Cuirass",             -- 39, 70, 55, __,  9 ( 8, __)
    hands="Gleti's Gauntlets",          -- 20, 70, 55, __,  7 ( 6, __)
    legs="Gleti's Breeches",            -- 49, 70, 55, __,  8 ( 7, __)
    feet="Gleti's Boots",               -- 33, 70, 55, __,  5 ( 4, __)
    neck="Dragoon's Collar +2",         -- 15, 25, 25, __, 10 ( 4, __)
    ear1="Moonshade Earring",           -- __, __,  4, __, __ (__, __); tp bonus +250
    ear2="Peltast's Earring",           -- __, __,  6, __,  7 (__, __)
    ring1="Niqmaddu Ring",              -- 10, __, __, __, __ (__, __)
    ring2="Ephramad's Ring",            -- 10, 20, 20, __, 10 (__, __)
    back=gear.DRG_WS2_Cape,             -- 30, 20, 20, 10, __ (__, __)
    waist="Sailfi Belt +1",             -- 15, 15, __, __, __ (__, __)
    -- 254 STR, 453 Att, 350 Acc, 16 WSD, 62 PDL (34 Crit Rate, 0 Crit Dmg)
    
    -- ear2="Peltast's Earring +2",     -- 15, __, 20, __,  9 ( 6, __)
    -- 269 STR, 453 Att, 364 Acc, 16 WSD, 64 PDL (40 Crit Rate, 0 Crit Dmg)
  }
  sets.precast.WS["Impulse Drive"].AttCappedMaxTP = set_combine(sets.precast.WS["Impulse Drive"].AttCapped, {
    ear1="Thrud Earring",               -- 10, __, __,  3, __ (__, __)
  })

  -- 80% DEX
  sets.precast.WS["Geirskogul"] = {
    ammo="Knobkierrie",                 -- __, 23, __,  6, __
    head="Peltast's Mezail +3",         -- 32, 71, 61, 12, __
    body=gear.Nyame_B_body,             -- 24, 65, 40, 13, __
    hands=gear.Nyame_B_hands,           -- 42, 65, 40, 11, __
    legs=gear.Lustratio_B_legs,         -- 43, 38, 20, __, __
    feet=gear.Lustratio_D_feet,         -- 48, __, __, __, __
    neck="Fotia Gorget",                -- __, __, __, __, __; ftp+
    ear1="Odr Earring",                 -- 10, __, __, __, __
    ear2="Moonshade Earring",           -- __, __,  4, __, __; tp bonus +250
    ring1="Ephramad's Ring",            -- 10, 20, 20, __, 10
    ring2="Epaminondas's Ring",         -- __, __, __,  5, __
    back=gear.DRG_WS2_Cape,             -- __, 20, 20, 10, __
    waist="Kentarch Belt +1",           -- 10, __, 14, __, __
    -- Lustratio set effect                __, __, __,  4, __
    -- 219 DEX, 302 Attack, 219 Accuracy, 61 WSD, 10 PDL

    -- back=gear.DRG_WS4_Cape,          -- 30, 20, 20, 10, __
    -- 249 DEX, 302 Attack, 219 Accuracy, 61 WSD, 10 PDL
  }
  sets.precast.WS["Geirskogul"].MaxTP = set_combine(sets.precast.WS["Geirskogul"], {
    ear2="Thrud Earring",               -- __, __, __,  3, __
    -- 249 DEX, 282 Attack, 195 Accuracy, 62 WSD, 0 PDL
  })
  sets.precast.WS["Geirskogul"].AttCapped = set_combine(sets.precast.WS["Geirskogul"], {
    body="Gleti's Cuirass",             -- 34, 70, 55, __,  9
    feet="Gleti's Boots",               -- 29, 70, 55, __,  5
    neck="Dragoon's Collar +2",         -- __, 25, 25, __, 10
    ear1="Moonshade Earring",           -- __, __,  4, __, __; tp bonus +250
    ear2="Peltast's Earring",           -- __, __, __, __,  7
    -- 230 DEX, 402 Attack, 314 Accuracy, 44 WSD, 41 PDL
  })
  sets.precast.WS["Geirskogul"].AttCappedMaxTP = set_combine(sets.precast.WS["Geirskogul"].AttCapped, {
    ear1="Odr Earring",                 -- 10, __, __, __, __
    ear2="Peltast's Earring",           -- __, __,  6, __,  7
    -- 240 DEX, 402 Attack, 310 Accuracy, 44 WSD, 41 PDL
  })

  -- 50% STR; 4 hit, can crit
  sets.precast.WS["Drakesbane"] = {
    ammo="Coiste Bodhar",               -- 10, __, 15, __ (__, __)
    head="Gleti's Mask",                -- 33, __, 70,  6 ( 5, __)
    body="Hjarrandi Breastplate",       -- 38, __, 53, __ (13, __)
    hands="Gleti's Gauntlets",          -- 20, __, 70,  7 ( 6, __)
    legs="Peltast's Cuissots +2",       -- 48, __, 63, __ (__, 12)
    feet="Gleti's Boots",               -- 33, __, 70,  5 ( 4, __)
    neck="Dragoon's Collar +2",         -- 15, __, 25, 10 ( 4, __)
    ear1="Moonshade Earring",           -- __, __, __, __ (__, __); TP Bonus+250
    ear2="Thrud Earring",               -- 10,  3, __, __ (__, __)
    ring1="Ephramad's Ring",            -- 10, __, 20, 10 (__, __)
    ring2="Sroda Ring",                 -- 15, __, __, __ (__, __)
    back=gear.DRG_WS2_Cape,             -- 30, 10, 20, __ (__, __)
    waist="Sailfi Belt +1",             -- 15, __, 15, __ (__, __)
    -- 277 STR, 13 WSD, 421 Att, 38 PDL (32 Crit Rate, 12 Crit Dmg)

    -- head="Blistering Sallet +1",     -- 41, __, __, __ (10, __)
    -- legs="Peltast's Cuissots +3",    -- 53, __, 73, __ (__, 13)
    -- ear2="Peltast's Earring +2",     -- 15, __, __,  9 ( 6, __)
    -- back=gear.DRG_WS3_Cape,          -- 30, __, 20, __ (10, __)
    -- 295 STR, 0 WSD, 361 Att, 41 PDL (53 Crit Rate, 13 Crit Dmg)
  }
  sets.precast.WS["Drakesbane"].MaxTP = set_combine(sets.precast.WS["Drakesbane"], {
    ear1="Thrud Earring",               -- 10,  3, __, __ (__, __)
    ear2="Sherida Earring",             --  5, __, __, __ (__, __)
  })
  sets.precast.WS["Drakesbane"].AttCapped = {
    ammo="Crepuscular Pebble",          --  3, __, __,  3 (__, __)
    head="Gleti's Mask",                -- 33, __, 70,  6 ( 5, __)
    body="Gleti's Cuirass",             -- 39, __, 70,  9 ( 8, __)
    hands="Gleti's Gauntlets",          -- 20, __, 70,  7 ( 6, __)
    legs="Peltast's Cuissots +2",       -- 48, __, 63, __ (__, 12)
    feet="Gleti's Boots",               -- 33, __, 70,  5 ( 4, __)
    neck="Dragoon's Collar +2",         -- 15, __, 25, 10 ( 4, __)
    ear1="Thrud Earring",               -- 10,  3, __, __ (__, __)
    ear2="Peltast's Earring",           -- __, __, __,  7 (__, __)
    ring1="Ephramad's Ring",            -- 10, __, 20, 10 (__, __)
    ring2="Sroda Ring",                 -- 15, __, __, __ (__, __)
    back=gear.DRG_WS2_Cape,             -- 30, 10, 20, __ (__, __)
    waist="Sailfi Belt +1",             -- 15, __, 15, __ (__, __)
    -- 271 STR, 13 WSD, 423 Att, 57 PDL (27 Crit Rate, 12 Crit Dmg)

    -- legs="Peltast's Cuissots +3",    -- 53, __, 73, __ (__, 13)
    -- ear2="Peltast's Earring +2",     -- 15, __, __,  9 ( 6, __)
    -- back=gear.DRG_WS3_Cape,          -- 30, __, 20, __ (10, __)
    -- 291 STR, 3 WSD, 433 Att, 59 PDL (43 Crit Rate, 13 Crit Dmg)
  }
  sets.precast.WS["Drakesbane"].AttCappedMaxTP = set_combine(sets.precast.WS["Drakesbane"].AttCapped, {})

  -- Deals lightning elemental damage. Damage varies with TP. 1.0-3.0 fTP
  sets.precast.WS["Raiden Thrust"] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",       --  4
    head=gear.Nyame_B_head,         -- 30
    body=gear.Nyame_B_body,         -- 30, __, 12
    hands=gear.Nyame_B_hands,       -- 30
    legs=gear.Nyame_B_legs,         -- 30, __, 11
    feet=gear.Nyame_B_feet,         -- 30
    neck="Sibyl Scarf",             -- 10
    ear1="Friomisi Earring",        -- 10, __, __
    ear2="Novio Earring",           --  7
    ring1="Shiva Ring +1",          --  3, __, __
    ring2="Epaminondas's Ring",     -- __, __,  5
    back="Argochampsa Mantle",      -- 12, __, __
    waist="Skrymir Cord",           --  5
    -- back=gear.DRG_MAB_Cape,      -- 10
    -- waist="Skrymir Cord +1",     --  7, 35, __
  })
  sets.precast.WS["Raiden Thrust"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Raiden Thrust"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Raiden Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  sets.precast.WS["Thunder Thrust"] = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  sets.precast.WS["Aeolian Edge"] = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Aeolian Edge"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Aeolian Edge"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Aeolian Edge"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  -- Cataclysm: 30% STR/30% INT, 2.75-5.0 fTP, 1 hit (aoe-magical)
  -- Stack MAB > WSD
  sets.precast.WS["Cataclysm"] = set_combine(sets.precast.WS["Raiden Thrust"], {
    head="Pixie Hairpin +1",        -- 28, __, __, __
    ear2="Moonshade Earring",       -- __, __, __, __; TP bonus
    ring2="Archon Ring",            --  5, __, __, __
  })
  sets.precast.WS["Cataclysm"].MaxTP = set_combine(sets.precast.WS["Cataclysm"], {
    ear2="Novio Earring",           -- __,  7, __, __
  })
  sets.precast.WS["Cataclysm"].AttCapped = set_combine(sets.precast.WS["Cataclysm"], {})
  sets.precast.WS["Cataclysm"].AttCappedMaxTP = set_combine(sets.precast.WS["Cataclysm"].AttCapped, {
    ear2="Novio Earring",           -- __,  7, __, __
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.LightDef = {
    ear2="Odnowa Earring +1",     --  3/ 5, ___
    ring1="Gelatinous Ring +1",   --  7/__, ___
    ring2="Defending Ring",       -- 10/10, ___
    -- 10 PDT from JSE cape
  } -- 30 PDT/15 MDT, 0 MEVA

  -- Overcapped DT to account for regain gear swap
  sets.HeavyDef = {
    ammo="Staunch Tathlum +1",    -- [ 3/ 3, ___] {__/__}; status resist
    head="Peltast's Mezail +3",   -- [__/__,  98] {__/__}; Pet absorb dmg
    body=gear.Nyame_B_body,       -- [ 9/ 9, 139] {__/__}
    hands=gear.Nyame_B_hands,     -- [ 7/ 7, 112] {__/__}
    legs=gear.Nyame_B_legs,       -- [ 8/ 8, 150] {__/__}
    feet=gear.Nyame_B_feet,       -- [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",   -- [__/__, ___] {25/25}
    ear1="Enmerkar Earring",      -- [__/__, ___] { 3/ 3}
    ear2="Odnowa Earring +1",     -- [ 3/ 5, ___] {__/__}
    ring1="Moonlight Ring",       -- [ 5/ 5, ___] {__/__}
    ring2="Defending Ring",       -- [10/10, ___] {__/__}
    back=gear.DRG_TP_Cape,        -- [10/__, ___] {__/__}
    waist="Isa Belt",             -- [__/__, ___] { 3/ 3}
    -- 62 PDT/54 MDT, 649 MEVA {31 PetPDT/31 PetMDT}

    -- ear2="Anastasi Earring",   -- [__/__, ___] { 3/__}
    -- 59 PDT/49 MDT, 649 MEVA {34 PetPDT/31 PetMDT}
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Gleti's Mask",        --  2
    body="Gleti's Cuirass",     --  3
    hands="Gleti's Gauntlets",  --  2
    legs="Gleti's Breeches",    --  3
    feet="Gleti's Boots"        --  2
    -- head="Valorous Mask",    --  3
  }
  sets.latent_regen = {
    head="Gleti's Mask",              --  3
    neck="Bathy Choker +1",           --  3 {__}
    ear1="Infused Earring",           --  1 {__}
    ring1="Chirich Ring +1",          --  2 {__}
    ring2="Chirich Ring +1",          --  2 {__}
    -- body="Sacro Breastplate",      -- 13 {__}
    -- feet="Pteroslaver Greaves +3", -- __ {10}
  } -- 24 Regen {10 Pet Regen}
  sets.latent_refresh = {
    ring1="Stikini Ring +1",      --  1
    -- body="Chozoron Coselete",  --  2
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

  sets.idle.LightDef = set_combine(sets.idle, sets.LightDef)
  sets.idle.LightDef.Regain = set_combine(sets.idle.Regain, sets.LightDef)
  sets.idle.LightDef.Regen = set_combine(sets.idle.Regen, sets.LightDef)
  sets.idle.LightDef.Refresh = set_combine(sets.idle.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen = set_combine(sets.idle.Regain.Regen, sets.LightDef)
  sets.idle.LightDef.Regain.Refresh = set_combine(sets.idle.Regain.Refresh, sets.LightDef)
  sets.idle.LightDef.Regen.Refresh = set_combine(sets.idle.Regen.Refresh, sets.LightDef)
  sets.idle.LightDef.Regain.Regen.Refresh = set_combine(sets.idle.Regain.Regen.Refresh, sets.LightDef)

  sets.idle.Weak = set_combine(sets.HeavyDef, {})

  sets.Kiting = {
    legs="Carmine Cuisses +1"
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Hjarrandi Helm",          -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    body="Hjarrandi Breastplate",   -- __, 10, 53, 47, 13 <__, __, __> [12/12,  69] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs="Pteroslaver Brais +3",    --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    feet="Flamma Gambieras +2",     --  2,  6, __, 42, __ < 6, __, __> [__/__,  86] {__/__}
    neck="Vim Torque +1",           -- __, 10, __, 15, __ <__, __, __> [__/__, ___] {__/__}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] {__/__}
    back=gear.DRG_TP_Cape,          -- __, __, 20, 30, __ <10, __, __> [10/__, ___] {__/__}
    waist="Tempus Fugit +1",        -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
    -- 25 Haste, 69 STP, 285 Att, 287 Acc, 19 Crit Rate <31 DA, 0 TA, 3 QA> [44 PDT/27 MDT, 378 Meva] {19 PetPDT/8 PetMDT}
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    hands=gear.Emicho_D_hands,
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    -- body="Vishap Mail +3",
    -- hands="Gazu Bracelets +1",
  })

  sets.engaged.SamRoll = {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",         --  3, __, 70, 55,  8 <10, __, __> [ 9/__, 102] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs="Pteroslaver Brais +3",    --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    feet="Flamma Gambieras +2",     --  2,  6, __, 42, __ < 6, __, __> [__/__,  86] {__/__}
    neck="Vim Torque +1",           -- __, 10, __, 15, __ <__, __, __> [__/__, ___] {__/__}
    ear1="Odnowa Earring +1",       -- __, __, __, __, __ <__, __, __> [ 3/ 5, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    back=gear.DRG_TP_Cape,          -- __, __, 20, 30, __ <10, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- 25 Haste, 58 STP, 255 Att, 313 Acc, 14 Crit Rate <43 DA, 5 TA, 0 QA> [39 PDT/15 MDT, 411 Meva] {19 PetPDT/8 PetMDT}
  }
  sets.engaged.LowAcc.SamRoll = set_combine(sets.engaged.SamRoll, {
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
  })
  sets.engaged.MidAcc.SamRoll = set_combine(sets.engaged.LowAcc.SamRoll, {
    hands=gear.Emicho_D_hands,
    -- ammo="Voluspa Tathlum",
  })
  sets.engaged.HighAcc.SamRoll = set_combine(sets.engaged.MidAcc.SamRoll, {
    -- body="Vishap Mail +3",
    -- hands="Gazu Bracelets +1",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.HeavyDef = set_combine(sets.engaged, {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Hjarrandi Helm",          -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    body="Hjarrandi Breastplate",   -- __, 10, 53, 47, 13 <__, __, __> [12/12,  69] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs="Pteroslaver Brais +3",    --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    feet=gear.Nyame_B_feet,         --  3, __, 65, 53, __ < 5, __, __> [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",     -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__ __, __> [10/__, ___] {__/__}
    waist="Tempus Fugit +1",        -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
    -- 26 Haste, 63 STP, 375 Att, 308 Acc, 23 Crit Rate <20 DA, 0 TA, 3 QA> [51 PDT/34 MDT, 442 Meva] {44 PetPDT/33 PetMDT}
  })
  sets.engaged.LowAcc.HeavyDef = set_combine(sets.engaged.LowAcc, {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",         --  3, __, 70, 55,  8 <10, __, __> [ 9/__, 102] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs=gear.Nyame_B_legs,         --  5, __, 65, 40, __ < 6, __, __> [ 8/ 8, 150] {__/__}
    feet=gear.Nyame_B_feet,         --  3, __, 65, 53, __ < 5, __, __> [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",     -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- 26 Haste, 47 STP, 356 Att, 345 Acc, 18 Crit Rate <39 DA, 5 TA, 0 QA> [51 PDT/25 MDT, 530 Meva] {33 PetPDT/33 PetMDT}
  })
  sets.engaged.MidAcc.HeavyDef = set_combine(sets.engaged.LowAcc.HeavyDef, {})
  sets.engaged.HighAcc.HeavyDef = set_combine(sets.engaged.LowAcc.HeavyDef, {})

  sets.engaged.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll, {
    ammo="Coiste Bodhar",           -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",         --  3, __, 70, 55,  8 <10, __, __> [ 9/__, 102] {__/__}
    hands="Gleti's Gauntlets",      --  3,  8, 70, 55,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs=gear.Nyame_B_legs,         --  5, __, 65, 40, __ < 6, __, __> [ 8/ 8, 150] {__/__}
    feet=gear.Nyame_B_feet,         --  3, __, 65, 53, __ < 5, __, __> [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",     -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    ring2="Moonlight Ring",         -- __,  5,  8,  8, __ <__, __, __> [ 5/ 5, ___] {__/__}
    back=gear.DRG_STP_Cape,         -- __, 10, 20, 30, __ <__, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- 26 Haste, 47 STP, 356 Att, 345 Acc, 18 Crit Rate <39 DA, 5 TA, 0 QA> [51 PDT/25 MDT, 530 Meva] {33 PetPDT/33 PetMDT}
  })
  sets.engaged.LowAcc.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll.HeavyDef, {})
  sets.engaged.MidAcc.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll.HeavyDef, {})
  sets.engaged.HighAcc.SamRoll.HeavyDef = set_combine(sets.engaged.SamRoll.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}
  sets.Special.SleepyHead = { head="Frenzy Sallet", }

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

  sets.WeaponSet = {}
  sets.WeaponSet['Shining One'] = {main="Shining One", sub="Utu Grip"}
  sets.WeaponSet['Naegling'] = {main="Naegling", sub=empty}
  sets.WeaponSet['Staff'] = {main="Reikikon", sub="Utu Grip"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  -- Wyvern Commands
  if spell.name == 'Dismiss' and pet.hpp < 100 then
    eventArgs.cancel = true
    add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
  elseif wyv_breath_spells:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
    equip(sets.precast.HealingBreath)
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs) 
  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end
    
    local safeSet = sets.precast.WS[spell.name] and sets.precast.WS[spell.name].Safe
    if state.HybridMode.value == 'LightDef' and safeSet then
      equip(safeSet)
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
  if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
    equip(sets.midcast.HealingBreath)
  elseif wyv_elem_breath:contains(spell.english) then
    equip(sets.midcast.ElementalBreath)
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
  end

  if buff == 'Hasso' and not gain then
    add_to_chat(167, 'Hasso just expired!')
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_melee_groups()
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
  if state.Buff['Boost'] or info.boost_temp_lock then
    meleeSet = set_combine(meleeSet, sets.BoostRegain)
  end
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
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local toy_msg = state.ToyWeapons.current

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
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
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

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(sets.WeaponSet[state.WeaponSet.current])
end

function cycle_toy_weapons(cycle_dir)
  --If current state is None, save current weapons to switch back later
  if state.ToyWeapons.current == 'None' then
    sets.ToyWeapon.None.main = player.equipment.main
    sets.ToyWeapon.None.sub = player.equipment.sub
  end

  if cycle_dir == 'forward' then
    state.ToyWeapons:cycle()
  elseif cycle_dir == 'back' then
    state.ToyWeapons:cycleback()
  else
    state.ToyWeapons:reset()
  end

  local mode_color = 001
  if state.ToyWeapons.current == 'None' then
    mode_color = 006
  end
  add_to_chat(012, 'Toy Weapon Mode: '..string.char(31,mode_color)..state.ToyWeapons.current)
  equip(sets.ToyWeapon[state.ToyWeapons.current])
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

  if cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'weaponset' then
    if cmdParams[2] == 'cycle' then
      cycle_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_weapons('back')
    elseif cmdParams[2] == 'current' then
      cycle_weapons('current')
    elseif cmdParams[2] == 'reset' then
      cycle_weapons('reset')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
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

function update_melee_groups()
  classes.CustomMeleeGroups:clear()
  
  if buffactive["samurai roll"] then
    classes.CustomMeleeGroups:append('SamRoll')
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
  set_macro_page(2, 13)
end

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^f8 gs c toggle AttCapped')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind !` input /ja "Call Wyvern" <me>')
  send_command('bind !q input /ja "Spirit Link" <me>')
  send_command('bind ^q input /ja "Steady Wing" <me>')
  send_command('bind !e input /ja "Ancient Circle" <me>')
  send_command('bind !r input /ja "Dragon Breaker" <t>')
end

function set_sub_keybinds()
  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Hasso" <me>')
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

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^f8')

  send_command('unbind ^`')
  send_command('unbind @c')
  
  send_command('unbind !`')
  send_command('unbind !q')
  send_command('unbind ^q')
  send_command('unbind !e')
  send_command('unbind !r')
  
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
end

function test()
end
