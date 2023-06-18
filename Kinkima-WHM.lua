-- File Status: Good.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Required addons: N/A
-- Recommended addons: WSBinder, Reorganizer, PartyBuffs, Shortcuts
-- Misc Recommendations: Disable RollTracker

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
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(4)
  silibs.enable_premade_commands()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  auto_solace = true -- Change to false if you don't want Afflatus Solace auto-applied
  auto_arts = true -- Change to false if you don't want Light Arts auto-applied

  state.CP = M(false, 'Capacity Points Mode')

  state.OffenseMode:options('None', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'PDT', 'CP')

  state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
  state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false

  state.Barelement = M{['description']='Barspell','Barfira','Barblizzara','Baraera','Barstonra','Barthundra','Barwatera'}
  state.Barstatus = M{['description']='Barstatus','Barsleepra','Barpoisonra','Barparalyzra','Barblindra','Barsilencera','Barpetra','Barvira','Baramnesra'}
  state.Storm = M{['description']='Storm','Aurorastorm','Sandstorm',
      'Rainstorm','Windstorm','Firestorm','Hailstorm','Thunderstorm','Voidstorm'}
  state.CuragaTier = M{['description']='Curaga Tier','IV','V','I'}

  -- Spells that don't scale with skill. Overrides Mote lib.
  classes.EnhancingDurSpells = S{'Adloquium', 'Haste', 'Haste II', 'Flurry', 'Flurry II', 'Protect', 'Protect II', 'Protect III',
      'Protect IV', 'Protect V', 'Protectra', 'Protectra II', 'Protectra III', 'Protectra IV', 'Protectra V', 'Shell', 'Shell II',
      'Shell III', 'Shell IV', 'Shell V', 'Shellra', 'Shellra II', 'Shellra III', 'Shellra IV', 'Shellra V', 'Blaze Spikes',
      'Ice Spikes', 'Shock Spikes', 'Enaero', 'Enaero II', 'Enblizzard', 'Enblizzard II', 'Enfire', 'Enfire II', 'Enstone',
      'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II', 'Firestorm', 'Firestorm II', 'Hailstorm', 'Hailstorm II',
      'Rainstorm', 'Rainstorm II', 'Sandstorm', 'Sandstorm II', 'Thunderstorm', 'Thunderstorm II', 'Voidstorm', 'Voidstorm II',
      'Windstorm', 'Windstorm II'}

  bar_status_spells = S{'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra',
      'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}

  set_main_keybinds()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  silibs.user_setup_hook()
  ----------- Non-silibs content goes below this line -----------

  include('Global-Binds.lua') -- Additional local binds

  select_default_macro_book()
  set_sub_keybinds()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  --------------------------------------
  -- Start defining the sets
  --------------------------------------

  -- Precast Sets

  -- Fast cast sets for spells
  sets.precast.FC = {
    main="Malignance Pole",           -- __ [20/20, ___]
    sub="Clerisy Strap +1",           --  3 [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]; Resist Status +11
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body="Pinga Tunic +1",            -- 15 [__/__, 128]
    hands=gear.Gende_SongFC_hands,    --  7 [ 3/ 2,  37]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Cleric's Torque +1",        --  8 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence +15
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.WHM_FC_Cape,            -- 10 [10/__,  20]
    waist="Carrier's Sash",           -- __ [__/__, ___]; Ele Resist +15
    -- 83 Fast Cast [60 PDT/44 MDT, 573 MEVA]

    -- neck="Cleric's Torque +2",     -- 10 [__/__, ___]
    -- ear1="Hearty Earring",         -- __ [__/__, ___]; Resist Status +5
    -- ring1="Shadow Ring",           -- __ [__/__, ___]; Annuls magic dmg
    -- 81 Fast Cast [54 PDT/43 MDT, 573 MEVA]
  }

  -- 10% cap on Quick Magic
  sets.precast.FC.QuickMagic = {
    main="Malignance Pole",           -- __ [20/20, ___] __
    sub="Mensch Strap +1",            -- __ [ 5/__, ___] __
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123] __
    body="Pinga Tunic +1",            -- 15 [__/__, 128] __
    hands=gear.Gende_SongFC_hands,    --  7 [ 3/ 2,  37] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118] __
    neck="Cleric's Torque +1",        --  8 [__/__, ___] __
    ear1="Malignance Earring",        --  4 [__/__, ___] __
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___] __
    ring1="Veneficium Ring",          -- __ [__/__, ___]  1
    ring2="Defending Ring",           -- __ [10/10, ___] __
    back=gear.WHM_FC_Cape,            -- 10 [10/__,  20] __
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- 82 Fast Cast [58 PDT/44 MDT, 573 MEVA] 6 Quick Magic

    -- main="Malignance Pole",        -- __ [20/20, ___] __
    -- sub="Clerisy Strap +1",        --  3 [__/__, ___] __
    -- ammo="Impatiens",              -- __ [__/__, ___]  2
    -- head="Bunzi's Hat",            -- 10 [ 7/ 7, 123] __
    -- body="Pinga Tunic +1",         -- 15 [__/__, 128] __
    -- hands=gear.Gende_SongFC_hands, --  7 [ 4/__,  37] __
    -- legs="Pinga Pants +1",         -- 13 [__/__, 147] __
    -- feet=gear.Merl_FC_feet,        -- 12 [__/__, 118] __
    -- neck="Cleric's Torque +2",     -- 10 [__/__, ___] __
    -- ear1="Malignance Earring",     --  4 [__/__, ___] __
    -- ear2="Ebers Earring +2",       -- __ [ 8/ 8, ___] __
    -- ring1="Kishar Ring",           --  4 [__/__, ___] __
    -- ring2="Defending Ring",        -- __ [10/10, ___] __
    -- back="Perimede Cape",          -- __ [__/__, ___]  4
    -- waist="Witful Belt",           --  3 [__/__, ___]  3
    -- 81 Fast Cast [49 PDT/45 MDT, 553 MEVA] 9 Quick Magic
  }

  -- Include divine caress gear in case of quick magic proc
  sets.precast.FC.QuickStatusRemoval = {
    main="Yagrush",                   -- 20 [__/__, ___] __, __, __
    sub="Genmei Shield",              -- __ [10/__, ___] __, __, __
    ammo="Impatiens",                 -- __ [__/__, ___]  2, __, 10
    head="Adhara Turban",             -- __ [__/__, ___] __, __, 20
    body="Rosette Jaseran +1",        -- __ [ 5/ 5,  80] __, __, 25
    hands="Ebers Mitts +2",           -- __ [10/10,  77] __,  4, __
    legs="Ebers Pantaloons +2",       -- 30 [12/12, 147] __, __, __; FC from Divine Benison
    feet="Theophany Duckbills +3",    -- __ [__/__, 127] __, __, 29
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] __, __,  5; +Defense
    ear1="Halasz Earring",            -- __ [__/__, ___] __, __,  5
    ear2="Nourishing Earring +1",     -- __ [__/__, ___] __, __,  5; Resist Silence +15
    ring1="Lebeche Ring",             -- __ [__/__, ___]  2, __, __
    ring2="Defending Ring",           -- __ [10/10, ___] __, __, __
    back="Perimede Cape",             -- __ [__/__, ___]  4, __, __
    waist="Witful Belt",              --  3 [__/__, ___]  3, __, __
    -- Divine Benison Trait              50
    -- Merits                                                    10
    -- 103 Fast Cast [53 PDT/43 MDT, 431 MEVA] 11 Quick Magic, 4 Divine Caress, 109 SIRD
    
    -- hands="Ebers Mitts +3",        -- __ [11/11,  87] __,  5, __
    -- legs="Ebers Pantaloons +3",    -- 30 [13/13, 157] __, __, __; FC from Divine Benison
    -- 103 Fast Cast [55 PDT/52 MDT, 451 MEVA] 11 Quick Magic, 5 Divine Caress, 109 SIRD
  }

  sets.precast.FC.Dispelga = {
    main="Daybreak",                  -- __ [__/__,  30]
    sub="Genmei Shield",              -- __ [10/__, ___]
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___]; Resist Status +11
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body="Pinga Tunic +1",            -- 15 [__/__, 128]
    hands=gear.Gende_SongFC_hands,    --  7 [ 3/ 2,  37]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 12 [__/__, 118]
    neck="Cleric's Torque +1",        --  8 [__/__, ___]
    ear1="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence +15
    ear2="Malignance Earring",        --  4 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.WHM_FC_Cape,            -- 10 [10/__,  20]
    waist="Carrier's Sash",           -- __ [__/__, ___]; Ele Resist +15
    -- 80 Fast Cast [50 PDT/24 MDT, 603 MEVA]

    -- hands=gear.Gende_SongFC_hands, --  7 [ 4/__,  37]
    -- neck="Cleric's Torque +2",     -- 10 [__/__, ___]
    -- ear2="Ebers Earring +2",       -- __ [ 8/ 8, ___]
    -- ring1="Kishar Ring",           --  4 [__/__, ___]
    -- 82 Fast Cast [52 PDT/31 MDT, 603 MEVA]
  }

  sets.precast.JA.Benediction = {
    -- body="Piety Briault"
  }


