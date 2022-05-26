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
  silibs.enable_auto_lockstyle(4)
  silibs.enable_premade_commands()

  state.CP = M(false, "Capacity Points Mode")

  state.OffenseMode:options('None', 'Normal')
  state.CastingMode:options('Normal', 'Resistant')
  state.IdleMode:options('Normal', 'PDT', 'CP')

  state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
  state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false

  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @c gs c toggle CP')

  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind !` input /ja "Afflatus Solace" <me>')

  send_command('bind !e input /ma "Haste" <stpc>')
  send_command('bind !u input /ma "Blink" <me>')
  send_command('bind !i input /ma "Stoneskin" <me>')
  send_command('bind !p input /ma "Aquaveil" <me>')
  send_command('bind !; input /ma "Regen V" <stpc>')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'SCH' then
    send_command('bind ^- gs c scholar light')
    send_command('bind ^= gs c scholar dark')
    
    send_command('bind ^\\\\ gs c scholar cost')
    send_command('bind ![ gs c scholar aoe')
    send_command('bind !\\\\ gs c scholar speed')

    send_command('bind !q input /ja "Sublimation" <me>')
  elseif player.sub_job == 'RDM' then
    send_command('bind !\' input /ma "Refresh" <stpc>')
  end

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @c')

  send_command('unbind ^`')
  send_command('unbind @w')
  
  send_command('unbind !`')

  send_command('unbind !e')
  send_command('unbind !u')
  send_command('unbind !i')
  send_command('unbind !p')
  send_command('unbind !;')

  send_command('unbind ^-')
  send_command('unbind ^=')
  
  send_command('unbind ^\\\\')
  send_command('unbind ![')
  send_command('unbind !\\\\')

  send_command('unbind !q')


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
    sub="Mensch Strap +1",            -- __ [ 5/__, ___]
    ammo="Incantor Stone",            --  2 [__/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91]
    legs="Pinga Pants +1",            -- 13 [__/__, 147]
    feet=gear.Merl_FC_feet,           -- 11 [__/__, 118]
    neck="Cleric's Torque +1",        --  8 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    waist="Carrier Sash",             -- __ [__/__, ___]; Ele Resist+15
    -- body="Inyanga Jubbah +2",      -- 14 [__/ 8, 120]
    -- hands=gear.Gende_FC_hands,     --  7 [ 4/__,  37]
    -- back=gear.WHM_FC_Cape,         -- 10 [10/__,  20]
    -- 80 Fast Cast [63PDT/47MDT, 565 MEVA]
  } -- 63 Fast Cast [51PDT/39MDT, 479 MEVA]

  -- 10% cap on Quick Magic
  sets.QuickMagic = {
    main="Malignance Pole",           -- __ [20/20, ___] __
    sub="Mensch Strap +1",            -- __ [ 5/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123] __
    body=gear.Merl_FC_body,           -- 14 [ 2/__,  91] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet=gear.Merl_FC_feet,           -- 11 [__/__, 118] __
    neck="Cleric's Torque +1",        --  8 [__/__, ___] __
    ear1="Malignance Earring",        --  4 [__/__, ___] __
    ear2="Odnowa Earring +1",         -- __ [ 3/ 5, ___] __
    ring2="Veneficium Ring",          -- __ [__/__, ___]  1
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- ammo="Impatiens",              -- __ [__/__, ___]  2
    -- body="Inyanga Jubbah +2",      -- 14 [__/ 8, 120] __
    -- hands=gear.Gende_FC_hands,     --  7 [ 4/__,  37] __
    -- ring1="Lebeche Ring",          -- __ [__/__, ___]  2
    -- back=gear.WHM_FC_Cape,         -- 10 [10/__,  20] __
    -- 80 Fast Cast [49PDT/40MDT, 565 MEVA] 8 Quick Magic
  } -- 63 Fast Cast [37PDT/32MDT, 479 MEVA] 4 Quick Magic

  -- Cap quick magic, but can remove some FC due to Diving Benison trait (increase defense instead)
  sets.precast.FC.StatusRemoval = {
    main="Malignance Pole",           -- __ [20/20, ___] __
    sub="Mensch Strap +1",            -- __ [ 5/__, ___]
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123] __
    body="Shamash Robe",              -- __ [10/__, 106] __; Resist Silence+90
    hands=gear.Nyame_B_hands,         -- __ [ 7/ 7, 112] __
    legs="Pinga Pants +1",            -- 13 [__/__, 147] __
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150] __
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___] __; +Defense
    ear1="Malignance Earring",        --  4 [__/__, ___] __
    ear2="Etiolation Earring",        --  1 [__/ 3, ___] __; Resist Silence+15
    ring2="Defending Ring",           -- __ [10/10, ___] __
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- Divine Benison Trait              50
    
    -- ammo="Impatiens",              -- __ [__/__, ___]  2
    -- ring1="Lebeche Ring",          -- __ [__/__, ___]  2
    -- back="Perimede Cape",          -- __ [__/__, ___]  4
  } -- 81 Fast Cast [72PDT/60MDT, 638 MEVA] 7 Quick Magic

  sets.precast.FC.Arise = sets.QuickMagic
  
  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    -- main="Daybreak",
    -- sub="Genmei Shield",
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
    -- head=gear.Kaykaus_C_head,      -- __, 11,  16,  19,  14, 12 [__/ 3,  75] __
    -- head="Chironic Hat",           -- __, __, ___,  29,  14, 11 [__/ 2, ???] __
    -- body=gear.Kaykaus_C_body,      --  4, __, ___,  33,  20, 12 [__/__,  80] __
    -- body="Rosette Jaseran +1",     -- __, __, ___,  29,  21, 25 [ 5/ 5, ???] 13
    -- body="Chrionic Doublet",       -- __, 13, ___,  34,  16, 11 [__/__, ???] __
    -- hands="Chironic Gloves",       -- __, __, ___,  38,  20, 31 [__/__, ???] __
    -- legs=gear.Kaykaus_C_legs,      -- __, 11, ___,  30,  12, 12 [__/__, 107] __
    -- legs="Chironic Hose",          -- __,  8, ___,  29,   6, 11 [__/__, ???] __
    -- feet="Chironic Slippers",      -- __, __, ___,  24,   6, 11 [ 2/__, ???]  5
    -- feet="Theophany Duckbills +3", -- __, __, ___,  34,  20, 29 [__/__, 127] __
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
  
  -- WHM/SCH M30 Healing Magic Skill = 506
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureNormal = {
    main="Malignance Pole",           -- __, __, ___, ___,  40, __ [20/20, ___] __
    sub="Mensch Strap +1",            -- __, __, ___, ___, ___, __ [ 5/__, ___] __
    ammo="Staunch Tathlum",           -- __, __, ___, ___, ___, 10 [ 2/ 2, ___] __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12 [__/ 3,  75] __
    body=gear.Kaykaus_C_body,         --  4, __, ___,  33,  20, 12 [__/__,  80] __
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31 [__/__,  48] __; Can add more DT or Enmity
    legs=gear.Kaykaus_C_legs,         -- __, 11, ___,  30,  12, 12 [__/__, 107] __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __ [__/__, 107]  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5 [ 6/ 6, ___] __
    ear2="Halasz Earring",            -- __, __, ___, ___, ___,  5 [__/__, ___]  3
    ring1="Gelatinous Ring +1",       -- __, __, ___, ___,  15, __ [ 7/-1, ___] __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __ [10/10, ___] __
    waist="Rumination Sash",          -- __, __, ___,   4, ___, 10 [__/__, ___] __

    -- Ideal:
    -- main="Eremite's Wand +1",      -- __, __, ___,   2, ___, 25 [__/__, ___] __
    -- sub="Genbu's Shield",          -- __,  5, ___, ___, ___, __ [10/__, ___] __; Requires synergy aug
    -- ammo="Staunch Tathlum +1",     -- __, __, ___, ___, ___, 11 [ 3/ 3, ___] __
    -- head=gear.Kaykaus_C_head,      -- __, 11,  16,  19,  14, 12 [__/ 3,  75] __
    -- body="Rosette Jaseran +1",     -- __, __, ___,  39,  31, 25 [ 5/ 5,  80] 13
    -- hands="Theophany Mitts +3",    --  4, __,  21,  48,  35, __ [__/__,  47]  6
    -- legs="Ebers Pantaloons +1",    -- __, __, ___,  33,  12, __ [__/__, 107] __; 6% cure mp return
    -- feet=gear.Kaykaus_D_feet,      -- __, 17, ___,  19,  10, __ [__/__, 107]  6
    -- neck="Loricate Torque +1",     -- __, __, ___, ___, ___,  5 [ 6/ 6, ___] __
    -- ear1="Novia Earring",          -- __, __, ___, ___, ___, __ [__/__, ___]  7
    -- ear2="Nourishing Earring +1",  -- __,  7, ___,   4, ___,  5 [__/__, ___] __; Resist Silence +15
    -- ring1="Gelatinous Ring +1",    -- __, __, ___, ___,  15, __ [ 7/-1, ___] __
    -- ring2="Defending Ring",        -- __, __, ___, ___, ___, __ [10/10, ___] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, ___,  30, ___, __ [10/__,  20] __
    -- waist="Sanctuary Obi +1",      -- __, __, ___, ___, ___, 10 [__/__, ___]  4
    -- Kaykaus bonus                      4, __, ___, ___, ___, __ [__/__, ___] __
    -- Base Stats                     -- __, __, 506, 129, 123, __ [__/__, ___] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ___]  5
    -- 8 CPII, 50 CP, 543 Heal Skill, 323 MND, 240 VIT, 103 SIRD [51PDT/26MDT, 416 MEVA] 41 -Enmity
  }

  -- WHM/SCH M30 Healing Magic Skill = 506
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
    main="Chatoyant Staff",           -- __, 10, ___,   5,   5, __, __/__, __
    sub="Mensch Strap +1",            -- __, __, ___, ___, ___, __ [ 5/__, ___] __
    ammo="Staunch Tathlum",           -- __, __, ___, ___, ___, 10,  2/ 2, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs=gear.Kaykaus_C_legs,         -- __, 11, ___,  30,  12, 12, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Gelatinous Ring +1",       -- __, __, ___, ___,  15, __,  7/-1, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    waist="Hachirin-no-Obi",          -- __, __, ___, ___, ___, __, __/__, __

    -- Ideal:
    -- main="Chatoyant Staff",        -- __, 10, ___,   5,   5, __ [__/__, ???] __
    -- sub="Mensch Strap +1",         -- __, __, ___, ___, ___, __ [ 5/__, ___] __
    -- ammo="Staunch Tathlum +1",     -- __, __, ___, ___, ___, 11 [ 3/ 3, ???] __
    -- head=gear.Kaykaus_C_head,      -- __, 11,  16,  19,  14, 12 [__/ 3,  75] __
    -- hands=gear.Chironic_SIRD_hands,-- __, __, ___,  38,  20, 31 [__/__, ???] __; Can add more DT or Enmity
    -- body="Bunzi's Robe",           -- __, 15, ___,  43,  23, __ [10/10, 139] 10
    -- legs="Ebers Pantaloons +1",    -- __, __, ___,  33,  12, __ [__/__, 107] __; 6% cure mp return
    -- feet="Theophany Duckbills +3", -- __, __, ___,  34,  20, 29 [__/__, 127] __
    -- neck="Loricate Torque +1",     -- __, __, ___, ___, ___,  5 [ 6/ 6, ???] __
    -- ear1="Novia Earring",          -- __, __, ___, ___, ___, __ [__/__, ___]  7
    -- ear2="Nourishing Earring +1",  -- __,  7, ___,   4, ___,  5 [__/__, ___] __; Resist Silence +15
    -- ring1="Gelatinous Ring +1",    -- __, __, ___, ___,  15, __ [ 7/-1, ???] __
    -- ring2="Defending Ring",        -- __, __, ___, ___, ___, __ [10/10, ???] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, ___,  30, ___, __ [10/__, ???] __
    -- waist="Hachirin-no-Obi",       -- __, __, ___, ___, ___, __ [__/__, ???] __
    -- Kaykaus set bonus              -- __, __, ___, ___, ___, __ [__/__, ???] __
    -- Base Stats                     -- __, __, 506, 129, 123, __ [__/__, ___] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ???]  5
    -- 0 CPII, 53 CP, 522 Heal Skill, 335 MND, 232 VIT, 103 SIRD, 51PDT/31MDT, 22 -Enmity
  })

  -- WHM/SCH M30 Healing Magic Skill = 506
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureSolace = set_combine(sets.midcast.CureNormal, {
    main="Malignance Pole",           -- __, __, ___, ___,  40, __, 20/20, __
    sub="Mensch Strap +1",            -- __, __, ___, ___, ___, __ [ 5/__, ___] __
    ammo="Staunch Tathlum",           -- __, __, ___, ___, ___, 10,  2/ 2, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body=gear.Kaykaus_C_body,         --  4, __, ___,  33,  20, 12, __/__, __
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs=gear.Kaykaus_C_legs,         -- __, 11, ___,  30,  12, 12, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear2="Halasz Earring",            -- __, __, ___, ___, ___,  5, __/__,  3
    ring1="Gelatinous Ring +1",       -- __, __, ___, ___,  15, __,  7/-1, __; Use Janniston if you have it
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    waist="Rumination Sash",          -- __, __, ___,   4, ___, 10, __/__, __

    -- Ideal:
    -- main="Ababinili +1",           -- __, 34,  21,  12, ___, __ [10/10, ___] __
    -- sub="Mensch Strap +1",         -- __, __, ___, ___, ___, __ [ 5/__, ___] __
    -- ammo="Staunch Tathlum +1",     -- __, __, ___, ___, ___, 11 [ 3/ 3, ___] __
    -- head="Adhara Turban",          -- __, __, ___, ___, ___, 20 [__/__, ___]  6
    -- body="Ebers Bliaut +1",        -- __, __,  24,  33,  20, __ [__/__,  80] __; Solace+14
    -- hands=gear.Chironic_SIRD_hands,-- __, __, ___,  38,  20, 31 [__/__,  48] __; Can add more DT or Enmity
    -- legs="Ebers Pantaloons +1",    -- __, __, ___,  33,  12, __ [__/__, 107] __; 6% cure mp return
    -- feet="Theophany Duckbills +3", -- __, __, ___,  34,  20, 29 [__/__, 127] __
    -- neck="Cleric's Torque +1",     -- __,  7, ___,  12, ___, __ [__/__, ___] 20
    -- ear1="Novia Earring",          -- __, __, ___, ___, ___, __ [__/__, ___]  7
    -- ear2="Odnowa Earring +1",      -- __, __, ___, ___,   3, __ [ 3/ 5, ___] __
    -- ring1="Gelatinous Ring +1",    -- __, __, ___, ___,  15, __ [ 7/-1, ___] __
    -- ring2="Defending Ring",        -- __, __, ___, ___, ___, __ [10/10, ___] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, ___,  30, ___, __ [10/__,  20] __; Solace+10
    -- waist="Sanctuary Obi +1",      -- __, __, ___, ___, ___, 10 [__/__, ___]  4
    -- Base Stats                     -- __, __, 506, 129, 123, __ [__/__, ___] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ___]  5
    -- 0 CPII, 51 CP, 551 Heal Skill, 321 MND, 213 VIT, 111 SIRD [48PDT/27MDT, 382] 42 -Enmity
  })

  -- WHM/SCH M30 Healing Magic Skill = 506
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  sets.midcast.CureWeatherSolace = {
    main="Chatoyant Staff",           -- __, 10, ___,   5,   5, __, __/__, __
    sub="Mensch Strap +1",            -- __, __, ___, ___, ___, __ [ 5/__, ___] __
    ammo="Staunch Tathlum",           -- __, __, ___, ___, ___, 10,  2/ 2, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs=gear.Kaykaus_C_legs,         -- __, 11, ___,  30,  12, 12, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Gelatinous Ring +1",       -- __, __, ___, ___,  15, __,  7/-1, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    waist="Hachirin-no-Obi",          -- __, __, ___, ___, ___, __, __/__, __

    -- Ideal:
    -- main="Ababinili +1",           -- __, 34,  21,  12, ___, __ [10/10, ___] __
    -- sub="Mensch Strap +1",         -- __, __, ___, ___, ___, __ [ 5/__, ___] __
    -- ammo="Staunch Tathlum +1",     -- __, __, ___, ___, ___, 11 [ 3/ 3, ___] __
    -- head="Adhara Turban",          -- __, __, ___, ___, ___, 20 [__/__, ___]  6
    -- body="Ebers Bliaut +1",        -- __, __,  24,  33,  20, __ [__/__,  80] __; Solace+14
    -- hands=gear.Chironic_SIRD_hands,-- __, __, ___,  38,  20, 31 [__/__,  48] __; Can add more DT or Enmity
    -- legs="Ebers Pantaloons +1",    -- __, __, ___,  33,  12, __ [__/__, 107] __; 6% cure mp return
    -- feet="Theophany Duckbills +3", -- __, __, ___,  34,  20, 29 [__/__, 127] __
    -- neck="Cleric's Torque +1",     -- __,  7, ___,  12, ___, __ [__/__, ___] 20
    -- ear1="Odnowa Earring +1",      -- __, __, ___, ___,   3, __ [ 3/ 5, ___] __
    -- ear2="Halasz Earring",         -- __, __, ___, ___, ___,  5 [__/__, ___]  3
    -- ring1="Gelatinous Ring +1",    -- __, __, ___, ___,  15, __ [ 7/-1, ___] __
    -- ring2="Defending Ring",        -- __, __, ___, ___, ___, __ [10/10, ___] __
    -- back=gear.WHM_CP_Cape,         -- __, 10, ___,  30, ___, __ [10/__,  20] __; Solace+10
    -- waist="Hachirin-no-Obi",       -- __, __, ___, ___, ___, __ [__/__, ___] __
    -- Base Stats                     -- __, __, 506, 129, 123, __ [__/__, ___] __
    -- Merit points                   -- __, __, ___, ___, ___, 10 [__/__, ___]  5
    -- 0 CPII, 51 CP, 551 Heal Skill, 321 MND, 213 VIT, 106 SIRD [48PDT/27MDT, 382] 34 -Enmity
  }

  -- Cap over 960 power; Power = 3×MND + VIT + 3×floor( Healing Magic Skill÷5 )
  sets.midcast.CuragaNormal = sets.midcast.CureNormal

  -- Cap over 960 power; Power = 3×MND + VIT + 3×floor( Healing Magic Skill÷5 )
  sets.midcast.CuragaWeather = sets.midcast.CureWeather

  -- Removal rate = Base Rate * (1+(y/100))
  -- Base rate = (10+(Healing Skill / 30)); y = Cursna+ stat from gear
  -- WHM/SCH M30 Healing Magic Skill = 506
  sets.midcast.Cursna = {
    main="Gada",                      -- 18, ___,  6
    -- sub="Chanter's Shield",        -- __, ___,  3
    ammo="Incantor Stone",            -- __, ___,  2
    head=gear.Vanya_B_head,           -- 20, ___, __
    -- body="Ebers Bliaut +1",        -- 24, ___, __
    -- hands="Fanatic Gloves",        -- 10,  15,  7
    -- legs="Theophany Pantaloons +3",-- __,  21, __
    feet=gear.Vanya_B_feet,           -- 40,   5, __
    neck="Debilis Medallion",         -- __,  15, __
    ear1="Malignance Earring",        -- __, ___,  4
    ear2="Meili Earring",             -- 10, ___, __
    ring1="Haoma's Ring",             --  8,  15, __
    ring2="Menelaus's Ring",          -- 15,  20,-10
    -- back=gear.WHM_FC_Cape,         -- __,  25, 10
    waist="Embla Sash",               -- __, ___,  5
    -- Base stats                       506, ___, __
    -- 651 Healing skill, 116 Cursna+, 27 FC; Cursna Rate = 68.472%

    -- Ideal:
    -- main="Gambanteinn",             -- __, 100, __ [__/__, ___]
    -- sub="Genmei Shield",            -- __, ___, __ [10/__, ___]
    -- ammo="Staunch Tathlum +1",      -- __, ___, __ [ 3/ 3, ___]
    -- head=gear.Vanya_B_head,         -- 20, ___, __ [__/ 5,  75]
    -- body="Bunzi's Robe",            -- __, ___, __ [10/10, 139]
    -- hands="Fanatic Gloves",         -- 10,  15,  7 [__/__,  37]
    -- legs="Theophany Pantaloons +3", -- __,  21, __ [__/__, 127]
    -- feet=gear.Vanya_B_feet,         -- 40,   5, __ [__/ 3, 107]
    -- neck="Debilis Medallion",       -- __,  15, __ [__/__, ___]
    -- ear1="Odnowa Earring +1",       -- __, ___, __ [ 3/ 5, ___]
    -- ear2="Meili Earring",           -- 10, ___, __ [__/__, ___]
    -- ring1="Haoma's Ring",           --  8,  15, __ [__/__, ___]
    -- ring2="Menelaus's Ring",        -- 15,  20,-10 [__/__, ___]
    -- back=gear.WHM_FC_Cape,          -- __,  25, 10 [10/__,  20]
    -- waist="Bishop's Sash",          --  5, ___, __ [__/__, ___]
    -- Base stats                        506, ___, __ [__/__, ___]
    -- 614 Healing skill, 216 Cursna+, 7 FC [36PDT/26MDT, 505MEVA]; Cursna Rate = 96.275%
  }

  sets.midcast.StatusRemoval = sets.midcast.FastRecast

  sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {
    neck="Cleric's Torque +1",
  })

  sets.midcast['Enhancing Magic'] = {
    main="Gada",                      -- 18, __, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __,  9, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __ [__/__,  80]
    hands=gear.Telchine_ENH_hands,    -- __, 10, __ [__/__,  61]
    legs=gear.Telchine_ENH_legs,      -- __, 10, __ [__/__, 128]
    feet=gear.Telchine_ENH_feet,      -- __,  9, __ [__/__, 107]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Base                             394; Includes merits
    -- Master Levels                     30

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
    -- Master Levels                     30
    -- 503 Enh Skill, 55% Enh Duration, 30 FC [51 PDT/38 MDT, 521 MEVA]
  } -- 454 Enh Skill, 68% Enh Duration, 5 FC [3 PDT/3 MDT, 451 MEVA]

  sets.midcast.EnhancingDuration = {
    main="Gada",                      -- 18, __, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __,  9, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __ [__/__,  80]
    hands=gear.Telchine_ENH_hands,    -- __, 10, __ [__/__,  61]
    legs=gear.Telchine_ENH_legs,      -- __, 10, __ [__/__, 128]
    feet=gear.Telchine_ENH_feet,      -- __,  9, __ [__/__, 107]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Base                             394; Includes merits
    -- Master Levels                     30

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
    -- ear1="Mimir Earring",          -- 10, __, __ [__/__, ___]
    -- ear2="Odnowa Earring +1",      -- __, __, __ [ 3/ 5, ___]
    -- ring1="Gelatinous Ring +1",    -- __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",        -- __, __, __ [10/10, ___]
    -- back="Fi Follet Cape +1",      --  9, __, 10 [__/__, ___]
    -- waist="Embla Sash",            -- __, 10,  5 [__/__, ___]
    -- Base                             394; Includes merits
    -- Master Levels                     30
    -- Light Arts                        26
    -- 520 Enh Skill, 76% Enh Duration, 41 FC [29 PDT/23 MDT, 526 MEVA]
  } -- 454 Enh Skill, 76% Enh Duration, 5 FC [3 PDT/3 MDT, 451 MEVA]

  -- Focus on SS pot, DT, and Recast time.
  -- In Odyssey endgame, no tank so WHM needs to be able to tank when spamming this.
  sets.midcast.Stoneskin = {
    main="Malignance Pole",     -- [20/20, ___] __, __
    sub="Mensch Strap +1",      -- [ 5/__, ___] __, __
    ammo="Incantor Stone",      -- [__/__, ___] __,  2
    head="Bunzi's Hat",         -- [ 7/ 7, 123] __, 10
    feet=gear.Merl_FC_feet,     -- [__/__, 118] __, 11
    neck="Nodens Gorget",       -- [__/__, ___] 30, __
    ear2="Malignance Earring",  -- [__/__, ___] __,  4
    ring1="Kishar Ring",        -- [__/__, ___] __,  4
    ring2="Defending Ring",     -- [10/10, ___] __, __
    -- body="Inyanga Jubbah +2",-- [__/ 8, 120] __, 14
    -- hands="Stone Mufflers",  -- [__/__, ___] 30, __
    -- legs="Shedir Seraweels", -- [__/__, ___] 35, __
    -- ear1="Earthcry Earring", -- [__/__, ___] 10, __
    -- back=gear.WHM_FC_Cape,   -- [10/__,  20] __, 10
    -- waist="Siegel Sash",     -- [__/__, ___] 20, __
    -- [52 PDT/45 MDT, 381 MEVA] +125 Stoneskin Potency, 55 Fast Cast
  }

  sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
    -- feet="Ebers Duckbills +1", -- Auspice+15
  })

  sets.midcast.Arise = sets.midcast.FastRecast

  -- At least 500 Enh magic skill
  sets.midcast.BarElement = {
    head=gear.Telchine_ENH_head,      -- __,  9 [__/__,  75] __, __
    body=gear.Telchine_ENH_body,      -- 12, 10 [__/__,  80] __, __
    hands=gear.Telchine_ENH_hands,    -- __, 10 [__/__,  61] __, __
    legs=gear.Telchine_ENH_legs,      -- __, 10 [__/__, 128] __, __
    feet=gear.Telchine_ENH_feet,      -- __,  9 [__/__, 107] __, __
    neck="Loricate Torque +1",        -- __, __ [ 6/ 6, ___] __, __
    ear2="Odnowa Earring +1",         -- __, __ [ 3/ 5, ___] __, __
    ring1="Gelantinous Ring +1",      -- __, __ [ 7/-1, ___] __, __
    ring2="Defending Ring",           -- __, __ [10/10, ___] __, __
    waist="Embla Sash",               -- __, 10 [__/__, ___] __, __
    -- Merits/JP                         16, __ [__/__, ___] 50, 10
    -- Base                             378
    -- Master Levels                     30

    -- main="Beneficus",              -- 15, __ [__/__, ___] __,  5
    -- sub="Genmei Shield",           -- __, __ [10/__, ___] __, __
    -- ammo="Staunch Tathlum +1",     -- __, __ [ 3/ 3, ___] __, __
    -- head=gear.Telchine_ENH_head,   -- __, 10 [__/__, 100] __, __
    -- body="Ebers Bliaut +1",        -- __, __ [__/__,  80] __, 14
    -- hands="Dynasty Mitts",         -- 18,  5 [__/__,  37] __, __
    -- legs="Piety Pantaloons +3",    -- 26, __ [__/__, 127] 36, __
    -- feet="Theophany Duckbills +3", -- 21, 10 [__/__, 127] __, __
    -- ear1="Mimir Earring",          -- 10, __ [__/__, ___] __, __
    -- back=gear.WHM_FC_Cape,         -- __, __ [10/__,  20] __, __
    -- 514 Enh Skill, 35% Enh Duration [49 PDT/23 MDT, 491 MEVA] 86 Barspell Resistance, 29 Barspell M.Def
  } -- 436 Enh Skill, 58% Enh Duration [26 PDT/20 MDT, 451 MEVA] 50 Barspell Resistance, 10 Barspell M.Def

  -- TODO
  sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
    main="Bolelabunga",
    legs=gear.Telchine_RGN_legs,
    -- sub="Genmei Shield",
    -- body="Piety Briault",
    -- hands="Orison Mitts +2",
    -- legs="Theophany Pantaloons",
  })

  -- sets.midcast['Divine Magic'] = {main="Bolelabunga",sub="Genmei Shield",
  --     head="Nahtirah Hat",neck="Colossus's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
  --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring2="Sangoma Ring",
  --     back="Refraction Cape",waist=gear.ElementalObi,legs="Theophany Pantaloons",feet="Gendewitha Galoshes"}

  -- sets.midcast['Dark Magic'] = {main="Bolelabunga", sub="Genmei Shield",
  --     head="Nahtirah Hat",neck="Aesir Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
  --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Sangoma Ring",
  --     back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}

  sets.midcast.MndEnfeebles = {
    ammo="Pemphredo Tathlum",         -- __,  8, __,  4 [__/__, ___]
    head="Bunzi's Hat",               -- __, 40, 33, 34 [ 7/ 7, 123]
    body="Bunzi's Robe",              -- __, 40, 43, 48 [10/10, 139]
    ear1="Regal Earring",             -- __, __, 10, 10 [__/__, ___]
    ear2="Malignance Earring",        -- __, 10,  8,  8 [__/__, ___]
    -- main="Daybreak",               -- __, 40, 30, __ [__/__, ___]
    -- sub="Genmei Shield",           -- __, __, __, __ [10/__, ___]
    -- hands=gear.Kaykaus_A_hands,    -- 16, 53, 47, 19 [__/__,  37]
    -- legs=gear.Chironic_MAcc_legs,  -- 13, 60, 29, 42 [__/__, 118]
    -- feet="Theophany Duckbills +3", -- 21, 46, 34, 32 [__/__, 127]
    -- neck="Incanter's Torque",      -- 10, __, __, __ [__/__, ___]
    -- ring1="Stikini Ring +1",       --  8, 11,  8, __ [__/__, ___]
    -- ring2="Stikini Ring +1",       --  8, 11,  8, __ [__/__, ___]
    -- back="Aurist's Cape +1",       -- __, 33, 33, 33 [__/__, ___]
    -- waist="Acuity Belt +1",        -- __, 15, __, 23 [__/__, ___]
    -- AF set bonus                   -- __, 15, __, __ [__/__, ___]
    -- 76 Enfeebling skill, 382 M.Acc, 283 MND, 253 INT [27 PDT/17 MDT, 544 MEVA]
  }

  sets.midcast.IntEnfeebles = sets.midcast.MndEnfeebles

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

  sets.midcast.Dispelga = {
    -- main="Daybreak",
    -- sub="Genmei Shield",
  }

  -- sets.midcast.IntEnfeebles = {main="Lehbrailg +2", sub="Mephitis Grip",
  --     head="Nahtirah Hat",neck="Weike Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
  --     body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Sangoma Ring",
  --     back="Refraction Cape",waist="Demonry Sash",legs="Bokwus Slops",feet="Piety Duckbills +1"}


