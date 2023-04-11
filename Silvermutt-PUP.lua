-- File Status: Ok, could use a little work on convenience features.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: N/A
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable RollTracker

-------------------------------------------------------------------------------------------------------------------
-- Notes about this specific lua
-------------------------------------------------------------------------------------------------------------------
-- With my attachments, I only need 21% Pet DT to cap when using tank mode. I will aim for that in all sets that do
-- not have a specific set based on pet mode. The minimum attachments/frame for this are:
-- Valoredge frame (12.5%), Armor Plate II (10%), Armor Plate IV (20%), Optic Fiber, Optic Fiber II
-- Optic fibers will add -15% DT with these armor plates and 1 light maneuver, and remember you get -9% DT from
-- Stout Servant III trait.

-- The intended use for pet is to set your pet mode using the cycle before summoning the pet. You cannot change
-- mode while pet is active (because the game restricts you from changing attachments when pet is active).

-- You can add or remove pet modes from the cycle but if you add, you should also make sure there is a corresponding
-- set name in AutoControl addon so it can equip the proper attachments. You should also add a corresponding entry
-- to the defaultManeuvers table, and sets for sets.idle.PetEngaged.NewNameHere, sets.engaged.Pet.NewNameHere, and
-- sets.engaged.Halfsies.NewNameHere (the additional .Acc sets are optional).