------------------------------------------------------------------------------------------------
------------------------------------- Weapon Skill Sets ----------------------------------------
------------------------------------------------------------------------------------------------

  -- TODO: Update
  sets.precast.WS = {
    -- head="Nahtirah Hat",
    -- body="Vanir Cotehardie",
    -- hands="Yaoyotl Gloves",
    -- legs="Gendewitha Spats",
    -- feet="Gendewitha Galoshes",
    -- neck="Fotia Gorget",
    -- ear1="Bladeborn Earring",
    -- ear2="Steelflash Earring",
    -- ring1="Rajas Ring",
    -- ring2="K'ayres Ring",
    -- back="Refraction Cape",
    -- waist="Fotia Belt",
  }
  
  -- TODO: Update
  -- Magical (light). dStat=INT. 50% STR / 50% MND
  -- Light MAB > MAB > M.Dmg > MND > STR > WSD
  sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {
    ear1="Friomisi Earring",
    -- head="Nahtirah Hat",
    -- body="Vanir Cotehardie",
    -- hands="Yaoyotl Gloves",
    -- legs="Gendewitha Spats",
    -- feet="Gendewitha Galoshes",
    -- neck="Stoicheion Medal",
    -- ear2="Hecate's Earring",
    -- ring1="Rajas Ring",
    -- ring2="Strendu Ring",
    -- back="Toro Cape",
    -- waist="Thunder Belt",
  })
  
  -- TODO: Update
  -- Physical damage. 2 hit. Damage varies with TP.
  -- 70% MND / 30% STR; 3.0-9.75fTP
  -- TP Bonus > WSD > MND > STR
  sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    ring1="Rufescent Ring",
    ring2="Metamorph Ring +1",
    back="Aurist's Cape +1",
    waist="Sailfi Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Ginsen", --Sub
    -- neck="Fotia Gorget",
    -- ear1="Moonshade Earring",
    -- ear2="Regal Earring",
  })
  
  -- TODO: Update
  -- Physical damage. 1 hit. Damage varies with TP.
  -- 50% MND / 50% STR; 3.5-12fTP
  -- TP Bonus > WSD > MND = STR
  sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    ring1="Rufescent Ring",
    ring2="Metamorph Ring +1",
    back="Aurist's Cape +1",
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Ginsen", --Sub
    -- neck="Fotia Gorget",
    -- ear1="Moonshade Earring",
    -- ear2="Regal Earring",
    -- waist="Sailfi Belt +1",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Midcast Sets
  sets.midcast.FastRecast = set_combine(sets.precast.FC, {})
  
  -- Cure sets

  -- CPII, CP, Heal Skill, MND, VIT, SIRD, PDT/MDT, -Enmity
  SIRD_options = {
    -- main="Eremite's Wand +1",      -- __, __, 25 [__/__, ???] __
    -- sub="Culminus",                -- __, __, 10 [__/__, ???] __

    -- sub="Magic Strap",             -- __, __,  5 [__/__, ???] __
    -- ammo="Staunch Tathlum +1",     -- __, __, 11 [ 3/ 3, ???] __
    -- head="Adhara Turban",          -- __, __, 20 [__/__, ___]  6
    -- head=gear.Kaykaus_C_head,      -- __, 11, 12 [__/ 3,  75] __
    -- head="Chironic Hat",           -- __, __, 11 [__/ 2, ???] __
    -- body=gear.Kaykaus_C_body,      --  4, __, 12 [__/__,  80] __
    -- body="Rosette Jaseran +1",     -- __, __, 25 [ 5/ 5, ???] 13
    -- body="Chrionic Doublet",       -- __, 13, 11 [__/__, ???] __
    -- hands="Chironic Gloves",       -- __, __, 31 [__/__,  48] __
    -- hands=gear.Kaykaus_C_hands,    -- __, 11, 12 [__/__,  37]  6
    -- legs=gear.Kaykaus_C_legs,      -- __, 11, 12 [__/__, 107] __
    -- legs="Chironic Hose",          -- __,  8, 11 [__/__, ???] __
    -- feet="Chironic Slippers",      -- __, __, 11 [ 2/__, ???]  5
    -- feet="Theophany Duckbills +3", -- __, __, 29 [__/__, 127] __
    -- neck="Loricate Torque +1",     -- __, __,  5 [ 6/ 6, ???] __
    -- ear1="Nourishing Earring +1",  -- __,  7,  5 [__/__, ___] __; Resist Silence +15
    -- ear1="Magnetic Earring",       -- __, __,  8 [__/__, ???] __
    -- ear1="Halasz Earring",         -- __, __,  5 [__/__, ???]  3
    -- ring1="Freke Ring",            -- __, __, 10 [__/__, ???] __
    -- ring1="Evanescence Ring",      -- __, __,  5 [__/__, ???] __
    -- back=AmbuCape1,                -- __, 10, 10 [__/__, ???] __
    -- back=AmbuCape2,                -- __, __, 10 [__/__, ???] 10
    -- waist="Emphatikos Rope",       -- __, __, 12 [__/__, ???] __
    -- waist="Sanctuary Obi +1",      -- __, __, 10 [__/__, ???]  4
    -- waist="Rumination Sash",       -- __, __, 10 [__/__, ???] __
    -- Merit points                   -- __, __, 10 [__/__, ???]  5
  }
  
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureNormal = {
    main="Eremite's Wand +1",         -- __, __, 25 [__/__, ___] __
    sub="Genmei Shield",              -- __, __, __ [10/__, ___] __
    ammo="Staunch Tathlum +1",        -- __, __, 11 [ 3/ 3, ___] __
    head=gear.Kaykaus_C_head,         -- __, 11, 12 [__/ 3,  75] __
    body=gear.Kaykaus_C_body,         --  4, __, 12 [__/__,  80] __
    hands=gear.Kaykaus_C_hands,       -- __, 11, 12 [__/__,  37]  6
    legs="Ebers Pantaloons +2",       -- __, __, __ [12/12, 147] __; 7% healing to MP
    feet=gear.Kaykaus_D_feet,         -- __, 17, __ [__/__, 107]  6
    neck="Cleric's Torque +1",        -- __,  7, __ [__/__, ___] 20
    ear1="Etiolation Earring",        -- __, __, __ [__/ 3, ___] __; Resist Silence +15
    ear2="Ebers Earring",             -- __, __, __ [__/__, ___]  7
    ring1="Freke Ring",               -- __, __, 10 [__/__, ___] __
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] __
    back=gear.WHM_CP_Cape,            -- __, 10, __ [10/__, ___] __
    waist="Sanctuary Obi +1",         -- __, __, 10 [__/__, ___]  4
    -- Kaykaus bonus                      8, __, __ [__/__, ___] __
    -- Merit points                      __, __, 10 [__/__, ___]  5
    -- 12 CPII, 56 CP, 102 SIRD [45 PDT/31 MDT, 446 M.Eva] 48 -Enmity
    
    -- legs="Ebers Pantaloons +3",    -- __, __, __ [13/13, 157] __; 8% healing to MP
    -- neck="Cleric's Torque +2",     -- __, 10, __ [__/__, ___] 25
    -- ear2="Ebers Earring +2",       -- __, __, __ [ 8/ 8, ___]  9
    -- Kaykaus bonus                      8, __, __ [__/__, ___] __
    -- 12 CPII, 59 CP, 102 SIRD [54 PDT/40 MDT, 456 M.Eva] 55 -Enmity
  }

  sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
    main="Chatoyant Staff",           -- __, 10, __ [__/__, ___] __; Weather bonus
    sub="Mensch Strap +1",            -- __, __, __ [ 5/__, ___] __
    ammo="Staunch Tathlum +1",        -- __, __, 11 [ 3/ 3, ___] __
    head=gear.Kaykaus_C_head,         -- __, 11, 12 [__/ 3,  75] __
    body="Rosette Jaseran +1",        -- __, __, 25 [ 5/ 5,  80] 13
    hands=gear.Kaykaus_C_hands,       -- __, 11, 12 [__/__,  37]  6
    legs="Ebers Pantaloons +2",       -- __, __, __ [12/12, 147] __; 7% healing to MP
    feet="Theophany Duckbills +3",    -- __, __, 29 [__/__, 127] __
    neck="Cleric's Torque +1",        -- __,  7, __ [__/__, ___] 20
    ear1="Nourishing Earring +1",     -- __,  7,  5 [__/__, ___] __; Resist Silence +15
    ear2="Ebers Earring",             -- __, __, __ [__/__, ___]  7
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___] __
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] __
    back=gear.WHM_CP_Cape,            -- __, 10, __ [10/__, ___] __
    waist="Hachirin-no-Obi",          -- __, __, __ [__/__, ___] __; Weather bonus
    -- Kaykaus set bonus              --  4, __, __ [__/__, ___] __
    -- Merit points                   -- __, __, 10 [__/__, ___]  5
    -- 4 CPII, 56 CP, 104 SIRD [52 PDT/32 MDT, 466 M.Eva] 51 -Enmity

    -- main="Chatoyant Staff",        -- __, 10, __ [__/__, ___] __; Weather bonus
    -- sub="Mensch Strap +1",         -- __, __, __ [ 5/__, ___] __
    -- ammo="Staunch Tathlum +1",     -- __, __, 11 [ 3/ 3, ___] __
    -- head=gear.Kaykaus_C_head,      -- __, 11, 12 [__/ 3,  75] __
    -- body=gear.Kaykaus_C_body,      --  4, __, 12 [__/__,  80] __
    -- hands=gear.Kaykaus_C_hands,    -- __, 11, 12 [__/__,  37]  6
    -- legs="Ebers Pantaloons +3",    -- __, __, __ [13/13, 157] __; 8% healing to MP
    -- feet="Theophany Duckbills +3", -- __, __, 29 [__/__, 127] __
    -- neck="Cleric's Torque +2",     -- __, 10, __ [__/__, ___] 25
    -- ear1="Magnetic Earring",       -- __, __,  8 [__/__, ___] __
    -- ear2="Ebers Earring +2",       -- __, __, __ [ 8/ 8, ___]  9
    -- ring1="Freke Ring",            -- __, __, 10 [__/__, ___] __
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, __ [10/__, ___] __
    -- waist="Hachirin-no-Obi",       -- __, __, __ [__/__, ___] __; Weather bonus
    -- Kaykaus bonus                      6, __, __ [__/__, ___] __
    -- Merit points                      __, __, 10 [__/__, ___]  5
    -- 10 CPII, 52 CP, 104 SIRD [49 PDT/37 MDT, 476 M.Eva] 45 -Enmity
  })

  sets.midcast.CureSolace = set_combine(sets.midcast.CureNormal, {
    main="Eremite's Wand +1",         -- __, __, 25 [__/__, ___] __
    sub="Genbu's Shield",             -- __,  5, __ [10/__, ___] __
    ammo="Staunch Tathlum +1",        -- __, __, 11 [ 3/ 3, ___] __
    head=gear.Kaykaus_C_head,         -- __, 11, 12 [__/ 3,  75] __
    body="Ebers Bliaut +2",           -- __, __, __ [__/__, 120] __; Solace+16
    hands=gear.Chironic_SIRD_hands,   -- __, __, 31 [__/__,  48] __; Can add more DT or Enmity
    legs="Ebers Pantaloons +2",       -- __, __, __ [12/12, 147] __; 7% healing to MP
    feet=gear.Kaykaus_D_feet,         -- __, 17, __ [__/__, 107]  6
    neck="Cleric's Torque +1",        -- __,  7, __ [__/__, ___] 20
    ear1="Halasz Earring",            -- __, __,  5 [__/__, ___]  3
    ear2="Ebers Earring",             -- __, __, __ [__/__, ___]  7
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___] __
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] __
    back=gear.WHM_CP_Cape,            -- __, 10, __ [10/__, ___] __
    waist="Sanctuary Obi +1",         -- __, __, 10 [__/__, ___]  4
    -- Kaykaus bonus                      4, __, __ [__/__, ___] __
    -- Merit points                      __, __, 10 [__/__, ___]  5
    -- 4 CPII, 50 CP, 104 SIRD [52PDT/27MDT, 497 M.Eva] 45 -Enmity
    
    -- main="Eremite's Wand +1",      -- __, __, 25 [__/__, ___] __
    -- sub="Culminus",                -- __, __, 10 [__/__, ___] __
    -- ammo="Staunch Tathlum +1",     -- __, __, 11 [ 3/ 3, ___] __
    -- head=gear.Kaykaus_C_head,      -- __, 11, 12 [__/ 3,  75] __
    -- body="Ebers Bliaut +3",        -- __, __, __ [__/__, 130] __; Solace+18
    -- hands=gear.Kaykaus_C_hands,    -- __, 11, 12 [__/__,  37]  6
    -- legs="Ebers Pantaloons +3",    -- __, __, __ [13/13, 157] __; 8% healing to MP
    -- feet=gear.Kaykaus_C_feet,      -- __, 11, 12 [__/__, 107]  6
    -- neck="Cleric's Torque +2",     -- __, 10, __ [__/__, ___] 25
    -- ear1="Halasz Earring",         -- __, __,  5 [__/__, ___]  3
    -- ear2="Ebers Earring +2",       -- __, __, __ [ 8/ 8, ___]  9
    -- ring1="Gelatinous Ring +1",    -- __, __, __ [ 7/-1, ___] __
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, __ [10/__, ___] __
    -- waist="Sanctuary Obi +1",      -- __, __, 10 [__/__, ___]  4
    -- Kaykaus bonus                      6, __, __ [__/__, ___] __
    -- Merit points                      __, __, 10 [__/__, ___]  5
    -- 6 CPII, 53 CP, 107 SIRD [51PDT/36MDT, 506 M.Eva] 58 -Enmity
  })

  sets.midcast.CureWeatherSolace = {
    main="Ababinili +1",              -- __, 34, __ [10/10, ___] __
    sub="Mensch Strap +1",            -- __, __, __ [ 5/__, ___] __
    ammo="Staunch Tathlum +1",        -- __, __, 11 [ 3/ 3, ___] __
    head="Adhara Turban",             -- __, __, 20 [__/__, ___]  6
    body="Ebers Bliaut +2",           -- __, __, __ [__/__, 120] __; Solace+16
    hands=gear.Chironic_SIRD_hands,   -- __, __, 31 [__/__,  48] __; Can add more DT or Enmity
    legs="Ebers Pantaloons +2",       -- __, __, __ [12/12, 147] __; 7% healing to MP
    feet="Theophany Duckbills +3",    -- __, __, 29 [__/__, 127] __
    neck="Cleric's Torque +1",        -- __,  7, __ [__/__, ___] 20
    ear1="Novia Earring",             -- __, __, __ [__/__, ___]  7
    ear2="Halasz Earring",            -- __, __,  5 [__/__, ___]  3
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___] __
    ring2="Defending Ring",           -- __, __, __ [10/10, ___] __
    back=gear.WHM_CP_Cape,            -- __, 10, __ [10/__, ___] __; Solace+10
    waist="Hachirin-no-Obi",          -- __, __, __ [__/__, ___] __
    -- Kaykaus set bonus              -- __, __, __ [__/__, ___] __
    -- Merit points                   -- __, __, 10 [__/__, ___]  5
    -- 0 CPII, 51 CP, 106 SIRD [57PDT/34MDT, 442 M.Eva] 41 -Enmity

    -- main="Chatoyant Staff",        -- __, 10, __ [__/__, ___] __
    -- sub="Mensch Strap +1",         -- __, __, __ [ 5/__, ___] __
    -- ammo="Staunch Tathlum +1",     -- __, __, 11 [ 3/ 3, ___] __
    -- head=gear.Kaykaus_C_head,      -- __, 11, 12 [__/ 3,  75] __
    -- body="Ebers Bliaut +3",        -- __, __, __ [__/__, 130] __; Solace+18
    -- hands=gear.Chironic_SIRD_hands,-- __, __, 31 [__/__,  48] __; Can add more DT or Enmity
    -- legs="Ebers Pantaloons +3",    -- __, __, __ [13/13, 157] __; 7% healing to MP
    -- feet="Theophany Duckbills +3", -- __, __, 29 [__/__, 127] __
    -- neck="Cleric's Torque +2",     -- __, 10, __ [__/__, ___] 25
    -- ear1="Nourishing Earring +1",  -- __,  7,  5 [__/__, ___] __; Resist Silence +15
    -- ear2="Ebers Earring +2",       -- __, __, __ [ 8/ 8, ___]  9
    -- ring1="Freke Ring",            -- __, __, 10 [__/__, ___] __
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, __ [10/__, ___] __
    -- waist="Hachirin-no-Obi",       -- __, __, __ [__/__, ___] __
    -- Kaykaus set bonus              -- __, __, __ [__/__, ___] __
    -- Merit points                   -- __, __, 10 [__/__, ___]  5
    -- 0 CPII, 48 CP, 108 SIRD [49PDT/37MDT, 537 M.Eva] 39 -Enmity
  }

  -- Cap over 960 power; Power = 3×MND + VIT + 3×floor( Healing Magic Skill÷5 )
  sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {})
  sets.midcast.CuragaWeather = set_combine(sets.midcast.CureWeather, {})

  -- Removal rate = Base Rate * (1+(y/100))
  -- Base rate = (10+(Healing Skill / 30)); y = Cursna+ stat from gear
  sets.midcast.Cursna = {
    main="Yagrush",
    sub="Genmei Shield",              -- __, __, __
    ammo="Incantor Stone",            -- __, __,  2
    head=gear.Vanya_B_head,           -- 20, __, __
    body="Ebers Bliaut +2",           -- 29, __, __
    hands=gear.Fanatic_Gloves,        --  8, 15,  5
    legs="Theophany Pantaloons +3",   -- __, 21, __
    feet=gear.Vanya_B_feet,           -- 40,  5, __
    neck="Debilis Medallion",         -- __, 15, __
    ear1="Malignance Earring",        -- __, __,  4
    ear2="Meili Earring",             -- 10, __, __
    ring1="Haoma's Ring",             --  8, 15, __
    ring2="Menelaus's Ring",          -- 15, 20,-10
    back=gear.WHM_FC_Cape,            -- __, 25, 10
    waist="Embla Sash",               -- __, __,  5
    -- Base stats                       440, __, __
    -- JP Gifts                          36
    -- Master levels                     15
    -- 621 Healing skill, 116 Cursna+, 16 FC; Cursna Rate = 66.312%

    -- sub="Chanter's Shield",        -- __, __,  3
    -- hands="Fanatic Gloves",        -- 10, 15,  7
    -- 623 Healing skill, 116 Cursna+, 21 FC; Cursna Rate = 66.456%

    -- main="Gambanteinn",            -- __, 100, __ [__/__, ___]
    -- sub="Genmei Shield",           -- __, ___, __ [10/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, ___, __ [ 3/ 3, ___]
    -- head=gear.Vanya_B_head,        -- 20, ___, __ [__/ 5,  75]
    -- body="Ebers Bliaut +3",        -- 34, ___, __ [__/__, 130]
    -- hands="Fanatic Gloves",        -- 10,  15,  7 [__/__,  37]
    -- legs="Theophany Pantaloons +3",-- __,  21, __ [__/__, 127]
    -- feet=gear.Vanya_B_feet,        -- 40,   5, __ [__/ 3, 107]
    -- neck="Debilis Medallion",      -- __,  15, __ [__/__, ___]
    -- ear1="Meili Earring",          -- 10, ___, __ [__/__, ___]
    -- ear2="Ebers Earring +2",       -- 12, ___, __ [ 8/ 8, ___]
    -- ring1="Haoma's Ring",          --  8,  15, __ [__/__, ___]
    -- ring2="Menelaus's Ring",       -- 15,  20,-10 [__/__, ___]
    -- back=gear.WHM_FC_Cape,         -- __,  25, 10 [10/__,  20]
    -- waist="Bishop's Sash",         --  5, ___, __ [__/__, ___]
    -- Base stats                       440, ___, __ [__/__, ___]
    -- JP Gifts                          36
    -- Master levels                     25
    -- 655 Healing skill, 216 Cursna+, 10 FC [31 PDT/19 MDT, 496 M.Eva]; Cursna Rate = 100.59%
    
    -- main="Gambanteinn",            -- __, 100, __ [__/__, ___]
    -- sub="Genmei Shield",           -- __, ___, __ [10/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, ___, __ [ 3/ 3, ___]
    -- head="Bunzi's Hat",            -- __, ___, 10 [ 7/ 7, 123]
    -- body="Ebers Bliaut +3",        -- 34, ___, __ [__/__, 130]
    -- hands="Fanatic Gloves",        -- 10,  15,  7 [__/__,  37]
    -- legs="Theophany Pantaloons +3",-- __,  21, __ [__/__, 127]
    -- feet=gear.Vanya_B_feet,        -- 40,   5, __ [__/ 3, 107]
    -- neck="Debilis Medallion",      -- __,  15, __ [__/__, ___]
    -- ear1="Meili Earring",          -- 10, ___, __ [__/__, ___]
    -- ear2="Ebers Earring +2",       -- 12, ___, __ [ 8/ 8, ___]
    -- ring1="Haoma's Ring",          --  8,  15, __ [__/__, ___]
    -- ring2="Menelaus's Ring",       -- 15,  20,-10 [__/__, ___]
    -- back=gear.WHM_FC_Cape,         -- __,  25, 10 [10/__,  20]
    -- waist="Witful Belt",           -- __, ___,  3 [__/__, ___]
    -- Base stats                       440, ___, __ [__/__, ___]
    -- JP Gifts                          36
    -- Master levels                     50
    -- 655 Healing skill, 216 Cursna+, 20 FC [38 PDT/21 MDT, 544 M.Eva]; Cursna Rate = 100.59%
  }

  -- Ensure DT is capped. Add SIRD but keep some FC
  sets.midcast.Erase = {
    main="Yagrush",                   -- __ [__/__, ___] __, __; AoE status removal
    sub="Culminus",                   -- __ [__/__, ___] 10, __
    ammo="Staunch Tathlum +1",        -- __ [ 3/ 3, ___] 11, __; Resist status +11
    head=gear.Kaykaus_C_head,         -- __ [__/ 3,  75] 12, __
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91] __,  5
    hands="Ebers Mitts +2",           -- __ [10/10,  77] __, 11
    legs="Ebers Pantaloons +2",       -- __ [12/12, 147] __, __
    feet="Theophany Duckbills +3",    -- __ [__/__, 127] 29, __
    neck="Cleric's Torque +1",        --  7 [__/__, ___] __, 20; Erase+1
    ear1="Halasz Earring",            -- __ [__/__, ___]  5,  3
    ear2="Nourishing Earring +1",     -- __ [__/__, ___]  5, __; Resist Silence +15
    ring1="Freke Ring",               -- __ [__/__, ___] 10, __
    ring2="Defending Ring",           -- __ [10/10, ___] __, __
    back=gear.WHM_FC_Cape,            -- 10 [10/__,  20] __, __
    waist="Sanctuary Obi +1",         -- __ [__/__, ___] 10,  4
    -- Merits                                            10,  5
    -- 31 FC [47 PDT/38 MDT, 537 MEVA] 102 SIRD, 48 -Enmity
    
    -- hands="Ebers Mitts +3",        -- __ [11/11,  87] __, 12
    -- legs="Ebers Pantaloons +3",    -- __ [13/13, 157] __, __
    -- neck="Cleric's Torque +2",     -- 10 [__/__, ___] __, 25; Erase+1
    -- Merits                                            10,  5
    -- 34 FC [49 PDT/40 MDT, 557 MEVA] 102 SIRD, 54 -Enmity
  }

  sets.midcast.StatusRemoval = {
    main="Yagrush",                   -- [__/__, ___] __, __, __; AoE status removal
    sub="Culminus",                   -- [__/__, ___] __, 10, __
    ammo="Staunch Tathlum +1",        -- [ 3/ 3, ___] __, 11, __; Resist status +11
    head=gear.Kaykaus_C_head,         -- [__/ 3,  75] __, 12, __
    body="Shamash Robe",              -- [10/__, 106] __, __, 10; Resist Silence+90
    hands="Ebers Mitts +2",           -- [10/10,  77]  4, __, 11
    legs="Ebers Pantaloons +2",       -- [12/12, 147] __, __, __
    feet="Theophany Duckbills +3",    -- [__/__, 127] __, 29, __
    neck="Loricate Torque +1",        -- [ 6/ 6, ___] __,  5, __; +Defense
    ear1="Halasz Earring",            -- [__/__, ___] __,  5,  3
    ear2="Novia Earring",             -- [__/__, ___] __, __,  7
    ring1="Freke Ring",               -- [__/__, ___] __, 10, __
    ring2="Defending Ring",           -- [10/10, ___] __, __, __
    back="Mending Cape",              -- [__/__, ___]  1, __,  6
    waist="Sanctuary Obi +1",         -- [__/__, ___] __, 10,  4
    -- Merits                                             10,  5
    -- [51PDT/44MDT, 532 MEVA] 5 Divine Caress, 102 SIRD, 46 -Enmity
    
    -- main="Yagrush",                -- [__/__, ___] __, __, __; AoE status removal
    -- sub="Culminus",                -- [__/__, ___] __, 10, __
    -- ammo="Staunch Tathlum +1",     -- [ 3/ 3, ___] __, 11, __; Resist status +11
    -- head=gear.Kaykaus_C_head,      -- [__/ 3,  75] __, 12, __
    -- body="Shamash Robe",           -- [10/__, 106] __, __, 10; Resist Silence+90
    -- hands="Ebers Mitts +3",        -- [11/11,  87]  5, __, 12
    -- legs="Ebers Pantaloons +3",    -- [13/13, 157] __, __, __
    -- feet="Theophany Duckbills +3", -- [__/__, 127] __, 29, __
    -- neck="Loricate Torque +1",     -- [ 6/ 6, ___] __,  5, __; +Defense
    -- ear1="Halasz Earring",         -- [__/__, ___] __,  5,  3
    -- ear2="Novia Earring",          -- [__/__, ___] __, __,  7
    -- ring1="Freke Ring",            -- [__/__, ___] __, 10, __
    -- ring2="Defending Ring",        -- [10/10, ___] __, __, __
    -- back="Mending Cape",           -- [__/__, ___]  1, __,  6
    -- waist="Sanctuary Obi +1",      -- [__/__, ___] __, 10,  4
    -- Merits                                             10,  5
    -- [53PDT/46MDT, 552 MEVA] 6 Divine Caress, 102 SIRD, 47 -Enmity
  }

  sets.midcast['Enhancing Magic'] = {
    main="Gada",                      -- 18, __, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __,  9, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __ [__/__,  80]
    hands=gear.Telchine_ENH_hands,    -- __, 10, __ [__/__,  61]
    legs=gear.Telchine_ENH_legs,      -- __, 10, __ [__/__, 128]
    feet="Theophany Duckbills +3",    -- 21, 10, __ [__/__, 127]
    neck="Incanter's Torque",         -- 10, __, __ [__/__, ___]
    ear1="Mimir Earring",             -- 10, __, __ [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ring1="Stikini Ring +1",          --  8, __, __ [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.WHM_FC_Cape,            -- __, __, 10 [10/__,  20]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Base                             394; Includes merits
    -- Master Levels                     15
    -- 488 Enh Skill, 69% Enh Duration, 15 FC [26 PDT/18 MDT, 491 MEVA]

    -- Ideal:
    -- main="Malignance Pole",        -- __, __, __ [20/20, ___]
    -- sub="Mensch Strap +1",         -- __, __, __ [ 5/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, __, __ [ 3/ 3, ___]
    -- head=gear.Telchine_ENH_head,   -- __, 10,  5 [__/__, 100]
    -- body=gear.Telchine_ENH_body,   -- 12, 10,  5 [__/__, 105]
    -- hands="Dynasty Mitts",         -- 18,  5, __ [__/__,  37]
    -- legs=gear.Telchine_ENH_legs,   -- __, 10,  5 [__/__, 132]
    -- feet="Theophany Duckbills +3", -- 21, 10, __ [__/__, 127]
    -- neck="Incanter's Torque",      -- 10, __, __ [__/__, ___]
    -- ear1="Mimir Earring",          -- 10, __, __ [__/__, ___]
    -- ear2="Odnowa Earring +1",      -- __, __, __ [ 3/ 5, ___]
    -- ring1="Stikini Ring +1",       --  8, __, __ [__/__, ___]
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___]
    -- back=gear.WHM_FC_Cape,         -- __, __, 10 [10/__,  20]
    -- waist="Embla Sash",            -- __, 10,  5 [__/__, ___]
    -- Base                             394; Includes merits
    -- Master Levels                     27
    -- 500 Enh Skill, 55% Enh Duration, 30 FC [51 PDT/38 MDT, 521 MEVA]
  }

  sets.midcast.EnhancingDuration = {
    main=gear.Gada_ENH,               -- 18,  6, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __,  9, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __ [__/__,  80]
    hands=gear.Telchine_ENH_hands,    -- __, 10, __ [__/__,  61]
    legs=gear.Telchine_ENH_legs,      -- __, 10, __ [__/__, 128]
    feet="Theophany Duckbills +3",    -- 21, 10, __ [__/__, 127]
    neck="Loricate Torque +1",        -- __, __, __ [ 6/ 6, ___]
    ear1="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ear2="Mimir Earring",             -- 10, __, __ [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.WHM_FC_Cape,            -- __, __, 10 [10/__,  20]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Traits/Merits/Gifts              394
    -- Master Levels                     15
    -- Light Arts                        26
    -- 496 Enh Skill, 75% Enh Duration, 15 FC [39 PDT/23 MDT, 491 MEVA]

    -- Ideal:
    -- main=gear.Gada_ENH,            -- 18,  6,  6 [__/__, ___]
    -- sub="Ammurapi Shield",         -- __, 10, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, __, __ [ 3/ 3, ___]
    -- head=gear.Telchine_ENH_head,   -- __, 10,  5 [__/__, 100]
    -- body=gear.Telchine_ENH_body,   -- 12, 10,  5 [__/__, 105]
    -- hands=gear.Telchine_ENH_hands, -- __, 10,  5 [__/__,  62]
    -- legs=gear.Telchine_ENH_legs,   -- __, 10,  5 [__/__, 132]
    -- feet="Theophany Duckbills +3", -- 21, 10, __ [__/__, 127]
    -- neck="Loricate Torque +1",     -- __, __, __ [ 6/ 6, ___]
    -- ear1="Odnowa Earring +1",      -- __, __, __ [ 3/ 5, ___]
    -- ear2="Ebers Earring +2",       -- __, __, __ [ 8/ 8, ___]
    -- ring1="Gelatinous Ring +1",    -- __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___]
    -- back=gear.WHM_FC_Cape,         -- __, __, 10 [10/__,  20]
    -- waist="Embla Sash",            -- __, 10,  5 [__/__, ___]
    -- Traits/Merits/Gifts              394
    -- Master Levels                     29
    -- Light Arts                        26
    -- 500 Enh Skill, 76% Enh Duration, 41 FC [47 PDT/31 MDT, 546 MEVA]
  }

  -- Focus on SS pot, DT, and Recast time.
  sets.midcast.Stoneskin = {
    main="Malignance Pole",     -- [20/20, ___] __, __
    sub="Mensch Strap +1",      -- [ 5/__, ___] __, __
    ammo="Incantor Stone",      -- [__/__, ___] __,  2
    head="Bunzi's Hat",         -- [ 7/ 7, 123] __, 10
    body="Inyanga Jubbah +2",   -- [__/ 8, 120] __, 14
    feet=gear.Merl_FC_feet,     -- [__/__, 118] __, 12
    neck="Nodens Gorget",       -- [__/__, ___] 30, __
    ear1="Earthcry Earring",    -- [__/__, ___] 10, __
    ear2="Malignance Earring",  -- [__/__, ___] __,  4
    ring1="Kishar Ring",        -- [__/__, ___] __,  4
    ring2="Defending Ring",     -- [10/10, ___] __, __
    back=gear.WHM_FC_Cape,      -- [10/__,  20] __, 10
    waist="Siegel Sash",        -- [__/__, ___] 20, __
    -- hands="Stone Mufflers",  -- [__/__, ___] 30, __
    -- legs="Shedir Seraweels", -- [__/__, ___] 35, __
    -- [52 PDT/45 MDT, 381 MEVA] +125 Stoneskin Potency, 56 Fast Cast
  }

  sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
    feet="Ebers Duckbills +2", -- Auspice+17
    -- feet="Ebers Duckbills +3", -- Auspice+19
  })

  sets.midcast.Arise = set_combine(sets.midcast.FastRecast, {})

  -- Cap at 500 Enh magic skill
  sets.midcast.BarElement = {
    main="Beneficus",                 -- 15, __ [__/__, ___] __,  5
    sub="Genmei Shield",              -- __, __ [10/__, ___] __, __
    ammo="Staunch Tathlum +1",        -- __, __ [ 3/ 3, ___] __, __
    head="Ebers Cap +2",              -- __, __ [__/__, 115] __, __; Set bonus
    body="Ebers Bliaut +2",           -- __, __ [__/__, 120] __, 16; Set bonus
    hands="Ebers Mitts +2",           -- __, __ [10/10,  77] __, __; Set bonus
    legs="Piety Pantaloons +2",       -- 24, __ [__/__, 117] 33, __
    feet="Ebers Duckbills +2",        -- 30, __ [10/10, 147] __, __; Set bonus
    neck="Loricate Torque +1",        -- __, __ [ 6/ 6, ___] __, __
    ear1="Odnowa Earring +1",         -- __, __ [ 3/ 5, ___] __, __
    ear2="Mimir Earring",             -- 10, __ [__/__, ___] __, __
    ring1="Gelatinous Ring +1",       -- __, __ [ 7/-1, ___] __, __
    ring2="Defending Ring",           -- __, __ [10/10, ___] __, __
    back=gear.WHM_FC_Cape,            -- __, __ [10/__,  20] __, __
    waist="Embla Sash",               -- __, 10 [__/__, ___] __, __
    -- Merits/JP                         16, __ [__/__, ___] 50, 10
    -- Base                             378
    -- Light Arts                        26
    -- Master Levels                     15
    -- Afflatus Solace                                       __,  5
    -- 514 Enh Skill, 10% Enh Duration [69 PDT/43 MDT, 596 MEVA] 83 Barspell Resistance, 36 Barspell M.Def

    -- main="Beneficus",              -- 15, __ [__/__, ___] __,  5
    -- sub="Ammurapi Shield",         -- __, 10 [__/__, ___] __, __
    -- ammo="Staunch Tathlum +1",     -- __, __ [ 3/ 3, ___] __, __
    -- head="Ebers Cap +3",           -- __, __ [__/__, 125] __, __; Set bonus
    -- body="Ebers Bliaut +3",        -- __, __ [__/__, 130] __, 18; Set bonus
    -- hands="Ebers Mitts +3",        -- __, __ [11/11,  87] __, __; Set bonus
    -- legs="Piety Pantaloons +3",    -- 26, __ [__/__, 127] 36, __
    -- feet="Ebers Duckbills +3",     -- 35, __ [11/11, 157] __, __; Set bonus
    -- neck="Loricate Torque +1",     -- __, __ [ 6/ 6, ___] __, __
    -- ear1="Odnowa Earring +1",      -- __, __ [ 3/ 5, ___] __, __
    -- ear2="Ebers Earring +2",       -- __, __ [ 8/ 8, ___] __, __
    -- ring1="Shadow Ring",           -- __, __ [__/__, ___] __, __; Annul magic dmg
    -- ring2="Defending Ring",        -- __, __ [10/10, ___] __, __
    -- back="Shadow Mantle",          -- __, __ [__/__, ___] __, __; Annul phys dmg
    -- waist="Embla Sash",            -- __, 10 [__/__, ___] __, __
    -- Ebers Set Bonus                                             ; 8% chance of nullify dmg
    -- Merits/JP                         16, __ [__/__, ___] 50, 10
    -- Base                             378
    -- Light Arts                        26
    -- Master Levels                      4
    -- Afflatus Solace                                       __,  5
    -- 500 Enh Skill, 20% Enh Duration [52 PDT/54 MDT, 626 MEVA] 86 Barspell Resistance, 38 Barspell M.Def
  }

  sets.midcast.BarStatus = set_combine(sets.midcast.EnhancingDuration, {
    neck="Sroda Necklace",
  })

  -- Regen 4 base potency 30 hp/tic. Base duration 60s.
  sets.midcast.Regen = {
    main="Bolelabunga",                 -- __, 10, __, __ [__/__, ___]
    sub="Ammurapi Shield",              -- __, __, __, 10 [__/__, ___]
    ammo="Staunch Tathlum +1",          -- __, __, __, __ [ 3/ 3, ___]
    head="Inyanga Tiara +2",            -- 14, __, __, __ [__/ 5, 114]
    hands="Ebers Mitts +2",             -- __, __, 24, __ [10/10,  77]
    legs="Theophany Pantaloons +3",     -- __, 24, __, __ [__/__, 127]
    feet="Theophany Duckbills +3",      -- __, __, __, 10 [__/__, 127]
    neck="Loricate Torque +1",          -- __, __, __, __ [ 6/ 6, ___]
    ear1="Odnowa Earring +1",           -- __, __, __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",         -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",             -- __, __, __, __ [10/10, ___]
    back=gear.WHM_FC_Cape,              -- __, __, __, __ [10/__,  20]
    waist="Embla Sash",                 -- __, __, __, 10 [__/__, ___]
    -- Merits/JP/Gifts                     __, 10, 60, __ [__/__, ___]
    -- 14% Regen Potency, 44 Regen Potency, 84 Regen Duration, 30% Enh Duration [49 PDT/38 MDT, 465 M.Eva]
    -- Regen IV 78 hp/tic @187 sec
    
    -- body="Piety Bliaut +3",          -- 52, __, __, __ [__/__, 100]
    -- hands="Ebers Mitts +3",          -- __, __, 26, __ [11/11,  87]
    -- feet="Bunzi's Sabots",           -- __, 10, __, __ [ 6/ 6, 150]; R30
    -- ear2="Ebers Earring +2",         -- __, __, __, __ [ 8/ 8, ___]
    -- 66% Regen Potency, 54 Regen Potency, 86 Regen Duration, 20% Enh Duration [64 PDT/53 MDT, 598 M.Eva]
    -- Regen IV 103 hp/tic @175 sec
  }

  sets.midcast.MndEnfeebles = {
    main="Contemplator +1",           -- __, 20, 70, 22, 12 [__/__, ___]
    sub="Mensch Strap +1",            -- __, __, __, __, __ [ 5/__, ___]
    ammo="Pemphredo Tathlum",         -- __, __,  8, __,  4 [__/__, ___]
    head="Ebers Cap +2",              -- __, __, 51, 29, 29 [__/__, 115]
    body="Ebers Bliaut +2",           -- __, __, 54, 43, 40 [__/__, 120]
    hands="Ebers Mitts +2",           -- __, __, 52, 45, 29 [10/10,  77]
    legs="Ebers Pantaloons +2",       -- __, __, 53, 40, 42 [12/12, 147]
    feet="Theophany Duckbills +3",    -- __, 21, 46, 34, 32 [__/__, 127]
    neck="Incanter's Torque",         -- __, 10, __, __, __ [__/__, ___]
    ear1="Malignance Earring",        -- __, __, 10,  8,  8 [__/__, ___]
    ear2="Dignitary's Earring",       -- __, __, 10, __, __ [__/__, ___]
    ring1="Stikini Ring +1",          -- __,  8, 11,  8, __ [__/__, ___]
    ring2="Stikini Ring +1",          -- __,  8, 11,  8, __ [__/__, ___]
    back="Aurist's Cape +1",          -- __, __, 33, 33, 33 [__/__, ___]
    waist="Obstinate Sash",           --  5, 15, 15,  5, __ [__/__, ___]
    -- AF set bonus                      __, __, 15, __, __
    -- 5 Enf Duration, 82 Enfeebling skill, 439 M.Acc, 275 MND, 229 INT [27 PDT/22 MDT, 586 MEVA]
    
    -- main="Contemplator +1",        -- __, 20, 70, 22, 12 [__/__, ___]
    -- sub="Mensch Strap +1",         -- __, __, __, __, __ [ 5/__, ___]
    -- ammo="Pemphredo Tathlum",      -- __, __,  8, __,  4 [__/__, ___]
    -- head="Ebers Cap +3",           -- __, __, 61, 34, 34 [__/__, 125]
    -- body="Ebers Bliaut +3",        -- __, __, 64, 48, 45 [__/__, 130]
    -- hands="Ebers Mitts +3",        -- __, __, 62, 50, 34 [11/11,  87]
    -- legs="Ebers Pantaloons +3",    -- __, __, 63, 45, 47 [13/13, 157]
    -- feet="Ebers Duckbills +3",     -- __, __, 60, 34, 32 [11/11, 157]
    -- neck="Incanter's Torque",      -- __, 10, __, __, __ [__/__, ___]
    -- ear1="Malignance Earring",     -- __, __, 10,  8,  8 [__/__, ___]
    -- ear2="Ebers Earring +2",       -- __, __, 20, 15, __ [ 8/ 8, ___]
    -- ring1="Kishar Ring",           -- 10, __,  5, __, __ [__/__, ___]
    -- ring2="Stikini Ring +1",       -- __,  8, 11,  8, __ [__/__, ___]
    -- back="Aurist's Cape +1",       -- __, __, 33, 33, 33 [__/__, ___]
    -- waist="Obstinate Sash",        --  5, 15, 15,  5, __ [__/__, ___]
    -- 15 Enf Duration, 53 Enf skill, 482 M.Acc, 302 MND, 249 INT [48 PDT/43 MDT, 656 MEVA]
  }
  sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
    waist="Acuity Belt +1",           -- __, __, 15, __, 23 [__/__, ___]
  })

  sets.midcast.Dia = set_combine(sets.midcast.MndEnfeebles, {})

  sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
    main="Daybreak",
    sub="Ammurapi Shield",
    ring1="Stikini Ring +1",          -- __,  8, 11,  8, __ [__/__, ___]
  })

  -- Divine magic skill
  sets.midcast.Repose = {
    main="Bunzi's Rod",               -- __, 55, 15, 15 [__/__, ___]
    sub="Ammurapi Shield",            -- __, 38, 13, 13 [__/__, ___]
    ammo="Pemphredo Tathlum",         -- __,  8, __,  4 [__/__, ___]
    head="Ebers Cap +2",              -- __, 51, 29, 29 [__/__, 115]
    body="Ebers Bliaut +2",           -- __, 54, 43, 40 [__/__, 120]
    hands="Ebers Mitts +2",           -- __, 52, 45, 29 [10/10,  77]
    legs="Ebers Pantaloons +2",       -- __, 53, 40, 42 [12/12, 147]
    feet="Ebers Duckbills +2",        -- __, 50, 29, 27 [10/10, 147]
    neck="Incanter's Torque",         -- 10, __, __, __ [__/__, ___]
    ear1="Malignance Earring",        -- __, 10,  8,  8 [__/__, ___]
    ear2="Dignitary's Earring",       -- __, 10, __, __ [__/__, ___]
    ring1="Stikini Ring +1",          --  8, 11,  8, __ [__/__, ___]
    ring2="Stikini Ring +1",          --  8, 11,  8, __ [__/__, ___]
    back="Aurist's Cape +1",          -- __, 33, 33, 33 [__/__, ___]
    waist="Obstinate Sash",           -- __, 15,  5, __ [__/__, ___]
    -- 26 Divine skill, 451 M.Acc, 276 MND, 240 INT [32 PDT/32 MDT, 606 MEVA]

    -- main="Bunzi's Rod",            -- __, 55, 15, 15 [__/__, ___]
    -- sub="Ammurapi Shield",         -- __, 38, 13, 13 [__/__, ___]
    -- ammo="Pemphredo Tathlum",      -- __,  8, __,  4 [__/__, ___]
    -- head="Ebers Cap +3",           -- __, 61, 34, 34 [__/__, 125]
    -- body="Ebers Bliaut +3",        -- __, 64, 48, 45 [__/__, 130]
    -- hands="Ebers Mitts +3",        -- __, 62, 50, 34 [11/11,  87]
    -- legs="Ebers Pantaloons +3",    -- __, 63, 45, 47 [13/13, 157]
    -- feet="Ebers Duckbills +3",     -- __, 60, 34, 32 [11/11, 157]
    -- neck="Incanter's Torque",      -- 10, __, __, __ [__/__, ___]
    -- ear1="Malignance Earring",     -- __, 10,  8,  8 [__/__, ___]
    -- ear2="Ebers Earring +2",       -- __, 20, 15, __ [ 8/ 8, ___]
    -- ring1="Stikini Ring +1",       --  8, 11,  8, __ [__/__, ___]
    -- ring2="Stikini Ring +1",       --  8, 11,  8, __ [__/__, ___]
    -- back="Aurist's Cape +1",       -- __, 33, 33, 33 [__/__, ___]
    -- waist="Obstinate Sash",        -- __, 15,  5, __ [__/__, ___]
    -- 26 Divine skill, 511 M.Acc, 316 MND, 265 INT [43 PDT/43 MDT, 656 MEVA]
  }


