-- Original: Motenten/Arislan || Modified: Silvermutt
-- Haste/DW Detection Requires Gearinfo Addon

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
--              [ CTRL+` ]          Cycle Treasure Hunter Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+PageUp ]     Cycle Toy Weapon Mode
--              [ CTRL+PageDown ]   Cycleback Toy Weapon Mode
--              [ ALT+PageDown ]    Reset Toy Weapon Mode
--              [ WIN+W ]           Toggle Rearming Lock
--                                  (off = re-equip previous weapons if you go barehanded)
--                                  (on = prevent weapon auto-equipping)
--
--  Abilities:  [ ALT+` ]           Flee
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--              [ CTRL+Numpad0 ]    Sneak Attack
--              [ CTRL+Numpad. ]    Trick Attack
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Other:      [ ALT+D ]           Cancel Invisible/Hide & Use Key on <t>
--              [ ALT+S ]           Turn 180 degrees in place
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
--
--  TH Modes:  None                 Will never equip TH gear
--             Tag                  Will equip TH gear sufficient for initial contact with a mob (either melee,
--
--             SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
--             Fulltime - Will keep TH gear equipped fulltime


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
  coroutine.schedule(function()
    send_command('gs org')
  end, 1)
  coroutine.schedule(function() 
    send_command('gs c weaponset current')
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(9)
  silibs.enable_premade_commands()
  silibs.enable_th()

  Haste = 0 -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify

  elemental_ws = S{'Aeolian Edge'}
  tp_bonus_weapons = {
    ['Fusetto +2'] = 1000,
    ['Fusetto +3'] = 1000,
    ['Centovente'] = 1000,
  }

  state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
  state.Buff['Trick Attack'] = buffactive['trick attack'] or false
  state.Buff['Feint'] = buffactive['feint'] or false
  
  state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
  state.AttackMode = M{['description']='Attack', 'Capped', 'Uncapped'}
  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.RangedMode:options('Normal', 'Acc')
  state.HybridMode:options('LightDef', 'Evasion', 'Normal')
  state.IdleMode:options('Normal', 'LightDef', 'Evasion')
  state.CP = M(false, 'Capacity Points Mode')
  state.AttCapped = M(true, "Attack Capped")
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.WeaponSet = M{['description']='Weapon Set', 'WhiteGlass', 'Normal', 'LowAtt', 'Naegling', 'Cleaving'}
  state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')
  
  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind ^pageup gs c toyweapon cycle')
  send_command('bind ^pagedown gs c toyweapon cycleback')
  send_command('bind !pagedown gs c toyweapon reset')
  
  send_command('bind ^f8 gs c toggle AttCapped')
  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind !` input /ja "Flee" <me>')
  send_command('bind @c gs c toggle CP')

  send_command('bind ^numpad0 input /ja "Sneak Attack" <me>')
  send_command('bind ^numpad. input /ja "Trick Attack" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Third Eye" <me>')
  elseif player.sub_job == 'DNC' then
    send_command('bind ^- gs c cycleback mainstep')
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind %numpad0 gs c step t')
    send_command('bind ^numlock input /ja "Reverse Flourish" <me>')
  elseif player.sub_job == 'NIN' then
    send_command('bind !numpad0 input /ma "Utsusemi: Ichi" <me>')
    send_command('bind !numpad. input /ma "Utsusemi: Ni" <me>')
  elseif player.sub_job == 'RUN' then
    send_command('bind %numpad0 input //gs c rune')
    send_command('bind ^- gs c cycleback Runes')
    send_command('bind ^= gs c cycle Runes')
  elseif player.sub_job == 'DRG' then
    send_command('bind !w input /ja "Ancient Circle" <me>')
    send_command('bind ^numpad/ input /ja "Jump" <t>')
    send_command('bind ^numpad* input /ja "High Jump" <t>')
  end

  update_combat_form()
  determine_haste_group()

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind @c')

  send_command('unbind !w')
  send_command('unbind ^numlock')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  send_command('unbind ^numpad0')
  send_command('unbind ^numpad.')
  send_command('unbind %numpad0')

  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind !numpad0')
  send_command('unbind !numpad.')
  send_command('unbind ^f8')

  send_command('lua u thfknife')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.TreasureHunter = {
    ammo="Perfect Lucky Egg", --1
    body=gear.Herc_TH_body, --2
    hands="Plunderer's Armlets +1", --3
  }

  sets.buff['Sneak Attack'] = {}
  sets.buff['Trick Attack'] = {}


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Collaborator'] = {
    -- head="Skulker's Bonnet +1",
  }
  sets.precast.JA['Accomplice'] = {
    -- head="Skulker's Bonnet +1",
  }
  sets.precast.JA['Flee'] = {
    -- feet="Pillager's Poulaines +3",
  }
  sets.precast.JA['Hide'] = {
    -- body="Pillager's Vest +3",
  }
  sets.precast.JA['Conspirator'] = {
    -- body="Skulker's Vest +1",
  }

  sets.precast.JA['Steal'] = {
    -- ammo="Barathrum", --3
    -- head="Asn. Bonnet +2",
    -- hands="Pillager's Armlets +1",
    -- feet="Pillager's Poulaines +3",
  }

  sets.precast.JA['Despoil'] = {
    feet="Skulk. Poulaines +1",
    -- ammo="Barathrum",
    -- legs="Skulk. Culottes +1",
  }
  sets.precast.JA['Perfect Dodge'] = {
    -- hands="Plunderer's Armlets +3",
  }
  sets.precast.JA['Feint'] = {
    -- legs="Plunderer's Culottes +3",
  }

  sets.precast.Waltz = {
    ammo="Yamarang",
    body="Passion Jacket",
    legs="Dashing Subligar",
    waist="Gishdubar Sash",
  }

  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.FC = {
    ammo="Impatiens", --Quick Magic 2%
    head="Herculean Helm", --7
    body=gear.Taeon_FC_body, --9
    hands=gear.Leyline_Gloves, --8
    legs=gear.Taeon_FC_legs, --5
    feet=gear.Taeon_FC_feet, --5
    ear1="Loquac. Earring", --2
    ring1="Lebeche Ring", --Quick Magic 2%
    ring2="Weatherspoon Ring", --5
  }

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    ammo="Staunch Tathlum +1",
    neck="Magoraga Beads", --10
    ring1="Defending Ring",
  })

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    ammo="Impatiens", --10
    neck="Loricate Torque +1", --5
  }

  sets.midcast.Utsusemi = set_combine(sets.precast.FC.Utsusemi, sets.midcast.SpellInterrupt)

  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default WS set
  sets.precast.WS = {
    ammo="Aurgelmir Orb",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_WS1_Cape,
    waist="Fotia Belt",
    -- ammo="Aurgelmir Orb +1",
    -- ring2="Epaminondas's Ring",
  }
  -- When Sneak Attack active, overlaid on top of normal set
  sets.precast.WS.SA = {
    ammo="Yetshila +1",
    head="Pillager's Bonnet +3",
  }

  -- 73-85% AGI
  sets.precast.WS['Exenterator'] = {
    ammo="Seething Bomblet +1",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands="Meghanada Gloves +2",
    legs="Meghanada Chausses +2",
    feet="Meg. Jam. +2",
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Telos Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_WS1_Cape,
    waist="Fotia Belt",
    -- ammo="Cath Palug Stone",
    -- head="Plunderer's Bonnet +3",
    -- body="Plunderer's Vest +3",
    -- feet="Plunderer's Poulaines +3",
    -- back=gear.THF_WS3_Cape
  }
  sets.precast.WS['Exenterator'].MaxTP = set_combine(sets.precast.WS['Exenterator'], {
  })
  sets.precast.WS['Exenterator'].AttCapped = {
    ammo="Seething Bomblet +1",
    head=gear.Adhemar_B_head,
    body="Gleti's Cuirass",
    hands="Malignance Gloves",
    legs="Malignance Tights",
    feet="Meg. Jam. +2",
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Brutal Earring",
    ring1="Regal Ring",
    ring2="Ilabrat Ring",
    back=gear.THF_WS1_Cape,
    waist="Fotia Belt",
    -- ammo="Cath Palug Stone",
    -- head="Plunderer's Bonnet +3",
    -- feet="Plunderer's Poulaines +3",
    -- back=gear.THF_WS3_Cape
  }
  sets.precast.WS['Exenterator'].AttCappedMaxTP = set_combine(sets.precast.WS['Exenterator'].AttCapped, {
  })
  
  -- 50% DEX
  sets.precast.WS['Evisceration'] = {
    ammo="Yetshila +1",
    head=gear.Adhemar_B_head,
    body="Gleti's Cuirass",
    hands=gear.Adhemar_B_hands,
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_DEX_CritDmg_feet,
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Odr Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    waist="Fotia Belt",
    back=gear.THF_WS1_Cape,
    -- body="Plunderer's Vest +3",
    -- legs="Pillager's Culottes +3",
    -- feet=gear.Adhemar_B_feet,
    -- back=gear.THF_WS4_Cape,
  }
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear1="Sherida Earring",
  })
  sets.precast.WS['Evisceration'].AttCapped = {
    ammo="Yetshila +1",
    head=gear.Adhemar_B_head,
    body="Gleti's Cuirass",
    hands=gear.Adhemar_B_hands,
    legs=gear.Lustratio_B_legs,
    feet=gear.Herc_DEX_CritDmg_feet,
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Odr Earring",
    ring1="Ilabrat Ring",
    ring2="Regal Ring",
    waist="Fotia Belt",
    back=gear.THF_WS1_Cape,
    -- legs="Pillager's Culottes +3",
    -- feet=gear.Adhemar_B_feet,
    -- back=gear.THF_WS4_Cape,
  }
  sets.precast.WS['Evisceration'].AttCappedMaxTP = set_combine(sets.precast.WS['Evisceration'].AttCapped, {
    ear1="Sherida Earring",
  })

  -- 80% DEX
  sets.precast.WS["Rudra's Storm"] = {
    ammo="Aurgelmir Orb",               --  5, __,  7, __
    head="Gleti's Mask",                -- 28, __, 60,  6
    body="Gleti's Cuirass",             -- 34, __, 64,  9
    hands="Meghanada Gloves +2",        -- 50,  7, 43, __
    legs=gear.Nyame_B_legs,             -- __,  9, 55, __
    feet=gear.Nyame_B_feet,             -- 26,  8, 55, __
    neck="Assassin's Gorget +2",        -- 15, __, __, __
    ear1="Odr Earring",                 -- 10, __, __, __
    ear2="Moonshade Earring",           -- __, __, __, __; TP Bonus+250
    ring1="Ilabrat Ring",               -- 10, __, 25, __
    ring2="Regal Ring",                 -- 10, __, 20, __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20, __
    waist="Grunfeld Rope",              --  5, __, 20, __
    -- head="Plunderer's Bonnet +3",    -- 41, __, 62, __
    -- body="Plunderer's Vest +3",      -- 46, __, 65, __
    -- legs="Plunderer's Culottes +3"   -- 21,  6, 64, __
    -- feet="Plunderer's Poulaines +3", -- 37, __, 61, __
    -- 280 DEX, 23 WSD, 387 Att, __ PDL
  } -- 223 DEX, 34 WSD, 369 Att, 15 PDL
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
    ear2="Sherida Earring",
  })
  sets.precast.WS["Rudra's Storm"].AttCapped = {
    ammo="Aurgelmir Orb",               --  5, __,  7, __
    head="Gleti's Mask",                -- 28, __, 60,  6
    body="Gleti's Cuirass",             -- 34, __, 64,  9
    hands="Meghanada Gloves +2",        -- 50,  7, 43, __
    legs=gear.Lustratio_B_legs,         -- 43, __, __, __
    feet=gear.Lustratio_D_feet,         -- 48, __, __, __
    neck="Assassin's Gorget +2",        -- 15, __, __, __
    ear1="Odr Earring",                 -- 10, __, __, __
    ear2="Moonshade Earring",           -- __, __, __, __; TP Bonus+250
    ring1="Ilabrat Ring",               -- 10, __, 25, __
    ring2="Regal Ring",                 -- 10, __, 20, __
    back=gear.THF_WS1_Cape,             -- 30, 10, 20, __
    waist="Kentarch Belt +1",           -- 10, __, __, __
    -- Lustratio set bonus              -- __,  4, __, __

    -- ammo="Cath Palug Stone",         -- 10, __, __, __
    -- ring1="Epaminondas's Ring",      -- __,  5, __, __
    -- 288 DEX, 26 WSD, 207 Att, 15 PDL
  } -- 293 DEX, 21 WSD, 239 Att, 15 PDL
  sets.precast.WS["Rudra's Storm"].AttCappedMaxTP = set_combine(sets.precast.WS["Rudra's Storm"].AttCapped, {
    ear2="Sherida Earring",
  })
  -- Is overlaid, don't set_combine
  sets.precast.WS["Rudra's Storm"].SA = {
    ammo="Yetshila +1",
    head="Pillager's Bonnet +3",
    feet=gear.Lustratio_D_feet,
  }

  sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]
  sets.precast.WS['Mandalic Stab'].MaxTP = sets.precast.WS["Rudra's Storm"].MaxTP
  sets.precast.WS['Mandalic Stab'].AttCapped = sets.precast.WS["Rudra's Storm"].AttCapped
  sets.precast.WS['Mandalic Stab'].AttCappedMaxTP = sets.precast.WS["Rudra's Storm"].AttCappedMaxTP
  
  -- 40% DEX / 40% INT + MAB
  sets.precast.WS['Aeolian Edge'] = {
    ammo="Seething Bomblet +1", --7
    head=gear.Nyame_B_head, --30
    body=gear.Nyame_B_body, --30
    hands=gear.Nyame_B_hands, --30
    legs=gear.Nyame_B_legs, --30
    feet=gear.Herc_MAB_feet, --50
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring", --10
    ear2="Moonshade Earring",
    ring1="Shiva Ring +1", --3
    ring2="Dingir Ring",
    back=gear.DNC_WS1_Cape,
    waist="Eschan Stone", --7
    -- ring1="Epaminondas's Ring",
    -- waist="Orpheus's Sash",
  }
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Novio Earring", --7
  })

  -- 50% STR / 50% MND
  sets.precast.WS['Savage Blade'] = {
    ammo="Seething Bomblet +1",   -- 15, __, 13, 13, __, __, ___
    head=gear.Nyame_B_head,       -- 26, 26, 55, 40,  8, __, ___
    body=gear.Nyame_B_body,       -- 35, 37, 55, 40, 10, __, ___
    hands=gear.Nyame_B_hands,     -- 17, 40, 55, 40,  8, __, ___
    legs=gear.Nyame_B_legs,       -- 43, 32, 55, 40,  9, __, ___
    feet=gear.Nyame_B_feet,       -- 23, 26, 55, 40,  8, __, ___
    neck="Anu Torque",            -- __, __, 20, __, __, __, ___
    ear1="Ishvara Earring",       -- __, __, __, __,  2, __, ___
    ear2="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    ring1="Regal Ring",           -- 10, __, 20, __, __, __, ___
    ring2="Gere Ring",            -- 10, __, 16, __, __, __, ___
    back=gear.THF_WS2_Cape,       -- 30, __, 20, 20, 10, __, ___
    waist="Sailfi Belt +1",       -- 15, __, 15, __, __, __, ___
    -- ring1="Epaminondas's Ring",-- __, __, __, __,  5, __, ___
    -- 214 STR, 161 MND, 359 Attack, 237 Accuracy, 60 WSD, 0 PDL, 250 TP Bonus
  } -- 224 STR, 161 MND, 379 Attack, 237 Accuracy, 55 WSD, 0 PDL, 250 TP Bonus
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    ear2="Sherida Earring",       --  5, __, __, __, __, __, ___
  })
  sets.precast.WS['Savage Blade'].AttCapped = {
    ammo="Seething Bomblet +1",   -- 15, __, 13, 13, __, __, ___
    head=gear.Nyame_B_head,       -- 26, 26, 55, 40,  8, __, ___
    body=gear.Nyame_B_body,       -- 35, 37, 55, 40, 10, __, ___
    hands=gear.Nyame_B_hands,     -- 17, 40, 55, 40,  8, __, ___
    legs=gear.Nyame_B_legs,       -- 43, 32, 55, 40,  9, __, ___
    feet=gear.Nyame_B_feet,       -- 23, 26, 55, 40,  8, __, ___
    neck="Anu Torque",            -- __, __, 20, __, __, __, ___
    ear1="Ishvara Earring",       -- __, __, __, __,  2, __, ___
    ear2="Moonshade Earring",     -- __, __, __,  4, __, __, 250
    ring1="Regal Ring",           -- 10, __, 20, __, __, __, ___
    ring2="Gere Ring",            -- 10, __, 16, __, __, __, ___
    back=gear.THF_WS2_Cape,       -- 30, __, 20, 20, 10, __, ___
    waist="Sailfi Belt +1",       -- 15, __, 15, __, __, __, ___
    -- ring1="Epaminondas's Ring",-- __, __, __, __,  5, __, ___
    -- 214 STR, 161 MND, 359 Attack, 237 Accuracy, 60 WSD, 0 PDL, 250 TP Bonus
  } -- 224 STR, 161 MND, 379 Attack, 237 Accuracy, 55 WSD, 0 PDL, 250 TP Bonus
  sets.precast.WS['Savage Blade'].AttCappedMaxTP = set_combine(sets.precast.WS['Savage Blade'].AttCapped, {
    ear2="Sherida Earring",       --  5, __, __, __, __, __, ___
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  sets.midcast.SpellInterrupt = {
    ammo="Impatiens", --10
    -- ring1="Evanescence Ring", --5
  }

  sets.midcast.Utsusemi = sets.midcast.SpellInterrupt


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.LightDef = {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139 
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    feet="Malignance Boots",    --  4/ 4, 150
    back=gear.THF_TP_Cape,      -- 10/__, ___
  } --44 PDT/34 MDT, 674 MEVA

  sets.Evasion = {
    ammo="Yamarang",              -- __/__,  15,  15
    head="Malignance Chapeau",    --  6/ 6, 123,  91
    body="Malignance Tabard",     --  9/ 9, 139, 102
    hands="Malignance Gloves",    --  5/ 5, 112,  80
    legs="Malignance Tights",     --  7/ 7, 150,  85
    feet="Malignance Boots",      --  4/ 4, 150, 119
    neck="Assassin's Gorget +2",  -- __/__, ___,  25
    ear1="Eabani Earring",        -- __/__,   8,  15
    ear2="Infused Earring",       -- __/__, ___,  10
    ring1="Moonlight Ring",       --  5/ 5, ___, ___
    ring2="Moonlight Ring",       --  5/ 5, ___, ___
    waist="Kasiri Belt",          -- __/__, ___,  13
  } -- 51 PDT / 41 MDT, 697 MEVA, 555 Evasion

  sets.HeavyDef = {
    ammo="Yamarang",            -- __/__,  15
    head="Malignance Chapeau",  --  6/ 6, 123
    body="Malignance Tabard",   --  9/ 9, 139
    hands="Malignance Gloves",  --  5/ 5, 112
    legs=gear.Nyame_B_legs,     --  8/ 8, 150
    feet=gear.Nyame_B_feet,     --  7/ 7, 150
    neck="Loricate Torque +1",  --  6/ 6, ___
    ear1="Eabani Earring",      -- __/__,   8
    ear2="Odnowa Earring +1",   --  3/ 5, ___
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
    waist="Engraved Belt",      -- __/__, ___
  } --69 PDT/61 MDT, 697 MEVA

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Turms Cap +1",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
  }
  sets.latent_regen = {
    head="Turms Cap +1",
    body="Meghanada Cuirie +2",
    hands="Turms Mittens +1",
    legs="Meghanada Chausses +2",
    feet="Turms Leggings +1",
    neck="Bathy Choker +1",
    ear1="Infused Earring",
    ring1="Chirich Ring +1",
  }
  sets.latent_refresh = {
    head=gear.Herc_Refresh_head,
    legs="Rawhide Trousers",
    feet=gear.Herc_Refresh_feet,
  }

  sets.resting = {}

  sets.idle = set_combine(sets.HeavyDef, {
    head="Turms Cap +1",        -- __/__, 109
    body="Gleti's Cuirass",     --  9/__, 102
    hands="Gleti's Gauntlets",  --  7/__, 75
    legs="Gleti's Breeches",    --  8/__, 112
  })

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

  sets.idle.Evasion = set_combine(sets.idle, sets.Evasion)

  sets.idle.Weak = set_combine(sets.HeavyDef, {
    neck="Loricate Torque +1",  --  6/ 6, ___
    ring1="Gelatinous Ring +1", --  7/-1, ___
    ring2="Moonlight Ring",     --  5/ 5, ___
    back="Moonlight Cape",      --  6/ 6, ___
  })
  

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Plunderer's Poulaines +2",
    neck="Assassin's Gorget +2",
    ear1="Dedition Earring",
    ear2="Sherida Earring",
    ring1="Hetairoi Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Windbuffet Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- body="Plunderer's Vest +3",
    -- feet="Plunderer's Poulaines +3",
  }
  sets.engaged.LowAcc = set_combine(sets.engaged, {
    ammo="Yamarang",
    ear1="Telos Earring",
  })
  sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
    legs="Malignance Tights",
  })
  sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
    ring1="Regal Ring",
    -- hands="Pillager's Armlets +3",
  })

  -- * THF Native DW Trait: 30% DW

  -- No Magic/Gear/JA Haste (74% DW to cap, 44% from gear)
  sets.engaged.DW = {
    ammo="Yamarang",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, -- 6
    hands=gear.Floral_Gauntlets, --5
    legs=gear.Samnuha_legs,
    feet=gear.Taeon_DW_feet, --9
    neck="Assassin's Gorget +2",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Hetairoi Ring",
    ring2="Gere Ring",
    back=gear.THF_DW_Cape, --10
    waist="Reiki Yotai", --7
    -- hands="Pillager's Armlets +3", --5
    -- feet=gear.Herc_DW_feet, --5
  }--36
  sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
    ammo="Yamarang",
  })
  sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
    legs="Malignance Tights",
  })
  sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
    ear1="Telos Earring",
    ring1="Regal Ring",
    -- hands="Pillager's Armlets +3", --5
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 37% from gear)
  sets.engaged.DW.LowHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Plunderer's Poulaines +2",
    neck="Assassin's Gorget +2",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Hetairoi Ring",
    ring2="Gere Ring",
    back=gear.THF_DW_Cape, --10
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- hands="Pillager's Armlets +3" --5
    -- feet="Plunderer's Poulaines +3",
  }
  sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    ammo="Yamarang",
  })
  sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    legs="Malignance Tights",
  })
  sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    ring1="Regal Ring",
  })

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 26% from gear)
  sets.engaged.DW.MidHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Plunderer's Poulaines +2",
    neck="Assassin's Gorget +2",
    ear1="Suppanomimi", --5
    ear2="Eabani Earring", --4
    ring1="Hetairoi Ring",
    ring2="Gere Ring",
    back=gear.THF_DW_Cape, --10
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- body="Plunderer's Vest +3",
    -- feet="Plunderer's Poulaines +3",
  }--22
  sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    ammo="Yamarang",
  })
  sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    legs="Malignance Tights",
  })
  sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    ear1="Telos Earring",
    ring1="Regal Ring",
    -- hands="Pillager's Armlets +3", --5
  })

  -- High Magic/Gear/JA Haste (43% DW to cap, 13% from gear)
  sets.engaged.DW.HighHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Plunderer's Poulaines +2",
    neck="Assassin's Gorget +2",
    ear1="Suppanomimi", --5
    ear2="Sherida Earring",
    ring1="Hetairoi Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- body="Plunderer's Vest +3",
    -- feet="Plunderer's Poulaines +3",
  }
  sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    ammo="Yamarang",
  })
  sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    legs="Malignance Tights",
  })
  sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    ear1="Telos Earring",
    ring1="Regal Ring",
    -- hands="Pillager's Armlets +3", --5
  })

  -- High Magic/Gear/JA Haste (36% DW to cap, 6% from gear)
  sets.engaged.DW.SuperHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body, --6
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Plunderer's Poulaines +2",
    neck="Assassin's Gorget +2",
    ear1="Dedition Earring",
    ear2="Sherida Earring",
    ring1="Hetairoi Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Reiki Yotai", --7
    -- ammo="Aurgelmir Orb +1",
    -- body="Plunderer's Vest +3",
    -- feet="Plunderer's Poulaines +3",
  }
  sets.engaged.DW.LowAcc.SuperHaste = set_combine(sets.engaged.DW.SuperHaste, {
    ammo="Yamarang",
    ear1="Telos Earring",
  })
  sets.engaged.DW.MidAcc.SuperHaste = set_combine(sets.engaged.DW.LowAcc.SuperHaste, {
    legs="Malignance Tights",
  })
  sets.engaged.DW.HighAcc.SuperHaste = set_combine(sets.engaged.DW.MidAcc.SuperHaste, {
    -- legs="Pillager's Coulottes +3",
    ring1="Regal Ring",
  })

  -- Max Magic/Gear/JA Haste (0-30% DW to cap, 0% from gear)
  sets.engaged.DW.MaxHaste = {
    ammo="Aurgelmir Orb",
    head=gear.Adhemar_B_head,
    body=gear.Adhemar_B_body,
    hands=gear.Adhemar_B_hands,
    legs=gear.Samnuha_legs,
    feet="Plunderer's Poulaines +2",
    neck="Assassin's Gorget +2",
    ear1="Dedition Earring",
    ear2="Sherida Earring",
    ring1="Hetairoi Ring",
    ring2="Gere Ring",
    back=gear.THF_TP_Cape,
    waist="Windbuffet Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- body="Plunderer's Vest +3",
    -- feet="Plunderer's Poulaines +3",
  }
  sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    ammo="Yamarang",
    ear1="Telos Earring",
  })
  sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    legs="Malignance Tights",
  })
  sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    -- legs="Pillager's Coulottes +3",
    ring1="Regal Ring",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- No DW
  sets.engaged.LightDef = set_combine(sets.engaged, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LowAcc, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.MidAcc, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.HighAcc, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26

  -- No Magic/Gear/JA Haste (74% DW to cap, 44% from gear)
  sets.engaged.DW.LightDef = set_combine(sets.engaged.DW, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.LowAcc.LightDef = set_combine(sets.engaged.DW.LowAcc, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.MidAcc.LightDef = set_combine(sets.engaged.DW.MidAcc, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    ring2="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.HighAcc.LightDef = set_combine(sets.engaged.DW.HighAcc, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26

  -- Low Magic/Gear/JA Haste (67% DW to cap, 37% from gear)
  sets.engaged.DW.LightDef.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Defending Ring",     -- 10/10, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.LowAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Defending Ring",     -- 10/10, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.MidAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Defending Ring",     -- 10/10, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.HighAcc.LightDef.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 26% from gear)
  sets.engaged.DW.LightDef.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.LowAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.MidAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.HighAcc.LightDef.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_DW_Cape,      -- 10/__, ___
  })-- 36/26

  -- High Magic/Gear/JA Haste (43% DW to cap, 13% from gear)
  sets.engaged.DW.LightDef.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.LowAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.MidAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.HighAcc.LightDef.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26

  -- Max Magic/Gear/JA Haste (0-30% DW to cap, 0% from gear)
  sets.engaged.DW.LightDef.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.LowAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.MidAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    hands="Malignance Gloves",  --  5/ 5, 112
    legs="Malignance Tights",   --  7/ 7, 150
    ring1="Moonlight Ring",     --  5/ 5, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26
  sets.engaged.DW.HighAcc.LightDef.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, {
    ammo="Staunch Tathlum +1",  --  3/ 3, ___
    head="Malignance Chapeau",  --  6/ 6, 123
    legs="Malignance Tights",   --  7/ 7, 150
    ring2="Defending Ring",     -- 10/10, ___
    back=gear.THF_TP_Cape,      -- 10/__, ___
  })-- 36/26

  sets.engaged.Evasion = sets.Evasion
  sets.engaged.LowAcc.Evasion = sets.Evasion
  sets.engaged.MidAcc.Evasion = sets.Evasion
  sets.engaged.HighAcc.Evasion = sets.Evasion

  sets.engaged.DW.Evasion = sets.Evasion
  sets.engaged.DW.LowAcc.Evasion = sets.Evasion
  sets.engaged.DW.MidAcc.Evasion = sets.Evasion
  sets.engaged.DW.HighAcc.Evasion = sets.Evasion


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

  sets.Kiting = {
    feet="Skadi's Jambeaux +1",
    -- feet="Pillager's Poulaines +3",
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

  sets.WeaponSet = {}
  sets.WeaponSet['WhiteGlass'] = {
    main="Twashtar",
    sub={name="Centovente", priority=1},
  }
  sets.WeaponSet['Normal'] = {
    main="Aeneas",
    sub="Twashtar",
    -- main="Twashtar",
    -- sub="Gleti's Knife",
  }
  sets.WeaponSet['LowAtt'] = {
    -- main="Vajra",
    -- sub="Centovente",
  }
  sets.WeaponSet['Naegling'] = {
    main="Naegling",
    sub="Centovente",
  }
  sets.WeaponSet['H2H'] = {
    main="Kaja Knuckles",
    sub=empty,
    -- main="Karambit",
  }
  -- sets.WeaponSet['SoloCleaving'] = {
  --   main=gear.Gandring_C,
  --   sub="Tauret",
  -- }
  sets.WeaponSet['Cleaving'] = {
    main="Kaja Knife",
    sub="Twashtar",
    -- main="Tauret",
  }
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
  if spellMap == 'Utsusemi' then
    if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
      cancel_spell()
      add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
      eventArgs.handled = true
      return
    elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
      send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
    end
  end
  if spell.type == 'WeaponSkill' then
    if state.Buff['Sneak Attack'] then
    -- If set isn't found for specific ws, overlay the default set
      local set = (sets.precast.WS[spell.name] and sets.precast.WS[spell.name].SA) or sets.precast.WS.SA or {}
      equip(set)
    end
    -- Handle special gear scenario for elemental WS
    if elemental_ws:contains(spell.english) then
      local base_day_weather_mult = silibs.get_day_weather_multiplier(spell.element, false, false)
      local obi_mult = silibs.get_day_weather_multiplier(spell.element, true, false)
      local orpheus_mult = silibs.get_orpheus_multiplier(spell.element, spell.target.distance)

      -- Determine which combination to use: orpheus, hachirin-no-obi, or neither
      if base_day_weather_mult >= obi_mult and base_day_weather_mult >= orpheus_mult then
        -- Wearing neither obi nor orpheus is better, both are harmful
      elseif obi_mult >= orpheus_mult then
        -- Obi is best
        equip(sets.Special.ElementalObi)
      else
        -- Orpheus is best
        -- equip({waist="Orpheus's Sash"})
        equip(sets.Special.ElementalObi) -- I don't have Orpheus yet
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
  if spell.type == 'WeaponSkill' and not spell.interrupted then
    state.Buff['Sneak Attack'] = false
    state.Buff['Trick Attack'] = false
    state.Buff['Feint'] = false
  end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)

  if buff == 'sleep' and gain and player.vitals.hp > 500 and player.status == 'Engaged' then
    equip(sets.Special.SleepyHead)
  end

  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end

  -- Update gear for these specific buffs
  if buff == "Sneak Attack" or buff == "Trick Attack" or buff == "doom" then
    status_change(player.status)
  end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  update_combat_form()
  determine_haste_group()

  -- Check for SATA when equipping gear.  If either is active, equip
  -- that gear specifically, and block equipping default gear.
  check_buff('Sneak Attack', eventArgs)
  check_buff('Trick Attack', eventArgs)
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
end

function update_combat_form()
  if DW == true then
    state.CombatForm:set('DW')
  elseif DW == false then
    state.CombatForm:reset()
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
  local main = player.equipment.main
  local sub = player.equipment.sub
  local weapon_bonus = (tp_bonus_weapons[main] or 0) + (tp_bonus_weapons[sub] or 0)
  local buff_bonus = T{
    buffactive['Crystal Blessing'] and 250 or 0,
  }:sum()
  if player.tp > 3000-weapon_bonus-buff_bonus-buffer then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
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

  defenseSet = set_combine(defenseSet, silibs.customize_defense_set(defenseSet))
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
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

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
  if player.sub_job == 'DNC' then
    local s_msg = state.MainStep.current
    msg = msg ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
  end
  if state.CP.current == 'on' then
    msg = msg .. ' CP Mode: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
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

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 0 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 0 and DW_needed <= 6 then
      classes.CustomMeleeGroups:append('SuperHaste')
    elseif DW_needed > 6 and DW_needed <= 13 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 13 and DW_needed <= 26 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 26 and DW_needed <= 37 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 37 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'step' then
    send_command('@input /ja "'..state.MainStep.Current..'" <t>')
  elseif cmdParams[1] == 'toyweapon' then
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
  elseif cmdParams[1] == 'rune' then
    send_command('@input /ja '..state.Runes.value..' <me>')
  elseif cmdParams[1] == 'test' then
    test()
  end

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
    if not midaction() then
      job_update()
    end
  end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
  if state.Buff[buff_name] then
    equip(sets.buff[buff_name] or {})
    eventArgs.handled = true
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
  -- Default macro set/book
  if player.sub_job == 'DNC' then
    set_macro_page(1, 8)
  elseif player.sub_job == 'WAR' then
    set_macro_page(2, 8)
  elseif player.sub_job == 'NIN' then
    set_macro_page(3, 8)
  elseif player.sub_job == 'RUN' then
    set_macro_page(4, 8)
  else
    set_macro_page(1, 8)
  end
end

function test()
end