-- For Overdrive, it is expected that you will manually deactivate your pet, change pet mode to the appropriate
-- pet mode (I only have one set for it called OverdriveDD), reactivate your pet, then use the Overdrive JA.
-- It is also expected that you will deactivate the pet, change pet mode, and reactivate again after Overdrive.

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
    is_setting_attachments = false
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
  state.CP = M(false, 'Capacity Points Mode')
  state.AutomaticPetTargeting = M(true, 'Automatic Pet Targeting')

  state.PetMode = M{['description']='Pet Mode', 'Tank', 'Ranged', 'RangedAcc', 'Heal', 'MeleeSpam', 'MeleeSC', 'DD',}

  -- List of pet weaponskills to check for
  petWeaponskills = S{'Slapstick', 'Knockout', 'Magic Mortar', 'Chimera Ripper', 'String Clipper', 'Cannibal Blade',
      'Bone Crusher', 'String Shredder', 'Arcuballista', 'Daze', 'Armor Piercer', 'Armor Shatterer'}

  -- Default maneuvers for each pet mode. Table keys must match PetMode values. Must have 1 for each mode.
	defaultManeuvers = {
		Tank =        { Light=1, Dark=0, Fire=2, Ice=0, Wind=0, Earth=0, Lightning=0, Water=0 },
		Ranged =      { Light=0, Dark=0, Fire=0, Ice=0, Wind=3, Earth=0, Lightning=0, Water=0 },
		RangedAcc =   { Light=0, Dark=0, Fire=0, Ice=0, Wind=3, Earth=0, Lightning=0, Water=0 },
		Heal =        { Light=2, Dark=1, Fire=0, Ice=0, Wind=0, Earth=0, Lightning=0, Water=0 },
		MeleeSpam =   { Light=0, Dark=0, Fire=2, Ice=0, Wind=1, Earth=0, Lightning=0, Water=0 },
		MeleeSC =     { Light=0, Dark=0, Fire=2, Ice=0, Wind=1, Earth=0, Lightning=0, Water=0 },
		OverdriveDD = { Light=1, Dark=0, Fire=1, Ice=0, Wind=0, Earth=0, Lightning=1, Water=0 },
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

  -- TODO: Determine pet's initial mode if already summoned
  check_initial_maneuvers()
  set_main_keybinds()
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  if S{'THF','DNC','RDM','BRD','RNG','NIN'}:contains(player.sub_job) then
    state.WeaponSet = M{['description']='Weapon Set', 'Kenkonken', 'Verethragna', 'Cleaving'}
  else
    state.WeaponSet = M{['description']='Weapon Set', 'Kenkonken', 'Verethragna'}
  end

  select_default_macro_book()
  set_sub_keybinds()
end

function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  -- Pet DT options [PDT/MDT, M.Eva] {Pet: PDT/MDT, Level}:
  -- head="Hike Khat +1",             -- [13/__,  75] { 5/ 5, ___}
  -- head=gear.Anwig_Salade,          -- [__/__, ___] {10/10, ___}
  -- head=gear.Taeon_Pet_DT_head,     -- [__/__,  73] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- body=gear.Taeon_Pet_DT_body,     -- [__/__,  84] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- hands=gear.Taeon_Pet_DT_hands,   -- [__/__,  57] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
  -- legs="Foire Churidars +3",       -- [__/__, 104] { 6/ 6, ___}
  -- legs="Tali'ah Seraweels +2",     -- [__/__,  69] { 5/ 5, ___}
  -- legs=gear.Taeon_Pet_DT_legs,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- feet=gear.Taeon_Pet_DT_feet,     -- [__/__,  89] { 4/ 4, ___}; Augs: +20 M.Eva, -4 Pet DT
  -- feet="Mpaca's Boots",            -- [ 6/__,  96] {__/__,   1}
  -- neck="Shepherd's Chain",         -- [__/__, ___] { 2/ 2, ___}
  -- ear1="Handler's Earring +1",     -- [__/__, ___] { 4/__, ___}
  -- ear1="Enmerkar Earring",         -- [__/__, ___] { 3/ 3, ___}
  -- ear1="Hypaspist Earring",        -- [-5/__, ___] { 5/__, ___}
  -- ear1="Rimeice Earring",          -- [__/__, ___] { 1/ 1, ___}
  -- ear2="Karagoz Earring +2",       -- [__/__, ___] {__/__,   1}
  -- ring1="Thurandaut Ring +1",      -- [__/__, ___] { 4/ 4, ___}; Adoulin ring
  -- back=gear.PUP_ambu_cape,         -- [__/__, ___] { 5/ 5,   1}
  -- waist="Isa Belt",                -- [__/__, ___] { 3/ 3, ___}

  sets.TreasureHunter = {
    body=gear.Herc_TH_body, --2
    hands=gear.Herc_TH_hands, --2
  }
  sets.TreasureHunter.RA = set_combine(sets.TreasureHunter, {})

  -- TODO: Hook up lua to actually equip this set
  -- This set is specifically for Strobe & Flashbulb
  sets.PetEnmity = {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __}
    ammo="Automat. Oil +3",           -- [__/__, ___] {__/__, ___ | __}
    head="Heyoka Cap +1",             -- [__/__, 101] {__/__, ___ | 10}
    body="Heyoka Harness +1",         -- [__/__, 117] {__/__, ___ | 12}
    hands="Heyoka Mittens +1",        -- [__/__,  90] {__/__, ___ |  9}
    legs="Heyoka Subligar +1",        -- [__/__, 139] {__/__, ___ | 11}
    feet="Heyoka Leggings +1",        -- [__/__, 139] {__/__, ___ |  8}
    neck="Loricate Torque +1",        -- [ 6/ 6, ___] {__/__, ___ | __}
    ear1="Domesticator's Earring ",   -- [__/__, ___] {__/__, ___ |  5}
    ear2="Rimeice Earring",           -- [__/__, ___] { 1/ 1, ___ |  5}
    ring1="Gelatinous Ring +1",       -- [ 7/-1, ___] {__/__, ___ | __}
    ring2="Defending Ring",           -- [10/10, ___] {__/__, ___ | __}
    back=gear.PUP_Pet_Engaged_Cape,   -- [__/__, ___] { 5/ 5,   1 | __}
    waist="Moonbow Belt +1",          -- [ 6/ 6, ___] {__/__, ___ | __}
    -- [29 PDT/21 MDT, 586 M.Eva] {Pet: 6 PDT/6 MDT, 120 Lv | 60 Enmity}
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Your Auto starts off with Burden, to help reduce the burden equip Overload- gear.
  sets.precast.JA['Activate'] = {
    range="Neo Animator",             -- __, __ [__/__, ___] {__/__, 119}
    head="Hike Khat +1",              -- __, __ [13/__,  75] { 5/ 5, ___}
    body="Karagoz Farsetto +3",       -- 40, __ [13/13, 109] {__/__, ___}
    hands="Foire Dastanas +3",        --  5,  5 [__/__,  46] {__/__, ___}
    legs="Foire Churidars +3",        -- __, __ [__/__,  84] { 6/ 6, ___}
    feet="Mpaca's Boots",             -- __, __ [ 6/__,  96] {__/__,   1}
    neck="Buffoon's Collar +1",       --  5, __ [__/__, ___] {__/__, ___}
    ear1="Burana Earring",            -- __,  1 [__/__, ___] {__/__, ___}
    ear2="Karagoz Earring +2",        -- __, __ [__/__, ___] {__/__,   1}
    ring1="Gelatinous Ring +1",       -- __, __ [ 7/-1, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __ [10/10, ___] {__/__, ___}
    back=gear.PUP_Pet_Engaged_Cape,   -- 10, __ [__/__, ___] { 5/ 5,   1}
    waist="Isa Belt",                 -- __, __ [__/__, ___] { 3/ 3, ___}
    -- 60 Overload-, 6 Maneuver+ [49 PDT/22 MDT, 410 M.Eva] {Pet: 19 PDT/19 MDT, 122 Lv+}
  }
  sets.precast.JA['Deus Ex Automata'] = set_combine(sets.precast.JA['Activate'], {})
  sets.precast.JA['Maneuver'] = set_combine(sets.precast.JA['Activate'], {})

  -- Pet HP+ can help increase healing, but you will only get 40% of that restored as
  -- HP, which is insignificant. It is not worth shoehorning in pet HP pieces just for
  -- that purpose, if you have to sacrifice other important stats.
	sets.precast.JA['Repair'] = {
    range="Neo Animator",             -- __, __ [__/__, ___] {__/__, 119 |  60}
    ammo="Automaton Oil +3",          -- __, __ [__/__, ___] {__/__, ___ | ___}
    head="Hike Khat +1",              -- __, __ [13/__,  75] { 5/ 5, ___ | ___}
    body=gear.Taeon_Pet_DT_body,      -- __, __ [__/__,  84] { 4/ 4, ___ | ___}; Augs: +20 M.Eva, -4 Pet DT
    hands=gear.Herc_Repair_hands,     -- __,  8 [ 2/__,  43] {__/__, ___ | ___}
    legs=gear.Herc_Repair_legs,       -- __,  8 [ 2/__,  75] {__/__, ___ | ___}
    feet="Foire Babouches +3",        --  3, __ [__/__,  87] {__/__, ___ | ___}
    neck="Loricate Torque +1",        -- __, __ [ 6/ 6, ___] {__/__, ___ | ___}
    ear1="Pratik Earring",            -- __, 10 [__/__, ___] {__/__, ___ | ___}
    ear2="Guignol Earring",           -- __, 20 [__/__, ___] {__/__, ___ | ___}
    ring1="Gelatinous Ring +1",       -- __, __ [ 7/-1, ___] {__/__, ___ | ___}
    ring2="Defending Ring",           -- __, __ [10/10, ___] {__/__, ___ | ___}
    back=gear.PUP_Pet_Engaged_Cape,   -- __, __ [__/__, ___] { 5/ 5,   1 | ___}
    waist="Isa Belt",                 -- __, __ [__/__, ___] { 3/ 3, ___ | ___}
    -- 3 Repair+, 46 Repair Potency [40 PDT/15 MDT, 364 M.Eva] {Pet: 17 PDT/17 MDT, 120 Lv | 60 HP}

    -- ring1="Cath Palug Ring",       -- __, __ [ 5/ 5, ___] {__/__, ___ | ___}
    -- 3 Repair+, 46 Repair Potency [38 PDT/21 MDT, 364 M.Eva] {Pet: 17 PDT/17 MDT, 120 Lv | 60 HP}
  }

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

  -- TODO: update
  sets.precast.Waltz = {
    body="Passion Jacket",
  }

  -- TODO: update
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
  -- TODO: update
  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    neck="Magoraga Beads"
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Master WS Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    ranged="Neo Animator",            -- __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, __ < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body="Kendatsuba Samue +1",       -- 33, __ <__,  6, __> [__/__, 117] {__/__, ___}
    hands=gear.Herc_TA_hands,         -- 16, __ <__,  6, __> [ 2/__,  43] {__/__, ___}
    legs="Mpaca's Hose",              -- 49, __ <__,  4, __> [ 9/__,  96] {__/__, ___}
    feet=gear.Herc_TA_feet,           -- 16, __ <__,  6, __> [ 2/__,  75] {__/__, ___}
    neck="Fotia Gorget",              -- __, __ <__, __, __> [__/__, ___] {__/__, ___}; ftp+
    ear1="Schere Earring",            --  5, __ < 6, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Niqmaddu Ring",            -- 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.PUP_STR_DA_Cape,        -- 30, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 212 STR, 5 WSD <21 DA, 33 TA, 3 QA> [36 PDT/16 MDT, 400 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Brutal Earring",            -- __, __ < 5, __, __> [__/__, ___] {__/__, ___}
  })

  -- Victory Smite: 80% STR, 1.5 fTP, 4 hit, can crit, ftp replicating
  -- crit dmg > TP Bonus = crit rate > multihit
  -- 1000 TP bonus = ~15% crit rate
  sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __, __ <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, __,  5 < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body="Kendatsuba Samue +1",       -- 33, __,  9 <__,  6, __> [__/__, 117] {__/__, ___}
    hands=gear.Ryuo_A_hands,          -- 24,  5,  5 <__, __, __> [__/__, ___] {__/__, ___}
    legs="Mpaca's Hose",              -- 49, __,  6 <__,  4, __> [ 9/__,  96] {__/__, ___}
    feet=gear.Herc_DEX_CritDmg_feet,  -- 16,  3, __ <__,  2, __> [ 2/__,  75] {__/__, ___}
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___] {__/__, ___}
    ear1="Odr Earring",               -- __, __,  5 <__, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Sroda Ring",               -- 15, __, __ <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.PUP_STR_Crit_Cape,      -- 30, __, 10 <__, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 220 STR, 8 Crit Dmg, 40 Crit Rate <5 DA, 23 TA, 0 QA> [40 PDT/22 MDT, 357 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}

    -- feet=gear.Herc_STR_CritDmg_feet,
  })
  sets.precast.WS["Victory Smite"].MaxTP = set_combine(sets.precast.WS["Victory Smite"], {
    ear2="Schere Earring",            --  5, __, __ < 6, __, __> [__/__, ___] {__/__, ___}
  })

  -- 32% STR / 32% VIT - Chance of Critical varies w/ TP (Mythic WS)
  sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS['Victory Smite'], {})
  sets.precast.WS['Stringing Pummel'].MaxTP = set_combine(sets.precast.WS['Victory Smite'].MaxTP, {})

  -- Shijin Spiral: 100% DEX, 1.5 fTP, 5 hit, ftp replicating
  -- DEX > multihit > WSD
  sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Kendatsuba Jinpachi +1",    -- 47, __ <__,  4, __> [__/__, 101] {__/__, ___}
    body="Malignance Tabard",         -- 49, __ <__, __, __> [ 9/ 9, 139] {__/__, ___}
    hands="Malignance Gloves",        -- 56, __ <__, __, __> [ 5/ 5, 112] {__/__, ___}
    legs="Mpaca's Hose",              -- __, __ <__,  4, __> [__/__,  96] {__/__, ___}
    feet="Kendatsuba Sune-Ate +1",    -- 44, __ <__,  4, __> [__/__, 139] {__/__, ___}
    neck="Loricate Torque +1",        -- __, __ <__, __, __> [ 6/ 6, ___] {__/__, ___}
    ear1="Odr Earring",               -- 10, __ <__, __, __> [__/__, ___] {__/__, ___}
    ear2="Schere Earring",            -- __, __ < 6, __, __> [__/__, ___] {__/__, ___}
    ring1="Niqmaddu Ring",            -- 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___}
    back=gear.PUP_DEX_DA_Cape,        -- 30, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 266 DEX, 5 WSD <16 DA, 20 TA, 3 QA> [36 PDT/36 MDT, 587 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}

    -- ear2="Karagoz Earring +2",     -- 15, __ <__, __, __> [__/__, ___] {__/__,   1}
  })
  sets.precast.WS["Shijin Spiral"].MaxTP = set_combine(sets.precast.WS["Shijin Spiral"], {})
  
  -- Asuran Fists: 15% STR / 15% VIT, 1.25 fTP, 8 hit, ftp replicating
  -- WSD > STR/VIT
  sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __,  5 [__/__, ___] {__/__, 119}
    head=gear.Nyame_B_head,           -- 26, 24, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 45, 45, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 17, 54, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 30, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 24, 11 [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ [__/__, ___] {__/__, ___}; ftp+
    ear1="Enmerkar Earring",          -- __, __, __ [__/__, ___] { 3/ 3, ___}
    ear2="Ishvara Earring",           -- __, __,  2 [__/__, ___] {__/__, ___}
    ring1="Epaminondas's Ring",       -- __, __,  5 [__/__, ___] {__/__, ___}
    ring2="Niqmaddu Ring",            -- 10, 10, __ [__/__, ___] {__/__, ___}
    back=gear.PUP_STR_DA_Cape,        -- 30, __, __ [__/__, ___] { 5/ 5,   1}; WSD cape would be better
    waist="Moonbow Belt +1",          -- 20, __, __ [ 6/ 6, ___] {__/__, ___}
    -- 229 STR, 187 VIT, 70 WSD [44 PDT/44 MDT, 674 M.Eva] {Pet: 8 PDT/8 MDT, 120 Lv}
  })
  sets.precast.WS["Asuran Fists"].MaxTP = set_combine(sets.precast.WS["Asuran Fists"], {})

  -- Raging Fists: 30% STR / 30% DEX, 1.0-3.75 fTP, 5 hit, ftp replicating
  -- TP Bonus > WSD > Multihit (assuming always used with high TP)
  sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, 30, __ < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body=gear.Nyame_B_body,           -- 45, 24, 13 < 7, __, __> [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 17, 42, 11 < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, __, 12 < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 26, 11 < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; ftp+
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Gere Ring",                -- 10, __, __ <__,  5, __> [__/__, ___] {__/__, ___}
    ring2="Niqmaddu Ring",            -- 10, 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    back=gear.PUP_STR_DA_Cape,        -- 30, __, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, 20, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 246 STR, 152 DEX, 52 WSD <43 DA, 16 TA, 3 QA> [44 PDT/37 MDT, 620 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}

    -- ear1="Moonshade Earring",      -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    -- ear2="Karagoz Earring +2",     -- 15, 15, __ <__, __, __> [__/__, ___] {__/__,   1}
  })
  sets.precast.WS["Raging Fists"].MaxTP = set_combine(sets.precast.WS["Raging Fists"], {
    ear2="Ishvara Earring",           -- __, __,  2 <__, __, __> [__/__, ___] {__/__, ___}

    -- Once karagoz earring +2 acquired:
    -- ear1="Brutal Earring",         -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    -- ear2="Karagoz Earring +2",     -- 15, 15, __ <__, __, __> [__/__, ___] {__/__,   1}
  })

  -- Spinning Attack: 100% STR, 1.0 fTP, 1 hit (aoe-physical), ftp replicating
  -- Multihit > WSD
  sets.precast.WS["Spinning Attack"] = set_combine(sets.precast.WS["Raging Fists"], {})
  sets.precast.WS["Spinning Attack"].MaxTP = set_combine(sets.precast.WS["Raging Fists"].MaxTP, {})

  -- Howling Fist: 50% VIT / 20% STR, 2.05-5.8 fTP, 2 hit, ftp replicating
  -- TP Bonus > Multihit > WSD
  sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
    ranged="Neo Animator",            -- __, __,  5 <__, __, __> [__/__, ___] {__/__, 119}
    head="Mpaca's Cap",               -- 33, 26, __ < 5,  3, __> [ 7/__,  69] {__/__, ___}; TP Bonus+200
    body=gear.Nyame_B_body,           -- 45, 45, 13 < 7, __, __> [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 17, 54, 11 < 5, __, __> [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- 58, 30, 12 < 6, __, __> [ 8/ 8, 150] {__/__, ___}
    feet=gear.Nyame_B_feet,           -- 23, 24, 11 < 5, __, __> [ 7/ 7, 150] {__/__, ___}
    neck="Fotia Gorget",              -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; ftp+
    ear1="Brutal Earring",            -- __, __, __ < 5, __, __> [__/__, ___] {__/__, ___}
    ear2="Moonshade Earring",         -- __, __, __ <__, __, __> [__/__, ___] {__/__, ___}; TP Bonus+250
    ring1="Gere Ring",                -- 10, __, __ <__,  5, __> [__/__, ___] {__/__, ___}
    ring2="Niqmaddu Ring",            -- 10, 10, __ <__, __,  3> [__/__, ___] {__/__, ___}
    back=gear.PUP_STR_DA_Cape,        -- 30, __, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
    waist="Moonbow Belt +1",          -- 20, __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___}
    -- 246 STR, 189 VIT, 52 WSD <43 DA, 16 TA, 3 QA> [44 PDT/37 MDT, 620 M.Eva] {Pet: 5 PDT/5 MDT, 120 Lv}
    
    -- back=gear.PUP_VIT_DA_Cape,     -- __, 30, __ <10, __, __> [__/__, ___] { 5/ 5,   1}
  })
  sets.precast.WS["Howling Fist"].MaxTP = set_combine(sets.precast.WS["Howling Fist"], {
    head=gear.Nyame_B_head,           -- 26, 24, 11 < 5, __, __> [ 7/ 7, 123] {__/__, ___}
    ear2="Schere Earring",            --  5, __, __ < 6, __, __> [__/__, ___] {__/__, ___}
  })

  sets.MAB = {
  }

  -- Cataclysm: 40% DEX/40% INT, 2.0-4.5 fTP, 1 hit (aoe-magical)
  -- Stack MAB > INT > DEX > WSD
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, sets.MAB, {
    ranged="Neo Animator",            -- __, __, __,  5 [__/__, ___] {__/__, 119}
    head=gear.Nyame_B_head,           -- 25, 28, 30, 11 [ 7/ 7, 123] {__/__, ___}
    body=gear.Nyame_B_body,           -- 24, 42, 30, 13 [ 9/ 9, 139] {__/__, ___}
    hands=gear.Nyame_B_hands,         -- 42, 28, 30, 11 [ 7/ 7, 112] {__/__, ___}
    legs=gear.Nyame_B_legs,           -- __, 44, 30, 12 [ 8/ 8, 150] {__/__, ___}
    feet=gear.Herc_MAB_feet,          -- 24, __, 57, __ [ 2/__,  75] {__/__, ___}
    neck="Sibyl Scarf",               -- __, 10, 10, __ [__/__, ___] {__/__, ___}
    ear1="Friomisi Earring",          -- __, __, 10, __ [__/__, ___] {__/__, ___}
    ear2="Novio Earring",             -- __, __,  7, __ [__/__, ___] {__/__, ___}
    ring1="Shiva Ring +1",            -- __,  9,  3, __ [__/__, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___] {__/__, ___}
    back="Argochampsa Mantle",        -- __, __, 12, __ [__/__, ___] {__/__, ___}
    waist="Skrymir Cord",             -- __, __,  5, __ [__/__, ___] {__/__, ___}
    -- 115 DEX, 161 INT, 224 MAB, 52 WSD [43 PDT/41 MDT, 599 M.Eva] {Pet: 0 PDT/0 MDT, 119 Lv}

    -- back=gear.PUP_MAB_Cape,        -- __, 30, 10, __ [__/__, ___] { 5/ 5,   1}
    -- waist="Skrymir Cord +1",       -- __, __,  7, __ [__/__, ___] {__/__, ___}
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Pet WS Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Pet WS sets are not really used because we cannot detect when pet is about to use a WS.
  -- Keeping these sets here just in case this changes some day.
  -- As a result, these pet WS sets are not up-to-date.

  -- sets.midcast.Pet.Weaponskill = {
  --   ranged="Neo Animator",
  --   head="Karagoz Capello +3",
  --   body="Pitre Tobe +3",
  --   hands="Mpaca's Gloves",
  --   legs="Kara. Pantaloni +1",
  --   feet={ name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}},
  --   neck="Pup. Collar",
  --   ear1="Enmerkar Earring",
  --   ear2="Burana Earring",
  --   ring1="C. Palug Ring",
  --   ring2="Varar Ring",
  --   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  --   waist="Incarnation Sash",
  -- }
  -- sets.midcast.Pet.Weaponskill.Halfsies = set_combine(sets.midcast.Pet.Weaponskill, {})

  -- -- 50% VIT - Critical hit rate varies w/ TP
  -- sets.midcast.Pet.Weaponskill['String Shredder'] = {
  --   ranged="Neo Animator",
  --   head="Pitre Taj +3",
  --   body="Pitre Tobe +3",
  --   hands="Tali'ah Gages +2",
  --   legs="Tali'ah Sera. +2",
  --   feet="Tali'ah Crackows +2",
  --   neck="Shulmanu Collar",
  --   ear1="Enmerkar Earring",
  --   ear2="Burana Earring",
  --   ring1="C. Palug Ring",
  --   ring2="Varar Ring",
  --   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  --   waist="Incarnation Sash",
  -- }
  -- sets.midcast.Pet.Weaponskill['String Shredder'].Halfsies = set_combine(sets.midcast.Pet.Weaponskill['String Shredder'], {})

  -- -- 60% VIT - This has additional effect stun, may want magic acc to help with the stun effect
  -- sets.midcast.Pet.Weaponskill['Bone Crusher'] = {
  --   ranged="Neo Animator",
  --   head="Tali'ah Turban +2",
  --   body="Tali'ah Manteel +2",
  --   hands="Mpaca's Gloves",
  --   legs="Tali'ah Sera. +2",
  --   feet="Tali'ah Crackows +2",
  --   neck="Adad Amulet",
  --   ear1="Enmerkar Earring",
  --   ear2="Burana Earring",
  --   ring1="C. Palug Ring",
  --   ring2="Varar Ring",
  --   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  --   waist="Incarnation Sash",
  -- }
  -- sets.midcast.Pet.Weaponskill['Bone Crusher'].Halfsies = set_combine(sets.midcast.Pet.Weaponskill['Bone Crusher'], {})

  -- -- 50% DEX - Provides Defense Down, may want magic acc to help it land. TP Bonus to help with duration.
  -- sets.midcast.Pet.Weaponskill['Armor Shatterer'] = {
  --   ranged="Neo Animator",
  --   head="Tali'ah Turban +2",
  --   body="Tali'ah Manteel +2",
  --   hands="Tali'ah Gages +2",
  --   legs="Tali'ah Sera. +2",
  --   feet="Tali'ah Crackows +2",
  --   neck="Adad Amulet",
  --   ear1="Enmerkar Earring",
  --   ear2="Burana Earring",
  --   ring1="C. Palug Ring",
  --   ring2="Varar Ring",
  --   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  --   waist="Incarnation Sash",
  -- }
  -- sets.midcast.Pet.Weaponskill['Armor Shatterer'].Halfsies = set_combine(sets.midcast.Pet.Weaponskill['Armor Shatterer'], {})

  -- -- 60% DEX - TP Bonus WS - Damage Varies with TP
  -- sets.midcast.Pet.Weaponskill['Arcuballista'] = {
  --   ranged="Neo Animator",
  --   head="Karagoz Capello +1",
  --   body="Pitre Tobe +3",
  --   hands="Tali'ah Gages +2",
  --   legs="Tali'ah Sera. +2",
  --   feet="Tali'ah Crackows +2",
  --   neck="Pup. Collar",
  --   ear1="Enmerkar Earring",
  --   ear2="Burana Earring",
  --   ring1="C. Palug Ring",
  --   ring2="Varar Ring",
  --   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  --   waist="Incarnation Sash",
  -- }
  -- sets.midcast.Pet.Weaponskill['Arcuballista'].Halfsies = set_combine(sets.midcast.Pet.Weaponskill['Arcuballista'], {})

  -- -- 60% DEX - TP Bonus - Magic Accuracy to help with Additional Effect Stun
  -- sets.midcast.Pet.Weaponskill['Daze'] = set_combine(sets.midcast.Pet.Weaponskill['Arcuballista'], {})
  -- sets.midcast.Pet.Weaponskill['Daze'].Halfsies = set_combine(sets.midcast.Pet.Weaponskill['Arcuballista'].Halfsies, {})

  -- -- 50% STR - TP Bonus
  -- sets.midcast.Pet.Weaponskill['Chimera Ripper'] = {
  --   ranged="Neo Animator",
  --   head="Karagoz Capello +1",
  --   body="Pitre Tobe +3",
  --   hands="Karagoz Guanti +1",
  --   legs="Kara. Pantaloni +1",
  --   feet={ name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}},
  --   neck="Pup. Collar",
  --   ear1="Enmerkar Earring",
  --   ear2="Burana Earring",
  --   ring1="C. Palug Ring",
  --   ring2="Varar Ring",
  --   back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Damage taken -5%',}},
  --   waist="Incarnation Sash",
  -- }
  -- sets.midcast.Pet.Weaponskill['Chimera Ripper'].Halfsies = set_combine(sets.midcast.Pet.Weaponskill['Chimera Ripper'], {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

	--------------------- Master-casted spells ---------------------
  sets.midcast['Cure'] = {
    ranged="Neo Animator",            -- __, __, __ [__/__, ___] {__/__, 119}
    head="Hike Khat +1",              -- __, __, 29 [13/__,  75] { 5/ 5, ___}
    body="Vrikodara Jupon",           -- 13, __, 29 [ 3/__,  80] {__/__, ___}
    hands="Weatherspoon Cuffs +1",    --  9, __, 33 [__/__,  37] {__/__, ___}
    legs="Gyve Trousers",             -- 10, __, 25 [__/ 2, 107] {__/__, ___}
    feet="Regal Pumps +1",            -- __, 21, 29 [__/__, 107] {__/__, ___}
    neck="Incanter's Torque",         -- __, 10, __ [__/__, ___] {__/__, ___}
    ear1="Enmerkar Earring",          -- __, __, __ [__/__, ___] { 3/ 3, ___}
    ear2="Mendicant's Earring",       --  5, __, __ [__/__, ___] {__/__, ___}
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___] {__/__, ___}
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] {__/__, ___}
    back=gear.PUP_Cure_Cape,          -- 10, __, 30 [__/__, ___] { 5/ 5,   1}
    waist="Isa Belt",                 -- __, __, __ [__/__, ___] { 3/ 3, ___}
    -- 47 Cure Potency, 31 Healing Skill, 175 MND [33 PDT/11 MDT, 406 M.Eva] {Pet: 16 PDT/16 MDT, 120 Lv}
  }
  sets.midcast['Curaga'] = set_combine(sets.midcast['Cure'], {})

  sets.midcast['Refresh'] = {
    back="Grapevine Cape",
    waist="Gishdubar Sash",
  }

  --------------------- Pet casted spells ---------------------
  -- These only equip if in 'Pet' or 'Halfsies' hybrid mode

  sets.midcast.Pet['Cure'] = {
    ranged="Neo Animator",            -- [__/__, ___] {__/__, 119 | __, __, __}
    head=gear.Naga_C_head,            -- [__/ 3,  43] {__/__, ___ |  4, __, __}
    body=gear.Naga_C_body,            -- [__/__,  53] {__/__, ___ |  4, __, __}
    hands=gear.Naga_C_hands,          -- [ 2/ 2,  26] {__/__, ___ |  4, __, __}
    legs="Foire Churidars +3",        -- [__/__,  84] { 6/ 6, ___ | 16, __, __}
    feet=gear.Naga_C_feet,            -- [__/__,  64] {__/__, ___ |  4, 10, __}
    neck="Loricate Torque +1",        -- [ 6/ 6, ___] {__/__, ___ | __, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __, __, __}
    ear2="Odnowa Earring +1",         -- [ 3/ 5, ___] {__/__, ___ | __, __, __}
    ring1="Gelatinous Ring +1",       -- [ 7/-1, ___] {__/__, ___ | __, __, __}
    ring2="Defending Ring",           -- [10/10, ___] {__/__, ___ | __, __, __}
    back="Refraction Cape",           -- [__/__, ___] {__/__, ___ | __, __,  8}
    waist="Moonbow Belt +1",          -- [ 6/ 6, ___] {__/__, ___ | __, __, __}
    -- [34 PDT/31 MDT, 270 M.Eva] {Pet: 9 PDT/9 MDT, 119 Lv | 32 Cure Potency, 10 Magic Skill, 8 MND}
  }
  sets.midcast.Pet['Cure'].Halfsies = {
    ranged="Neo Animator",            -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, __}
    body="Mpaca's Doublet",           --  8, 55 <__,  4, __> [10/__,  86] {__/__, ___ | __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, __}
    legs="Foire Churidars +3",        -- __, 49 <__, __, __> [__/__,  84] { 6/ 6, ___ | 16, __, __}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, __}
    neck="Combatant's Torque",        --  4, __ <__, __, __> [__/__, ___] {__/__, ___ | __, __, __}
    ear1="Schere Earring",            --  5, 15 < 6, __, __> [__/__, ___] {__/__, ___ | __, __, __}
    ear2="Karagoz Earring +2",        --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __}
    ring1="Epona's Ring",             -- __, __ < 3,  3, __> [__/__, ___] {__/__, ___ | __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __}
    back=gear.PUP_TP_Cape,            -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __}
    -- 46 STP, 341 Acc <14 DA, 21 TA, 0 QA> [49 PDT/31 MDT, 417 M.Eva] {Pet: 11 PDT/11 MDT, 122 Lv | 16 Cure Potency, 0 Magic Skill, 0 MND}
  }

  sets.midcast.Pet['Elemental Magic'] = {
    ranged="Neo Animator",              -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, __, 30}
    head=gear.Rawhide_D_head,           -- __, __ <__, __, __> [__/__,  53] {__/__, ___ | 15, __, __, 20}
    body="Udug Jacket",                 -- __, 45 <__, __, __> [10/10,  86] {__/__, ___ | 45, __, __, 45}
    hands=gear.Naga_D_hands,            -- __, __ <__, __, __> [ 2/ 2,  26] {__/__, ___ | 20, __, __, 20}
    legs="Pitre Churidars +3",          -- __, 46 <__, __, __> [__/__,  84] {__/__, ___ | 51, __, __, 48}
    feet="Pitre Babouches +3",          -- __, 36 <__, __, __> [__/__,  84] {__/__, ___ | 57, __, __, 43}
    neck="Adad Amulet",                 -- __, __ <__, __, __> [ 4/ 4, ___] {__/__, ___ | 10, __, __, 20}
    ear1="Burana Earring",              -- __, __ <__, __, __> [__/__, ___] {__/__, ___ | 10, __, __, __}
    ear2="Karagoz Earring +2",          --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __, __}
    ring1="Cath Palug Ring",            -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ | __, __, __, 12}
    ring2="Defending Ring",             -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __, __}
    back=gear.PUP_Pet_Nuke_Cape,        -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __, 30}
    waist="Incarnation Sash",           -- __, __ <__, __, __> [__/__, ___] {__/__, ___ | __, __, __, 15}
    -- 18 STP, 177 Acc <0 DA, 0 TA, 0 QA> [31 PDT/31 MDT, 333 M.Eva] {Pet: 5 PDT/5 MDT, 121 Lv | 208 MAB, 0 Magic Skill, 0 INT, 283 M.Acc}
    
    -- head=gear.Herc_Pet_Nuke_head,
    -- hands=gear.Herc_Pet_Nuke_hands,
    -- neck="Puppetmaster's Collar +2", -- __, 30 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, __, 25}
  }
  sets.midcast.Pet['Elemental Magic'].Halfsies = set_combine(sets.midcast.Pet['Elemental Magic'], {
    ranged="Neo Animator",              -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, __, 30}
    head="Mpaca's Cap",                 -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, __, 50}
    body="Mpaca's Doublet",             --  8, 55 <__,  4, __> [10/__,  86] {__/__, ___ | __, __, __, 50}
    hands="Karagoz Guanti +3",          -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, __, 62}
    legs="Pitre Churidars +3",          -- __, 46 <__, __, __> [__/__,  84] {__/__, ___ | 51, __, __, 48}
    feet="Pitre Babouches +3",          -- __, 36 <__, __, __> [__/__,  84] {__/__, ___ | 57, __, __, 43}
    neck="Adad Amulet",                 -- __, __ <__, __, __> [ 4/ 4, ___] {__/__, ___ | 10, __, __, 20}
    ear1="Burana Earring",              -- __, __ <__, __, __> [__/__, ___] {__/__, ___ | 10, __, __, __}
    ear2="Karagoz Earring +2",          --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __, __}
    ring1="Cath Palug Ring",            -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ | __, __, __, 12}
    ring2="Defending Ring",             -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __, __}
    back=gear.PUP_Pet_Nuke_Cape,        -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __, 30}
    waist="Moonbow Belt +1",            -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __, __}
    -- 37 STP, 304 Acc <5 DA, 15 TA, 0 QA> [52 PDT/35 MDT, 405 M.Eva] {Pet: 5 PDT/5 MDT, 121 Lv | 128 MAB, 0 Magic Skill, 0 INT, 345 M.Acc}
    
    -- neck="Puppetmaster's Collar +2", -- __, 30 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, __, 25}
  })

  sets.midcast.Pet['Enfeebling Magic'] = {
    ranged="Neo Animator",              -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, __, 30}
    head="Karagoz Cappello +3",         -- __, 61 < 5, __, __> [__/__,  98] {__/__, ___ | __, __, __, 61}
    body="Karagoz Farsetto +3",         -- __, 64 <__, __, __> [13/13, 109] {__/__, ___ | __, __, __, 64}
    hands="Karagoz Guanti +3",          -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, __, 62}
    legs="Karagoz Pantaloni +3",        -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | 33, __, __, 63}
    feet="Karagoz Scarpe +3",           -- __, 60 <__, __, __> [__/__, 119] {__/__, ___ | __, 30, 30, 60}
    neck="Adad Amulet",                 -- __, __ <__, __, __> [ 4/ 4, ___] {__/__, ___ | __, __, __, 20}
    ear1="Enmerkar Earring",            -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __, __, __, 15}
    ear2="Karagoz Earring +2",          --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __, __}
    ring1="Cath Palug Ring",            -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ | __, __, __, 12}
    ring2="Defending Ring",             -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __, __}
    back=gear.PUP_Pet_Nuke_Cape,        -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __, 30}
    waist="Incarnation Sash",           -- __, __ <__, __, __> [__/__, ___] {__/__, ___ | __, __, __, 15}
    -- 29 STP, 360 Acc <5 DA, 0 TA, 0 QA> [54 PDT/54 MDT, 527 M.Eva] {Pet: 8 PDT/8 MDT, 121 Lv | 33 Magic Skill, 30 MND, 30 INT, 432 M.Acc}

    -- neck="Puppetmaster's Collar +2", -- __, 30 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, __, 25}
  }
  sets.midcast.Pet['Enfeebling Magic'].Halfsies = set_combine(sets.midcast.Pet['Enfeebling Magic'], {
    ranged="Neo Animator",              -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, __, 30}
    head="Mpaca's Cap",                 -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, __, 50}
    body="Mpaca's Doublet",             --  8, 55 <__,  4, __> [10/__,  86] {__/__, ___ | __, __, __, 50}
    hands="Karagoz Guanti +3",          -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, __, 62}
    legs="Karagoz Pantaloni +3",        -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | 33, __, __, 63}
    feet="Karagoz Scarpe +3",           -- __, 60 <__, __, __> [__/__, 119] {__/__, ___ | __, 30, 30, 60}
    neck="Adad Amulet",                 -- __, __ <__, __, __> [ 4/ 4, ___] {__/__, ___ | __, __, __, 20}
    ear1="Schere Earring",              --  5, 15 < 6, __, __> [__/__, ___] {__/__, ___ | __, __, __, __}
    ear2="Karagoz Earring +2",          --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __, __}
    ring1="Gere Ring",                  -- __, __ <__,  5, __> [__/__, ___] {__/__, ___ | __, __, __, __}
    ring2="Niqmaddu Ring",              -- __, __ <__, __,  3> [__/__, ___] {__/__, ___ | __, __, __, __}
    back=gear.PUP_Pet_Nuke_Cape,        -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __, 30}
    waist="Moonbow Belt +1",            -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __, __}
    -- 42 STP, 360 Acc <11 DA, 20 TA, 3 QA> [49 PDT/32 MDT, 475 M.Eva] {Pet: 8 PDT/8 MDT, 121 Lv | 33 Magic Skill, 30 MND, 30 INT, 432 M.Acc}

    -- neck="Puppetmaster's Collar +2", -- __, 30 <__, __, __> [__/__, ___] {__/__, ___ | 25, __, __, 25}
  })

  sets.midcast.Pet['Dark Magic'] = set_combine(sets.midcast.Pet['Enfeebling Magic'], {})
  sets.midcast.Pet['Dark Magic'].Halfsies = set_combine(sets.midcast.Pet['Enfeebling Magic'].Halfsies, {})
  sets.midcast.Pet['Divine Magic'] = set_combine(sets.midcast.Pet['Enfeebling Magic'], {})
  sets.midcast.Pet['Divine Magic'].Halfsies = set_combine(sets.midcast.Pet['Enfeebling Magic'].Halfsies, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- This set is used when both master and pet are idle
  sets.HeavyDef = {
    range="Neo Animator",             -- __ [__/__, ___] {__/__, 119 | __, __}
    head="Pitre Taj +3",              --  5 [__/__,  63] {__/__, ___ |  5,  5}
    body="Hizamaru Haramaki +2",      -- 12 [__/__,  69] {__/__, ___ | __, __}
    hands=gear.Taeon_Pet_DT_hands,    -- __ [__/__,  57] { 4/ 4, ___ |  3, __}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
    legs="Karagoz Pantaloni +3",      -- __ [12/12, 119] {__/__, ___ | __, __}
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150] {__/__, ___ | __, __}
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] {__/__, ___ | __, __}
    ear1="Burana Earring",            -- __ [__/__, ___] {__/__, ___ |  2, __}
    ear2="Enmerkar Earring",          -- __ [__/__, ___] { 3/ 3, ___ | __, __}
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___] {__/__, ___ | __, __}
    ring2="Defending Ring",           -- __ [10/10, ___] {__/__, ___ | __, __}
    back=gear.PUP_TP_Cape,            -- __ [__/__, ___] { 5/ 5,   1 | __, __}
    waist="Moonbow Belt +1",          -- __ [ 6/ 6, ___] {__/__, ___ | __, __}
    -- 17 Regen [48 PDT/40 MDT, 458 M.Eva] {Pet: 12 PDT/12 MDT, 120 Lv | 10 Regen, 5 Refresh}
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    feet=gear.Herc_Refresh_feet,
  }

  sets.resting = {}

  sets.idle = set_combine(sets.HeavyDef, {})

  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)

  sets.idle.Weak = set_combine(sets.HeavyDef, {})

  -- idle.PetEngaged sets is when master is idle but pet is engaged
  -- It is assumed that in this situation, master is standing out of range
  -- so no emphasis is placed on master survivability stats.
  sets.idle.PetEngaged = {}
  sets.idle.PetEngaged.Tank = {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head=gear.Anwig_Salade,           -- [__/__, ___] {10/10, ___ | __, __, __/__, __/__, __, __, __}
    body="Heyoka Harness +1",         -- [__/__, 117] {__/__, ___ | __, __, 52/52, __/__,  4, __, 12}
    hands=gear.Taeon_Pet_DT_hands,    -- [__/__,  57] { 4/ 4, ___ | __, __, __/__, __/__, __,  3, __}; Augs: +20 M.Eva, -4 Pet DT, Pet Regen +3
    legs="Heyoka Subligar +1",        -- [__/__, 139] {__/__, ___ | __, __, 51/51, __/__,  9, __, 11}
    feet="Mpaca's Boots",             -- [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +2",        -- [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- [11 PDT/5 MDT, 429 M.Eva] {Pet: 22 PDT /22 MDT, 122 Lv | 5 DA, 20 STP, 290 Acc/255 Racc, 40 Att/20 Ratt, 22 Haste, 13 Regen, 23 Enmity}
  }
  -- Haste does not affect the ranged pet
  sets.idle.PetEngaged.Ranged = {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Pitre Taj +3",              -- [__/__,  63] {__/__, ___ | __, __, 37/37, 57/57, __,  5, __}
    body="Pitre Tobe +3",             -- [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}; AGI+26
    legs="Karagoz Pantaloni +3",      -- [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Empath Necklace",           -- [__/__, ___] {__/__, ___ | __, __, 10/10,  5/10, __,  1, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +2",        -- [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- [33 PDT/27 MDT, 453 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 5 DA, 29 STP, 389 Acc/374 Racc, 142 Att/147 Ratt, 9 Haste, 16 Regen, 0 Enmity}
  }
  sets.idle.PetEngaged.RangedAcc = set_combine(sets.idle.PetEngaged.Ranged, {})
  sets.idle.PetEngaged.MeleeSpam = {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Pitre Taj +3",              -- [__/__,  63] {__/__, ___ | __, __, 37/37, 57/57, __,  5, __}
    body="Pitre Tobe +3",             -- [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}; STR/DEX+26
    legs="Karagoz Pantaloni +3",      -- [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Sroda Earring",             -- [__/__, -10] {__/__, ___ | __, __, __/__, __/__, __, __, __}: Melee DMG+10
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __, __}
    back=gear.PUP_Pet_TP_Cape,        -- [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, 10, __, __}
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- [33 PDT/27 MDT, 443 M.Eva] {Pet: 8 PDT /8 MDT, 121 Lv | 10 DA, 29 STP, 399 Acc/364 Racc, 157 Att/137 Ratt, 19 Haste, 5 Regen, 0 Enmity}
  }
  sets.idle.PetEngaged.MeleeSC = set_combine(sets.idle.PetEngaged.MeleeSpam, {})
  sets.idle.PetEngaged.OverdriveDD = set_combine(sets.idle.PetEngaged.MeleeSpam, {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __}
    head="Karagoz Cappello +3",       -- [__/__,  98] {__/__, ___ | __, __, 61/61, __/__, __}; TP Bonus+600
    body="Pitre Tobe +3",             -- [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __}
    hands="Mpaca's Gloves",           -- [ 8/__,  59] {__/__, ___ | __, __, 50/50, __/__, __}; WSD+10
    legs="Heyoka Subligar +1",        -- [__/__, 139] {__/__, ___ | __, __, 51/51, __/__,  9}
    feet="Mpaca's Boots",             -- [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __}
    neck="Shulmanu Collar",           -- [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __}
    ear2="Sroda Earring",             -- [__/__, -10] {__/__, ___ | __, __, __/__, __/__, __}: Melee DMG+10
    ring1="Cath Palug Ring",          -- [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __}
    ring2="Varar Ring +1",            -- [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __}
    back=gear.PUP_Adoulin_Cape,       -- [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __}; TP Bonus+500
    waist="Klouskap Sash +1",         -- [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9}
    -- [19 PDT/5 MDT, 455 M.Eva] {Pet: 3 PDT /3 MDT, 120 Lv | 10 DA, 29 STP, 369 Acc/334 Racc, 80 Att/60 Ratt, 18 Haste}
  })
  sets.idle.PetEngaged.Heal = {
    range="Neo Animator",             -- [__/__, ___] {__/__, 119 | __, __, __}
    head="Pitre Taj +3",              -- [__/__,  63] {__/__, ___ | __,  5,  5}
    body=gear.Naga_C_body,            -- [__/__,  53] {__/__, ___ |  3, __, __}
    hands=gear.Naga_C_hands,          -- [ 2/ 2,  26] {__/__, ___ |  3, __, __}
    legs="Pitre Churidars +3",        -- [__/__,  84] {__/__, ___ | 10, __, __}
    feet=gear.Naga_C_feet,            -- [__/__,  64] {__/__, ___ |  3, __, __}
    neck="Loricate Torque +1",        -- [ 6/ 6, ___] {__/__, ___ | __, __, __}
    ear1="Enmerkar Earring",          -- [__/__, ___] { 3/ 3, ___ | __, __, __}
    ear2="Karagoz Earring +2",        -- [__/__, ___] {__/__,   1 | __, __, __}
    ring1="Gelatinous Ring +1",       -- [ 7/-1, ___] {__/__, ___ | __, __, __}
    ring2="Defending Ring",           -- [10/10, ___] {__/__, ___ | __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- [__/__,  20] { 5/ 5,   1 | __, 10, __}
    waist="Ukko Sash",                -- [__/__, ___] {__/__, ___ |  5, __, __}
    -- [25 PDT/17 MDT, 310 M.Eva] {Pet: 8 PDT /8 MDT, 121 Lv | 24 FC, 15 Regen, 5 Refresh}
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

	--------------------- When master is engaged in Master hybrid mode ---------------------
  sets.engaged = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    body="Mpaca's Doublet",           --  8, 55 <__,  4, __> [10/__,  86] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Malignance Tights",         -- 10, 50 <__, __, __> [ 7/ 7, 150] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- __, 20 < 3, __, __> [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Schere Earring",            --  5, 15 < 6, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    ear2="Karagoz Earring +2",        --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Niqmaddu Ring",            -- __, __ <__, __,  3> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_TP_Cape,            -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __/__, __/__, __, __, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 52 STP, 362 Acc <14 DA, 18 TA, 3 QA> [51 PDT/28 MDT, 483 M.Eva] {Pet: 5 PDT /5 MDT, 122 Lv | 10 DA, 0 STP, 274 Acc/254 Racc, 20 Att/0 Ratt, 0 Haste, 0 Regen, 0 Enmity}
  }
  sets.engaged.Acc = set_combine(sets.engaged, {
    head="Karagoz Cappello +3",       -- __, 61 < 5, __, __> [__/__,  98] {__/__, ___}; h2h skill+19
    neck="Puppetmaster's Collar +2",  -- __, 30 <__, __, __> [__/__, ___] {__/__, ___}
    ring1="Chirich Ring +1",          --  6, 10 <__, __, __> [__/__, ___] {__/__, ___}
    ring2="Chirich Ring +1",          --  6, 10 <__, __, __> [__/__, ___] {__/__, ___}
  })

	--------------------- When master is engaged in Pet hybrid mode ---------------------
  -- These will be similar to the idle.PetEngaged modes, but put a little more
  -- emphasis on master survivability.
  sets.engaged.PetTank = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Hike Khat +1",              -- __, __ <__, __, __> [13/__,  75] { 5/ 5, ___ | __, __, __/__, __/__, __, __, __}
    body=gear.Taeon_Pet_DT_body,      -- __, __ <__, __, __> [__/__,  84] { 4/ 4, ___ | __, __, __/__, __/__, __, __,  8}; Augs: +20 M.Eva, -4 Pet DT
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Heyoka Subligar +1",        -- __, 51 <__, __, __> [__/__, 139] {__/__, ___ | __, __, 51/51, __/__,  9, __, 11}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Loricate Torque +1",        -- __, __ <__, __, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +2",        --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Klouskap Sash +1",         -- __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- 19 STP, 218 Acc <0 DA, 3 TA, 0 QA> [50 PDT/31 MDT, 496 M.Eva] {Pet: 17 PDT /17 MDT, 122 Lv | 5 DA, 8 STP, 270 Acc/255 Racc, 20 Att/20 Ratt, 18 Haste, 10 Regen, 19 Enmity}
  }
  sets.engaged.PetTank.Acc = set_combine(sets.engaged.PetTank, {})
  sets.engaged.PetRanged = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Pitre Taj +3",              -- __, 37 <__, __, __> [__/__,  63] {__/__, ___ | __, __, 37/37, 57/57, __,  5, __}
    body="Pitre Tobe +3",             -- __, 50 <__, __, __> [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Karagoz Pantaloni +3",      -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Empath Necklace",           -- __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10,  5/10, __,  1, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +2",        --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 19 STP, 307 Acc <0 DA, 11 TA, 0 QA> [49 PDT/43 MDT, 453 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 5 DA, 23 STP, 359 Acc/344 Racc, 142 Att/147 Ratt, 0 Haste, 16 Regen, 0 Enmity}
  }
  sets.engaged.PetRanged.Acc = set_combine(sets.engaged.PetRanged, {})
  sets.engaged.PetRangedAcc = set_combine(sets.engaged.PetRanged, {})
  sets.engaged.PetRangedAcc.Acc = set_combine(sets.engaged.PetRanged, {})
  sets.engaged.PetMeleeSpam = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Hike Khat +1",              -- __, __ <__, __, __> [13/__,  75] { 5/ 5, ___ | __, __, __/__, __/__, __, __, __}
    body="Pitre Tobe +3",             -- __, 50 <__, __, __> [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Karagoz Pantaloni +3",      -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- __, 20 < 3, __, __> [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Sroda Earring",             -- __, __ < 7, __, __> [__/__, -10] {__/__, ___ | __, __, __/__, __/__, __, __, __}: Melee DMG+10
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Varar Ring +1",            -- __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __, __}
    back=gear.PUP_Pet_TP_Cape,        -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, 10, __, __}
    waist="Klouskap Sash +1",         -- __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- 11 STP, 290 Acc <10 DA, 3 TA, 0 QA> [46 PDT/27 MDT, 455 M.Eva] {Pet: 13 PDT /13 MDT, 121 Lv | 10 DA, 29 STP, 362 Acc/327 Racc, 100 Att/80 Ratt, 19 Haste, 0 Regen, 0 Enmity}
  }
  sets.engaged.PetMeleeSpam.Acc = set_combine(sets.engaged.PetMeleeSpam, {})
  sets.engaged.PetMeleeSC = set_combine(sets.engaged.PetMeleeSpam, {})
  sets.engaged.PetMeleeSC.Acc = set_combine(sets.engaged.PetMeleeSC, {})
  sets.engaged.PetOverdriveDD = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Karagoz Cappello +3",       -- __, 61 < 5, __, __> [__/__,  98] {__/__, ___ | __, __, 61/61, __/__, __, __, __}; TP Bonus+600
    body="Karagoz Farsetto +3",       -- __, 64 <__, __, __> [13/13, 109] {__/__, ___ | __, __, 64/64, __/__, __, __, __}
    hands="Mpaca's Gloves",           -- __, 55 <__,  3, __> [ 8/__,  59] {__/__, ___ | __, __, 50/50, __/__, __, __, __}; WSD+10
    legs="Heyoka Subligar +1",        -- __, 51 <__, __, __> [__/__, 139] {__/__, ___ | __, __, 51/51, __/__,  9, __, 11}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Loricate Torque +1",        -- __, __ <__, __, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Sroda Earring",             -- __, __ < 7, __, __> [__/__, -10] {__/__, ___ | __, __, __/__, __/__, __, __, __}: Melee DMG+10
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Adoulin_Cape,       -- __, 15 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}; TP Bonus+500
    waist="Klouskap Sash +1",         -- __, 20 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 20/20, __/__,  9, __, __}
    -- 0 STP, 331 Acc <12 DA, 6 TA, 0 QA> [48 PDT/34 MDT, 491 M.Eva] {Pet: 3 PDT /3 MDT, 120 Lv | 5 DA, 8 STP, 353 Acc/338 Racc, 0 Att/0 Ratt, 18 Haste, 0 Regen, 11 Enmity}
  }
  sets.engaged.PetOverdriveDD.Acc = set_combine(sets.engaged.PetOverdriveDD, {})
  sets.engaged.PetHeal = set_combine(sets.engaged, {
    legs="Pitre Churidars +3",        -- __, 46 <__, __, __> [__/__,  84] {__/__, ___ | 10, __, __}
    waist="Ukko Sash",                -- __, __ <__, __, __> [__/__, ___] {__/__, ___ |  5, __, __}
  })
  sets.engaged.PetHeal.Acc = set_combine(sets.engaged.Acc, {
    legs="Pitre Churidars +3",        -- __, 46 <__, __, __> [__/__,  84] {__/__, ___ | 10, __, __}
    waist="Ukko Sash",                -- __, __ <__, __, __> [__/__, ___] {__/__, ___ |  5, __, __}
  })

	--------------------- When master is engaged in Halfsies hybrid mode ---------------------
  sets.engaged.HalfsiesTank = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    body="Mpaca's Doublet",           --  8, 55 <__,  4, __> [10/__,  86] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Malignance Tights",         -- 10, 50 <__, __, __> [ 7/ 7, 150] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- __, 20 < 3, __, __> [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Sroda Earring",             -- __, __ < 7, __, __> [__/__, -10] {__/__, ___ | __, __, __/__, __/__, __, __, __}: Melee DMG+10
    ear2="Karagoz Earring +2",        --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Niqmaddu Ring",            -- __, __ <__, __,  3> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Pet_Tank_Cape,      -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, __, 10, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 37 STP, 327 Acc <15 DA, 18 TA, 3 QA> [51 PDT/28 MDT, 493 M.Eva] {Pet: 5 PDT /5 MDT, 122 Lv | 10 DA, 0 STP, 304 Acc/284 Racc, 40 Att/20 Ratt, 0 Haste, 10 Regen, 0 Enmity}
  }
  sets.engaged.HalfsiesTank.Acc = set_combine(sets.engaged.HalfsiesTank, {})
  sets.engaged.HalfsiesRanged = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    body="Pitre Tobe +3",             -- __, 50 <__, __, __> [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Karagoz Pantaloni +3",      -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Empath Necklace",           -- __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, 10/10,  5/10, __,  1, __}
    ear1="Enmerkar Earring",          -- __, __ <__, __, __> [__/__, ___] { 3/ 3, ___ | __,  8, 15/__, __/__, __, __, __}
    ear2="Karagoz Earring +2",        --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Chirich Ring +1",          --  6, 10 <__, __, __> [__/__, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_TP_Cape,            -- 10, 20 <__, __, __> [__/__, ___] { 5/ 5,   1 | __, __, __/__, __/__, __, __, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 35 STP, 355 Acc <5 DA, 14 TA, 0 QA> [51 PDT/38 MDT, 439 M.Eva] {Pet: 8 PDT /8 MDT, 122 Lv | 0 DA, 23 STP, 330 Acc/315 Racc, 65 Att/70 Ratt, 0 Haste, 1 Regen, 0 Enmity}
  }
  sets.engaged.HalfsiesRanged.Acc = set_combine(sets.engaged.HalfsiesRanged, {})
  sets.engaged.HalfsiesRangedAcc = set_combine(sets.engaged.HalfsiesRanged, {})
  sets.engaged.HalfsiesRangedAcc.Acc = set_combine(sets.engaged.HalfsiesRanged, {})
  sets.engaged.HalfsiesMeleeSpam = {
    range="Neo Animator",             -- __, 10 <__, __, __> [__/__, ___] {__/__, 119 | __, __, 30/30, __/__, __, __, __}
    head="Mpaca's Cap",               -- __, 55 < 5,  3, __> [ 7/__,  69] {__/__, ___ | __, __, 50/50, __/__, __, __, __}
    body="Pitre Tobe +3",             -- __, 50 <__, __, __> [__/__,  73] {__/__, ___ | __, 15, 50/50, 60/60, __, __, __}
    hands="Karagoz Guanti +3",        -- 11, 62 <__, __, __> [10/10,  82] {__/__, ___ | __, __, 62/62, __/__, __, __, __}
    legs="Malignance Tights",         -- 10, 50 <__, __, __> [ 7/ 7, 150] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    feet="Mpaca's Boots",             -- __, 55 <__,  3, __> [ 6/__,  96] {__/__,   1 | __, __, 50/50, __/__, __, __, __}
    neck="Shulmanu Collar",           -- __, 20 < 3, __, __> [__/__, ___] {__/__, ___ |  5, __, 20/__, 20/__, __, __, __}
    ear1="Sroda Earring",             -- __, __ < 7, __, __> [__/__, -10] {__/__, ___ | __, __, __/__, __/__, __, __, __}: Melee DMG+10
    ear2="Karagoz Earring +2",        --  8, 20 <__, __, __> [__/__, ___] {__/__,   1 | __, __, __/__, __/__, __, __, __}
    ring1="Cath Palug Ring",          -- __, __ <__, __, __> [ 5/ 5, ___] {__/__, ___ |  5, __, 12/12, __/__, __, __, __}
    ring2="Defending Ring",           -- __, __ <__, __, __> [10/10, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    back=gear.PUP_Pet_TP_Cape,        -- __, __ <__, __, __> [__/__,  20] { 5/ 5,   1 | __, __, 30/30, 20/20, 10, __, __}
    waist="Moonbow Belt +1",          -- __, __ <__,  8, __> [ 6/ 6, ___] {__/__, ___ | __, __, __/__, __/__, __, __, __}
    -- 29 STP, 322 Acc <15 DA, 14 TA, 0 QA> [51 PDT/38 MDT, 480 M.Eva] {Pet: 5 PDT /5 MDT, 122 Lv | 10 DA, 15 STP, 304 Acc/284 Racc, 100 Att/80 Ratt, 10 Haste, 0 Regen, 0 Enmity}
  }
  sets.engaged.HalfsiesMeleeSpam.Acc = set_combine(sets.engaged.HalfsiesMeleeSpam, {
    legs="Karagoz Pantaloni +3",      -- __, 63 <__, __, __> [12/12, 119] {__/__, ___ | __, __, 63/63, __/__, __, __, __}; Skills+33
    ring1="Varar Ring +1",            -- __, 10 <__, __, __> [__/__, ___] {__/__, ___ | __,  6, 10/10, __/__, __, __, __}
  })
  sets.engaged.HalfsiesMeleeSC = set_combine(sets.engaged.HalfsiesMeleeSpam, {})
  sets.engaged.HalfsiesMeleeSC.Acc = set_combine(sets.engaged.HalfsiesMeleeSpam.Acc, {})
  sets.engaged.HalfsiesOverdriveDD = set_combine(sets.engaged.PetOverdriveDD, {})
  sets.engaged.HalfsiesOverdriveDD.Acc = set_combine(sets.engaged.PetOverdriveDD.Acc, {})
  sets.engaged.HalfsiesHeal = set_combine(sets.engaged.PetHeal, {})
  sets.engaged.HalfsiesHeal.Acc = set_combine(sets.engaged.PetHeal.Acc, {})

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.Special = {}
  sets.Special.ElementalObi = {waist="Hachirin-no-Obi",}

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
  sets.WeaponSet['Cleaving'] = {main="Tauret", sub="Kaja Knife"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if state.HybridMode.value == 'Pet' and pet_midaction() then
    eventArgs.cancel = true
    add_to_chat(122, 'Action canceled because pet was midaction.')
  end
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
  -- Do not change gear for pet abilities in Master mode while engaged
  if player.status == 'Engaged' and state.HybridMode.current == 'Master' then
    eventArgs.handled = true
  else
    if spell.action_type == 'Magic' then
      equip(get_pup_midcast_set(spell, spellMap))
    -- There is not really a reliable way of detecting when pet is about to use a WS, but leaving this here just in case
    -- elseif petWeaponskills:contains(spell.english) then
    --     classes.CustomClass = "Weaponskill"
    --   if sets.midcast.Pet.WeaponSkill[spell.english] then
    --     if state.HybridMode.current == 'Halfsies' and sets.midcast.Pet.WeaponSkill[spell.english]['Halfsies'] then
    --       equip(sets.midcast.Pet.WeaponSkill[spell.english]['Halfsies'] )
    --     else
    --       equip(sets.midcast.Pet.WeaponSkill[spell.english])
    --     end
    --   else
    --     if state.HybridMode.current == 'Halfsies' and sets.midcast.Pet.WeaponSkill['Halfsies'] then
    --       equip(sets.midcast.Pet.WeaponSkill['Halfsies'])
    --     else
    --       equip(sets.midcast.Pet.WeaponSkill)
    --     end
    --   end
    end
  end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
  active_maneuvers = L{}
  handle_equipping_gear(player.status)
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
  if not pet_midaction() then
    if pet.isvalid then
      if pet.status == 'Engaged' then
        idleSet = set_combine(idleSet, sets.idle.PetEngaged[state.PetMode.value])
      end
    end
  
    -- If not in DT mode put on move speed gear
    if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
      -- Apply movement speed gear
      if classes.CustomIdleGroups:contains('Adoulin') then
        idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
      else
        idleSet = set_combine(idleSet, sets.Kiting)
      end
      if state.CP.current == 'on' then
        idleSet = set_combine(idleSet, sets.CP)
      end
    end  
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
  if not pet_midaction() then
    if pet.isvalid then
      if pet.status == 'Engaged' and state.HybridMode.value ~= 'Master' then
        meleeSet = set_combine(meleeSet, sets.engaged[state.HybridMode.value..state.PetMode.value])
      end
    end

    if state.CP.current == 'on' then
      meleeSet = set_combine(meleeSet, sets.CP)
    end
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then meleeSet = set_combine(meleeSet, { neck=player.equipment.neck }) end
  if locked_ear1 then meleeSet = set_combine(meleeSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then meleeSet = set_combine(meleeSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then meleeSet = set_combine(meleeSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then meleeSet = set_combine(meleeSet, { ring2=player.equipment.ring2 }) end

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if not pet_midaction() then
    if state.CP.current == 'on' then
      meleeSet = set_combine(meleeSet, sets.CP)
    end
  end

  -- If slot is locked to use no-swap gear, keep it equipped
  if locked_neck then defenseSet = set_combine(defenseSet, { neck=player.equipment.neck }) end
  if locked_ear1 then defenseSet = set_combine(defenseSet, { ear1=player.equipment.ear1 }) end
  if locked_ear2 then defenseSet = set_combine(defenseSet, { ear2=player.equipment.ear2 }) end
  if locked_ring1 then defenseSet = set_combine(defenseSet, { ring1=player.equipment.ring1 }) end
  if locked_ring2 then defenseSet = set_combine(defenseSet, { ring2=player.equipment.ring2 }) end

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
  -- Must check 'is_setting_attachments' to avoid trying to set the same mode twice
  -- This would not cause a functional difference, but causes autocontrol to spam
  -- messages in the console.
  if set_name == state.PetMode.current:lower() and not is_setting_attachments then
    is_setting_attachments = true
    send_command('input //acon equipset '..set_name)
    coroutine.schedule(function()
      is_setting_attachments = false
    end, 3)
  end
end

function auto_engage_pet()
	if areas.Cities:contains(world.area) then
    return
  end

	local abil_recasts = windower.ffxi.get_ability_recasts()

	if state.AutomaticPetTargeting.value == true and pet.isvalid and pet.status == "Idle" and player.status == 'Engaged'
      and player.target.type == "MONSTER" and abil_recasts[207] < 0.1 then
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
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
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
  elseif cmdParams[1] == 'petactivation' then
    if pet.isvalid then
      windower.chat.input('/pet Deactivate <me>')
    else
      -- Check if still setting attachments
      if is_setting_attachments then
        add_to_chat(123, 'Not activating automaton while setting attachments. Please wait.')
        return
      end
      windower.chat.input('/ja Activate <me>')
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

-- Upon loading file, checks to see if any maneuvers are already active and attempts to track them
-- This is partly guesswork without having access to the exact buff durations
-- TODO: Access buff durations to set up the active_maneuvers list in the correct order
function check_initial_maneuvers()
  for element in pairs(elements.list) do
    local maneuver = element..' Maneuver'
    local active = buffactive[maneuver] or 0
    for i=0,active,1 do
      active_maneuvers:append(maneuver)
    end
  end
end

-- Get the default pet midcast gear set.
-- This is built in sets.midcast.Pet.
function get_pup_midcast_set(spell, spellMap)
  -- If there are no midcast sets defined, bail out.
  if not sets.midcast or not sets.midcast.Pet then
    return {}
  end

  local equipSet = sets.midcast.Pet

  if sets.midcast and sets.midcast.Pet then
    classes.SkipSkillCheck = false
    equipSet = select_specific_set(equipSet, spell, spellMap)

    -- Use hybrid set under certain conditions
    if equipSet['Halfsies'] and (player.status == 'Engaged' or state.HybridMode.current == 'Halfsies') then
      equipSet = equipSet['Halfsies']
    end

    -- We can only generally be certain about whether the pet's action is
    -- Magic (ie: it cast a spell of its own volition) or Ability (it performed
    -- an action at the request of the player).  Allow CastinMode and
    -- OffenseMode to refine whatever set was selected above.
    if spell.action_type == 'Magic' then
      if equipSet[state.CastingMode.current] then
        equipSet = equipSet[state.CastingMode.current]
      end
    elseif spell.action_type == 'Ability' then
      if equipSet[state.OffenseMode.current] then
        equipSet = equipSet[state.OffenseMode.current]
      end
    end
  end

  return equipSet
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

  send_command('bind !z gs c toggle AutomaticPetTargeting')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^pageup gs c petmode cycle')
  send_command('bind ^pagedown gs c petmode cycleback')
  send_command('bind !pagedown gs c petmode reset')
  
  send_command('bind !` gs c maneuver')
  send_command('bind !q gs c petcontrol deploy')
  send_command('bind !w gs c petcontrol retrieve')
  send_command('bind !e gs c petactivation')
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