------------------------------------------------------------------------------------------------
----------------------------------------- Idle Sets --------------------------------------------
------------------------------------------------------------------------------------------------


  sets.idle = {
    main="Bolelabunga",             -- __/__, ___ [ 1]
    sub="Genmei Shield",            -- 10/__, ___ [__]
    ammo="Staunch Tathlum",         --  2/ 2, ___ [__]
    head=gear.Nyame_B_head,         --  7/ 7, 123 [__]
    body="Shamash Robe",            -- 10/__, 106 [ 3]; Resist Silence+90
    hands=gear.Nyame_B_hands,       --  7/ 7, 112 [__]
    legs="Assiduity Pants +1",      -- __/__, 107 [ 2]
    feet=gear.Nyame_B_feet,         --  7/ 7, 150 [__]
    neck="Loricate Torque +1",      --  6/ 6, ___ [__]; DEF+60
    ear1="Hearty Earring",          -- __/__, ___ [__]; Resist Status+5
    ear2="Etiolation Earring",      -- __/ 3, ___ [__]; Resist Silence+15
    ring2="Defending Ring",         -- 10/10, ___ [__]
    back=gear.WHM_FC_Cape,          -- 10/__,  20 [__]
    waist="Carrier's Sash",         -- __/__, ___ [__]; Ele Resist+15
    -- main="Mpaca's Staff",        -- __/__, ___ [ 2]
    -- sub="Mensch Strap +1",       --  5/__, ___ [__]
    -- ammo="Staunch Tathlum +1",   --  3/ 3, ___ [__]; Resist Status+11
    -- hands="Volte Gloves",        -- __/__,  96 [ 1]
    -- feet="Volte Gaiters",        -- __/__, 142 [ 1]
    -- ring1="Stikini Ring +1",     -- __/__, ___ [ 1]
    -- 51 PDT / 29 MDT, 574 M.Eva [10 Refresh]
  } -- 69 PDT / 42 MDT, 618 M.Eva [6 Refresh]
  sets.idle.Refresh = sets.idle
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle.Refresh, {
    waist="Fucho-no-Obi",
  })
  sets.idle.Sublimation = set_combine(sets.idle, {
    waist="Embla Sash",
  })
  sets.idle.Sublimation.Refresh = sets.idle.Sublimation

  
