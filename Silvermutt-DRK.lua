-- File Status: WIP. Not functional.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: HasteInfo
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable GearInfo, disable RollTracker

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
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Rearming Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Other:      [ ALT+D ]           Cancel Invisible/Hide & Use Key on <t>
--              [ ALT+S ]           Turn 180 degrees in place
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
  silibs.enable_auto_lockstyle(18)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.HybridMode:options('LightDef', 'SubtleBlow', 'Normal')
  state.IdleMode:options('Normal', 'HeavyDef')
  state.AttCapped = M(true, "Attack Capped")

  state.CP = M(false, 'Capacity Points Mode')
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger','Sword','Club','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Anguta', 'Club', 'Dagger'}
  -- state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Anguta', 'Apocalypse', 'Caladbolg', 'Club', 'Dagger'}
  state.EnmityMode = M{['description']='Enmity Mode', 'Normal', 'Low', 'Schere'}
  
  skill_ids_2h = S{4, 6, 7, 8, 10, 12} -- DO NOT MODIFY
  fencer_tp_bonus = {200, 300, 400, 450, 500, 550, 600, 630} -- DO NOT MODIFY
  activate_AM_mode = {
    ["Liberator"] = S{"Aftermath: Lv.3"},
    ["Apocalypse"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
    ["Foenaria"] = S{"Aftermath: Lv.1", "Aftermath: Lv.2", "Aftermath: Lv.3"},
  }

  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  update_melee_groups()

  select_default_macro_book()
  set_sub_keybinds()
end

function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}

  -- Enmity sets
  sets.Enmity = {
    ammo="Sapience Orb",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck="Loricate Torque +1",
    ear1="Friomisi Earring",
    ear2="Cryptic Earring",
    ring1="Moonlight Ring",
    ring2="Defending Ring",
    -- back=???
    -- waist=???  
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Sapience Orb",             --  2 [__/__, ___]
    head=gear.Carmine_D_head,        -- 14 [__/__,  53]
    -- body="Fallen's Cuirass +3",   -- 10 [__/__,  68]
    hands=gear.Leyline_Gloves,       --  8 [__/__,  62]
    legs=gear.Odyssean_FC_legs,      --  6 [__/__,  86]
    feet=gear.Odyssean_FC_feet,      -- 11 [__/__,  86]
    neck="Orunmila's Torque",        --  5 [__/__, ___]
    ear1="Malignance Earring",       --  4 [__/__, ___]
    ear2="Loquacious Earring",       --  2 [__/__, ___]
    ring1="Kishar Ring",             --  4 [__/__, ___]
    ring2="Prolix Ring",             --  2 [__/__, ___]
    -- back=gear.DRK_FC_Cape,        -- 10 [10/__, ___]
    waist="Flume Belt +1",           -- __ [ 4/__, ___]
    -- 78 FC [14 PDT/0 MDT, 355 M.Eva]

    -- body="Sacro Breastplate",     -- 10 [__/__, 129]
    -- legs="Enif Cosciales",        --  8 [__/__, ___]
    -- 80 FC [14 PDT/0 MDT, 330 M.Eva]
  }
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    ring2="Defending Ring",
  })
  sets.precast.FC.Trust = set_combine(sets.precast.FC, {
    ring1="Weatherspoon Ring", --5
  })
  sets.precast.FC.Impact = set_combine(sets.precast.FC,{
    -- head=empty,
    -- body="Crepuscular Cloak",
  })

  sets.precast.JA['Blood Weapon'] = {
    -- body="Fallen's Cuirass +3",
  }
  sets.precast.JA['Arcane Circle'] = {
    -- feet="Ignominy Sollerets +3",
  }
  sets.precast.JA['Last Resort'] = {
    -- back=gear.DRK_FC_Cape,
  }
  sets.precast.JA['Weapon Bash'] = {
    -- hands="Ignominy Guantlets +3",
  }
  sets.precast.JA['Souleater'] = {
    -- head="Ignominy Burgeonet +3",
  }
  sets.precast.JA['Dark Seal'] = {
    -- head="Fallen's Burgeonet +3",
  }
  sets.precast.JA['Diabolic Eye'] = {
    -- hands="Fallen's Finger Gauntlets +3",
  }
  sets.precast.JA['Nether Void'] = {
    legs="Heathen's Flanchard +2",
    -- legs="Heathen's Flanchard +3",
  }
  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  -- PDL caps at 100. Don't overcap it.
  -- Aria of Passion = assume +22% PDL (max song+ bonus)
  -- PrimeAM = assume 12% PDL (stage 4 AM3)
  sets.precast.WS = {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, __, 40, 15, __, 10 [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 [__/__, ___]
    ring2="Epaminondas's Ring",           -- __, __, __, __,  5, __ [__/__, ___]
    -- back=gear.DRK_STR_WSD_Cape,        -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 264 STR, 161 MND, 435 Attack, 280 Accuracy, 82 WSD, 71 PDL [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 274 STR, 161 MND, 435 Attack, 276 Accuracy, 85 WSD, 71 PDL [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    ammo="Crepuscular Pebble",            --  3, __, __, __, __,  3 [ 3/ 3, ___]
    head="Heathen's Burgeonet +3",        -- 42, 27, 61, 61, __, 10 [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 21, 70, 55, __,  7 [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, __, 40, 15, __, 10 [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 [__/__, ___]
    -- back=gear.DRK_STR_WSD_Cape,        -- 30, __, 20, 20, 10, __ [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 288 STR, 151 MND, 433 Attack, 326 Accuracy, 48 WSD, 101 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 298 STR, 151 MND, 433 Attack, 322 Accuracy, 51 WSD, 101 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedPrimeAM = set_combine(sets.precast.WS.AttCapped, {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    -- Prime AM3                                                 12
    -- 269 STR, 150 MND, 460 Attack, 315 Accuracy, 65 WSD, 100 PDL [42 PDT/32 MDT, 643 M.Eva]
  })
  sets.precast.WS.AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS.AttCappedPrimeAM, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 279 STR, 150 MND, 460 Attack, 311 Accuracy, 68 WSD, 100 PDL [42 PDT/32 MDT, 643 M.Eva]
  })
  sets.precast.WS.AttCappedAria = set_combine(sets.precast.WS.AttCapped, {
    ammo="Knobkierrie",                   -- __, __, 23, __,  6, __ [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ [ 8/ 8, 150]
    -- Aria                                                      22
    -- 274 STR, 161 MND, 455 Attack, 300 Accuracy, 77 WSD, 103 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedAriaMaxTP = set_combine(sets.precast.WS.AttCappedAria, {
    ear1="Thrud Earring",                 -- 10, __, __, __,  3, __ [__/__, ___]
    -- 284 STR, 161 MND, 455 Attack, 296 Accuracy, 80 WSD, 103 PDL [38 PDT/28 MDT, 607 M.Eva]
  })
  sets.precast.WS.AttCappedPrimeAMAria = set_combine(sets.precast.WS.AttCappedAria, {})
  sets.precast.WS.AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS.AttCappedAriaMaxTP, {})

  -- 50% MND / 30% STR. Dark elemental. Absorbs HP. dStat = INT
  sets.precast.WS['Sanguine Blade'] = {
    ammo="Seething Bomblet +1",       -- __, 15, __,  7, __ [__/__, ___]
    head="Pixie Hairpin +1",          -- __, __, 27, __, __ [__/__, ___]; Dark MAB+28
    body=gear.Nyame_B_body,           -- 37, 45, 42, 30, 13 [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 40, 17, 28, 30, 11 [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 32, 58, 44, 30, 12 [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",    -- 26, 33, 22, 50, 12 [__/__, 119]
    neck="Baetyl Pendant",            -- __, __, __, 13, __ [__/__, ___]
    ear1="Malignance Earring",        --  8, __,  8,  8, __ [__/__, ___]
    ear2="Friomisi Earring",          -- __, __, __, 10, __ [__/__, ___]
    ring1="Epaminondas's Ring",       -- __, __, __, __,  5 [__/__, ___]
    ring2="Archon Ring",              -- __, __, __, __, __ [__/__, ___]; Dark MAB+5
    -- back=gear.DRK_MAB_Cape,        -- __, __, 30, 10, __ [10/__, ___]
    waist="Eschan Stone",             -- __, __, __,  7, __ [__/__, ___]
    -- 143 MND, 168 STR, 201 INT, 195 MAB, 53 WSD [34 PDT/24 MDT, 520 M.Eva]
  }

  -- 80% VIT; Damage varies with TP
  sets.precast.WS['Torcleaver'] = {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 30, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 30, 60, 60, 12, __ < 5, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_VIT_WSD_Cape,        -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; FTP+
    -- DRK traits/gifts/etc                                  50
    -- 223 VIT, 440 Attack, 300 Accuracy, 77 WSD, 78 PDL <28 DA, 0 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS['Torcleaver'].MaxTP = set_combine(sets.precast.WS['Torcleaver'], {
    ear1="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCapped = {
    ammo="Crepuscular Pebble",            --  3, __, __, __,  3 <__, __, __> [ 3/ 3, ___]
    head="Heathen's Burgeonet +3",        -- 33, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 34, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 30, 60, 60, 12, __ < 5, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_VIT_WSD_Cape,        -- 30, 20, 20, 10, __ <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                  50
    -- 239 VIT, 433 Attack, 326 Accuracy, 48 WSD, 98 PDL <35 DA, 2 TA, 3 QA> [38 PDT/28 MDT, 607 M.Eva]
  }
  sets.precast.WS['Torcleaver'].AttCappedMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAM = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    -- Prime AM3                                             12
    -- 230 VIT, 437 Attack, 315 Accuracy, 59 WSD, 100 PDL <34 DA, 2 TA, 3 QA> [45 PDT/35 MDT, 643 M.Eva]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCappedPrimeAM, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __, __ [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCappedAria = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    -- Aria                                                  22
    -- 223 VIT, 455 Attack, 300 Accuracy, 77 WSD, 100 PDL <33 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Torcleaver'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCappedAria, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __, __ [__/__, ___]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Torcleaver'].AttCapped, {
    ammo="Knobkierrie",                   -- __, 23, __,  6, __ <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 24, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    hands=gear.Nyame_B_hands,             -- 54, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    ear2="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
    -- Prime AM3 + Aria                                      34
    -- 233 VIT, 438 Attack, 289 Accuracy, 78 WSD, 104 PDL <33 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Torcleaver'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Torcleaver'].AttCappedPrimeAMAria, {
    ear1="Lugra Earring +1",              -- 16, __, __, __, __, __ [__/__, ___]
  })

  -- 85% STR; 5 hit, transfers ftp
  sets.precast.WS['Resolution'] = {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 47, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 24, 70, 55, __,  6 < 6, __, __> [ 8/ 8, 112]
    -- legs="Ignominy Flanchard +3",      -- 50, 45, 49, __, __ <10, __, __> [__/__,  84]
    feet="Sakpata's Leggings",            -- 29, 70, 55, __,  4 < 4, __, __> [ 6/ 6, 150]
    neck="Fotia Gorget",                  -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",             -- __,  4, __, __, __ <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Schere Earring",                --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, __, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- DRK traits/gifts/etc                                  50
    -- 257 STR, 390 Attack, 310 Accuracy, 10 WSD, 88 PDL <53 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 572 M.Eva]
  }
  sets.precast.WS['Resolution'].MaxTP = set_combine(sets.precast.WS['Resolution'], {
    ear1="Thrud Earring",                 -- 10, __, __,  3, __ <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCapped = set_combine(sets.precast.WS['Resolution'], {
    ammo="Crepuscular Pebble",            --  3, __, __, __,  3 <__, __, __> [ 3/ 3, ___]
    head="Heathen's Burgeonet +3",        -- 42, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body="Sakpata's Breastplate",         -- 42, 70, 55, __,  8 < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 24, 70, 55, __,  6 < 6, __, __> [ 8/ 8, 112]
    -- legs="Ignominy Flanchard +3",      -- 50, 45, 49, __, __ <10, __, __> [__/__,  84]
    feet="Sakpata's Leggings",            -- 29, 70, 55, __,  4 < 4, __, __> [ 6/ 6, 150]
    neck="Fotia Gorget",                  -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    ear1="Moonshade Earring",             -- __,  4, __, __, __ <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Fotia Belt",                   -- __, __, __, __, __ <__, __, __> [__/__, ___]; ftp+
    -- DRK traits/gifts/etc                                  50
    -- 240 STR, 377 Attack, 326 Accuracy, 2 WSD, 99 PDL <44 DA, 0 TA, 3 QA> [37 PDT/27 MDT, 572 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ear1="Schere Earring",                --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAM = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    ear2="Schere Earring",                --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
    -- Prime AM3                                             12
    -- 252 STR, 390 Attack, 330 Accuracy, 0 WSD, 100 PDL <53 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 572 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAM, {
    ear1="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]

    -- ear1="Schere Earring",             --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
    -- ear2="Heathen's Earring +2",       -- 15, 20, 20,  8,  9 <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCappedAria = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    ear2="Schere Earring",                --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
    -- Aria                                                  22
    -- 252 STR, 390 Attack, 330 Accuracy, 0 WSD, 110 PDL <53 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 572 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedAria, {
    ear1="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]

    -- ear1="Schere Earring",             --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
    -- ear2="Heathen's Earring +2",       -- 15, 20, 20,  8,  9 <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Resolution'].AttCapped, {
    ammo="Coiste Bodhar",                 -- 10, 15, __, __, __ < 3, __, __> [__/__, ___]
    ear2="Schere Earring",                --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
    -- Prime AM3 + Aria                                      34
    -- 252 STR, 390 Attack, 330 Accuracy, 0 WSD, 122 PDL <53 DA, 0 TA, 3 QA> [34 PDT/24 MDT, 572 M.Eva]
  })
  sets.precast.WS['Resolution'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMAria, {
    ear1="Brutal Earring",                -- __, __, __, __, __ < 5, __, __> [__/__, ___]

    -- ear1="Schere Earring",             --  5, 15, 15, __, __ < 6, __, __> [__/__, ___]
    -- ear2="Heathen's Earring +2",       -- 15, 20, 20,  8,  9 <__, __, __> [__/__, ___]
  })

  -- 70% INT/30% STR; Dark elemental. Att down varies with TP
  sets.precast.WS['Infernal Scythe'] = {
    ammo="Seething Bomblet +1",       -- 15, __,  7, __ [__/__, ___]
    head="Pixie Hairpin +1",          -- __, 27, __, __ [__/__, ___]; Dark MAB+28
    body=gear.Nyame_B_body,           -- 45, 42, 30, 13 [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 28, 30, 11 [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 44, 30, 12 [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",    -- 33, 22, 50, 12 [__/__, 119]
    neck="Sibyl Scarf",               -- __, 10, 10, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  8,  8, __ [__/__, ___]
    ear2="Moonshade Earring",         -- __, __, __, __ [__/__, ___]; TP bonus
    ring1="Metamorph Ring +1",        -- __, 16, __, __ [__/__, ___]
    ring2="Archon Ring",              -- __, __, __, __ [__/__, ___]; Dark MAB+5
    -- back=gear.DRK_MAB_Cape,        -- __, 30, 10, __ [10/__, ___]
    waist="Eschan Stone",             -- __, __,  7, __ [__/__, ___]
    -- 168 STR, 227 INT, 182 MAB, 48 WSD [34 PDT/24 MDT, 520 M.Eva]
  }
  sets.precast.WS['Infernal Scythe'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'], {
    ear2="Friomisi Earring",          -- __, __, 10, __ [__/__, ___]
  })
  sets.precast.WS['Infernal Scythe'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Infernal Scythe'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  
  -- 40% STR/40% INT; Dark elemental. Damage varies with TP
  sets.precast.WS['Dark Harvest'] = set_combine(sets.precast.WS['Infernal Scythe'], {})
  sets.precast.WS['Dark Harvest'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedMaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMMaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedAriaMaxTP, {})
  sets.precast.WS['Dark Harvest'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMAriaMaxTP, {})

  -- 40% STR/40% INT; Dark elemental. Damage varies with TP
  sets.precast.WS['Shadow of Death'] = set_combine(sets.precast.WS['Infernal Scythe'], {})
  sets.precast.WS['Shadow of Death'].MaxTP = set_combine(sets.precast.WS['Infernal Scythe'].MaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedMaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMMaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedAriaMaxTP, {})
  sets.precast.WS['Shadow of Death'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Infernal Scythe'].AttCappedPrimeAMAriaMaxTP, {})

  -- 100% STR; 1 hit, crit varies with TP
  sets.precast.WS['Vorpal Scythe'] = set_combine(sets.precast.WS, {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head="Blistering Sallet +1",          -- 41, __, 53, __, __ (10, __) < 3, __, __> [ 3/__,  53]
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 60, 60, 12, __ (__, __) <__, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, 40, 15, __, 10 ( 4, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 (__, __) <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __,  3 (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                  50
    -- 289 STR, 367 Attack, 303 Accuracy, 50 WSD, 81 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].MaxTP = set_combine(sets.precast.WS['Vorpal Scythe'], {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCapped = set_combine(sets.precast.WS.AttCapped, {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head="Blistering Sallet +1",          -- 41, __, 53, __, __ (10, __) < 3, __, __> [ 3/__,  53]
    body="Sakpata's Cuisses",             -- 42, 70, 55, __,  8 ( 5, __) < 8, __, __> [10/10, 139]
    hands=gear.Nyame_B_hands,             -- 17, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 70, 55, __,  7 (__, __) < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 60, 60, 12, __ (__, __) <__, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, 40, 15, __, 10 ( 4, __) <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP bonus+250
    ear2="Heathen's Earring +1",          -- __, 17, 11,  2,  8 (__, __) <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __,  3 (__, __) <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, 15, __, __, __ (__, __) < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                  50
    -- 281 STR, 377 Attack, 333 Accuracy, 25 WSD, 96 PDL (31 Crit Rate, 6 Crit Dmg) <28 DA, 2 TA, 0 QA> [39 PDT/26 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAM = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    -- Prime AM3                                             12
    -- 286 STR, 372 Attack, 318 Accuracy, 37 WSD, 101 PDL (31 Crit Rate, 6 Crit Dmg) <27 DA, 2 TA, 0 QA> [38 PDT/25 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAM, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedAria = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    -- Aria                                                  22
    -- 289 STR, 367 Attack, 303 Accuracy, 50 WSD, 103 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCappedAria, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Vorpal Scythe'].AttCapped, {
    body=gear.Nyame_B_body,               -- 45, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    legs=gear.Nyame_B_legs,               -- 58, 65, 40, 12, __ (__, __) < 6, __, __> [ 8/ 8, 150]
    -- Prime AM3 + Aria                                      34
    -- 289 STR, 367 Attack, 303 Accuracy, 50 WSD, 115 PDL (26 Crit Rate, 6 Crit Dmg) <26 DA, 2 TA, 0 QA> [37 PDT/24 MDT, 573 M.Eva]
  })
  sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Vorpal Scythe'].AttCappedPrimeAMAria, {
    ear1="Odr Earring",                   -- __, __, 10, __, __ ( 5, __) <__, __, __> [__/__, ___]
  })

  -- 50% MND/30% STR; 4 hit, silence duration varies with TP
  sets.precast.WS['Guillotine'] = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ <__, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Schere Earring",                --  5, __, 15, 15, __, __ < 6, __, __> [__/__, ___]
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Epaminondas's Ring",           -- __, __, __, __,  5, __ <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 274 STR, 161 MND, 442 Attack, 291 Accuracy, 66 WSD, 68 PDL <47 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS['Guillotine'].MaxTP = set_combine(sets.precast.WS['Guillotine'], {})
  sets.precast.WS['Guillotine'].AttCapped = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 42, 27, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 37, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 40, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 21, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 26, 60, 60, 12, __ <__, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Schere Earring",                --  5, __, 15, 15, __, __ < 6, __, __> [__/__, ___]
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 300 STR, 151 MND, 463 Attack, 337 Accuracy, 38 WSD, 98 PDL <49 DA, 2 TA, 0 QA> [35 PDT/25 MDT, 607 M.Eva]
  }
  sets.precast.WS['Guillotine'].AttCappedMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCapped, {})
  sets.precast.WS['Guillotine'].AttCappedPrimeAM = set_combine(sets.precast.WS['Guillotine'].AttCapped, {
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3                                                 12
    -- 300 STR, 151 MND, 463 Attack, 337 Accuracy, 38 WSD, 100 PDL <49 DA, 2 TA, 0 QA> [35 PDT/25 MDT, 607 M.Eva]
  })
  sets.precast.WS['Guillotine'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCappedPrimeAM, {})
  sets.precast.WS['Guillotine'].AttCappedAria = set_combine(sets.precast.WS['Guillotine'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Aria                                                      22
    -- 284 STR, 161 MND, 462 Attack, 311 Accuracy, 61 WSD, 100 PDL <47 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Guillotine'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCappedAria, {})
  sets.precast.WS['Guillotine'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Guillotine'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 26, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 32, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3 + Aria                                          34
    -- 284 STR, 161 MND, 462 Attack, 311 Accuracy, 61 WSD, 112 PDL <47 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Guillotine'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Guillotine'].AttCappedPrimeAMAria, {})

  -- 20% STR/20% INT; 4 hit, dmg varies with TP
  sets.precast.WS['Insurgency'] = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 26, 28, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 45, 42, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 28, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",        -- 33, 22, 60, 60, 12, __ <__, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus
    ear2="Schere Earring",                --  5, __, 15, 15, __, __ < 6, __, __> [__/__, ___]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    ring2="Epaminondas's Ring",           -- __, __, __, __,  5, __ <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 274 STR, 164 INT, 425 Attack, 284 Accuracy, 64 WSD, 60 PDL <47 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  }
  sets.precast.WS['Insurgency'].MaxTP = set_combine(sets.precast.WS['Insurgency'], {
    ear1="Brutal Earring",                -- __, __, __, __, __, __ < 5, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCapped = {
    ammo="Coiste Bodhar",                 -- 10, __, 15, __, __, __ < 3, __, __> [__/__, ___]
    head="Heathen's Burgeonet +3",        -- 42, 31, 61, 61, __, 10 < 6, __, __> [__/__,  87]
    body=gear.Nyame_B_body,               -- 45, 42, 65, 40, 13, __ < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 17, 28, 65, 40, 11, __ < 5, __, __> [ 7/ 7, 112]
    legs="Sakpata's Cuisses",             -- 53, 32, 70, 55, __,  7 < 7, __, __> [ 9/ 9, 150]
    feet="Heathen's Sollerets +3",        -- 33, 22, 60, 60, 12, __ <__, __, __> [__/__, 119]
    -- neck="Abyssal Beads +2",           -- 25, __, 40, 15, __, 10 <__, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __, __,  4, __, __ <__, __, __> [__/__, ___]; TP bonus
    ear2="Heathen's Earring +1",          -- __, __, 17, 11,  2,  8 <__, __, __> [__/__, ___]
    ring1="Sroda Ring",                   -- 15, __, __, __, __,  3 <__, __, __> [__/__, ___]
    ring2="Ephramad's Ring",              -- 10, __, 20, 20, __, 10 <__, __, __> [__/__, ___]
    -- back=gear.DRK_STR_DA_Cape,         -- 30, __, 20, 20, __, __ <10, __, __> [10/__, ___]
    waist="Sailfi Belt +1",               -- 15, __, 15, __, __, __ < 5,  2, __> [__/__, ___]
    -- DRK traits/gifts/etc                                      50
    -- 305 STR, 155 INT, 448 Attack, 326 Accuracy, 38 WSD, 98 PDL <43 DA, 2 TA, 0 QA> [35 PDT/25 MDT, 607 M.Eva]
  }
  sets.precast.WS['Insurgency'].AttCappedMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    ear1="Schere Earring",                --  5, __, 15, 15, __, __ < 6, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAM = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3                                                 12
    -- 295 STR, 167 INT, 443 Attack, 311 Accuracy, 50 WSD, 100 PDL <42 DA, 2 TA, 3 QA> [34 PDT/24 MDT, 607 M.Eva]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCappedPrimeAM, {
    ear1="Schere Earring",                --  5, __, 15, 15, __, __ < 6, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCappedAria = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 28, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Aria                                                      22
    -- 279 STR, 164 INT, 447 Attack, 300 Accuracy, 61 WSD, 100 PDL <41 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Insurgency'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCappedAria, {
    ear1="Schere Earring",                --  5, __, 15, 15, __, __ < 6, __, __> [__/__, ___]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Insurgency'].AttCapped, {
    head=gear.Nyame_B_head,               -- 26, 28, 65, 50, 11, __ < 5, __, __> [ 7/ 7, 123]
    legs=gear.Nyame_B_legs,               -- 58, 44, 65, 40, 12, __ < 6, __, __> [ 8/ 8, 150]
    ring1="Niqmaddu Ring",                -- 10, __, __, __, __, __ <__, __,  3> [__/__, ___]
    -- Prime AM3 + Aria                                          34
    -- 279 STR, 164 INT, 447 Attack, 300 Accuracy, 61 WSD, 112 PDL <41 DA, 2 TA, 3 QA> [41 PDT/31 MDT, 643 M.Eva]
  })
  sets.precast.WS['Insurgency'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Insurgency'].AttCappedPrimeAMAria, {
    ear1="Schere Earring",                --  5, __, 15, 15, __, __ < 6, __, __> [__/__, ___]
  })

  -- TODO
  -- 40% STR/40% INT; Drains target's HP. Add effect: Haste
  sets.precast.WS['Catastrophe'] = {
    -- 233 DEX, 358 Attack, 309 Accuracy, 35 WSD, 10 PDL (23 Crit Rate, 19 Crit Dmg) <66 DA, 0 TA, 3 QA> [43 PDT/33 MDT, 504 M.Eva]
  }
  sets.precast.WS['Catastrophe'].MaxTP = set_combine(sets.precast.WS['Catastrophe'], {
  })
  sets.precast.WS['Catastrophe'].AttCapped = {
    -- 179 DEX, 408 Attack, 387 Accuracy, 0 WSD, 39 PDL (25 Crit Rate, 19 Crit Dmg) <76 DA, 0 TA, 3 QA> [45 PDT/35 MDT, 634 M.Eva]
  }
  sets.precast.WS['Catastrophe'].AttCappedMaxTP = set_combine(sets.precast.WS['Catastrophe'].AttCapped, {
  })
  sets.precast.WS['Catastrophe'].AttCappedPrimeAM = set_combine(sets.precast.WS['Catastrophe'].AttCapped, {
  })
  sets.precast.WS['Catastrophe'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Catastrophe'].AttCappedPrimeAM, {
  })
  sets.precast.WS['Catastrophe'].AttCappedAria = set_combine(sets.precast.WS['Catastrophe'].AttCapped, {
  })
  sets.precast.WS['Catastrophe'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Catastrophe'].AttCappedAria, {
  })
  sets.precast.WS['Catastrophe'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Catastrophe'].AttCapped, {
  })
  sets.precast.WS['Catastrophe'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Catastrophe'].AttCappedPrimeAMAria, {
  })

  -- TODO
  -- 50% DEX; 5 hit, crit varies with TP
  sets.precast.WS['Judgment'] = {
    ammo="Knobkierrie",
    head="Heathen's Burgeonet +3",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Heathen's Sollerets +3",
    -- neck="Abyssal Beads +2",
    ear1="Moonshade Earring",
    ear2=gear.jse_ear,
    ring1="Sroda Ring",
    ring2="Niqmaddu Ring",
    back=gear.jse_back_wsd_str,
    waist="Sailfi Belt +1",
    -- 233 DEX, 358 Attack, 309 Accuracy, 35 WSD, 10 PDL (23 Crit Rate, 19 Crit Dmg) <66 DA, 0 TA, 3 QA> [43 PDT/33 MDT, 504 M.Eva]
  }
  sets.precast.WS['Judgment'].MaxTP = set_combine(sets.precast.WS['Judgment'], {
  })
  sets.precast.WS['Judgment'].AttCapped = {
    -- 179 DEX, 408 Attack, 387 Accuracy, 0 WSD, 39 PDL (25 Crit Rate, 19 Crit Dmg) <76 DA, 0 TA, 3 QA> [45 PDT/35 MDT, 634 M.Eva]
  }
  sets.precast.WS['Judgment'].AttCappedMaxTP = set_combine(sets.precast.WS['Judgment'].AttCapped, {
  })
  sets.precast.WS['Judgment'].AttCappedPrimeAM = set_combine(sets.precast.WS['Judgment'].AttCapped, {
  })
  sets.precast.WS['Judgment'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Judgment'].AttCappedPrimeAM, {
  })
  sets.precast.WS['Judgment'].AttCappedAria = set_combine(sets.precast.WS['Judgment'].AttCapped, {
  })
  sets.precast.WS['Judgment'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Judgment'].AttCappedAria, {
  })
  sets.precast.WS['Judgment'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Judgment'].AttCapped, {
  })
  sets.precast.WS['Judgment'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Judgment'].AttCappedPrimeAMAria, {
  })

  -- 50% STR; 3 hits, transfers ftp, acc varies with tp
  sets.precast.WS['Decimation'] = set_combine(sets.precast.WS['Resolution'], {})
  sets.precast.WS['Decimation'].MaxTP = set_combine(sets.precast.WS['Resolution'].MaxTP, {})
  sets.precast.WS['Decimation'].AttCapped = set_combine(sets.precast.WS['Resolution'].AttCapped, {})
  sets.precast.WS['Decimation'].AttCappedMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedMaxTP, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAM = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAM, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMMaxTP, {})
  sets.precast.WS['Decimation'].AttCappedAria = set_combine(sets.precast.WS['Resolution'].AttCappedAria, {})
  sets.precast.WS['Decimation'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedAriaMaxTP, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMAria, {})
  sets.precast.WS['Decimation'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Resolution'].AttCappedPrimeAMAriaMaxTP, {})
  
  -- 40% DEX/40% INT; wind elemental, dmg varies with TP
  sets.precast.WS['Aeolian Edge'] = {
    ammo="Seething Bomblet +1",               -- __, __,  7, __ [__/__, ___]
    head=gear.Nyame_B_head,                   -- 25, 28, 30, 11 [ 7/ 7, 123]
    -- body="Fallen's Cuirass +3",            -- 32, 32, 60, __ [__/__,  68]
    -- hands="Fallen's Finger Gauntlets +3",  -- 39, 24, 62, __ [__/__,  46]
    legs=gear.Nyame_B_legs,                   -- __, 44, 30, 12 [ 8/ 8, 150]
    feet="Heathen's Sollerets +3",            -- 25, 22, 50, 12 [__/__, 119]
    neck="Sibyl Scarf",                       -- __, 10, 10, __ [__/__, ___]
    ear1="Malignance Earring",                -- __,  8,  8, __ [__/__, ___]
    ear2="Friomisi Earring",                  -- __, __, 10, __ [__/__, ___]
    ring1="Metamorph Ring +1",                -- __, 16, __, __ [__/__, ___]
    ring2="Defending Ring",                   -- __, __, __, __ [10/10, ___]
    -- back=gear.DRK_MAB_Cape,                -- __, 30, 10, __ [10/__, ___]
    waist="Eschan Stone",                     -- __, __,  7, __ [__/__, ___]
    -- 121 DEX, 214 INT, 284 MAB, 35 WSD [35 PDT/25 MDT, 506 M.Eva]
  }

  -- TODO
  -- 50% DEX; 5 hit, crit varies with TP
  sets.precast.WS['Evisceration'] = {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head=gear.Nyame_B_head,               -- 25, 65, 50, 11, __ (__, __) < 5, __, __> [ 7/ 7, 123]
    body=gear.Nyame_B_body,               -- 24, 65, 40, 13, __ (__, __) < 7, __, __> [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,             -- 42, 65, 40, 11, __ (__, __) < 5, __, __> [ 7/ 7, 112]
    legs=gear.Lustratio_B_legs,           -- 43, 38, 20, __, __ ( 3, __) <__, __, __> [__/__, ___]
    feet="Boii Calligae +3",              -- 34, 60, 60, __, __ (__, 13) <__, __, __> [10/10, 130]
    neck="Warrior's Bead Necklace +2",    -- 15, 25, 25, __, __ (__, __) < 7, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Lugra Earring +1",              -- 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    ring1="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",                -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    back=gear.WAR_STP_Cape,               -- 30, 20, 20, __, __ (__, __) <__, __, __> [10/__, ___]; DA Dmg+20%
    waist="Fotia Belt",                   -- __, __, 10, __, __ (__, __) <__, __, __> [__/__, ___]; ftp+0.1
    -- WAR Traits                            __, __, __, __, __ (__, __) <33, __, __> [__/__, ___]
    -- 249 DEX, 358 Attack, 289 Accuracy, 35 WSD, 10 PDL (5 Crit Rate, 19 Crit Dmg) <60 DA, 0 TA, 3 QA> [43 PDT/33 MDT, 504 M.Eva]

    -- ear2="Boii Earring +2",            -- __, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
    -- back=gear.WAR_DEX_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]; DA Dmg+20%
    -- 233 DEX, 358 Attack, 309 Accuracy, 35 WSD, 10 PDL (23 Crit Rate, 19 Crit Dmg) <66 DA, 0 TA, 3 QA> [43 PDT/33 MDT, 504 M.Eva]
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear1="Thrud Earring",                 -- __, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    ear2="Lugra Earring +1",              -- 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    
    -- ear1="Lugra Earring +1",           -- 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
  })
  sets.precast.WS['Evisceration'].AttCapped = {
    ammo="Yetshila +1",                   -- __, __, __, __, __ ( 2,  6) <__, __, __> [__/__, ___]
    head="Sakpata's Helm",                -- 20, 70, 55, __,  5 (__, __) < 5, __, __> [ 7/ 7, 123]
    body="Sakpata's Breastplate",         -- 25, 70, 55, __,  8 ( 5, __) < 8, __, __> [10/10, 139]
    hands="Sakpata's Gauntlets",          -- 35, 70, 55, __,  6 (__, __) < 6, __, __> [ 8/ 8, 112]
    legs="Boii Cuisses +3",               -- __, 73, 63, __, 10 (__, __) < 8, __, __> [__/__, 130]; TP Bonus+100
    feet="Boii Calligae +3",              -- 34, 60, 60, __, __ (__, 13) <__, __, __> [10/10, 130]
    neck="Warrior's Bead Necklace +2",    -- 15, 25, 25, __, __ (__, __) < 7, __, __> [__/__, ___]
    ear1="Moonshade Earring",             -- __, __,  4, __, __ (__, __) <__, __, __> [__/__, ___]; TP Bonus+250
    ear2="Lugra Earring +1",              -- 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    ring1="Ephramad's Ring",              -- 10, 20, 20, __, 10 (__, __) <__, __, __> [__/__, ___]
    ring2="Niqmaddu Ring",                -- 10, __, __, __, __ (__, __) <__, __,  3> [__/__, ___]
    back=gear.WAR_STP_Cape,               -- 30, 20, 20, __, __ (__, __) <__, __, __> [10/__, ___]; DA Dmg+20%
    waist="Fotia Belt",                   -- __, __, 10, __, __ (__, __) <__, __, __> [__/__, ___]; ftp+0.1
    -- WAR Traits                            __, __, __, __, __ (__, __) <33, __, __> [__/__, ___]
    -- 195 DEX, 408 Attack, 367 Accuracy, 0 WSD, 39 PDL (7 Crit Rate, 19 Crit Dmg) <70 DA, 0 TA, 3 QA> [45 PDT/35 MDT, 634 M.Eva]

    -- ear2="Boii Earring +2",            -- __, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
    -- back=gear.WAR_DEX_Crit_Cape,       -- 30, 20, 20, __, __ (10, __) <__, __, __> [10/__, ___]; DA Dmg+20%
    -- 179 DEX, 408 Attack, 387 Accuracy, 0 WSD, 39 PDL (25 Crit Rate, 19 Crit Dmg) <76 DA, 0 TA, 3 QA> [45 PDT/35 MDT, 634 M.Eva]
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
    ear1="Thrud Earring",                 -- __, __, __,  3, __ (__, __) <__, __, __> [__/__, ___]
    ear2="Lugra Earring +1",              -- 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    
    -- ear1="Lugra Earring +1",           -- 16, __, __, __, __ (__, __) < 3, __, __> [__/__, ___]
    -- ear2="Boii Earring +2",            -- 15, __, 20, __, __ ( 8, __) < 9, __, __> [__/__, ___]
  })
  sets.precast.WS['Evisceration'].AttCappedPrimeAM = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
  })
  sets.precast.WS['Evisceration'].AttCappedPrimeAMMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCappedPrimeAM, {
  })
  sets.precast.WS['Evisceration'].AttCappedAria = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
  })
  sets.precast.WS['Evisceration'].AttCappedAriaMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCappedAria, {
  })
  sets.precast.WS['Evisceration'].AttCappedPrimeAMAria = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
  })
  sets.precast.WS['Evisceration'].AttCappedPrimeAMAriaMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCappedPrimeAMAria, {
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  -- TODO
  sets.midcast.Utsusemi = {
    ammo="Impatiens", -- SIRD
    head=gear.Nyame_B_head, -- DT
    body=gear.Nyame_B_body, -- DT
    hands=gear.Nyame_B_hands, -- DT
    legs=gear.Nyame_B_legs, -- DT
    feet=gear.Nyame_B_feet, -- DT
    neck="Loricate Torque +1", -- SIRD + DT
    ring1="Defending Ring", -- DT
  }

  -- TODO
  sets.midcast['Enfeebling Magic'] = {
    ammo="Pemphredo Tathlum",
    head="Carmine Mask +1",
    body="Heathen's Cuirass +3",
    hands="Heathen's Gauntlets +2",
    legs="Heathen's Flanchard +2",
    feet="Heathen's Sollerets +3",
    neck="Erra Pendant",
    waist="Eschan Stone",
    ear1="Malignance Earring",
    ear2=gear.jse_ear,
    ring1="Stikini Ring +1",
    ring2="Metamorph Ring +1",
    back=gear.jse_back_nuke,
    
    -- hands="Heathen's Gauntlets +3",
    -- legs="Heathen's Flanchard +3",
  }
  
  sets.midcast.Poison = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Poisonga = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Sleep = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Bind = set_combine(sets.midcast['Enfeebling Magic'],{})
  sets.midcast.Break = set_combine(sets.midcast['Enfeebling Magic'],{})
  
  -- TODO
  sets.midcast['Elemental Magic'] = {
    ammo="Pemphredo Tathlum",
    head="Nyame Helm",
    body="Fallen's Cuirass +3",
    hands="Fallen's Finger Gauntlets +3",
    legs="Nyame Flanchard",
    feet="Heathen's Sollerets +3",
    neck="Sanctity Necklace",
    waist="Skrymir Cord +1",
    ear1="Malignance Earring",
    ear2="Friomisi Earring",
    ring1="Shiva Ring +1",
    ring2="Metamorph Ring +1",
    back=gear.jse_back_nuke,
  }

  -- TODO
  sets.MagicBurst = set_combine(sets.midcast['Elemental Magic'],{ring1="Mujin Band"})

  -- TODO
  sets.midcast['Dark Magic'] = {
    ammo="Pemphredo Tathlum",
    head="Ignominy Burgeonet +3", 
    body="Carmine Scale Mail +1",
    hands="Fallen's Finger Gauntlets +3",
    legs="Heathen's Flanchard +2",
    feet="Ratri Sollerets +1", 
    neck="Incanter's Torque", 
    waist="Eschan Stone",
    ear1="Mani Earring",
    ear2="Dark Earring",
    ring1="Stikini Ring +1",
    ring2="Evanescence Ring",
    back=gear.jse_back_nuke,

    -- legs="Heathen's Flanchard +3",
  }
  sets.midcast.Bio = set_combine(sets.midcast['Dark Magic'],{})

  -- TODO
  sets.midcast['Dread Spikes'] = {
    ammo="Egoist's Tathlum", 
    head="Ratri Sallet +1",
    body="Heathen's Cuirass +3",
    hands="Ratri Gadlings +1",
    legs="Ratri Cuisses +1",
    feet="Ratri Sollerets +1",
    neck="Unmoving Collar +1",
    waist="Platinum Moogle Belt",
    ear1="Odnowa Earring +1",
    ear2="Tuisto Earring",
    ring1="Moonlight Ring",
    ring2="Gelatinous Ring +1",
    back="Moonlight Cape"
  }

  -- TODO
  sets.DreadSpikesWeapon = {
    main="Crepuscular Scythe",
    sub="Utu Grip",
    ammo="Egoist's Tathlum"
  }

  -- TODO
  sets.midcast.Endark ={
    ammo="Pemphredo Tathlum",
    head="Ignominy Burgonet +3", 
    body="Carmine Scale Mail +1",
    hands="Fallen's Finger Gauntlets +3",
    legs="Heathen's Flanchard +2",
    feet="Ratri Sollerets +1",
    neck="Erra Pendant",
    waist="Casso Sash",
    ear1="Mani Earring",
    ear2="Dark Earring",
    ring1="Stikini Ring +1",
    ring2="Evanescence Ring",
    back=gear.jse_reive,
    
    -- legs="Heathen's Flanchard +3",
  }
  sets.midcast['Endark II'] = set_combine(sets.midcast.Endark,{})

  -- TODO
  sets.midcast.Absorb = {
    head="Ignominy Burgeonet +3", 
    body="Carmine Scale Mail +1",
    hands="Pavor Gauntlets",
    legs="Fallen's Flanchard +3",
    feet="Ratri Sollerets +1", 
    neck="Erra Pendant", 
    waist="Casso Sash",
    ear1="Mani Earring",
    ear2="Dark Earring",
    ring1="Kishar Ring",
    ring2="Stikini Ring +1",
    back="Chuparrosa Mantle"
  }

  -- TODO
  sets.AbsorbWeapon = {
    main="Liberator",
    sub="Khonsu",
    range="Ullr"
  }
  
  -- TODO
  sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb,{
    hands="Heathen's Gauntlets +2",
    feet="Ignominy Sollerets +3",
    ring1="Stikini Ring +1",
    back=gear.jse_back_fc,
    
    -- hands="Heathen's Gauntlets +3",
  })
  sets.midcast['Absorb-Attri'] = set_combine(sets.midcast.Absorb,{})
  
  -- TODO
  sets.midcast.Drain = {
    sub="Dark Grip",
    range="Ullr",
    head="Fallen's Burgeonet +3",
    body="Carmine Scale Mail +1",
    hands="Fallen's Finger Gauntlets +3",
    legs="Fallen's Flanchard +3",
    feet="Ignominy Sollerets +3", 
    neck="Erra Pendant",
    waist="Orpheus's Sash",
    ear1="Hirudinea Earring",
    ear2="Nehalennia Earring",
    ring1="Archon Ring",
    ring2="Evanescence Ring",
    back=gear.jse_reive,
  }
  
  -- TODO
  sets.DrainWeapon = {
    main="Father Time",
    sub="Dark Grip",
    range="Ullr"
  }
  
  -- TODO
  sets.midcast.Aspir = set_combine(sets.midcast.Drain,{})
  
  -- TODO
  sets.midcast.Impact = {
    range="Ullr",
    body="Crepuscular Cloak",
    hands="Heathen's Gauntlets +2",
    legs="Heathen's Flanchard +2",
    feet="Heathen's Sollerets +3",
    neck="Erra Pendant",
    waist="Eschan Stone",
    ear1="Malignance Earring",
    ear2=gear.jse_ear,
    ring1="Stikini Ring +1",
    ring2="Metamorph Ring +1",
    back=gear.jse_reive,
    
    -- hands="Heathen's Gauntlets +3",
    -- legs="Heathen's Flanchard +3",
  }
  
  -- TODO
  sets.midcast.Stun = {
    ammo="Pemphredo Tathlum",
    head="Carmine Mask +1",
    body="Ratri Plate +1",
    hands="Raetic Bangles +1",
    legs="Ratri Cuisses +1",
    feet="Ignominy Sollerets +3", 
    neck="Erra Pendant",
    waist="Tempus Fugit +1",
    ear1="Malignance Earring",
    ear2="Dignitary's Earring",
    ring1="Stikini Ring +1",
    ring2="Stikini Ring +1",
    back=gear.jse_back_nuke,
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- TODO
  sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Breastplate",
    hands="Heathen's Gauntlets +2",
    legs="Heathen's Flanchards +2",
    feet="Sakpata's Leggings",
    neck="Abyssal Beads +2",
    ear1="Odnowa Earring +1",
    ear2="Arete Del Luna +1",
    ring1="Moonlight Ring",
    ring2="Gelatinous Ring +1",
    back="Moonlight Cape",
    waist="Carrier's Sash",

    -- hands="Heathen's Gauntlets +3",
    -- legs="Heathen's Flanchards +3",
  }
  sets.defense.MDT = set_combine(sets.defense.PDT, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Valorous Mask",       -- 3
    -- head="Ratri Sallet +1",  -- 5
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
    -- ring2="Chirich Ring +1",
    -- body="Sacro Breastplate", --10
  }
  sets.latent_refresh = {
    neck="Sibyl Scarf", -- Must be Windurstian
    ring1="Stikini Ring +1"
  }

  sets.idle = set_combine(sets.defense.PDT, {})

  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)

  sets.idle.HeavyDef = set_combine(sets.defense.PDT, {})

  sets.idle.Weak = set_combine(sets.defense.PDT, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged = {
    ammo="Coiste Bodhar",             -- [__/__, ___]  3 < 3, __, __> __, __
    head="Flamma Zucchetto +2",       -- [__/__,  53]  6 <__,  5, __> __,  4
    body="Hjarrandi Breastplate",     -- [12/12,  69] 10 <__, __, __> 13, __
    hands="Sakpata's Gauntlets",      -- [ 8/ 8, 112]  8 < 6, __, __> __,  4
    -- legs="Ignominy Flanchard +3",  -- [__/__,  84] __ <10, __, __> __,  5
    feet="Flamma Gambieras +2",       -- [__/__,  86]  6 < 6, __, __> __,  2
    -- neck="Abyssal Beads +2",       -- [__/__, ___]  7 <__, __, __>  4, __
    ear1="Schere Earring",            -- [__/__, ___]  5 < 6, __, __> __, __
    ear2="Dedition Earring",          -- [__/__, ___]  8 < 1, __, __> __, __
    ring1="Moonlight Ring",           -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Moonlight Ring",           -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- back=gear.DRK_STP_Cape,        -- [10/__, ___] 10 <__, __, __> __, __
    waist="Sailfi Belt +1",           -- [__/__, ___] __ < 5,  2, __> __,  9
    -- [40 PDT/30 MDT, 404 MEVA] 73 STP <37 DA, 7 TA, 0 QA> 17 Crit Rate, 24 Haste
  }
  -- TODO
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ear2="Telos Earring",             -- [__/__, ___]  5 < 1, __, __> __, __
  })
  -- TODO
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
  })
  -- TODO
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
  })

  -- TODO
  sets.engaged.LowDW = set_combine(sets.engaged,{
    ear2="Eabani Earring",
    -- back=gear.DRK_DW_Cape,
  })
  sets.engaged.MidDW = set_combine(sets.engaged.LowDW, {})
  -- TODO
  sets.engaged.HighDW = set_combine(sets.engaged.LowDW, {})
  -- TODO
  sets.engaged.SuperDW = set_combine(sets.engaged.LowDW, {})
  -- TODO
  sets.engaged.MaxDW = set_combine(sets.engaged.LowDW, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = {
    ammo="Coiste Bodhar",             -- [__/__, ___]  3 < 3, __, __> __, __
    head="Flamma Zucchetto +2",       -- [__/__,  53]  6 <__,  5, __> __,  4
    body="Hjarrandi Breastplate",     -- [12/12,  69] 10 <__, __, __> 13, __
    hands="Sakpata's Gauntlets",      -- [ 8/ 8, 112]  8 < 6, __, __> __,  4
    legs="Sakpata's Cuisses",         -- [ 9/ 9, 150] __ < 7, __, __> __,  4
    feet="Flamma Gambieras +2",       -- [__/__,  86]  6 < 6, __, __> __,  2
    -- neck="Abyssal Beads +2",       -- [__/__, ___]  7 <__, __, __>  4, __
    ear1="Schere Earring",            -- [__/__, ___]  5 < 6, __, __> __, __
    ear2="Dedition Earring",          -- [__/__, ___]  8 < 1, __, __> __, __
    ring1="Moonlight Ring",           -- [ 5/ 5, ___]  5 <__, __, __> __, __
    ring2="Moonlight Ring",           -- [ 5/ 5, ___]  5 <__, __, __> __, __
    -- back=gear.DRK_STP_Cape,        -- [10/__, ___] 10 <__, __, __> __, __
    waist="Sailfi Belt +1",           -- [__/__, ___] __ < 5,  2, __> __,  9
    -- [49 PDT/39 MDT, 470 MEVA] 73 STP <34 DA, 7 TA, 0 QA> 17 Crit Rate, 23 Haste
  }
  -- TODO
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LightDef, {})
  -- TODO
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.LightDef, {})
  -- TODO
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.LightDef, {})
  
  -- TODO
  sets.engaged.LowDW.LightDef = set_combine(sets.engaged.LightDef,{
    ear2="Eabani Earring",
    -- back=gear.DRK_DW_Cape,
  })
  sets.engaged.MidDW.LightDef = set_combine(sets.engaged.LowDW.LightDef, {})
  -- TODO
  sets.engaged.HighDW.LightDef = set_combine(sets.engaged.LowDW.LightDef, {})
  -- TODO
  sets.engaged.SuperDW.LightDef = set_combine(sets.engaged.LowDW.LightDef, {})
  -- TODO
  sets.engaged.MaxDW.LightDef = set_combine(sets.engaged.LowDW.LightDef, {})

  sets.engaged.SubtleBlow = {
    ammo="Seething Bomblet +1",           -- [__/__, ___] __ <__, __, __> __,  5, __(__)
    head="Sakpata's Helm",                -- [ 7/ 7, 123] __ < 5, __, __> __,  4, __(__)
    body="Dagon Breastplate",             -- [__/__,  86] __ <__,  5, __>  4,  1, __(10)
    hands="Sakpata's Gauntlets",          -- [ 8/ 8, 112]  8 < 6, __, __> __,  4,  8(__)
    legs="Sakpata's Cuisses",             -- [ 9/ 9, 150] __ < 7, __, __> __,  4, __(__)
    feet="Sakpata's Leggings",            -- [ 6/ 6, 150] __ < 4, __, __> __,  2, 13(__)
    neck="Loricate Torque +1",            -- [ 6/ 6, ___] __ <__, __, __> __, __, __(__)
    ear1="Schere Earring",                -- [__/__, ___]  5 < 6, __, __> __, __,  3(__)
    ear2="Telos Earring",                 -- [__/__, ___]  5 < 1, __, __> __, __, __(__)
    ring1="Chirich Ring +1",              -- [__/__, ___]  6 <__, __, __> __, __, 10(__)
    ring2="Niqmaddu Ring",                -- [__/__, ___] __ <__, __,  3> __, __, __( 5)
    back=gear.DRK_STP_Cape,               -- [10/__, ___] 10 <__, __, __> __, __, __(__)
    waist="Peiste Belt +1",               -- [__/__, ___] __ <__, __, __> __, __, 10(__)
    -- [46 PDT/36 MDT, 621 MEVA] 34 STP <29 DA, 5 TA, 3 QA> 4 Crit Rate, 20 Haste, 44(15) Subtle Blow
  }
  -- TODO
  sets.engaged.LowAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  -- TODO
  sets.engaged.MidAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})
  -- TODO
  sets.engaged.HighAcc.SubtleBlow = set_combine(sets.engaged.SubtleBlow, {})

  -----------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}
  sets.Special.Sleepyhead = { neck="Vim Torque +1", }
  sets.Special.LowEnmity = { ear2="Novia Earring", } -- Assumes -Enmity merits and Dirge
  sets.Special.Schere = { ear2="Schere Earring", }

  -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
  sets.buff.Doom = {
    neck="Nicander's necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }
  sets.Kiting = {
    legs=gear.Carmine_A_legs,
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.CP = {
    back=gear.CP_Cape,
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1"
  }
  sets.TreasureHunter = {
    ammo="Perfect Lucky Egg", --1
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }
  sets.TreasureHunter.RA = {
    hands="Volte Bracers", --1
    waist="Chaac Belt", --1
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Naegling'].DW = {
    main="Naegling",
    sub="Ternion Dagger +1",
    -- sub="Sangarius +1",
  }
  sets.WeaponSet['Anguta'] = {
    main="Anguta",
    sub="Utu Grip",
  }
  sets.WeaponSet['Apocalypse'] = {
    main="Apocalypse",
    sub="Utu Grip",
  }
  sets.WeaponSet['Caladbolg'] = {
    main="Caladbolg",
    sub="Utu Grip",
  }
  sets.WeaponSet['Club'] = {
    main="Loxotic Mace +1",
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Club'].DW = {
    main="Loxotic Mace +1",
    sub="Ternion Dagger +1",
    -- sub="Sangarius +1",
  }
  sets.WeaponSet['Dagger'] = {
    main=gear.Malevolence_1,
    sub="Blurred Shield +1",
  }
  sets.WeaponSet['Dagger'].DW = {
    main=gear.Malevolence_1,
    sub=gear.Malevolence_2,
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
    -- Don't gearswap for weaponskills when Defense is on.
    if state.DefenseMode.current ~= 'None' then
      eventArgs.handled = true
    elseif buffactive['Sekkanoki'] then
      equip(sets.precast.JA['Sekkanoki'])
    end
  end

  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spell.type == 'WeaponSkill' then
    if buffactive['Reive Mark'] then
      equip(sets.Reive)
    end

    if state.EnmityMode.current == 'Low' then
      equip(sets.Special.LowEnmity)
    elseif state.EnmityMode.current == 'Schere' and player.mp > 0 then
      equip(sets.Special.Schere)
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
  if spell.english == 'Warcry' and not spell.interrupted then
    warcry_self = true
  end

  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)
  classes.CustomMeleeGroups:clear()

  if buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.Special.Sleepyhead)
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "doom" then
    status_change(player.status)
  end

  if buff == "Aftermath: Lv.3" then
    if gain then
        send_command('timers create "Aftermath Tier III" 180 down')
        send_command('input /echo Tier III Aftermath!!!')
    else
        send_command('timers delete "Aftermath Tier III";gs c -cd AM3 Lost!!!')
        send_command('input /echo Tier III Aftermath OFF!!!')
    end
  end
  if buff == "Aftermath: Lv.2" then
      if gain then
          send_command('timers create "Aftermath Tier II" 120 down')
          send_command('input /echo Tier II Aftermath!!')
      else
          send_command('timers delete "Aftermath Tier II";gs c -cd AM3 Lost!!!')
      end
  end
  if buff == "Aftermath: Lv.1" then
      if gain then
          send_command('timers create "Aftermath Tier I" 60 down')
          send_command('input /echo Tier I Aftermath!')
      else
          send_command('timers delete "Aftermath Tier I";gs c -cd AM3 Lost!!!')
      end
  end

  if buff == 'Warcry' and not gain and warcry_self then
    warcry_self = false
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_melee_groups()
  update_combat_form()
end

function update_combat_form()
  if silibs.get_dual_wield_needed() <= 0 or not silibs.is_dual_wielding() then
    state.CombatForm:reset()
    
    if player and player.equipment and player.equipment.main and player.equipment.main ~= 'empty' then
      for weapon,am_list in pairs(activate_AM_mode) do
        if player.equipment.main == weapon or player.equipment.ranged == weapon then
          for am_level,_ in pairs(am_list) do
            if buffactive[am_level] then
              state.CombatForm:set(weapon..'AM')
              break
            end
          end
        end
      end
    end
  else
    if silibs.get_dual_wield_needed() > 0 and silibs.get_dual_wield_needed() <= 6 then
      state.CombatForm:set('LowDW')
    elseif silibs.get_dual_wield_needed() > 6 and silibs.get_dual_wield_needed() <= 13 then
      state.CombatForm:set('MidDW')
    elseif silibs.get_dual_wield_needed() > 13 and silibs.get_dual_wield_needed() <= 26 then
      state.CombatForm:set('HighDW')
    elseif silibs.get_dual_wield_needed() > 26 and silibs.get_dual_wield_needed() <= 37 then
      state.CombatForm:set('SuperDW')
    elseif silibs.get_dual_wield_needed() > 37 then
      state.CombatForm:set('MaxDW')
    end
  end
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local ws_msg = (state.AttCapped.value and 'AttCapped') or state.WeaponskillMode.value

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

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

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,012).. ' Toy Weapon: ' ..string.char(31,001)..toy_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