------------------------------------------------------------------------------------------------
----------------------------------------- Idle Sets --------------------------------------------
------------------------------------------------------------------------------------------------

  sets.idle = {
    main="Mpaca's Staff",           -- __/__, ___ [ 2]
    sub="Mensch Strap +1",          --  5/__, ___ [__]
    ammo="Staunch Tathlum +1",      --  3/ 3, ___ [__]; Resist Status+11
    head=gear.Nyame_B_head,         --  7/ 7, 123 [__]
    body="Shamash Robe",            -- 10/__, 106 [ 3]; Resist Silence+90
    hands="Volte Gloves",           -- __/__,  96 [ 1]
    legs="Assiduity Pants +1",      -- __/__, 107 [ 2]
    feet="Volte Gaiters",           -- __/__, 142 [ 1]
    neck="Loricate Torque +1",      --  6/ 6, ___ [__]; DEF+60
    ear1="Arete Del Luna +1",       -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",      -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",        -- __/__, ___ [ 1]
    ring2="Defending Ring",         -- 10/10, ___ [__]
    back=gear.WHM_FC_Cape,          -- 10/__,  20 [__]
    waist="Carrier's Sash",         -- __/__, ___ [__]; Ele Resist+15
    -- 51 PDT / 29 MDT, 594 M.Eva [10 Refresh]
    
    -- head="Volte Beret",          -- __/__, 104 [ 1]
    -- ear2="Ebers Earring +2",     --  8/ 8, ___ [__]
    -- 52 PDT / 27 MDT, 575 M.Eva [11 Refresh]
  }
  sets.idle.Refresh = set_combine(sets.idle, {})
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle.Refresh, {
    waist="Fucho-no-Obi",
  })
  sets.idle.Sublimation = set_combine(sets.idle, {
    waist="Embla Sash",
  })
  sets.idle.Sublimation.Refresh = set_combine(sets.idle.Sublimation, {})

  
