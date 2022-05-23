-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup, init_gear_sets
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(5)
  silibs.enable_premade_commands()

  state.CP = M(false, "Capacity Points Mode")

  state.OffenseMode:options('None', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal','Dispelga', 'PDT', 'CP')

  state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
  state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @c gs c toggle CP')

  send_command('bind @w gs c toggle RearmingLock')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  include('Global-Binds.lua') -- Additional local binds

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @c')

  send_command('unbind ^`')
  send_command('unbind @w')
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
    sub="Khonsu",                     -- __ [ 6/ 6, ___]
    ammo="Incantor Stone",            --  2 [__/__, ___]
    head=gear.Psycloth_D_head,        -- 10 [__/__,  75]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 11 [__/__, 118]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    waist="Carrier Sash",             -- __ [__/__, ___]; Ele Resist+15
    -- head="Bunzi's Hat",            -- 10 [ 7/ 7, 123] __
    -- hands=gear.Gende_FC_hands,     --  7 [ 4/__,  37]
    -- neck="Cleric's Torque +1",     --  8 [__/__, ___]
    -- back=gear.WHM_FC_Cape,         -- 10 [10/__,  20]
    -- 80 Fast Cast [66PDT/45MDT, 536 MEVA]
  } -- 55 Fast Cast [45PDT/38MDT, 431 MEVA]

  -- 10% cap on Quick Magic
  sets.QuickMagic = {
    main="Malignance Pole",           -- __ [20/20, ___] __
    sub="Khonsu",                     -- __ [ 6/ 6, ___] __
    head=gear.Psycloth_D_head,        -- 10 [__/__,  75] __
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet=gear.Merl_FC_feet,           -- 11 [__/__, 118] __
    ear1="Malignance Earring",        --  4 [__/__, ___] __
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___] __
    -- ammo="Impatiens",              -- __ [__/__, ___]  2
    -- head="Bunzi's Hat",            -- 10 [ 7/ 7, 123] __
    -- hands=gear.Gende_FC_hands,     --  7 [ 4/__,  37] __
    -- neck="Cleric's Torque +1",     --  8 [__/__, ___] __
    -- ring1="Lebeche Ring",          -- __ [__/__, ___]  2
    -- ring2="Veneficium Ring",       -- __ [__/__, ___]  1
    -- back=gear.WHM_FC_Cape,         -- 10 [10/__,  20] __
    -- waist="Witful Belt",           --  3 [__/__, ___]  3
    -- 80 Fast Cast [52PDT/38MDT, 536 MEVA] 8 Quick Magic
  } -- 52 Fast Cast [31PDT/31MDT, 431 MEVA] 0 Quick Magic

  -- Cap quick magic, but can remove some FC due to Diving Benison trait (increase defense instead)
  sets.precast.FC.StatusRemoval = {
    main="Malignance Pole",           -- __ [20/20, ___] __
    sub="Khonsu",                     -- __ [ 6/ 6, ___] __
    head=gear.Psycloth_D_head,        -- 10 [__/__,  75] __
    body="Shamash Robe",              -- __ [10/__, 106] __; Resist Silence+90
    hands=gear.Nyame_B_hands,         -- __ [ 7/ 7, 112] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150] __
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] __; +Defense
    ear1="Malignance Earring",        --  4 [__/__, ___] __
    ear2="Etiolation Earring",        --  1 [__/ 3, ___] __; Resist Silence+15
    ring2="Defending Ring",           -- __ [10/10, ___] __
    back="Persimede Cape",            -- __ [__/__, ___]  4
    -- Divine Benison Trait              50
    
    -- ammo="Impatiens",              -- __ [__/__, ___]  2
    -- head="Bunzi's Hat",            -- 10 [ 7/ 7, 123] __
    -- ring1="Lebeche Ring",          -- __ [__/__, ___]  2
    -- waist="Witful Belt",           --  3 [__/__, ___]  3
  } -- 81 Fast Cast [73PDT/66MDT, 638 MEVA] 11 Quick Magic

  sets.precast.FC.Arise = sets.QuickMagic
  
  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    -- main="Daybreak",
    sub="Genmei Shield",
  })

  sets.precast.JA.Benediction = {
    -- body="Piety Briault"
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    -- head="Nahtirah Hat",
    -- body="Vanir Cotehardie",
    -- hands="Yaoyotl Gloves",
    -- legs="Gendewitha Spats",
    -- feet="Gendewitha Galoshes",
    -- neck=gear.ElementalGorget,
    -- ear1="Bladeborn Earring",
    -- ear2="Steelflash Earring",
    -- ring1="Rajas Ring",
    -- ring2="K'ayres Ring",
    -- back="Refraction Cape",
    -- waist=gear.ElementalBelt,
  }
  
  -- Magical (light). dStat=INT. 50% STR / 50% MND
  -- Light MAB > MAB > M.Dmg > MND > STR > WSD
  sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {
    -- head="Nahtirah Hat",
    -- body="Vanir Cotehardie",
    -- hands="Yaoyotl Gloves",
    -- legs="Gendewitha Spats",
    -- feet="Gendewitha Galoshes",
    -- neck="Stoicheion Medal",
    -- ear1="Friomisi Earring",
    -- ear2="Hecate's Earring",
    -- ring1="Rajas Ring",
    -- ring2="Strendu Ring",
    -- back="Toro Cape",
    -- waist="Thunder Belt",
  })
  
  -- Physical damage. 2 hit. Damage varies with TP.
  -- 70% MND / 30% STR; 3.0-9.75fTP
  -- TP Bonus > WSD > MND > STR
  sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Ginsen", --Sub
    -- head="Nyame Helm",
    -- body="Nyame Mail",
    -- hands="Nyame Gauntlets",
    -- legs="Nyame Flanchard",
    -- feet="Nyame Sollerets",
    -- neck="Duelist's Torque +2",
    -- ear1="Moonshade Earring",
    -- ear2="Regal Earring",
    -- ring1="Rufescent Ring",
    -- ring2="Metamorph Ring +1",
    -- back="Aurist's Cape +1",
    -- waist="Sailfi Belt +1",
  })
  
  -- Physical damage. 1 hit. Damage varies with TP.
  -- 50% MND / 50% STR; 3.5-12fTP
  -- TP Bonus > WSD > MND = STR
  sets.precast.WS['Judgment'] = set_combine(sets.precast.WS, {
    -- ammo="Aurgelmir Orb +1",
    -- ammo="Ginsen", --Sub
    -- head="Nyame Helm",
    -- body="Nyame Mail",
    -- hands="Nyame Gauntlets",
    -- legs="Nyame Flanchard",
    -- feet="Nyame Sollerets",
    -- neck="Duelist's Torque +2",
    -- ear1="Moonshade Earring",
    -- ear2="Regal Earring",
    -- ring1="Rufescent Ring",
    -- ring2="Metamorph Ring +1",
    -- back="Aurist's Cape +1",
    -- waist="Sailfi Belt +1",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Midcast Sets
  sets.midcast.FastRecast = sets.precast.FC
  
  -- Cure sets

  -- CPII, CP, Heal Skill, MND, VIT, SIRD, PDT/MDT, -Enmity
  SIRDoptions = {
    -- main="Eremite's Wand +1",      -- __, __, ___,   2, ___, 25 [__/__, ???] __
    -- sub="Culminus",                -- __, __, ___, ___, ___, 10 [__/__, ???] __

    -- sub="Magic Strap",             -- __, __, ___, ___, ___,  5 [__/__, ???] __
    -- ammo="Staunch Tathlum +1",     -- __, __, ___, ___, ___, 11 [ 3/ 3, ???] __
    -- head="Adhara Turban",          -- __, __, ___, ___, ___, 20 [__/__, ___]  6
    -- head=gear.Kaykaus_C_head,      -- __, 11,  16,  19,  14, 12 [__/ 3, ???] __
    -- head="Chironic Hat",           -- __, __, ___,  29,  14, 11 [__/ 2, ???] __
    -- body=gear.Kaykaus_C_body,      --  4, __, ___,  33,  20, 12 [__/__, ???] __
    -- body="Rosette Jaseran +1",     -- __, __, ___,  29,  21, 25 [ 5/ 5, ???] 13
    -- body="Chrionic Doublet",       -- __, 13, ___,  34,  16, 11 [__/__, ???] __
    -- hands="Chironic Gloves",       -- __, __, ___,  38,  20, 31 [__/__, ???] __
    -- legs=gear.Kaykaus_C_legs,      -- __, 11, ___,  30,  12, 12 [__/__, ???] __
    -- legs="Chironic Hose",          -- __,  8, ___,  29,   6, 11 [__/__, ???] __
    -- feet="Chironic Slippers",      -- __, __, ___,  24,   6, 11 [ 2/__, ???]  5
    -- neck="Loricate Torque +1",     -- __, __, ___, ___, ___,  5 [ 6/ 6, ???] __
    -- ear1="Nourishing Earring +1",  -- __,  7, ___,   4, ___,  5 [__/__, ___] __; Resist Silence +15
    -- ear1="Magnetic Earring",       -- __, __, ___, ___, ___,  8 [__/__, ???] __
    -- ear1="Halasz Earring",         -- __, __, ___, ___, ___,  5 [__/__, ???]  3
    -- ring1="Freke Ring",            -- __, __, ___, ___, ___, 10 [__/__, ???] __
    -- ring1="Evanescence Ring",      -- __, __, ___, ___, ___,  5 [__/__, ???] __
    -- back=AmbuCape1,                -- __, 10, ___,  30, ___, 10 [__/__, ???] __
    -- back=AmbuCape2,                -- __, __, ___,  30, ___, 10 [__/__, ???] 10
    -- waist="Emphatikos Rope",       -- __, __, ___, ___, ___, 12 [__/__, ???] __
    -- waist="Sanctuary Obi +1",      -- __, __, ___, ___, ___, 10 [__/__, ???]  4
    -- waist="Rumination Sash",       -- __, __, ___,   4, ___, 10 [__/__, ???] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ???]  5
  }

  -- Mithra WHM/SCH M30 Healing Magic Skill = 506
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureNormal = {
    -- main="Eremite's Wand +1",      -- __, __, ___,   2, ___, 25 [__/__, ___] __
    -- sub="Genbu's Shield",          -- __,  5, ___, ___, ___, __ [10/__, ___] __; Requires synergy aug
    -- ammo="Staunch Tathlum +1",     -- __, __, ___, ___, ___, 11 [ 3/ 3, ___] __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12 [__/ 3,  75] __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25 [ 5/ 5,  80] 13
    -- hands="Theophany Mitts +3",    --  4, __,  21,  48,  35, __ [__/__,  47]  6
    -- legs="Ebers Pantaloons +1",    -- __, __, ___,  33,  12, __ [__/__, 107] __; 6% cure mp return
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __ [__/__, 107]  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5 [ 6/ 6, ___] __
    -- ear1="Novia Earring",          -- __, __, ___, ___, ___, __ [__/__, ___]  7
    -- ear2="Nourishing Earring +1",  -- __,  7, ___,   4, ___,  5 [__/__, ___] __; Resist Silence +15
    ring1="Gelatinous Ring +1",       -- __, __, ___, ___,  15, __ [ 7/-1, ___] __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __ [10/10, ___] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, ___,  30, ___, __ [10/__,  20] __
    -- waist="Sanctuary Obi +1",      -- __, __, ___, ___, ___, 10 [__/__, ___]  4
    -- Kaykaus bonus                      4, __, ___, ___, ___, __ [__/__, ___] __
    -- Base Stats                     -- __, __, 506, 129, 123, __ [__/__, ___] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ___]  5
    -- 8 CPII, 50 CP, 543 Heal Skill, 323 MND, 240 VIT, 103 SIRD [51PDT/26MDT, 416 MEVA] 41 -Enmity
    -- 764 Power
  }

  -- TODO: Update set
  sets.midcast.Curaga = set_combine(sets.midcast.CureNormal,{
    body="Bunzi's Robe",        --+15Pot,   , 10DT ,-10Enm
  })

  -- TODO: Update set
  sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
    --Removed chatoyant due to big loss of CP and PDT
    -- main="Chatoyant Staff",
    -- sub="Achaq grip",           --+0FC      , 0DT, ,-4Enm
    -- back="Twilight Cape",
    waist="Hachirin-no-Obi",

    main="Malignance Pole",           -- __, __, ___, ___,  40, __ [20/20, ___] __
    sub="Khonsu",                     -- __, __, ___, ___, ___, __ [ 6/ 6, ___]  5
    -- ammo="Staunch Tathlum +1",     -- __, __, ___, ___, ___, 11 [ 3/ 3, ___] __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12 [__/ 3,  75] __
    body="Bunzi's Robe",              -- __, 15, ___,  43,  23, __ [10/10, 139] 10
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31 [__/__,  48] __; Can add more DT or Enmity
    legs="Ebers Pantaloons +1",       -- __, __, ___,  33,  12, __ [__/__, 107] __; 6% cure mp return
    feet="Theophany Duckbills +3",    -- __, __, ___,  34,  20, 29 [__/__, 127] __
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5 [ 6/ 6, ___] __
    -- ear1="Novia Earring",          -- __, __, ___, ___, ___, __ [__/__, ___]  7
    -- ear2="Nourishing Earring +1",  -- __,  7, ___,   4, ___,  5 [__/__, ___] __; Resist Silence +15
    -- ring1="Kuchekula Ring",        -- __, __, ___, ___, ___, __ [__/__, ___]  7; Use Janniston if you have it
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __ [10/10, ___] __
    -- back=gear.SCH_CP_Cape,         -- __, 10, ___,  30, ___, __ [10/__,  20] __
    -- waist="Sanctuary Obi +1",      -- __, __, ___, ___, ___, 10 [__/__, ___]  4
    -- Base Stats                     -- __, __, 506, 129, 123, __ [__/__, ___] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ___]  5
    -- 0 CPII, 43 CP, 522 Heal Skill, 330 MND, 252 VIT, 113 SIRD, [65PDT/58MDT, 516 MEVA], 38 -Enmity
  })--52% CP, 20 DT, 27PDT, -38 Enmity, 93SIRD (+10 merits)

  -- TODO: Update set
  sets.midcast.CureSolace = {
    main="Daybreak",                  -- __, 30, ___,  30, ___, __ [__/__,  30] __
    sub="Sors Shield",                -- __,  3, ___, ___, ___, __ [__/__, ___]  5
    ammo="Staunch tathlum +1",        -- __, 11, ___, ___, ___, __ [ 3/ 3, ___] __
    head="Bunzi's Hat",               -- __, __, ___,  33,  16, __ [ 7/ 7, ___]  7
    body="Ebers Bliaut +1",           -- __, __,  24,  33,  20, __ [__/__,  80] __; Afflatus +14
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31 [__/__,  48] __; Can add more DT or Enmity
    legs="Ebers Pantaloons +1",       -- __, __, ___,  33,  12, __ [__/__, 107] __; 6% cure mp return
    feet="Theophany Duckbills +3",    -- __, __, ___,  34,  20, 29 [__/__, 127] __
    neck="Cleric's Torque +1",        -- __,  7, ___, ___, ___, __ [__/__, ___] __
    ear1="Magnetic Earring",          -- __, __, ___, ___, ___,  8 [__/__, ___] __
    ear2="Halasz Earring",            -- __, __, ___, ___, ___,  5 [__/__, ___]  3
    ring1="Gelatinous Ring +1",       -- __, __, ___, ___,  15, __ [ 7/-1, ___] __; Use Janniston if you have it
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __ [10/10, ___] __
    back=gear.WHM_FC_Cape,            -- __, 10, ___,  30, ___, __ [10/__,  20] __
    waist="Sanctuary Obi +1",         -- __, __, ___, ___, ___, 10 [__/__, ___]  4
    -- Base Stats                     -- __, __, 506, 129, 123, __ [__/__, ___] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ___]  5
    -- 0 CPII, 61 CP, 530 Heal Skill, 360 MND, 226 VIT, 103 SIRD, [47PDT/19MDT, 412 MEVA], 24 -Enmity
  }

  --Maximize healing skill + cursna gear
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
end