function select_weapons()
  if state.ToyWeapons.current ~= 'None' then
    return sets.ToyWeapon[state.ToyWeapons.current]
  else
    if sets.WeaponSet[state.WeaponSet.current] then
      if use_dw_if_available and silibs.can_dual_wield() and sets.WeaponSet[state.WeaponSet.current].DW then
        return sets.WeaponSet[state.WeaponSet.current].DW
      else
        return sets.WeaponSet[state.WeaponSet.current]
      end
    end
  end
end

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
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
  equip(select_weapons())
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  -- Determine if attack capped
  if state.AttCapped.value then
    wsmode = 'AttCapped'

    if state.CombatForm.value == 'FoenariaAM' then
      wsmode = wsmode..'PrimeAM'
    end

    if buffactive['Aria'] then
      wsmode = wsmode..'Aria'
    end
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
    warcry_self and 700 or 0,
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  local trait_bonus = T{
    calc_fencer_tp_bonus()
  }:sum()
  if player.tp > 3000-tp_bonus_from_weapons-buff_bonus-trait_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

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
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if state.EnmityMode.current == 'Low' then
    equip(sets.Special.LowEnmity)
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive['sleep'] and player.vitals.hp > 500 and player.status == 'Engaged' then
    meleeSet = set_combine(meleeSet, sets.Special.Sleepyhead)
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
    defenseSet = set_combine(defenseSet, sets.Special.Sleepyhead)
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