------------------------------------------------------------------------------------------------
---------------------------------------- Engaged Sets ------------------------------------------
------------------------------------------------------------------------------------------------

  -- TODO: Update
  sets.engaged = {
    -- head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    -- body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
    -- back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"
  }


------------------------------------------------------------------------------------------------
---------------------------------------- Special Sets ------------------------------------------
------------------------------------------------------------------------------------------------
  
  -- Can remove from self with 100% success when combined with cursna set
  sets.buff.Doom = {
    waist="Gishdubar Sash", --10
  }

  sets.CP = {
    back=gear.CP_Cape
  }

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
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

  refine_various_spells(spell, action, spellMap, eventArgs)

  if spellMap == 'StatusRemoval' and not buffactive['Divine Caress'] and spell.english ~= 'Erase' then
    equip(sets.precast.FC.QuickStatusRemoval)
    eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
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

  if spell.action_type == 'Magic' then
    if (buffactive['Light Arts'] or buffactive['Addendum: White']) or (buffactive['Dark Arts'] or buffactive['Addendum: Black']) then
      local customEquipSet = select_specific_set(sets.midcast, spell, spellMap)
      -- Add optional casting mode
      if customEquipSet[state.CastingMode.current] then
        customEquipSet = customEquipSet[state.CastingMode.current]
      end
      if (buffactive['Light Arts'] or buffactive['Addendum: White']) and customEquipSet['LightArts'] then
        equip(customEquipSet['LightArts'])
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      elseif (buffactive['Dark Arts'] or buffactive['Addendum: Black']) and customEquipSet['DarkArts'] then
        equip(customEquipSet['DarkArts'])
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      end
    end
  end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  -- If no explicit set defined for this spell
  if spell.skill == 'Enhancing Magic' then
    if classes.EnhancingDurSpells:contains(spell.english) and sets.midcast.EnhancingDuration then
      equip(sets.midcast.EnhancingDuration)
    end
    -- If self targeted refresh
    if spellMap == 'Refresh' and spell.targets.Self and sets.midcast.RefreshSelf then
      equip(sets.midcast.RefreshSelf)
    end
  end

  -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
  if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] and spell.english ~= 'Erase' then
    equip(sets.buff['Divine Caress'])
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
  
  if not spell.interrupted then
    if spell.english == "Sleep II" then
      send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
    elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
      send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
    elseif spell.english == "Break" then
      send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
    end
  end