------------------------------------------------------------------------------------------------
---------------------------------------- Engaged Sets ------------------------------------------
------------------------------------------------------------------------------------------------

  sets.engaged = {
    -- head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
    -- body="Vanir Cotehardie",hands="Dynasty Mitts",ring1="Rajas Ring",ring2="K'ayres Ring",
    -- back="Umbra Cape",waist="Goading Belt",legs="Gendewitha Spats",feet="Gendewitha Galoshes"
  }


------------------------------------------------------------------------------------------------
---------------------------------------- Special Sets ------------------------------------------
------------------------------------------------------------------------------------------------
  
  -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
  sets.buff['Divine Caress'] = {
    -- hands="Ebers Mitts +1",
    -- back="Mending Cape",
  }

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

  if spell.action_type == 'Magic' then
    if (buffactive['Light Arts'] or buffactive['Addendum: White']) or (buffactive['Dark Arts'] or buffactive['Addendum: Black']) then
      equipSet = select_specific_set(sets.midcast, spell, spellMap)
      -- Add optional casting mode
      if equipSet[state.CastingMode.current] then
        equipSet = equipSet[state.CastingMode.current]
      end
      if (buffactive['Light Arts'] or buffactive['Addendum: White']) and equipSet['LightArts'] then
        equip(equipSet['LightArts'])
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      elseif (buffactive['Dark Arts'] or buffactive['Addendum: Black']) and equipSet['DarkArts'] then
        equip(equipSet['DarkArts'])
        eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
      end
    end
  end
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
  if spell.skill == 'Elemental Magic' or spell.english:contains('Holy') or spell.english:contains('Banish') then
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
    if not sets.midcast[spell.english] and not sets.midcast[spellMap]
        and (classes.NoSkillSpells:contains(spell.english) or classes.ShortEnhancingSpells:contains(spell.english)) then
      equip(sets.midcast.EnhancingDuration)
    end
    -- If self targeted refresh
    if spellMap == 'Refresh' then
      if spell.targets.Self then
        equip(sets.midcast.RefreshSelf)
      end
    end
  end

  -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
  if spellMap == 'StatusRemoval' and buffactive['Divine Caress']
      and spell.english ~= 'Erase' and spell.english ~= 'Esuna' and spell.english ~= 'Sacrifice' then
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
    if default_spell_map == 'Cure' then
      if (world.weather_element == 'Light' or world.day_element == 'Light') then
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
      if (world.weather_element == 'Light' or world.day_element == 'Light') then
        return 'CuragaWeather'
      else
        return 'CuragaNormal'
      end
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
  set_macro_page(1, 4)
end
