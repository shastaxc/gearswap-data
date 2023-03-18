-- File Status: Ok. Sets are outdated since Sortie release. Never actually used this lua, more hypothetical than practical.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: HasteInfo
-- Recommended addons: WSBinder, Reorganizer
-- Misc Recommendations: Disable GearInfo, disable RollTracker

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ CTRL+B ]          Toggle Battle Mode
--              [ CTRL+Delete ]     Weapon Weapons
--              [ CTRL+Insert ]     Cycleback Weapons
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
  Custom commands:

  You can set these via the standard 'set' and 'cycle' self-commands.  EG:
  gs c cycle SongMode
  gs c set SongMode Placeholder

  The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.

  Simple macro to cast a placeholder Daurdabla song:
  /console gs c set SongMode Placeholder
  /ma "Shining Fantasia" <me>

  To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
  'Terpander', and info.ExtraSongs to 1.
--]]

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
  silibs.enable_auto_lockstyle(11)
  silibs.enable_premade_commands()
  silibs.enable_th()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_haste_info()

  -- Adjust this if using the Terpander (new +song instrument)
  info.ExtraSongInstrument = 'Daurdabla'
  -- How many extra songs we can keep from Daurdabla/Terpander
  info.ExtraSongs = 2

  state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

  state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}
  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('DT', 'Normal')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT')
  state.CP = M(false, "Capacity Points Mode")
  state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}
  state.Carol = M{['description']='Carol',
      'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
      'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
      'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
      }
  state.Threnody = M{['description']='Threnody',
      'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
      'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
      }
  state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
      'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
      'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'}
  state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Carnwenhan', 'Twashtar', 'Tauret', 'Aeneas', 'Cleaving', 'Free'}
  state.BattleMode = M(true, 'Battle Mode')
  state.WeaponLock = M(false, 'Weapon Lock')

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle WeaponLock')
  send_command('bind ^b gs c toggle BattleMode')

  send_command('bind ^` gs c cycle SongMode')
  send_command('bind !` input /ma "Chocobo Mazurka" <me>')
  send_command('bind !p input /ja "Pianissimo" <me>')

  send_command('bind ^backspace gs c cycle SongTier')
  send_command('bind ^[ gs c cycleback Etude')
  send_command('bind ^] gs c cycle Etude')
  send_command('bind ^; gs c cycleback Carol')
  send_command('bind ^\' gs c cycle Carol')
  send_command('bind ^, gs c cycleback Threnody')
  send_command('bind ^. gs c cycle Threnody')

  send_command('bind @` gs c cycle LullabyMode')
  send_command('bind @c gs c toggle CP')
  send_command('bind ^delete gs c cycleback WeaponSet')
  send_command('bind ^insert gs c cycle WeaponSet')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  -- Additional local binds
  include('Global-Binds.lua')

  select_default_macro_book()
  set_lockstyle()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')
  send_command('unbind ^b')

  send_command('unbind ^`')
  send_command('unbind !`')
  send_command('unbind !p')

  send_command('unbind ^backspace')
  send_command('unbind ^[')
  send_command('unbind ^]')
  send_command('unbind ^;')
  send_command('unbind ^\'')
  send_command('unbind ^,')
  send_command('unbind ^.')

  send_command('unbind @`')
  send_command('unbind @c')
  send_command('unbind ^delete')
  send_command('unbind ^insert')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}
  sets.org.job[1] = {range="Marsyas"}
  sets.org.job[2] = {range="Daurdabla"}
  sets.org.job[3] = {range="Gjallarhorn"}
  
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- FC caps 80% but some pieces will be replaced depending on spell type
  sets.precast.FC = {
    sub="Genmei Shield",        -- __ (10, __, ___)
    head="Bunzi's Hat",         -- 10 ( 7,  7, 123)
    body="Inyanga Jubbah +2",   -- 14 (__,  8, 120)
    hands=gear.Leyline_Gloves,  --  8 (__, __,  62)
    legs="Volte Brais",         --  8 (__, __, 142); Chironic good alt
    neck="Orunmila's Torque",   --  5 (__, __, ___)
    ear1="Loquac. Earring",     --  2 (__, __, ___)
    ear2="Etiolation Earring",  --  1 (__,  3, ___)
    ring1="Defending Ring",     -- __ (10, 10, ___)
    ring2="Kishar Ring",        --  4 (__, __, ___)
    back=gear.BRD_Song_Cape,    -- 10 (10, __, ___)
    waist="Embla Sash",         --  5 (__, __, ___)
    -- main="Kali",             --  7 (__, __, ___)
    -- range=gear.Linos_FC,     --  6 (__, __,  15)
    -- feet="Volte Gaiters",    --  6 (__, __, 142); Chironic good alt
    -- 86 Fast Cast (37 PDT, 28 MDT, 604 MEVA)
  } -- 67 Fast Cast (37 PDT, 28 MDT, 447 MEVA)

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash",
  })

  -- Total cast speed cap 80%, fill in rest with defensive gear
  sets.precast.FC.Cure = {
    sub="Genmei Shield",              -- __, __ (10, __, ___)
    head="Bunzi's Hat",               -- 10, __ ( 7,  7, 123)
    body="Inyanga Jubbah +2",         -- 14, __ (__,  8, 120)
    legs=gear.Nyame_B_legs,           -- __, __ ( 8,  8, 150)
    neck="Loricate Torque +1",        -- __, __ ( 6,  6, ___)
    ear2="Etiolation Earring",        --  1, __ (__,  3, ___)
    ring1="Kishar Ring",              --  4, __ (__, __, ___)
    ring2="Defending Ring",           -- __, __ (10, 10, ___)
    back=gear.BRD_Song_Cape,          -- 10, __ (10, __, ___)
    waist="Embla Sash",               --  5, __ (__, __, ___)
    -- main="Kali",                   --  7, __ (__, __, ___)
    -- range=gear.Linos_FC,           --  6, __ (__, __,  15)
    -- hands=gear.Gende_CureFC_hands, --  7,  5 ( 4, __,  37)
    -- feet=gear.Vanya_B_feet,        -- __,  7 (__, __, 107)
    -- ear1="Mendi. Earring",         -- __,  5 (__, __, ___)
    -- 64 Fast Cast, 17 Cure Cast Time- (55 PDT, 42 MDT, 552 Magic Evasion)
  } -- 44 Fast Cast, 0 Cure Cast Time- (51 PDT, 42 MDT, 393 Magic Evasion)

  -- Total cast speed cap 80%, "song cast time-" cap 50%, fill in rest with defensive gear
  -- Don't use Quick Magic for songs because lag might mess up midcast sets
  sets.precast.FC.BardSong = {
    sub="Genmei Shield",              -- __, __, __ (10, __, ___)
    head="Bunzi's Hat",               -- 10, __, __ ( 7,  7, 123)
    body="Inyanga Jubbah +2",         -- 14, __, __ (__,  8, 120)
    hands=gear.Gende_SongFC_hands,    --  7,  4, __ ( 4,  2,  37)
    legs=gear.Gende_SongFC_legs,      -- __,  9, __ ( 3, __, 107)
    neck="Loricate Torque +1",        -- __, __, __ ( 6,  6, ___)
    ear1="Loquac. Earring",           --  2, __, __ (__, __, ___)
    ear2="Etiolation Earring",        --  1, __, __ (__,  3, ___)
    ring1="Defending Ring",           -- __, __, __ (10, 10, ___)
    ring2="Kishar Ring",              --  4, __, __ (__, __, ___)
    back=gear.BRD_Song_Cape,          -- 10, __, __ (10, __, ___)
    waist="Embla Sash",               --  5, __, __ (__, __, ___)
    -- main="Kali",                   --  7, __, __ (__, __, ___)
    -- range=gear.Linos_FC,           --  6, __, __ (__, __,  15)
    -- hands=gear.Gende_SongFC_hands, --  7,  5,  3 ( 4, __,  37)
    -- legs=gear.Gende_SongFC_legs,   -- __, 10,  3 ( 4, __, 107)
    -- feet="Volte Gaiters",          --  6, __, __ (__, __, 142); Chironic good alt
    -- ear2="Enchanter's Earring +1", --  2, __, __ (__, __, ___)
    -- JP Gifts                          __,  5, __ (__, __, ___)
    -- 73 Fast Cast, 20 Song Cast Time-, 6 Song Recast- (51 PDT, 31 MDT, 544 Magic Evasion)
  } -- 53 Fast Cast, 17 Song Cast Time-, 0 Song Recast- (50 PDT, 36 MDT, 387 Magic Evasion)

  sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {
    range=info.ExtraSongInstrument,
  })

  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",
    sub="Genmei Shield",
    -- sub="Ammurapi Shield", -- M.Acc
    -- waist="Shinjutsu-no-Obi +1", -- Conserve MP
  })

  -- Precast sets to enhance JAs
  sets.precast.JA.Nightingale = {
    -- feet="Bihu Slippers +3", -- +1 is acceptable
  }
  sets.precast.JA.Troubadour = {
    -- body="Bihu Jstcorps. +3", -- +1 is acceptable
  }
  sets.precast.JA['Soul Voice'] = {
    -- legs="Bihu Cannions +3", -- +1 is acceptable
  }

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Epaminondas's Ring",
    ring2="Ilabrat Ring",
    waist="Fotia Belt",
    -- range=gear.Linos_WS3,
    -- back=gear.BRD_WS1_Cape,
  }

  -- Specific weaponskill sets.
  -- Modifiers: 70% CHR / 30% DEX
  sets.precast.WS['Mordant Rime'] = {
    ear1="Regal Earring",         -- __, __, __, __, __, __, 10, __
    ear2="Ishvara Earring",       --  2, __, __, __, __, __, __, __
    ring1="Metamor. Ring +1",     -- __, __, __, __, __, __, 16, __
    ring2="Epaminondas's Ring",   --  5, __, __, __, __, __, __, __
    waist="Kentarch Belt +1",     -- __, __, __,  3, __, 14, __, 10
    -- range=gear.Linos_WS2,      --  3, __, __, __, 15, 15,  8, __
    -- head="Bihu Roundlet +3",   -- __, __, __, __, 62, 37, 40, 24
    -- body="Bihu Jstcorps. +3",  -- 10, __, __, __, 92, 53, 43, 41
    -- hands="Bihu Cuffs +3",     -- __, __, __, __, 63, 38, 33, 38
    -- legs="Bihu Cannions +3",   -- __, __, __, __, 64, 39, 43, __
    -- feet="Bihu Slippers +3",   -- __, __, __, __, 61, 36, 48, 21
    -- neck="Bard's Charm +2",    -- __,  3, __, __, __, 30, 25, 25
    -- back=gear.BRD_WS1_Cape,    -- 10, __, __, __, 20, 20, 30, __
  } -- 30 WSD, 3 QA, 0 TA, 3 DA, 377 Att, 282 Acc, 296 CHR, 159 DEX

  -- Modifiers: 80% DEX
  sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
    head=gear.Lustratio_D_head,     -- __, __, __, __, __, __, 45
    legs=gear.Lustratio_B_legs,     -- __, __, __, __, 38, 20, 43
    feet=gear.Lustratio_D_feet,     -- __, __, __, __, __, __, 48
    ear1="Moonshade Earring",       -- __, __, __, __, __,  4, __; 250 TP Bonus
    ear2="Ishvara Earring",         --  2, __, __, __, __, __, __
    ring1="Ilabrat Ring",           -- __, __, __, __, 25, __, 10
    ring2="Epaminondas's Ring",     --  5, __, __, __, __, __, __
    waist="Kentarch Belt +1",       -- __, __, __,  3, __, 14, 10
    -- range=gear.Linos_WS3,        --  3, __, __, __, 15, 15,  8
    -- body="Bihu Jstcorps. +3",    -- 10, __, __, __, 92, 53, 41
    -- hands=gear.Lustratio_D_hands,-- __, __, __, __, __, 30, 54
    -- neck="Bard's Charm +2",      -- __,  3, __, __, __, 30, 25
    -- back=gear.BRD_WS1_Cape,      -- 10, __, __, __, 20, 20, 30
    -- Lustr. Set bonus                 8, __, __, __, __, __, __
  }) -- 38 WSD, 3 QA, 0 TA, 3 DA, 190 Att, 186 Acc, 314 DEX
  sets.precast.WS["Rudra's Storm"].MaxTP = set_combine(sets.precast.WS["Rudra's Storm"], {
    ear1="Odr Earring",             -- __, __, __, __, __, 10, 10
  })

  -- Modifiers: 50% DEX, Focus: crit rate
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    body="Ayanmo Corazza +2",       -- __, __, __,  7, __, 46, 48, __
    legs=gear.Lustratio_B_legs,     -- __, __, __, __, 38, 20, 43,  3
    neck="Fotia Gorget",            -- 10, __, __, __, __, __, __, __
    ear1="Moonshade Earring",       -- __, __, __, __, __,  4, __, __; 250 TP Bonus
    ear2="Brutal Earring",          -- __, __, __,  5, __, __, __, __
    ring1="Hetairoi Ring",          -- __, __,  2, __, __, __, __,  1
    ring2="Begrudging Ring",        -- __, __, __, __,  7,  7, __,  5
    waist="Fotia Belt",             -- 10, __, __, __, __, __, __, __
    -- range=gear.Linos_WS3,        --  3, __, __, __, 15, 15,  8, __
    -- head="Blistering Sallet +1", -- __, __, __,  3, __, 53, 41, 10
    -- hands=gear.Lustratio_B_hands,-- __, __, __, __, __, 20, 52,  3
    -- feet=gear.Lustratio_B_feet,  -- __, __, __, __, __, 20, 41,  3
    -- back=gear.BRD_WS3_Cape,      -- __, __, __, __, 20, 20, 30, 10
  }) -- 23 WSD, 0 QA, 2 TA, 15 DA, 80 Att, 205 Acc, 263 DEX, 35 crit rate
  sets.precast.WS['Evisceration'].MaxTP = set_combine(sets.precast.WS['Evisceration'], {
    ear1="Odr Earring",             -- __, __, __, __, __, 10, 10
  })

  -- Modifiers: 85% AGI, Focus: multi-attack
  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    body="Ayanmo Corazza +2",     -- __, __, __,  7, __, 46, 33
    neck="Fotia Gorget",          -- 10, __, __, __, __, __, __
    ear1="Brutal Earring",        -- __, __, __,  5, __, __, __
    ear2="Cessance Earring",      -- __, __, __,  3, __,  6, __
    ring1="Hetairoi Ring",        -- __, __,  2, __, __, __, __
    ring2="Ilabrat Ring",         -- __, __, __, __, __, __, 10
    waist="Fotia Belt",           -- 10, __, __, __, __, __, __
    -- range=gear.Linos_WS4,      -- __,  3, __,  3, 15, 15, __
    -- head="Bihu Roundlet +3",   -- __, __, __, __, 62, 37, 24
    -- hands="Bihu Cuffs +3",     -- __, __, __, __, 63, 38, 15
    -- legs=gear.Telchine_DA_legs,--  3, __, __,  6, 20, __, 15
    -- feet="Bihu Slippers +3",   -- __, __, __, __, 61, 36, 43
    -- back=gear.BRD_WS4_Cape,    -- __, __, __, 10, 20, 20, 30
    -- 23 WSD, 3 QA, 2 TA, 34 DA, 241 Att, 198 Acc, 170 AGI
  })

  -- Modifiers: 40% DEX / 40% INT, Focus: MAB
  sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
    head=gear.Nyame_B_head,       -- 10, 
    body=gear.Nyame_B_body,       -- 12, 
    hands=gear.Nyame_B_hands,     -- 10, 
    legs=gear.Nyame_B_legs,       -- 11, 
    feet=gear.Nyame_B_feet,       -- 10, 
    neck="Sibyl Scarf",           -- __, __, 10, 10
    ear1="Moonshade Earring",     -- __, __, __, __; 250 TP Bonus
    ear2="Friomisi Earring",      -- __, __, __, 10
    ring1="Shiva Ring +1",        -- __, __,  9,  3
    ring2="Epaminondas's Ring",   --  5, __, __, __
    waist="Skrymir Cord",         -- __, __, __,  5; +30 M.Dmg
    -- range=gear.Linos_WS1,      --  3, __,  8, 20
    -- back=gear.BRD_WS2_Cape,    -- 10, 30, __, __
    -- 58 WSD, 166 DEX, 213 INT, 248 MAB
  })
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear1="Regal Earring",         -- __, __, 10,  7
  })

  -- Modifiers: 50% STR / 50% MND
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    head=gear.Nyame_B_head,       -- 10, __, __,  5, 65, 50, 26, 26
    body=gear.Nyame_B_body,       -- 12, __, __,  7, 65, 40, 45, 37
    hands=gear.Nyame_B_hands,     -- 10, __, __,  5, 65, 40, 17, 40
    legs=gear.Nyame_B_legs,       -- 11, __, __,  6, 65, 40, 58, 32
    feet=gear.Nyame_B_feet,       -- 10, __, __,  5, 65, 53, 23, 26
    ear1="Moonshade Earring",     -- __, __, __, __, __,  4, __, __; 250 TP Bonus
    ear2="Regal Earring",         -- __, __, __, __, __, __, __, 10
    ring1="Sroda Ring",           -- __, __, __, __, __, __, 15, __
    ring2="Epaminondas's Ring",   --  5, __, __, __, __, __, __, __
    waist="Sailfi Belt +1",       -- __, __,  2,  5, 15, __, 15, __
    -- range=gear.Linos_WS5,      --  3, __, __, __, 15, 15,  8, __
    -- neck="Bard's Charm +2",    -- __,  3, __, __, __, 30, __, __
    -- back=gear.BRD_WS5_Cape,    -- 10, __, __, __, 20, 20, 30, __
    -- 71 WSD, 3 QA, 2 TA, 33 DA, 375 Att, 292 Acc, 237 STR, 171 MND
  })
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    -- ear1="Vulcan's Pearl",     -- __, __, __, __, __, __,  4, __
  })

  -- Modifiers: 100% STR
  sets.precast.WS['Circle Blade'] = set_combine(sets.precast.WS, {
    ear2="Ishvara Earring",         --  2, __, __, __, __, __, __
    ring2="Epaminondas's Ring",     --  5, __, __, __, __, __, __
    waist="Sailfi Belt +1",         -- __, __,  2,  5, 15, __, 15
    -- range=gear.Linos_WS5,        --  3, __, __, __, 15, 15,  8
    -- head=gear.Lustratio_A_head,  -- __, __, __,  3, 20, __, 47
    -- body="Bihu Jstcorps. +3",    -- 10, __, __, __, 92, 53, 39
    -- hands=gear.Lustratio_A_hands,-- __, __, __,  3, 20, __, 30
    -- legs="Bihu Cannions +3",     -- __, __, __, __, 64, 39, 33
    -- feet=gear.Lustratio_A_feet,  -- __, __, __,  3, 20, __, 40
    -- neck="Bard's Charm +2",      -- __,  3, __, __, __, 30, __
    -- ear1="Vulcan's Pearl",       -- __, __, __, __, __, __,  4
    -- ring1="Ifrit Ring +1",       -- __, __, __, __,  5, __,  9
    -- back=gear.BRD_WS5_Cape,      -- 10, __, __, __, 20, 20, 30
  }) -- 30 WSD, 3 QA, 2 TA, 14 DA, 271 Att, 157 Acc, 255 STR


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- General set for recast times.
  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  -- Song-specific gear to enhance party buff songs.
  sets.midcast.Ballad = {
    -- legs="Fili Rhingrave +1",
  }
  sets.midcast.Minne = {
    -- legs="Mousai Seraweels +1",
  }
  sets.midcast.Minuet = {
    -- body="Fili Hongreline +1", -- No potency change with +1
  }
  sets.midcast.Madrigal = {
    -- head="Fili Calot +1", -- No potency change with +1
    -- Ambuscape cape has Madrigal+1 but will be combined in later
  }
  sets.midcast.Prelude = {
    -- Ambuscape cape has Prelude+1 but will be combined in later
  }
  sets.midcast.March = {
    -- hands="Fili Manchettes +1", -- No potency change with +1
  }
  sets.midcast["Sentinel's Scherzo"] = {
    feet="Fili Cothurnes +1",
  }
  sets.midcast.Carol = {
    -- hands="Mousai Gages +1",
  }
  sets.midcast.Paeon = {
    -- head="Brioso Roundlet +3",
  }
  sets.midcast.Mambo = {
    -- feet="Mousai Crackows"
  }
  sets.midcast.Etude = {
    -- head="Mousai Turban +1",
  }

  -- Song-specific gear to enhance offensive songs.
  sets.midcast.Lullaby = {
    -- hands="Brioso Cuffs +3",
  }
  sets.midcast.HonorMarch = {
    range="Marsyas",
    -- hands="Fili Manchettes +1",
  }
  sets.midcast.Threnody = {
    -- body="Mou. Manteel +1",
  }
  sets.midcast['Adventurer\'s Dirge'] = {
    range="Marsyas",
    -- hands="Bihu Cuffs +3",
  }
  sets.midcast['Foe Sirvente'] = {
    -- head="Bihu Roundlet +3",
  }
  sets.midcast['Magic Finale'] = {
    -- legs="Fili Rhingrave +1",
  }
  sets.midcast["Chocobo Mazurka"] = {
    range="Marsyas",
  }

  -- For song buffs (duration and AF3 set bonus)
  -- Song-specific gear will be combined in later
  sets.midcast.SongEnhancing = {
    sub="Genmei Shield",
    legs="Inyanga Shalwar +2",
    ear1="Genmei Earring",
    ear2="Etiolation Earring",
    ring1="Moonlight Ring", -- Gel. Ring +1 acceptable alt
    ring2="Defending Ring",
    back=gear.BRD_Song_Cape,
    waist="Flume Belt +1",
    -- main="Carnwenhan",
    -- range="Gjallarhorn",        -- +4 Potency
    -- head="Fili Calot +1",
    -- body="Fili Hongreline +1",
    -- hands="Fili Manchettes +1",
    -- feet="Brioso Slippers +3",
    -- neck="Mnbw. Whistle +1",
  }

  -- For the following song sets, instrument may be replaced later situationally

  -- For song debuffs (duration primary, accuracy secondary)
  sets.midcast.SongEnfeeble = {
    legs="Inyanga Shalwar +2",    -- 32, 17, 45, ___
    ear1="Digni. Earring",        -- __, __, 10, ___
    ear2="Regal Earring",         -- 10, __, __, ___; Adds to set bonus
    ring1="Stikini Ring +1",      -- __, __, 11, ___
    back=gear.BRD_Song_Cape,      -- 20, __, 30, ___
    -- main="Carnwenhan",         -- __, 50, 70, 255
    -- sub="Ammurapi Shield",     -- __, __, 38, ___
    -- range="Gjallarhorn",
    -- head="Brioso Roundlet +3", -- 41, __, 61, ___
    -- body="Fili Hongreline +1", -- 37, 12, __, ___
    -- hands="Brioso Cuffs +3",   -- 39, __, 48, ___
    -- feet="Brioso Slippers +3", -- 48, 15, 46, ___
    -- neck="Mnbw. Whistle +1",   -- 23, __, 23, ___
    -- ring2="Stikini Ring +1",   -- __, __, 11, ___
    -- waist="Acuity Belt +1",    -- __, __, 15, ___
    -- Set bonuses                   __, __, 45, ___
    -- 250 CHR, 94% Duration, 453 M.Acc, 255 M.Acc skill
  }

  -- For song debuffs (accuracy primary, duration secondary)
  sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {
    hands="Inyan. Dastanas +2", -- 32, __, 43, ___; Used for extra skill since set bonus 5/5
    ring2="Metamor. Ring +1",   -- 16, __, 15, ___; Stikini acceptable alt
    -- body="Brioso Justau. +3",   -- 43, __, 64, ___
    -- legs="Brioso Cannions +3",  -- 33, __, 56, ___
    -- Set bonuses                 __, __, 60, ___
  }) -- 266 CHR, 65% Duration, 542 M.Acc, 255 M.Acc skill

  -- For Horde Lullaby maxiumum AOE range.
  sets.midcast.SongStringSkill = {
    ear1="Gersemi Earring",
    ring2="Stikini Ring +1",
    -- ear2="Darkside Earring",
  }

  -- Placeholder song; minimize duration to make it easy to overwrite.
  sets.midcast.SongPlaceholder = set_combine(sets.midcast.SongEnhancing, {
    range=info.ExtraSongInstrument,
  })

  -- Other general spells and classes.

  -- Prioritize: Cap Cure Potency > Heal Skill > Conserve MP > MND
  sets.midcast.Cure = {
    -- Cheap set
    main="Daybreak",              -- 30, __, __, 30
    neck="Incanter's Torque",     -- __, 10, __, __
    -- sub="Ammurapi Shield",        -- __, __, __, 13
    -- range=gear.Linos_CnsvMP,      -- __, __,  6,  8
    -- head=gear.Vanya_B_head,       -- 10, 20,  6, 27
    -- body=gear.Vanya_B_body,       -- __, 20, __, 36
    -- hands=gear.Vanya_B_hands,     -- __, 20, __, 33
    -- legs=gear.Vanya_B_legs,       -- __, 20,  6, 34
    -- feet=gear.Vanya_B_feet,       --  5, 40, __, 19
    -- ear1="Beatific Earring",      -- __,  4, __, __
    -- ear2="Meili Earring",         -- __, 10, __, __
    -- ring1="Sirona's Ring",        -- __, 10, __,  3
    -- ring2="Menelaus's Ring",      --  5, 15, __, __
    -- back="Aurist's Cape +1",      -- __, __,  5, 33
    -- waist="Bishop's Sash",        -- __,  5, __, __
    -- 50 CP, 174 Heal Skill, 23 Conserve MP, 272 MND
  }

  sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

  -- Removal rate = Base Rate * (1+(y/100))
  -- Base rate = (10+(Healing Skill / 30)); y = Cursna+ stat from gear
  -- BRD/WHM M20 Healing Magic Skill = 184, Base rate = 16.13%
  sets.midcast.Cursna = {
    -- head=gear.Vanya_B_head,       -- 20, __
    -- body=gear.Vanya_B_body,       -- 20, __
    -- hands="Hieros Mittens",       -- __, 10
    -- legs=gear.Vanya_B_legs,       -- 20, __
    -- feet=gear.Vanya_B_feet,       -- 40, __
    -- neck="Debilis Medallion",     -- __, 15
    -- ear1="Beatific Earring",      --  5, __
    -- ear2="Meili Earring",         -- 10, __
    -- ring1="Haoma's Ring",         --  8, 15
    -- ring2="Menelaus's Ring",      -- 15, 20
    -- back="Oretan. Cape +1",       -- __,  5
    -- waist="Bishop's Sash",        --  5, __
    -- Base stats                      184, __
    -- 327 Healing skill, 65 Cursna+
    -- Removal rate = 34.49%
  }

  sets.midcast['Enhancing Magic'] = {
    hands="Inyan. Dastanas +2",   -- 20, __
    neck="Incanter's Torque",     -- 10, __
    ear1="Mimir Earring",         -- 10, __
    ear2="Andoaa Earring",        --  5, __
    ring1="Stikini Ring +1",      --  8, __
    waist="Embla Sash",           -- __, 10
    -- main="Pukulatmuj +1",         -- 11, __
    -- sub="Ammurapi Shield",        -- __, 10
    -- range=gear.Linos_CnsvMP,      -- __, __
    -- head="Umuthi Hat",            -- 13, __
    -- body=gear.Telchine_ENH_body,  -- 12, 10
    -- legs="Shedir Seraweels",      -- 15, __
    -- feet="Kaykaus Boots +1",      -- 21, __
    -- ring2="Stikini Ring +1",      --  8, __
    -- back="Fi Follet Cape +1",     --  9, __
    -- 142 Enhancing Skill, 30% Enhancing Duration
  }

  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
    -- head="Inyanga Tiara +2",
  })
  sets.midcast.Haste = set_combine(sets.midcast['Enhancing Magic'], {})
  sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
    waist="Gishdubar Sash",
    -- back="Grapevine Cape",
  })
  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    neck="Nodens Gorget",
    waist="Siegel Sash",
    -- legs="Shedir Seraweels",
  })
  sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
    -- head="Chironic Hat",
    -- legs="Shedir Seraweels",
    -- waist="Emphatikos Rope",
  }) -- 4 Interruptions Prevented
  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
    -- ring2="Sheltered Ring",
  })
  sets.midcast.Protectra = set_combine(sets.midcast.Protect, {})
  sets.midcast.Shell = set_combine(sets.midcast.Protect, {})
  sets.midcast.Shellra = set_combine(sets.midcast.Shell, {})

  sets.midcast['Enfeebling Magic'] = {
    ear1="Digni. Earring",        -- ___, 10, __, __
    ring1="Kishar Ring",          -- ___,  5, 10, __
    ring2="Metamor. Ring +1",     -- ___, 15, __, __; Stikini acceptable alt
    back=gear.BRD_Song_Cape,      -- ___, 30, __, __
    -- main="Carnwenhan",         -- 255, 40, __, __
    -- sub="Ammurapi Shield",     -- ___, 38, __, __
    -- head="Brioso Roundlet +3", -- ___, 61, __, __
    -- body="Brioso Justau. +3",  -- ___, 64, __, __
    -- hands="Brioso Cuffs +3",   -- ___, 48, __, __
    -- legs="Brioso Cannions +3", -- ___, 56, __, __
    -- feet="Brioso Slippers +3", -- ___, 46, __, __
    -- neck="Mnbw. Whistle +1",   -- ___, 23, __, __
    -- ear2="Vor Earring",        -- ___, __, __, 10
    -- waist="Acuity Belt +1",    -- ___, 15, __, __
    -- Set bonuses                   ___, 60, __, __
    -- 255 Magic accuracy skill, 511 Magic accuracy, 10 enfeebling duration, 10 enfeebling skill
  }

  sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {
    main="Daybreak",
    -- sub="Ammurapi Shield",
  })

  sets.midcast.Utsusemi = {
    head=gear.Nyame_B_head, -- DT
    body=gear.Nyame_B_body, -- DT
    hands=gear.Nyame_B_hands, -- DT
    legs=gear.Nyame_B_legs, -- DT
    feet=gear.Nyame_B_feet, -- DT
    neck="Loricate Torque +1", -- SIRD + DT
    ring1="Defending Ring", -- DT
  }

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    main="Gozuki Mezuki",             -- Just to enable use of grip
    neck="Bathy Choker +1",           -- 3
    ear2="Infused Earring",           -- 1
    ring2="Chirich Ring +1",          -- 2
    -- sub="Mensch Strap +1",         -- 3
    -- Spare ambu cape can have 5 Regen
  }
  sets.latent_refresh = {
    ring2="Stikini Ring +1",          -- 1
    -- main="Mpaca's Staff",          -- 2; Contemplator +1 good alt
    -- sub="Oneiros Grip",            -- 1
    -- body="Kaykaus Bliaut +1",      -- 3; Gendewitha bliaut +1 good alt
    -- neck="Chrys. Torque",          -- 1
    -- ring1="Stikini Ring +1",       -- 1
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  -- PDT and MDT cap at 50% each, but included more in case slots
  -- swap out for Regen, or in battle mode
  sets.HeavyDef = {
    main="Naegling",          -- __, __, ___
    sub="Genmei Shield",      -- 10, __, ___
    head=gear.Nyame_B_head,   --  7,  7, 123
    body=gear.Nyame_B_body,   --  9,  9, 139
    hands=gear.Nyame_B_hands, --  7,  7, 112
    legs=gear.Nyame_B_legs,   --  8,  8, 150
    feet=gear.Nyame_B_feet,   --  7,  7, 150
    neck="Loricate Torque +1",--  6,  6, ___
    ear1="Arete Del Luna +1", -- __, __, ___; Resists
    ear2="Etiolation Earring",-- __,  3, ___; Status resist
    ring1="Defending Ring",   -- 10, 10, ___
    ring2="Moonlight Ring",   --  5,  5, ___; Gel. Ring +1 acceptable alt
    back="Moonlight Cape",    --  6,  6, ___
    waist="Flume Belt +1", --  4, __, ___
    -- main="Barfawc",        -- 12, 12, ___
    -- range=gear.Linos_DT,   --  5, __,  15
    -- body="Ashera Harness", --  7,  7,  96; Status resist, Mousai Manteel +1 good alt
    -- 94 PDT, 78 MDT, 646 MEVA
  }

  sets.idle = set_combine(sets.HeavyDef, {})
  sets.idle.Regain = set_combine(sets.idle, sets.latent_regain)
  sets.idle.Regen = set_combine(sets.idle, sets.latent_regen)
  sets.idle.Refresh = set_combine(sets.idle, sets.latent_refresh)
  sets.idle.RefreshSub50 = set_combine(sets.idle, sets.latent_refresh_sub50)
  sets.idle.Regain.Regen = set_combine(sets.idle, sets.latent_regain, sets.latent_regen)
  sets.idle.Regain.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh)
  sets.idle.Regain.RefreshSub50 = set_combine(sets.idle, sets.latent_regain, sets.latent_refresh_sub50)
  sets.idle.Regen.Refresh = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regen.RefreshSub50 = set_combine(sets.idle, sets.latent_regen, sets.latent_refresh_sub50)
  sets.idle.Regain.Regen.Refresh = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh)
  sets.idle.Regain.Regen.RefreshSub50 = set_combine(sets.idle, sets.latent_regain, sets.latent_regen, sets.latent_refresh_sub50)

  -- DT mode disables move speed, regain, regen, refresh
  sets.idle.DT = set_combine(sets.HeavyDef, {})
  
  sets.idle.Weak = set_combine(sets.HeavyDef, {})

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.

  -- No DW (0 needed from gear)
  sets.engaged = {
    -- Acceptable
    head="Aya. Zucchetto +2",         -- __,  6, __, __, __, __, 44,  3/ 3
    body="Ayanmo Corazza +2",         -- __, __, __, __,  7, __, 46,  6/ 6
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45,  5/ 5
    ear1="Brutal Earring",            -- __,  1, __, __,  5, __, __, __/__
    ear2="Telos Earring",             -- __,  5, __, __,  1, 10, 10, __/__
    ring1="Ilabrat Ring",             -- __,  5, __, __, __, 25, __, __/__
    ring2="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, __/__
    waist="Windbuffet Belt +1",       -- __, __,  2,  2, __, __,  2, __/__
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- hands=gear.Chironic_QA_hands,  -- __,  3, __, __, __, 32, 45, __/__
    -- feet=gear.Chironic_QA_feet,    -- __,  3, __, __, __, 52, 30,  2/__
    -- neck="Bard's Charm +1",        -- __,  6,  2, __, __, __, 25, __/__
    -- back=gear.BRD_STP_Cape,        -- __, 10, __, __, __, 20, 20, 10/__
    -- Acceptable: 0 DW, 49 STP, 7 QA, 2 TA, 13 DA, 139 Att, 297 Acc, 26PDT/14MDT

    -- Ideal
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- head="Aya. Zucchetto +2",      -- __,  6, __, __, __, __, 44,  3/ 3
    -- body="Ashera Harness",         -- __, 10, __, __, __, 45, 45,  7/ 7
    -- hands="Volte Mittens",         -- __,  6, __, __, __, __, 36, __/__
    -- legs="Volte Tights",           -- __,  8, __, __, __, __, 38, __/__
    -- feet="Volte Spats",            -- __,  6, __, __, __, __, 35, __/__
    -- neck="Bard's Charm +2",        -- __,  7,  3, __, __, __, 30, __/__
    -- ear1="Brutal Earring",         -- __,  1, __, __,  5, __, __, __/__
    -- ear2="Telos Earring",          -- __,  5, __, __,  1, 10, 10, __/__
    -- ring1="Ilabrat Ring",          -- __,  5, __, __, __, 25, __, __/__
    -- ring2="Chirich Ring +1",       -- __,  6, __, __, __, __, 10, __/__
    -- back=gear.BRD_STP_Cape,        -- __, 10, __, __, __, 20, 20, 10/__
    -- waist="Windbuffet Belt +1",    -- __, __,  2,  2, __, __,  2, __/__
    -- Ideal: 0 DW, 74 STP, 8 QA, 2 TA, 6 DA, 100 Att, 290 Acc, 20PDT/10MDT
  }
  sets.engaged.Acc = set_combine(sets.engaged, {
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45,  5/ 5
    ear1="Dignitary's Earring",       -- __,  3, __, __, __, __, 10, __/__
    ring1="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, __/__
    waist="Olseni Belt",              -- __,  3, __, __, __, -5, 20, __/__
    -- hands="Raetic Bangles +1",     -- __, __, __, __, __, __, 55, __/__
    -- Acceptable: 0 DW, 52 STP, 5 QA, 0 TA, 8 DA, 77 Att, 345 Acc, 26PDT/14MDT
    -- Ideal: 0 DW, 74 STP, 6 QA, 0 TA, 1 DA, 70 Att, 354 Acc, 25PDT/15MDT
  })

  -- Low DW (11 needed from gear)
  sets.engaged.LowDW = {
    -- Acceptable
    head="Aya. Zucchetto +2",         -- __,  6, __, __, __, __, 44,  3/ 3
    body="Ayanmo Corazza +2",         -- __, __, __, __,  7, __, 46,  6/ 6
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45,  5/ 5
    ear1="Eabani Earring",            --  4, __, __, __, __, __, __, __/__
    ear2="Telos Earring",             -- __,  5, __, __,  1, 10, 10, __/__
    ring1="Ilabrat Ring",             -- __,  5, __, __, __, 25, __, __/__
    ring2="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, __/__
    waist="Reiki Yotai",              --  7,  4, __, __, __, __, 10, __/__
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- hands=gear.Chironic_QA_hands,  -- __,  3, __, __, __, 32, 45, __/__
    -- feet=gear.Chironic_QA_feet,    -- __,  3, __, __, __, 52, 30,  2/__
    -- neck="Bard's Charm +1",        -- __,  6,  2, __, __, __, 25, __/__
    -- back=gear.BRD_STP_Cape,        -- __, 10, __, __, __, 20, 20, 10/__
    -- Acceptable: 11 DW, 52 STP, 5 QA, 0 TA, 8 DA, 139 Att, 305 Acc, 26PDT/14MDT

    -- Ideal
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- head="Aya. Zucchetto +2",      -- __,  6, __, __, __, __, 44,  3/ 3
    -- body="Ashera Harness",         -- __, 10, __, __, __, 45, 45,  7/ 7
    -- hands="Volte Mittens",         -- __,  6, __, __, __, __, 36, __/__
    -- legs="Volte Tights",           -- __,  8, __, __, __, __, 38, __/__
    -- feet="Volte Spats",            -- __,  6, __, __, __, __, 35, __/__
    -- neck="Bard's Charm +2",        -- __,  7,  3, __, __, __, 30, __/__
    -- ear1="Eabani Earring",         --  4, __, __, __, __, __, __, __/__
    -- ear2="Telos Earring",          -- __,  5, __, __,  1, 10, 10, __/__
    -- ring1="Ilabrat Ring",          -- __,  5, __, __, __, 25, __, __/__
    -- ring2="Chirich Ring +1",       -- __,  6, __, __, __, __, 10, __/__
    -- back=gear.BRD_STP_Cape,        -- __, 10, __, __, __, 20, 20, 10/__
    -- waist="Reiki Yotai",           --  7,  4, __, __, __, __, 10, __/__
    -- 11 DW, 77 STP, 6 QA, 0 TA, 1 DA, 100 Att, 298 Acc, 20PDT/10MDT
  }
  sets.engaged.LowDW.Acc = set_combine(sets.engaged.LowDW, {
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45, ??/??
    ring1="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, ??/??
    -- hands="Raetic Bangles +1",     -- __, __, __, __, __, __, 55, ??/??
    -- Acceptable: 11 DW, 50 STP, 5 QA, 0 TA, 8 DA, 82 Att, 325 Acc, 26PDT/14MDT
    -- Ideal: 11 DW, 64 STP, 6 QA, 0 TA, 1 DA, 75 Att, 334 Acc, 25PDT/15MDT
  })

  -- Mid DW (18 needed from gear)
  sets.engaged.MidDW = {
    -- Acceptable
    head="Aya. Zucchetto +2",         -- __,  6, __, __, __, __, 44,  3/ 3
    body="Ayanmo Corazza +2",         -- __, __, __, __,  7, __, 46,  6/ 6
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45,  5/ 5
    ear1="Eabani Earring",            --  4, __, __, __, __, __, __, __/__
    ear2="Telos Earring",             -- __,  5, __, __,  1, 10, 10, __/__
    ring1="Ilabrat Ring",             -- __,  5, __, __, __, 25, __, __/__
    ring2="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, __/__
    waist="Reiki Yotai",              --  7,  4, __, __, __, __, 10, __/__
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- hands=gear.Chironic_QA_hands,  -- __,  3, __, __, __, 32, 45, __/__
    -- feet=gear.Chironic_QA_feet,    -- __,  3, __, __, __, 52, 30,  2/__
    -- neck="Bard's Charm +1",        -- __,  6,  2, __, __, __, 25, __/__
    -- back=gear.BRD_DW_Cape,         -- 10, __, __, __, __, 20, 30, 10/__
    -- Acceptable: 21 DW, 42 STP, 5 QA, 0 TA, 8 DA, 139 Att, 315 Acc, 26PDT/14MDT

    -- Ideal
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- head="Aya. Zucchetto +2",      -- __,  6, __, __, __, __, 44,  3/ 3
    -- body="Ashera Harness",         -- __, 10, __, __, __, 45, 45,  7/ 7
    -- hands="Volte Mittens",         -- __,  6, __, __, __, __, 36, __/__
    -- legs="Volte Tights",           -- __,  8, __, __, __, __, 38, __/__
    -- feet="Volte Spats",            -- __,  6, __, __, __, __, 35, __/__
    -- neck="Bard's Charm +2",        -- __,  7,  3, __, __, __, 30, __/__
    -- ear1="Eabani Earring",         --  4, __, __, __, __, __, __, __/__
    -- ear2="Telos Earring",          -- __,  5, __, __,  1, 10, 10, __/__
    -- ring1="Ilabrat Ring",          -- __,  5, __, __, __, 25, __, __/__
    -- ring2="Chirich Ring +1",       -- __,  6, __, __, __, __, 10, __/__
    -- back=gear.BRD_DW_Cape,         -- 10, __, __, __, __, 20, 30, 10/__
    -- waist="Reiki Yotai",           --  7,  4, __, __, __, __, 10, __/__
    -- 21 DW, 67 STP, 6 QA, 0 TA, 1 DA, 100 Att, 308 Acc, 20PDT/10MDT
  }
  sets.engaged.MidDW.Acc = set_combine(sets.engaged.MidDW, {
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45,  5/ 5
    ring1="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, __/__
    -- hands="Raetic Bangles +1",     -- __, __, __, __, __, __, 55, __/__
    -- Acceptable: 21 DW, 40 STP, 5 QA, 0 TA, 8 DA, 82 Att, 335 Acc, 26PDT/14MDT
    -- Ideal: 21 DW, 66 STP, 6 QA, 0 TA, 1 DA, 75 Att, 344 Acc, 25PDT/15MDT
  })

  -- High DW (31 needed from gear)
  sets.engaged.HighDW = set_combine(sets.engaged.MidDW, {})
  sets.engaged.HighDW.Acc = set_combine(sets.engaged.MidDW.Acc, {})

  -- Super DW (42 needed from gear)
  sets.engaged.SuperDW = set_combine(sets.engaged.HighDW, {})
  sets.engaged.SuperDW.Acc = set_combine(sets.engaged.HighDW.Acc, {})

  -- Max DW (49 needed from gear)
  sets.engaged.MaxDW = {
    -- Acceptable
    head="Aya. Zucchetto +2",         -- __,  6, __, __, __, __, 44,  3/ 3
    body="Ayanmo Corazza +2",         -- __, __, __, __,  7, __, 46,  6/ 6
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45,  5/ 5
    ear1="Eabani Earring",            --  4, __, __, __, __, __, __, __/__
    ear2="Suppanomimi",               --  5, __, __, __, __, __, __, __/__
    ring1="Ilabrat Ring",             -- __,  5, __, __, __, 25, __, __/__
    ring2="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, __/__
    waist="Reiki Yotai",              --  7,  4, __, __, __, __, 10, __/__
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- hands=gear.Chironic_QA_hands,  -- __,  3, __, __, __, 32, 45, __/__
    -- feet=gear.Chironic_QA_feet,    -- __,  3, __, __, __, 52, 30,  2/__
    -- neck="Bard's Charm +1",        -- __,  6,  2, __, __, __, 25, __/__
    -- back=gear.BRD_DW_Cape,         -- 10, __, __, __, __, 20, 30, 10/__
    -- Acceptable: 26 DW, 37 STP, 5 QA, 0 TA, 7 DA, 129 Att, 305 Acc, 26PDT/14MDT

    -- Ideal
    -- range=gear.Linos_TP,           -- __,  4,  3, __, __, __, 20, __/__
    -- head="Aya. Zucchetto +2",      -- __,  6, __, __, __, __, 44,  3/ 3
    -- body="Ashera Harness",         -- __, 10, __, __, __, 45, 45,  7/ 7
    -- hands="Volte Mittens",         -- __,  6, __, __, __, __, 36, __/__
    -- legs="Volte Tights",           -- __,  8, __, __, __, __, 38, __/__
    -- feet="Volte Spats",            -- __,  6, __, __, __, __, 35, __/__
    -- neck="Bard's Charm +2",        -- __,  7,  3, __, __, __, 30, __/__
    -- ear1="Eabani Earring",         --  4, __, __, __, __, __, __, __/__
    -- ear2="Suppanomimi",            --  5, __, __, __, __, __, __, __/__
    -- ring1="Ilabrat Ring",          -- __,  5, __, __, __, 25, __, __/__
    -- ring2="Chirich Ring +1",       -- __,  6, __, __, __, __, 10, __/__
    -- back=gear.BRD_DW_Cape,         -- 10, __, __, __, __, 20, 30, 10/__
    -- waist="Reiki Yotai",           --  7,  4, __, __, __, __, 10, __/__
    -- Ideal: 26 DW, 62 STP, 6 QA, 0 TA, 0 DA, 90 Att, 298 Acc, 20PDT/10MDT
  } -- Only 26% DW; doesn't cap but can't get much better
  sets.engaged.MaxDW.Acc = set_combine(sets.engaged.MaxDW, {
    legs="Aya. Cosciales +2",         -- __, __, __, __, __, __, 45,  5/ 5
    ear1="Dignitary's Earring",       -- __,  3, __, __, __, __, 10, __/__
    ring1="Chirich Ring +1",          -- __,  6, __, __, __, __, 10, __/__
    -- hands="Raetic Bangles +1",     -- __, __, __, __, __, __, 55, __/__
    -- Acceptable: 26 DW, 38 STP, 5 QA, 0 TA, 7 DA, 72 Att, 335 Acc, 26PDT/14MDT
    -- Ideal: 26 DW, 52 STP, 6 QA, 0 TA, 0 DA, 65 Att, 344 Acc, 25PDT/15MDT
  })

  sets.engaged.Aftermath = {
    head="Aya. Zucchetto +2",
    ring1="Chirich Ring +1",
    -- body="Ashera Harness",
    -- hands=gear.Telchine_STP_hands,
    -- feet=gear.Telchine_STP_feet,
    -- neck="Bard's Charm +1",
    -- ring2="Chirich Ring +1",
    -- back=gear.BRD_STP_Cape,
  }

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Use Barfawc for extra DT
  sets.engaged.Hybrid = {
    neck="Loricate Torque +1", --6/6
    ring1="Moonlight Ring", --5/5
    ring2="Defending Ring", --10/10
  }

  sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
  sets.engaged.DT.Acc = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

  sets.engaged.LowDW.DT = set_combine(sets.engaged.LowDW, sets.engaged.Hybrid)
  sets.engaged.LowDW.DT.Acc = set_combine(sets.engaged.LowDW.Acc, sets.engaged.Hybrid)

  sets.engaged.MidDW.DT = set_combine(sets.engaged.MidDW, sets.engaged.Hybrid)
  sets.engaged.MidDW.DT.Acc = set_combine(sets.engaged.MidDW.Acc, sets.engaged.Hybrid)

  sets.engaged.HighDW.DT = set_combine(sets.engaged.HighDW, sets.engaged.Hybrid)
  sets.engaged.HighDW.DT.Acc = set_combine(sets.engaged.HighDW.Acc, sets.engaged.Hybrid)

  sets.engaged.SuperDW.DT = set_combine(sets.engaged.SuperDW, sets.engaged.Hybrid)
  sets.engaged.SuperDW.DT.Acc = set_combine(sets.engaged.SuperDW.Acc, sets.engaged.Hybrid)

  sets.engaged.MaxDW.DT = set_combine(sets.engaged.MaxDW, sets.engaged.Hybrid)
  sets.engaged.MaxDW.DT.Acc = set_combine(sets.engaged.MaxDW.Acc, sets.engaged.Hybrid)


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.SongDWDuration = {
    -- main="Carnwenhan",
    -- sub="Kali",
  }

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Obi = {
    waist="Hachirin-no-Obi",
  }
  sets.CP = {
    back="Mecisto. Mantle",
  }
  sets.Reive = {
    neck="Ygnas's Resolve +1",
  }
  sets.Kiting = {
    feet="Fili Cothurnes +1",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  sets.WeaponSet = {} -- DO NOT MODIFY
  sets.WeaponSet.Free = {} -- DO NOT MODIFY
  sets.WeaponSet.Carnwenhan = {
    sub="Taming Sari",
    -- main="Carnwenhan",
    -- sub="Crepuscular Knife",
  }
  sets.WeaponSet.Twashtar = {
    main="Twashtar",
    sub="Centovente",
  }
  sets.WeaponSet.Naegling = {
    main="Naegling",
    sub="Centovente",
  }
  sets.WeaponSet.Tauret = {
    main="Tauret",
    sub="Twashtar",
  }
  sets.WeaponSet.Aeneas = {
    main="Aeneas",
    sub="Twashtar",
  }
  sets.WeaponSet.Cleaving = {
    main="Tauret",
    sub="Twashtar",
    -- main="Barfawc", -- Path A
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

  if spell.type == 'BardSong' then
    --[[ Auto-Pianissimo
    if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
        not state.Buff['Pianissimo'] then

        local spell_recasts = windower.ffxi.get_spell_recasts()
        if spell_recasts[spell.recast_id] < 2 then
            send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
            eventArgs.cancel = true
            return
        end
    end]]
    if spell.name == 'Honor March' then
      equip({range="Marsyas"})
    end
    if string.find(spell.name,'Lullaby') then
      if buffactive.Troubadour then
        equip({range="Marsyas"})
      elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
        equip({range="Daurdabla"})
      else
        equip({range="Gjallarhorn"})
      end
    end
  end
  if spellMap == 'Utsusemi' and spell.english == 'Utsusemi: Ichi' and
      (buffactive['Copy Image'] or buffactive['Copy Image (2)']) then
    send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
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

  if state.BattleMode.value == true then
    -- Keep weapons the same, to avoid losing TP
    if silibs.can_dual_wield() then
      equip(sets.WeaponSet[state.WeaponSet.value])
    else
      equip({ main=sets.WeaponSet[state.WeaponSet.value].main })
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

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if spell.type == 'BardSong' then
    -- layer general gear on first, then let default handler add song-specific gear.
    local generalClass = get_song_class(spell)
    if generalClass and sets.midcast[generalClass] then
      equip(sets.midcast[generalClass])
    end
    if spell.name == 'Honor March' then
      equip({range="Marsyas"})
    end
    if string.find(spell.name,'Lullaby') then
      if buffactive.Troubadour then
        equip({range="Marsyas"})
      elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
        equip({range="Daurdabla"})
        equip(sets.midcast.SongStringSkill)
      else
        equip({range="Gjallarhorn"})
      end
    end
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.type == 'BardSong' then
    if silibs.can_dual_wield() then
      equip(sets.SongDWDuration)
    end
  end

  if state.BattleMode.value == true then
    -- Keep weapons the same, to avoid losing TP
    if silibs.can_dual_wield() then
      equip(sets.WeaponSet[state.WeaponSet.value])
    else
      equip({ main=sets.WeaponSet[state.WeaponSet.value].main })
    end
  end

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

  if spell.english:contains('Lullaby') and not spell.interrupted then
    get_lullaby_duration(spell)
  end
end

function job_buff_change(buff,gain)
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
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
  if state.WeaponLock.value == true then
    disable('main','sub')
  else
    enable('main','sub')
  end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
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
      if player.mpp < 50 then
        classes.CustomIdleGroups:append('RefreshSub50')
      elseif isRefreshing==true and player.mpp < 100 then
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

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  silibs.update_combat_form()
end

-- Called for direct player commands.
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
    end
  elseif cmdParams[1] == 'etude' then
    send_command('@input /ma '..state.Etude.value..' <stpc>')
  elseif cmdParams[1] == 'carol' then
    send_command('@input /ma '..state.Carol.value..' <stpc>')
  elseif cmdParams[1] == 'threnody' then
    send_command('@input /ma '..state.Threnody.value..' <stnpc>')
  elseif cmdParams[1] == 'test' then
    test()
  end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end
  if player.mpp < 51 then
    idleSet = set_combine(idleSet, sets.latent_refresh)
  end
  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  if state.BattleMode.value == true then
    -- Keep weapons the same, to avoid losing TP
    if silibs.can_dual_wield() then
      idleSet = set_combine(idleSet, sets.WeaponSet[state.WeaponSet.value])
    else
      idleSet = set_combine(idleSet, { main=sets.WeaponSet[state.WeaponSet.value].main })
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
  if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
    meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end

  if state.BattleMode.value == true then
    -- Keep weapons the same, to avoid losing TP
    if silibs.can_dual_wield() then
      meleeSet = set_combine(meleeSet, sets.WeaponSet[state.WeaponSet.value])
    else
      meleeSet = set_combine(meleeSet, { main=sets.WeaponSet[state.WeaponSet.value].main })
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
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end

  if state.BattleMode.value == true then
    -- Keep weapons the same, to avoid losing TP
    if silibs.can_dual_wield() then
      defenseSet = set_combine(defenseSet, sets.WeaponSet[state.WeaponSet.value])
    else
      defenseSet = set_combine(defenseSet, { main=sets.WeaponSet[state.WeaponSet.value].main })
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

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  if state.OffenseMode.value == 'Acc' then
    wsmode = 'Acc'
  end

  if player.tp > 2900 then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
  local cf_msg = ''
  if state.CombatForm.has_value then
    cf_msg = ' (' ..state.CombatForm.value.. ')'
  end

  local m_msg = state.OffenseMode.value
  if state.HybridMode.value ~= 'Normal' then
    m_msg = m_msg .. '/' ..state.HybridMode.value
  end

  local ws_msg = state.WeaponskillMode.value

  local c_msg = state.CastingMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value

  local msg = ''
  if state.Kiting.value then
    msg = msg .. ' Kiting: On |'
  end

  add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
      ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
      ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  if silibs.can_dual_wield() then
    equip(sets.WeaponSet[state.WeaponSet.value])
  else
    equip({ main=sets.WeaponSet[state.WeaponSet.value].main })
  end
end

-- Determine the custom class to use for the given song.
function get_song_class(spell)
  -- Can't use spell.targets:contains() because this is being pulled from resources
  if set.contains(spell.targets, 'Enemy') then
    if state.CastingMode.value == 'Resistant' then
      return 'SongEnfeebleAcc'
    else
      return 'SongEnfeeble'
    end
  elseif state.SongMode.value == 'Placeholder' then
    return 'SongPlaceholder'
  else
    return 'SongEnhancing'
  end
end

function get_lullaby_duration(spell)
  local self = windower.ffxi.get_player()

  local troubadour = false
  local clarioncall = false
  local soulvoice = false
  local marcato = false

  for i,v in pairs(self.buffs) do
      if v == 348 then troubadour = true end
      if v == 499 then clarioncall = true end
      if v == 52 then soulvoice = true end
      if v == 231 then marcato = true end
  end

  local mult = 1

  if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
  if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
  if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

  if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
  if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
  if player.equipment.main == "Kali" then mult = mult + 0.05 end
  if player.equipment.sub == "Kali" then mult = mult + 0.05 end
  if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
  if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
  if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
  if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
  if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
  if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
  if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
  if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
  if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
  if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
  if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
  if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
  if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.1 end
  if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

  --JP Duration Gift
  if self.job_points.brd.jp_spent >= 1200 then
    mult = mult + 0.05
  end

  if troubadour then
    mult = mult * 2
  end

  if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
    base = 60
  elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
    base = 30
  end

  totalDuration = math.floor(mult * base)

  -- Job Points Buff
  totalDuration = totalDuration + self.job_points.brd.lullaby_duration
  if troubadour then
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    -- adding it a second time if Troubadour up
  end

  if clarioncall then
    if troubadour then
      totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
      -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
    else
      totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
      -- Clarion Call gives 2 seconds per Job Point upgrade.
    end
  end

  if marcato and not soulvoice then
    totalDuration = totalDuration + self.job_points.brd.marcato_effect
  end

  -- Create the custom timer
  if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
    send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
  elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
    send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
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
  set_macro_page(1, 14)
end

function set_lockstyle()
  -- Set lockstyle 2 seconds after changing job, trying immediately will error
  coroutine.schedule(function()
    if locked_style == false then
      send_command('input /lockstyleset '..lockstyleset)
    end
  end, 2)
  -- In case lockstyle was on cooldown for first command, try again (lockstyle has 10s cd)
  coroutine.schedule(function()
    if locked_style == false then
      send_command('input /lockstyleset '..lockstyleset)
    end
  end, 10)
end

function test()
end