end

function job_post_aftercast(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes above this line -----------
  silibs.post_aftercast_hook(spell, action, spellMap, eventArgs)
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
-- Theory: debuffs must be lowercase and buffs must begin with uppercase
function job_buff_change(buff,gain)
  if buff == "doom" then
    if gain then
      send_command('@input /p Doomed.')
    elseif player.hpp > 0 then
      send_command('@input /p Doom Removed.')
    end
  end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
  if spell.action_type == 'Magic' then
    if default_spell_map == 'Cure' then
      if (world.weather_element == 'Light' and not (silibs.get_weather_intensity() < 2 and world.day_element == 'Dark'))
          or (world.day_element == 'Light' and not world.weather_element == 'Dark') then
        if state.Buff['Afflatus Solace'] then
          return 'CureWeatherSolace'
        else
          return 'CureWeather'
        end
      else
        if state.Buff['Afflatus Solace'] then
          return 'CureSolace'
        else
          return 'CureNormal'
        end
      end
    elseif default_spell_map == 'Curaga' then
      if (world.weather_element == 'Light' and not (silibs.get_weather_intensity() < 2 and world.day_element == 'Dark'))
          or (world.day_element == 'Light' and not world.weather_element == 'Dark') then
        return 'CuragaWeather'
      else
        return 'CuragaNormal'
      end
    elseif bar_status_spells:contains(spell.english) then
      return 'BarStatus'
    elseif spell.skill == 'Enfeebling Magic' then
      if spell.english:startswith('Dia') then
        return "Dia"
      elseif spell.type == "WhiteMagic" or spell.english:startswith('Frazzle') or spell.english:startswith('Distract') then
        return 'MndEnfeebles'
      else
        return 'IntEnfeebles'
      end
    end
  end
end

function refine_various_spells(spell, action, spellMap, eventArgs)
  local newSpell = spell.english

  -- If target is in party and close enough then aoe, otherwise single target
  if spell.english:startswith('Protect') and not spell.english:startswith('Protectra') then
    if spell.target.ispartymember and spell.target.distance < 10 then
      newSpell = 'Protectra V'
      send_command('@input /ma "'..newSpell..'" <me>')
      eventArgs.cancel = true
    end
  -- If target is in party and close enough then aoe, otherwise single target
  elseif spell.english:startswith('Shell') and not spell.english:startswith('Shellra') then
    if spell.target.ispartymember and spell.target.distance < 10 then
      newSpell = 'Shellra V'
      send_command('@input /ma "'..newSpell..'" <me>')
      eventArgs.cancel = true
    end
  end
end

function customize_idle_set(idleSet)
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

  if buffactive.Doom then
    defenseSet = set_combine(defenseSet, sets.buff.Doom)
  end

  return defenseSet
end

function auto_solace_and_arts()
  if not areas.Cities:contains(world.area) then
	  local abil_recasts = windower.ffxi.get_ability_recasts()
    local solace_recast = abil_recasts[29]
    local arts_recast = abil_recasts[228]
    local needs_solace = auto_solace
        and not state.Buff['Afflatus Solace']
        and not state.Buff['Afflatus Misery']
    local needs_arts = auto_arts
        and player.sub_job:lower() == 'sch'
        and not buffactive['Light Arts']
        and not buffactive['Addendum: White']
        and not buffactive['Dark Arts']
        and not buffactive['Addendum: Black']
    if needs_solace and needs_arts and solace_recast == 0 and arts_recast == 0 then
      send_command('input /ja "Afflatus Solace" <me>;wait 1.2;input /ja "Light Arts" <me>')
    elseif needs_solace and not needs_arts and solace_recast == 0 then
      send_command('input /ja "Afflatus Solace" <me>')
    elseif not needs_solace and needs_arts and arts_recast == 0 then
      send_command('input /ja "Light Arts" <me>')
    end
  end
end

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if buffactive['Sublimation: Activated'] then
      classes.CustomIdleGroups:append('Sublimation')
    end
    if (isRegening==true and player.hpp < 100) or (isRegening==false and player.hpp < 85) then
      classes.CustomIdleGroups:append('Regen')
    end
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if (isRefreshing==true and player.mpp < 100) or (isRefreshing==false and player.mpp < 85) then
        classes.CustomIdleGroups:append('Refresh')
      end
      if player.mpp < 50 then
        classes.CustomIdleGroups:append('MpSub50')
      end
    end
    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
    -- Apply time of day
    if (world.time >= (6*60) and world.time < (18*60)) then
      classes.CustomIdleGroups:append('Daytime')
      if (world.time >= (6*60) and world.time < (7*60)) then
        classes.CustomIdleGroups:append('Dawn')
      elseif (world.time >= (17*60) and world.time < (18*60)) then
        classes.CustomIdleGroups:append('Dusk')
      end
    elseif (world.time >= (18*60) or world.time < (6*60)) then
      classes.CustomIdleGroups:append('Nighttime')
    end
  end
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
  display_current_caster_state()
  eventArgs.handled = true
end

function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  auto_solace_and_arts()
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


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  
  gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'scholar' then
    handle_strategems(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1] == 'curaga' then
    if state.CuragaTier.current == 'I' then
      send_command('@input /ma "Curaga" <stpc>')
    else
      send_command('@input /ma "Curaga '..state.CuragaTier.current..'" <stpc>')
    end
  elseif cmdParams[1] == 'barelement' then
    send_command('@input /ma "'..state.Barelement.current..'" <me>')
  elseif cmdParams[1] == 'barstatus' then
    send_command('@input /ma "'..state.Barstatus.current..'" <me>')
  elseif cmdParams[1] == 'storm' then
    send_command('@input /ma "'..state.Storm.current..'" <stpc>')
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
  end
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

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
  -- cmdParams[1] == 'scholar'
  -- cmdParams[2] == strategem to use

  if not cmdParams[2] then
    add_to_chat(123,'Error: No strategem command given.')
    return
  end
  local strategem = cmdParams[2]

  if strategem == 'light' then
    if buffactive['light arts'] then
      send_command('input /ja "Addendum: White" <me>')
    elseif buffactive['addendum: white'] then
      add_to_chat(122,'Error: Addendum: White is already active.')
    else
      send_command('input /ja "Light Arts" <me>')
    end
  elseif strategem == 'dark' then
    if buffactive['dark arts'] then
      send_command('input /ja "Addendum: Black" <me>')
    elseif buffactive['addendum: black'] then
      add_to_chat(122,'Error: Addendum: Black is already active.')
    else
      send_command('input /ja "Dark Arts" <me>')
    end
  elseif buffactive['light arts'] or buffactive['addendum: white'] then
    if strategem == 'cost' then
      send_command('input /ja Penury <me>')
    elseif strategem == 'speed' then
      send_command('input /ja Celerity <me>')
    elseif strategem == 'aoe' then
      send_command('input /ja Accession <me>')
    elseif strategem == 'power' then
      send_command('input /ja Rapture <me>')
    elseif strategem == 'duration' then
      send_command('input /ja Perpetuance <me>')
    elseif strategem == 'accuracy' then
      send_command('input /ja Altruism <me>')
    elseif strategem == 'enmity' then
      send_command('input /ja Tranquility <me>')
    elseif strategem == 'skillchain' then
      add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
    elseif strategem == 'addendum' then
      send_command('input /ja "Addendum: White" <me>')
    else
      add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
    end
  elseif buffactive['dark arts']  or buffactive['addendum: black'] then
    if strategem == 'cost' then
      send_command('input /ja Parsimony <me>')
    elseif strategem == 'speed' then
      send_command('input /ja Alacrity <me>')
    elseif strategem == 'aoe' then
      send_command('input /ja Manifestation <me>')
    elseif strategem == 'power' then
      send_command('input /ja Ebullience <me>')
    elseif strategem == 'duration' then
      add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
    elseif strategem == 'accuracy' then
      send_command('input /ja Focalization <me>')
    elseif strategem == 'enmity' then
      send_command('input /ja Equanimity <me>')
    elseif strategem == 'skillchain' then
      send_command('input /ja Immanence <me>')
    elseif strategem == 'addendum' then
      send_command('input /ja "Addendum: Black" <me>')
    else
      add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
    end
  else
    add_to_chat(123,'No arts has been activated yet.')
  end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  set_macro_page(2, 4)
end

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @c gs c toggle CP')

  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind !` input /ja "Afflatus Solace" <me>')
  send_command('bind !w gs c curaga')
  send_command('bind !z gs c barelement')
  send_command('bind !x gs c barstatus')
  
  send_command('bind ^insert gs c cycleback Barelement')
  send_command('bind ^delete gs c cycle Barelement')
  send_command('bind !delete gs c reset Barelement')

  send_command('bind ^home gs c cycleback Barstatus')
  send_command('bind ^end gs c cycle Barstatus')
  send_command('bind !end gs c reset Barstatus')

  send_command('bind ^pageup gs c cycle Storm')
  send_command('bind ^pagedown gs c cycleback Storm')
  send_command('bind !pagedown gs c reset Storm')

  send_command('bind ^. gs c cycleback CuragaTier')
  send_command('bind ^/ gs c cycle CuragaTier')

  send_command('bind !r input /ma "Auspice" <me>')
  send_command('bind !e input /ma "Haste" <stpc>')
  send_command('bind !u input /ma "Blink" <me>')
  send_command('bind !i input /ma "Stoneskin" <me>')
  send_command('bind !p input /ma "Aquaveil" <me>')
  send_command('bind !; input /ma "Regen IV" <stpc>')
  send_command('bind ^z input /ma "Boost-INT" <me>')
  send_command('bind ^x input /ma "Boost-MND" <me>')
  send_command('bind ^c input /ma "Boost-STR" <me>')
  send_command('bind ^v input /ma "Boost-AGI" <me>')
end

function set_sub_keybinds()
  if player.sub_job == 'SCH' then
    send_command('bind !c gs c elemental storm')
    send_command('bind !/ input /ma "Klimaform" <me>')
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    send_command('bind ^[ gs c scholar power')
    send_command('bind ^\\\\ gs c scholar cost')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !\\\\ gs c scholar speed')
    send_command('bind !q input /ja "Sublimation" <me>')
  elseif player.sub_job == 'RDM' then
    send_command('bind !\' input /ma "Refresh" <stpc>')
  end
end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @c')

  send_command('unbind @w')
  
  send_command('unbind !`')
  send_command('unbind !w')
  send_command('unbind !z')
  send_command('unbind !x')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind ^home')
  send_command('unbind ^end')
  send_command('unbind !end')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^.')
  send_command('unbind ^/')
  send_command('unbind !/')

  send_command('unbind !r')
  send_command('unbind !e')
  send_command('unbind !u')
  send_command('unbind !i')
  send_command('unbind !p')
  send_command('unbind !;')
  send_command('unbind ^z')
  send_command('unbind ^x')
  send_command('unbind ^c')
  send_command('unbind ^v')

  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind ^[')
  send_command('unbind ^\\\\')
  send_command('unbind ![')
  send_command('unbind !\\\\')
  send_command('unbind !q')

  send_command('unbind !\'')
end

function test()
end
