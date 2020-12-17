-- TODO: Update engaged sets and WS sets

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
--
--  Abilities:  [ CTRL+` ]          Cycle SongMode
--
--  Songs:      [ ALT+` ]           Chocobo Mazurka
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Mordant Rime
--              [ CTRL+Numpad4 ]    Evisceration
--              [ CTRL+Numpad5 ]    Rudra's Storm
--              [ CTRL+Numpad1 ]    Aeolian Edge
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
end

-- Executes on first load and main job change
function job_setup()
  lockstyleset = 1
  -- Adjust this if using the Terpander (new +song instrument)
  info.ExtraSongInstrument = 'Daurdabla'
  -- How many extra songs we can keep from Daurdabla/Terpander
  info.ExtraSongs = 2

  Haste = 0 -- Do not modify
  DW_needed = 0 -- Do not modify
  DW = false -- Do not modify

  state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

  state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}
  state.OffenseMode:options('Normal', 'Acc')
  state.HybridMode:options('Normal', 'DT')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'DT', 'MEva')
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
  state.WeaponSet = M{['description']='Weapon Set', 'Carnwenhan', 'Twashtar', 'Naegling', 'Tauret', 'Aeneas', 'Free'}
  state.BattleMode = M(false, 'Battle Mode')
  state.WeaponLock = M(false, 'Weapon Lock')

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
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
  -- Additional local binds
  include('Global-Binds.lua')

  update_combat_form()
  determine_haste_group()

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
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- FC caps 80% but some pieces will be replaced depending on spell type
  sets.precast.FC = {
    main="Kali",                --  7, __ (__, __, ___)
    sub="Genmei Shield",        -- __, __ (10, __, ___)
    range=gear.Linos_FC,        --  6, __ (__, __,  15)
    head="Nahtirah Hat",        -- 10, __ (__, __,  75)
    body="Inyanga Jubbah +2",   -- 14, __ (__,  8, 120)
    hands=gear.Leyline_Gloves,  --  8, __ (__, __,  62)
    legs="Volte Brais",         --  8, __ (__, __, 142); Aya. Cosciales +2 good alt
    feet="Volte Gaiters",       --  6, __ (__, __, 142); Navon Crackows good alt
    neck="Orunmila's Torque",   --  5, __ (__, __, ___)
    ear1="Loquac. Earring",     --  2, __ (__, __, ___)
    ear2="Etiolation Earring",  --  1, __ (__,  3, ___)
    ring1="Weather. Ring +1",   --  6,  4 (__, __, ___); Lebeche Ring good alt
    ring2="Kishar Ring",        --  4, __ (__, __, ___)
    back=gear.BRD_Song_Cape,    -- 10, __ (__, __, ___)
    waist="Witful Belt",        --  3,  3 (__, __, ___)
  } -- 90 Fast Cast, 7 Quick Magic
    -- (10 PDT, 11 MDT, 556 Magic Evasion)

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash",
  })

  -- Total cast speed cap 80%, fill in rest with defensive gear
  sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    hands=gear.Gende_CureFC_hands,  --  7, __,  5 ( 4, __,  37)
    legs="Brioso Cannions +3",      -- __, __, __ ( 8,  8, 127)
    feet=gear.Vanya_B_feet,         -- __, __,  7 (__, __, 107)
    neck="Loricate Torque +1",      -- __, __, __ ( 6,  6, ___)
    ear1="Hearty Earring",          -- __, __, __ (__, __, ___); Status resist
    ear2="Mendi. Earring",          -- __, __,  5 (__, __, ___)
    ring2="Defending Ring",         -- __, __, __ (10, 10, ___)
  })-- 63 Fast Cast, 7 Quick Magic, 17 Cure Cast Time-
    -- (38 PDT, 32 MDT, 481 Magic Evasion)

  -- Total cast speed cap 80%, "song cast time-" cap 50%, fill in rest with defensive gear
  -- Don't use Quick Magic for songs because lag might mess up midcast sets
  sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
    head=gear.Gende_SongFC_head,    -- __,  5,  3 ( 4, __,  75)
    hands=gear.Gende_SongFC_hands,  --  7,  5,  3 ( 4, __,  37)
    legs=gear.Gende_SongFC_legs,    -- __, 10,  3 ( 4, __, 107)
    feet=gear.Gende_SongFC_feet,    -- __,  5,  3 ( 4, __, 107)
    neck="Loricate Torque +1",      -- __, __, __ ( 6,  6, ___)
    ring1="Defending Ring",         -- __, __, __ (10, 10, ___)
    waist="Embla Sash",             --  5, __, __ (__, __, ___)
  })-- 56 Fast Cast, 25 Song Cast Time-, 12 Song Recast-
    -- (42 PDT, 27 MDT, 461 Magic Evasion)

  sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {
    range=info.ExtraSongInstrument,
  })

  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",
    sub="Ammurapi Shield", -- Not sure this is necessary
    waist="Shinjutsu-no-Obi +1", -- Not sure this is necessary
  })

  -- Precast sets to enhance JAs
  sets.precast.JA.Nightingale = {
    feet="Bihu Slippers +3", -- +1 is acceptable
  }
  sets.precast.JA.Troubadour = {
    body="Bihu Jstcorps. +3", -- +1 is acceptable
  }
  sets.precast.JA['Soul Voice'] = {
    legs="Bihu Cannions +3", -- +1 is acceptable
  }

  -- Waltz set (chr and vit)
  sets.precast.Waltz = {}


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Default set for any weaponskill that isn't any more specifically defined
  sets.precast.WS = {
    range=gear.Linos_WS,
    head=gear.Chironic_WSD_head,
    body="Bihu Jstcorps. +3",
    hands=gear.Chironic_WSD_hands,
    legs="Bihu Cannions +3",
    feet="Bihu Slippers +3",
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
    ring1="Epaminondas's Ring",
    ring2="Ilabrat Ring",
    back=gear.BRD_WS1_Cape,
    waist="Fotia Belt",
  }

  -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
    range=gear.Linos_TP,
    head="Lustratio Cap +1",
    body="Ayanmo Corazza +2",
    hands="Bihu Cuffs +3",
    legs="Zoar Subligar +1",
    feet="Lustra. Leggings +1",
    ear1="Brutal Earring",
    ring1="Begrudging Ring",
    back=gear.BRD_WS2_Cape,
  })

  sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
    range=gear.Linos_TP,
    body="Bihu Roundlet +3",
    hands="Bihu Cuffs +3",
    ear1="Brutal Earring",
    ring1="Shukuyu Ring",
    back=gear.BRD_WS2_Cape,
  })

  sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
    neck="Bard's Charm +1",
    ear2="Regal Earring",
    ring2="Metamor. Ring +1",
    waist="Grunfeld Rope",
  })

  sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
    legs="Lustr. Subligar +1",
    feet="Lustra. Leggings +1",
    neck="Bard's Charm +1",
    waist="Grunfeld Rope",
    back=gear.BRD_WS2_Cape,
  })

  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    feet="Lustra. Leggings +1",
    neck="Caro Necklace",
    ring1="Shukuyu Ring",
    waist="Sailfi Belt +1",
    back=gear.BRD_WS2_Cape,
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- General set for recast times.
  sets.midcast.FastRecast = sets.precast.FC

  -- Song-specific gear to enhance party buff songs.
  sets.midcast.Ballad = {
    legs="Fili Rhingrave +1",
  }
  sets.midcast.Minne = {
    legs="Mousai Seraweels +1",
  }
  sets.midcast.Minuet = {
    body="Fili Hongreline +1", -- No potency change with +1
  }
  sets.midcast.Madrigal = {
    head="Fili Calot +1", -- No potency change with +1
    -- Ambuscape cape has Madrigal+1 but will be combined in later
  }
  sets.midcast.Prelude = {
    -- Ambuscape cape has Prelude+1 but will be combined in later
  }
  sets.midcast.March = {
    hands="Fili Manchettes +1", -- No potency change with +1
  }
  sets.midcast["Sentinel's Scherzo"] = {
    feet="Fili Cothurnes +1",
  }
  sets.midcast.Carol = {
    hands="Mousai Gages +1",
  }
  sets.midcast.Paeon = {
    head="Brioso Roundlet +3",
  }
  sets.midcast.Mambo = {
    feet="Mousai Crackows"
  }
  sets.midcast.Etude = {
    head="Mousai Turban +1",
  }

  -- Song-specific gear to enhance offensive songs.
  sets.midcast.Lullaby = {
    hands="Brioso Cuffs +3",
  }
  sets.midcast.HonorMarch = {
    range="Marsyas",
    hands="Fili Manchettes +1",
  }
  sets.midcast.Threnody = {
    body="Mou. Manteel +1",
  }
  sets.midcast['Adventurer\'s Dirge'] = {
    range="Marsyas",
    hands="Bihu Cuffs +3",
  }
  sets.midcast['Foe Sirvente'] = {
    head="Bihu Roundlet +3",
  }
  sets.midcast['Magic Finale'] = {
    legs="Fili Rhingrave +1",
  }
  sets.midcast["Chocobo Mazurka"] = {
    range="Marsyas",
  }

  -- For song buffs (duration and AF3 set bonus)
  -- Song-specific gear will be combined in later
  sets.midcast.SongEnhancing = {
    main="Carnwenhan",
    sub="Genmei Shield",
    range="Gjallarhorn",        -- +4 Potency
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Mnbw. Whistle +1",
    ear1="Genmei Earring",
    ear2="Etiolation Earring",
    ring1="Moonlight Ring", -- Gel. Ring +1 acceptable alt
    ring2="Defending Ring",
    waist="Flume Belt +1",
    back=gear.BRD_Song_Cape,
  }

  -- For the following song sets, instrument may be replaced later situationally

  -- For song debuffs (duration primary, accuracy secondary)
  sets.midcast.SongEnfeeble = {
    main="Carnwenhan",          -- __, 50, 70, 255
    sub="Ammurapi Shield",      -- __, __, 38, ___
    range="Gjallarhorn",
    head="Brioso Roundlet +3",  -- 41, __, 61, ___
    body="Fili Hongreline +1",  -- 37, 12, __, ___
    hands="Brioso Cuffs +3",    -- 39, __, 48, ___
    legs="Inyanga Shalwar +2",  -- 32, 17, 45, ___
    feet="Brioso Slippers +3",  -- 48, 15, 46, ___
    neck="Mnbw. Whistle +1",    -- 23, __, 23, ___
    ear1="Digni. Earring",      -- __, __, 10, ___
    ear2="Regal Earring",       -- 10, __, __, ___; Adds to set bonus
    ring1="Stikini Ring +1",    -- __, __, 11, ___
    ring2="Stikini Ring +1",    -- __, __, 11, ___
    waist="Acuity Belt +1",     -- __, __, 15, ___
    back=gear.BRD_Song_Cape,    -- 20, __, 30, ___
    -- Set bonuses                 __, __, 45, ___
  } -- 250 CHR, 94% Duration, 453 M.Acc, 255 M.Acc skill

  -- For song debuffs (accuracy primary, duration secondary)
  sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {
    body="Brioso Justau. +3",   -- 43, __, 64, ___
    hands="Inyan. Dastanas +2", -- 32, __, 43, ___; Used for extra skill since set bonus 5/5
    legs="Brioso Cannions +3",  -- 33, __, 56, ___
    ring2="Metamor. Ring +1",   -- 16, __, 15, ___; Stikini acceptable alt
    -- Set bonuses                 __, __, 60, ___
  }) -- 266 CHR, 65% Duration, 542 M.Acc, 255 M.Acc skill

  -- For Horde Lullaby maxiumum AOE range.
  sets.midcast.SongStringSkill = {
    ear1="Gersemi Earring",
    ear2="Darkside Earring",
    ring2="Stikini Ring +1",
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
    sub="Ammurapi Shield",        -- __, __, __, 13
    range=gear.Linos_CnsvMP,      -- __, __,  6,  8
    head=gear.Vanya_B_head,       -- 10, 20,  6, 27
    body=gear.Vanya_B_body,       -- __, 20, __, 36
    hands=gear.Vanya_B_hands,     -- __, 20, __, 33
    legs=gear.Vanya_B_legs,       -- __, 20,  6, 34
    feet=gear.Vanya_B_feet,       --  5, 40, __, 19
    neck="Incanter's Torque",     -- __, 10, __, __
    ear1="Beatific Earring",      -- __,  4, __, __
    ear2="Meili Earring",         -- __, 10, __, __
    ring1="Sirona's Ring",        -- __, 10, __,  3
    ring2="Menelaus's Ring",      --  5, 15, __, __
    back="Aurist's Cape +1",      -- __, __,  5, 33
    waist="Bishop's Sash",        -- __,  5, __, __
    -- 50 CP, 174 Heal Skill, 23 Conserve MP, 272 MND
  }

  sets.midcast.Curaga = sets.midcast.Cure

  -- Cursna+ and healing magic skill
  sets.midcast.Cursna = {
    head=gear.Vanya_B_head,       -- __, 20
    body=gear.Vanya_B_body,       -- __, 20
    hands="Hieros Mittens",       -- 10, __
    legs=gear.Vanya_B_legs,       -- __, 20
    feet=gear.Vanya_B_feet,       -- __, 40
    neck="Debilis Medallion",     -- 15, __
    ear1="Beatific Earring",      -- __,  4
    ear2="Meili Earring",         -- __, 10
    ring1="Haoma's Ring",         -- 15,  8
    ring2="Menelaus's Ring",      -- 20, 15
    back="Oretan. Cape +1",       --  5, __
    waist="Bishop's Sash",        -- __,  5
  } -- 65 Cursna+, 182 Healing Skill

  sets.midcast['Enhancing Magic'] = {
    main="Pukulatmuj +1",         -- 11, __
    sub="Ammurapi Shield",        -- __, 10
    range=gear.Linos_CnsvMP,      -- __, __
    head="Umuthi Hat",            -- 13, __
    body=gear.Telchine_ENH_body,  -- 12, 10
    hands="Inyan. Dastanas +2",   -- 20, __
    legs="Shedir Seraweels",      -- 15, __
    feet="Kaykaus Boots +1",      -- 21, __
    neck="Incanter's Torque",     -- 10, __
    ear1="Mimir Earring",         -- 10, __
    ear2="Andoaa Earring",        --  5, __
    ring1="Stikini Ring +1",      --  8, __
    ring2="Stikini Ring +1",      --  8, __
    back="Fi Follet Cape +1",     --  9, __
    waist="Embla Sash",           -- __, 10
  } -- 142 Enhancing Skill, 30% Enhancing Duration

  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
    head="Inyanga Tiara +2",
  })
  sets.midcast.Haste = sets.midcast['Enhancing Magic']
  sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
    waist="Gishdubar Sash",
    back="Grapevine Cape",
  })
  sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    legs="Shedir Seraweels",
    neck="Nodens Gorget",
    waist="Siegel Sash",
  })
  sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
    head="Chironic Hat",
    legs="Shedir Seraweels",
    waist="Emphatikos Rope",
  }) -- 4 Interruptions Prevented
  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
    ring2="Sheltered Ring",
  })
  sets.midcast.Protectra = sets.midcast.Protect
  sets.midcast.Shell = sets.midcast.Protect
  sets.midcast.Shellra = sets.midcast.Shell

  sets.midcast['Enfeebling Magic'] = {
    main="Carnwenhan",          -- 255, 40, __, __
    sub="Ammurapi Shield",      -- ___, 38, __, __
    head="Brioso Roundlet +3",  -- ___, 61, __, __
    body="Brioso Justau. +3",   -- ___, 64, __, __
    hands="Brioso Cuffs +3",    -- ___, 48, __, __
    legs="Brioso Cannions +3",  -- ___, 56, __, __
    feet="Brioso Slippers +3",  -- ___, 46, __, __
    neck="Mnbw. Whistle +1",    -- ___, 23, __, __
    ear1="Digni. Earring",      -- ___, 10, __, __
    ear2="Vor Earring",         -- ___, __, __, 10
    ring1="Kishar Ring",        -- ___,  5, 10, __
    ring2="Metamor. Ring +1",   -- ___, 15, __, __; Stikini acceptable alt
    waist="Acuity Belt +1",     -- ___, 15, __, __
    back=gear.BRD_Song_Cape,    -- ___, 30, __, __
    -- Set bonuses                 ___, 60, __, __
  }-- 255 Magic accuracy skill, 511 Magic accuracy, 10 enfeebling duration, 10 enfeebling skill

  sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {
    main="Daybreak",
    sub="Ammurapi Shield",
  })

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = sets.precast.FC

  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
  }
  sets.latent_regen = {
    main="Terra's Staff",             -- Just to enable use of grip
    sub="Mensch Strap +1",            -- 3
    head=gear.Telchine_Regen_head,    -- 2
    body=gear.Telchine_Regen_body,    -- 2
    hands=gear.Telchine_Regen_hands,  -- 2
    legs=gear.Telchine_Regen_legs,    -- 2
    feet="Fili Cothurnes +1",         -- 2
    neck="Bathy Choker +1",           -- 3
    ear2="Infused Earring",           -- 1
    ring1="Chirich Ring +1",          -- 2
    ring2="Chirich Ring +1",          -- 2
    -- Spare ambu cape can have 5 Regen
  }
  sets.latent_refresh = {
    main="Contemplator +1",           -- 2
    sub="Oneiros Grip",               -- 1
    head=gear.Chironic_Refresh_head,  -- 2
    body="Kaykaus Bliaut +1",         -- 3; Gendewitha bliaut +1 good alt
    hands=gear.Chironic_Refresh_hands,-- 2
    legs="Assid. Pants +1",           -- 2
    feet=gear.Chironic_Refresh_feet,  -- 2
    neck="Chrys. Torque",             -- 1
    ring1="Stikini Ring +1",          -- 1
    ring2="Stikini Ring +1",          -- 1
  }
  sets.latent_refresh_sub50 = set_combine(sets.latent_refresh, {
    waist="Fucho-no-Obi",
  })

  -- PDT and MDT cap at 50% each, but included more in case slots
  -- swap out for Regen, or in battle mode
  sets.HeavyDef = {
    main="Barfawc",           -- 12, 12, ___
    sub="Genmei Shield",      -- 10, __, ___
    range=gear.Linos_DT,      --  5, __,  15
    head="Inyanga Tiara +2",  -- __,  5, 114
    body="Ashera Harness",    --  7,  7,  96; Status resist, Mousai Manteel +1 good alt
    hands="Volte Bracers",    -- __, __, 102; Status resist, Raetic Bangles +1 good alt
    legs="Brioso Cannions +3",--  8,  8, 127
    feet="Inyan. Crackows +2",-- __, __, 147
    neck="Loricate Torque +1",--  6,  6, ___
    ear1="Hearty Earring",    -- __, __, ___; Status resist
    ear2="Etiolation Earring",-- __,  3, ___; Status resist
    ring1="Defending Ring",   -- 10, 10, ___
    ring2="Moonlight Ring",   --  5,  5, ___; Gel. Ring +1 acceptable alt
    back="Moonlight Cape",    --  6,  6, ___
    waist="Flume Belt +1",    --  4, __, ___
  } --73 PDT, 62 MDT, 601 MEVA

  sets.idle = sets.HeavyDef
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
  sets.idle.DT = sets.HeavyDef

  -- Mainly to avoid aoe status effects like Stun
  -- MEva mode disables move speed, regain, regen, refresh
  sets.idle.MEva = {
    main="Daybreak",
    sub="Ammurapi Shield",
    head="Inyanga Tiara +2", --0/5
    body="Inyanga Jubbah +2", --0/8
    hands="Raetic Bangles +1",
    legs="Inyanga Shalwar +2", --0/6
    feet="Inyan. Crackows +2", --0/3
    neck="Warder's Charm +1",
    ear1="Eabani Earring",
    ear2="Sanare Earring",
    ring1="Purity Ring",
    ring2="Inyanga Ring",
    back="Moonlight Cape", --6/6
    waist="Carrier's Sash",
  } --?? PDT, ?? MDT, ??? MEVA

  sets.idle.Weak = sets.HeavyDef

  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Engaged sets

  -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
  -- sets if more refined versions aren't defined.
  -- If you create a set with both offense and defense modes, the offense mode should be first.
  -- EG: sets.engaged.Dagger.Accuracy.Evasion

  sets.engaged = {
    range=gear.Linos_TP,
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands=gear.Chironic_QA_hands,
    legs="Aya. Cosciales +2",
    feet=gear.Chironic_QA_feet,
    neck="Bard's Charm +1",
    ear1="Cessance Earring",
    ear2="Telos Earring",
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
    back=gear.BRD_STP_Cape,
    waist="Windbuffet Belt +1",
  }

  sets.engaged.Acc = set_combine(sets.engaged, {
    hands="Raetic Bangles +1",
    ear2="Mache Earring +1",
    waist="Kentarch Belt +1",
  })

  -- * DNC Subjob DW Trait: +15%
  -- * NIN Subjob DW Trait: +25%

  -- No Magic/Gear/JA Haste (74% DW to cap, 49% from gear)
  sets.engaged.DW = {
    range=gear.Linos_TP,
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands=gear.Chironic_QA_hands,
    legs="Aya. Cosciales +2",
    feet=gear.Chironic_QA_feet,
    neck="Bard's Charm +1",
    ear1="Eabani Earring", --4
    ear2="Suppanomimi", --5
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
    back=gear.BRD_DW_Cape, --10
    waist="Reiki Yotai", --7
  } -- 26%
  sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
    hands="Raetic Bangles +1",
    feet="Bihu Slippers +3",
  })

  -- Low Magic/Gear/JA Haste (67% DW to cap, 42% from gear)
  sets.engaged.DW.LowHaste = sets.engaged.DW
  sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

  -- Mid Magic/Gear/JA Haste (56% DW to cap, 31% from gear)
  sets.engaged.DW.MidHaste = sets.engaged.DW
  sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc

  -- High Magic/Gear/JA Haste (51% DW to cap, 27% from gear)
  sets.engaged.DW.HighHaste = sets.engaged.DW
  sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc

  -- Super Magic/Gear/JA Haste (46% DW to cap, 21% from gear)
  sets.engaged.DW.SuperHaste = set_combine(sets.engaged.DW.MaxHaste, {
    main="Carnwenhan",
    sub="Taming Sari",
    range=gear.Linos_TP,
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands=gear.Chironic_QA_hands,
    legs="Aya. Cosciales +2",
    feet=gear.Chironic_QA_feet,
    neck="Bard's Charm +1",
    ear1="Eabani Earring", --4
    ear2="Telos Earring",
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
    back=gear.BRD_STP_Cape,
    waist="Reiki Yotai", --7
  })
  sets.engaged.DW.Acc.SuperHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, {
    hands="Raetic Bangles +1",
    feet="Bihu Slippers +3",
    ear2="Mache Earring +1",
  })

  -- Max Magic/Gear/JA Haste (37% DW to cap, 12% from gear)
  sets.engaged.DW.MaxHaste = {
    main="Carnwenhan",
    sub="Taming Sari",
    range=gear.Linos_TP,
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands=gear.Chironic_QA_hands,
    legs="Aya. Cosciales +2",
    feet=gear.Chironic_QA_feet,
    neck="Bard's Charm +1",
    ear1="Eabani Earring", --4
    ear2="Telos Earring",
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
    back=gear.BRD_STP_Cape,
    waist="Reiki Yotai", --7
  }
  sets.engaged.DW.MaxHaste.Acc = set_combine(sets.engaged.DW, {
    hands="Raetic Bangles +1",
    feet="Bihu Slippers +3",
    ear2="Mache Earring +1",
  })

  sets.engaged.Aftermath = {
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands=gear.Telchine_STP_hands,
    feet=gear.Telchine_STP_feet,
    neck="Bard's Charm +1",
    ring1="Chirich Ring +1",
    ring2="Chirich Ring +1",
    back=gear.BRD_STP_Cape,
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
  sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

  sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
  sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

  sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
  sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
  sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
  sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
  sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)

  sets.engaged.DW.DT.SuperHaste = set_combine(sets.engaged.DW.SuperHaste, sets.engaged.Hybrid)
  sets.engaged.DW.Acc.DT.SuperHaste = set_combine(sets.engaged.DW.Acc.SuperHaste, sets.engaged.Hybrid)


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.SongDWDuration = {
    main="Carnwenhan",
    sub="Kali",
  }

  sets.buff.Doom = {
    -- neck="Nicander's Necklace", --20
    -- ring2="Eshmun's Ring", --20
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
  sets.WeaponSet.Carnwenhan = {main="Carnwenhan",sub="Taming Sari"}
  sets.WeaponSet.Twashtar = {main="Twashtar",sub="Centovente"}
  sets.WeaponSet.Naegling = {main="Naegling",sub="Centovente"}
  sets.WeaponSet.Tauret = {main="Tauret",sub="Twashtar"}
  sets.WeaponSet.Aeneas = {main="Aeneas",sub="Taming Sari"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
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
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_precast(spell, action, spellMap, eventArgs)
  -- Always put this last in job_post_precast
  if state.BattleMode.value == true then
    equip(sets.WeaponSet[state.WeaponSet.current])
  end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
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
    if state.CombatForm.current == 'DW' then
      equip(sets.SongDWDuration)
    end
  end
  -- Always put this last in job_post_midcast
  if state.BattleMode.value == true then
    equip(sets.WeaponSet[state.WeaponSet.current])
  end
end

function job_aftercast(spell, action, spellMap, eventArgs)
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
  update_combat_form()
  update_idle_groups()
  determine_haste_group()
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
  update_weaponskill_binds()
end

function update_combat_form()
  if DW == true then
    state.CombatForm:set('DW')
  elseif DW == false then
    state.CombatForm:reset()
  end
end

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
  if cmdParams[1]:lower() == 'etude' then
    send_command('@input /ma '..state.Etude.value..' <stpc>')
  elseif cmdParams[1]:lower() == 'carol' then
    send_command('@input /ma '..state.Carol.value..' <stpc>')
  elseif cmdParams[1]:lower() == 'threnody' then
    send_command('@input /ma '..state.Threnody.value..' <stnpc>')
  elseif cmdParams[1]:lower() == 'usekey' then
    send_command('cancel Invisible; cancel Hide; cancel Gestation; cancel Camouflage')
    if player.target.type ~= 'NONE' then
      if player.target.name == 'Sturdy Pyxis' then
        send_command('@input /item "Forbidden Key" <t>')
      end
    end
  elseif cmdParams[1]:lower() == 'faceaway' then
    windower.ffxi.turn(player.facing - math.pi);
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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
  if state.BattleMode.value == true then
    equip(sets.WeaponSet[state.WeaponSet.current])
  end
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
  if buffactive.Doom then
    idleSet = set_combine(idleSet, sets.buff.Doom)
  end

  return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
  equip(sets.WeaponSet[state.WeaponSet.current])
  if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
    meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
  end
  if state.CP.current == 'on' then
    meleeSet = set_combine(meleeSet, sets.CP)
  end
  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if state.BattleMode.value == true then
    equip(sets.WeaponSet[state.WeaponSet.current])
  end
  if state.CP.current == 'on' then
    defenseSet = set_combine(defenseSet, sets.CP)
  end
  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode
  if state.OffenseMode.value == 'Acc' then
    wsmode = 'Acc'
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

function determine_haste_group()
  classes.CustomMeleeGroups:clear()
  if DW == true then
    if DW_needed <= 12 then
      classes.CustomMeleeGroups:append('MaxHaste')
    elseif DW_needed > 12 and DW_needed <= 21 then
      classes.CustomMeleeGroups:append('SuperHaste')
    elseif DW_needed > 21 and DW_needed <= 27 then
      classes.CustomMeleeGroups:append('HighHaste')
    elseif DW_needed > 27 and DW_needed <= 31 then
      classes.CustomMeleeGroups:append('MidHaste')
    elseif DW_needed > 31 and DW_needed <= 42 then
      classes.CustomMeleeGroups:append('LowHaste')
    elseif DW_needed > 42 then
      classes.CustomMeleeGroups:append('')
    end
  end
end

function check_gear()
  if no_swap_rings:contains(player.equipment.left_ring) then
    disable("ring1")
  else
    enable("ring1")
  end
  if no_swap_rings:contains(player.equipment.right_ring) then
    disable("ring2")
  else
    enable("ring2")
  end
end

windower.register_event('zone change',
  function()
    if no_swap_rings:contains(player.equipment.left_ring) then
      enable("ring1")
      equip(sets.idle)
    end
    if no_swap_rings:contains(player.equipment.right_ring) then
      enable("ring2")
      equip(sets.idle)
    end
  end
)

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