function job_post_precast(spell, action, spellMap, eventArgs)
  -- If magic and grimoire is active, use Grimoire sub-set
  local crumbs = mote_vars.set_breadcrumbs
  if spell.action_type == 'Magic' then
    if (buffactive["Light Arts"] or buffactive["Addendum: White"]) or (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
      if (#crumbs == 3) then
        equip(sets[crumbs[2]][crumbs[3]].Grimoire)
      end
      if (#crumbs == 4) then
        equip(sets[crumbs[2]][crumbs[3]][crumbs[4]].Grimoire)
      end
      if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact.Grimoire)
      end
    else
      if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
      end
    end
  end
  
  -- Handle belts for elemental WS
  if spell.type == 'WeaponSkill' and elemental_ws:contains(spell.english) then
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

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
  if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
    equip(sets.magic_burst)
    if spell.english == "Impact" then
      equip(sets.midcast.Impact)
    end
  end
  -- Handle belts for elemental damage
  if spell.skill == 'Elemental Magic' then
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
  if spell.english == 'Drain' or 'Aspir' then
    local obi_mult = silibs.get_day_weather_multiplier(spell.element, true, false)
    if obi_mult > 1.08 then -- Must beat Fucho-no-Obi
      equip({waist="Hachirin-no-Obi"})
    end
  end
  if spell.skill == 'Enhancing Magic' then
    if classes.NoSkillSpells:contains(spell.english) then
      equip(sets.midcast.EnhancingDuration)
      if spellMap == 'Refresh' then
        if spell.targets.Self then
          -- If self targeted
          equip(sets.midcast.RefreshSelf)
        else
          -- If not self targeted
          equip(sets.midcast.Refresh)
        end
      end
    end
  end

  -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
  if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
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
    if default_spell_map == 'Cure' and state.Buff['Afflatus Solace'] then
      return 'CureSolace'
    end
    if spell.skill == 'Enfeebling Magic' then
      if spell.type == 'WhiteMagic' then
        return 'MndEnfeebles'
      else
        return 'IntEnfeebles'
      end
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

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
  if cmdParams[1] == 'user' and not areas.Cities:contains(world.area) then
    local needsArts = player.sub_job:lower() == 'sch' and
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
end

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
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


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  gearinfo(cmdParams, eventArgs)
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
    if not midaction() then
      job_update()
    end
  end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book
  set_macro_page(1, 4)
end