function update_melee_groups()
  if player then
    classes.CustomMeleeGroups:clear()

    if state.Buff['Brazen Rush'] or state.Buff["Warrior's Charge"] then
      classes.CustomMeleeGroups:append('Charge')
    end

    if state.Buff['Mighty Strikes'] then
      classes.CustomMeleeGroups:append('Mighty')
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
  set_macro_page(2, 14)
end

-- Calculate Fencer tier. Fencer active if not two-handed weapon, and offhand is empty or shield.
function calc_fencer_tier()
  local fencer = 0
  local main_weapon_skill = res.items:with('en', player.equipment.main).skill
  if not skill_ids_2h:contains(main_weapon_skill) then
    if player.equipment.sub == 'empty' then
      fencer = 5
    else
      local is_using_shield = res.items:with('en', player.equipment.sub).category == 'Armor'
      if is_using_shield then
        fencer = 5
        if player.equipment.sub == 'Blurred Shield +1' then
          fencer = fencer + 1
        end
      end
    end
  end
  if fencer > 0 then
    -- Can also assume any single handed ws will use JSE neck for another fencer+1
    fencer = fencer + 1
  end
  -- Fencer caps at level 8
  return math.min(fencer, 8)
end

function calc_fencer_tp_bonus()
  local total_fencer_tp_bonus = 0
  local fencer_tier = calc_fencer_tier()
  if fencer_tier > 0 then
    -- Add Fencer TP bonus based on base trait
    total_fencer_tp_bonus = fencer_tp_bonus[fencer_tier]
    -- Add TP Bonus based on JP gifts
    local jp_spent = player.job_points.war.jp_spent
    if jp_spent >= 1805 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 230
    elseif jp_spent >= 980 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 160
    elseif jp_spent >= 405 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 100
    elseif jp_spent >= 80 then
      total_fencer_tp_bonus = total_fencer_tp_bonus + 50
    end
  end
  return total_fencer_tp_bonus
end

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind !e input /ja "Hasso" <me>')
  send_command('bind !q input /ja "Meditate" <me>')
end

function set_sub_keybinds()
  if player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind ^numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind ^numpad. input /ma "Utsusemi: Ni" <me>')
  elseif player.sub_job == 'DRG' then
    send_command('bind !w input /ja "Ancient Circle" <me>')
    send_command('bind ^numpad/ input /ja "Jump" <t>')
    send_command('bind ^numpad* input /ja "High Jump" <t>')
    send_command('bind ^numpad- input /ja "Super Jump" <t>')
  end
end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind @c')
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind ^f8')
end

function test()
end
