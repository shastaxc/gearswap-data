-- File Status: Acceptable.

-- Author: Silvermutt
-- Required external libraries: SilverLibs
-- Recommended addons: WSBinder, Reorganizer, PartyBuffs
-- Misc Recommendations: Disable RollTracker

-- Initialization function for this job file.
function get_sets()
  mote_include_version = 2 --DO NOT MOVE TO GLOBALS. MUST BE HERE.

  -- Load and initialize the include file.
  include('Mote-Include.lua') --DO NOT MOVE TO GLOBALS. MUST BE HERE.
  include('reorganizer-lib.lua')
  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_auto_lockstyle(7)
  silibs.enable_premade_commands()
  silibs.enable_custom_roll_text()
  silibs.enable_equip_loop()
  silibs.enable_weapon_rearm()
  silibs.enable_th()
  silibs.enable_haste_info()
  silibs.enable_elemental_belt_handling(has_obi, has_orpheus)

  state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'Enspell')
  state.HybridMode:options('Normal')
  state.WeaponskillMode:options('Normal')
  state.CastingMode:options('Normal', 'Seidr', 'Resistant')
  state.IdleMode:options('Normal', 'Gyve')
  state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
  state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
  state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
  state.GainSpell = M{['description']='GainSpell', 'Gain-STR', 'Gain-INT', 'Gain-AGI', 'Gain-VIT', 'Gain-DEX', 'Gain-MND', 'Gain-CHR'}
  state.PhysicalDefenseMode:options('PDT')
  state.MagicBurst = M(false, 'Magic Burst')
  state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}
  state.NM = M(false, 'NM?')
  state.CP = M(false, 'Capacity Points Mode')
  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Savage Blade', 'Seraph Blade', 'Black Halo', 'Enspell', 'Cleaving'}
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  state.ElementalMode = M{['description'] = 'Elemental Mode', 'Fire','Ice','Wind','Earth','Lightning','Water','Light','Dark'}

  state.Buff.Composure = buffactive.Composure or false
  state.Buff.Saboteur = buffactive.Saboteur or false
  state.Buff.Stymie = buffactive.Stymie or false

  enfeebling_stat_map = {
    ['Addle'] = 'MND', ['Addle II'] = 'MND',
    ['Bind'] = 'INT',
    ['Blind'] = 'INT', ['Blind II'] = 'INT',
    ['Break'] = 'INT', ['Breakga'] = 'INT',
    ['Dia'] = 'MND', ['Dia II'] = 'MND', ['Dia III'] = 'MND', ['Diaga'] = 'MND',
    ['Dispel'] = 'INT',
    ['Distract'] = 'MND', ['Distract II'] = 'MND', ['Distract III'] = 'MND',
    ['Frazzle'] = 'MND', ['Frazzle II'] = 'MND', ['Frazzle III'] = 'MND',
    ['Gravity'] = 'INT', ['Gravity II'] = 'INT',
    ['Paralyze'] = 'MND', ['Paralyze II'] = 'MND',
    ['Poison'] = 'INT', ['Poison II'] = 'INT', ['Poisonga'] = 'INT',
    ['Sleep'] = 'INT', ['Sleep II'] = 'INT', ['Sleepga'] = 'INT', ['Sleepga II'] = 'INT',
    ['Silence'] = 'MND',
    ['Slow'] = 'MND', ['Slow II'] = 'MND',
  }
  -- Potency is based on enfeebling skill
  enfeebling_skill_spells = S{'Distract III', 'Frazzle III', 'Poison II'}
  -- 100% land rate, focus on duration gear
  enfeebling_duration_spells = S{'Dia', 'Dia II', 'Dia III', 'Diaga'}
  -- Spells that you want to always use high m.acc set
  enfeebling_default_acc_spells = S{'Bind', 'Break', 'Dispel', 'Dispelga', 'Distract', 'Distract II', 'Frazzle',
      'Frazzle II', 'Gravity', 'Gravity II', 'Silence', 'Impact'}
  -- Spells that require high/uncapped enhancing magic skill
  enhancing_skill_spells = S{'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero',
      'Enaero II', 'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}
  last_midcast_set = {} -- DO NOT MODIFY
  enfeebling_dur_gear = {
    -- Base = multiplier form of the base enhancing duration stat
    -- Aug = multiplier form of the enhancing duration stat from augments
    ['Regal Cuffs'] =           {base=0.20, aug=0.00},
    ['Duelist\'s Torque'] =     {base=0.00, aug=0.15},
    ['Duelist\'s Torque +1'] =  {base=0.00, aug=0.20},
    ['Duelist\'s Torque +2'] =  {base=0.00, aug=0.25},
    ['Snotra Earring'] =        {base=0.10, aug=0.00},
    ['Kishar Ring'] =           {base=0.10, aug=0.00},
    ['Obstinate Sash'] =        {base=0.05, aug=0.00},
  }
  empy_duration_mult = {
    [0] = 1.00,
    [1] = 1.00,
    [2] = 1.10,
    [3] = 1.20,
    [4] = 1.35,
    [5] = 1.50,
  }
  saboteur_bonus_gear = {
    ['Estoquer\'s Gantherots +1'] = {normal=2.05, nm=1.30},
    ['Estoquer\'s Gantherots +2'] = {normal=2.10, nm=1.35},
    ['Lethargy Gantherots'] =       {normal=2.11, nm=1.36},
    ['Lethargy Gantherots +1'] =    {normal=2.12, nm=1.37},
    ['Lethargy Gantherots +2'] =    {normal=2.13, nm=1.38},
    ['Lethargy Gantherots +3'] =    {normal=2.14, nm=1.39},
  }
  enf_timer_spells = S{'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II', 'Break', 'Breakga'}
  -- Spells with variable base duration
  enf_variable_duration_spells = S{'Gravity', 'Gravity II', 'Bind', 'Addle', 'Addle II'}

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

  if player.sub_job == 'SCH' then
    state.Buff['Light Arts'] = buffactive['Light Arts'] or false
    state.Buff['Dark Arts'] = buffactive['Dark Arts'] or false
    state.Buff['Addendum: White'] = buffactive['Addendum: White'] or false
    state.Buff['Addendum: Black'] = buffactive['Addendum: Black'] or false
  end

  select_default_macro_book()
  set_sub_keybinds()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
  unbind_keybinds()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Precast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Precast sets to enhance JAs
  sets.precast.JA['Chainspell'] = {
    body="Vitiation Tabard +1"
    -- body="Vitiation Tabard +3"
  }

  -- Fast cast sets for spells (cap 80% FC).
  -- RDM has 38% FC at 2000 job points
  sets.precast.FC = {
    range=empty,                      -- __ [__/__, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head="Atrophy Chapeau +2",        -- 14 [__/__,  85]
    body="Shamash Robe",              -- __ [10/__, 106]; Resist Silence+90
    hands=gear.Nyame_B_hands,         -- __ [ 7/ 7, 112]
    legs="Bunzi's Pants",             -- __ [ 9/ 9, 150]
    feet=gear.Nyame_B_feet,           -- __ [ 7/ 7, 150]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Arete Del Luna +1",         -- __ [__/__, ___]; Resist Statuses
    ear2="Etiolation Earring",        --  1 [__/ 3, ___]; Resist Silence+15
    ring1="Kishar Ring",              --  4 [__/__, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.RDM_FC_Cape,            -- 10 [10/10, ___]
    waist="Shinjutsu-no-Obi +1",      --  5 [__/__, ___]
    -- Traits/Gifts/Merits            -- 38 [__/__, ___]
    -- 79 FC [53 PDT/46 MDT, 603 M.Eva]
    
    -- head="Atrophy Chapeau +3",     -- 16 [__/__,  95]
    -- 81 FC [53 PDT/46 MDT, 613 M.Eva]
  }

  -- 10% cap on quick magic
  sets.precast.FC.QuickMagic = {
    range=empty,                      -- __ [__/__, ___]
    ammo="Impatiens",                 -- __ [__/__, ___]  2
    head="Bunzi's Hat",               -- 10 [ 7/ 7, 123]
    body="Pinga Tunic +1",            -- 15 [__/__, 128]
    hands="Lethargy Gantherots +2",   -- __ [10/10,  77]
    legs="Bunzi's Pants",             -- __ [ 9/ 9, 150]
    feet=gear.Carmine_D_feet,         --  8 [ 4/__,  80]
    neck="Loricate Torque +1",        -- __ [ 6/ 6, ___]
    ear1="Odnowa Earring +1",         -- __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          --  7 [__/__, ___]
    ring1="Lebeche Ring",             -- __ [__/__, ___]  2
    ring2="Defending Ring",           -- __ [10/10, ___]
    back="Perimede Cape",             -- __ [__/__, ___]  4
    waist="Witful Belt",              --  3 [__/__, ___]  3
    -- Traits/Gifts/Merits            -- 38 [__/__, ___]
    -- 81 FC [49 PDT/47 MDT, 558 M.Eva] 11 QM
    
    -- hands="Lethargy Gantherots +3",-- __ [11/11,  87]
    -- 81 FC [50 PDT/48 MDT, 568 M.Eva] 11 QM
  }

  sets.precast.FC.Impact = {
    range=empty,                      -- __ [__/__, ___]
    ammo="Sapience Orb",              --  2 [__/__, ___]
    head=empty,                       -- __ [__/__, ___]
    body="Crepuscular Cloak",         -- __ [__/__, 231]
    hands="Lethargy Gantherots +2",   -- __ [10/10,  77]
    legs="Bunzi's Pants",             -- __ [ 9/ 9, 150]
    feet=gear.Carmine_D_feet,         --  8 [ 4/__,  80]
    neck="Orunmila's Torque",         --  5 [__/__, ___]
    ear1="Malignance Earring",        --  4 [__/__, ___]
    ear2="Lethargy Earring",          --  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __ [10/10, ___]
    back=gear.RDM_FC_Cape,            -- 10 [10/10, ___]
    waist="Shinjutsu-no-Obi +1",      --  5 [__/__, ___]
    -- Traits/Gifts/Merits            -- 38 [__/__, ___]
    -- 79 FC [50 PDT/38 MDT, 538 M.Eva]
    
    -- hands="Lethargy Gantherots +3",-- __ [11/11,  87]
    -- 79 FC [51 PDT/39 MDT, 548 M.Eva]
  }

  sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",
    sub={name="Ammurapi Shield", priority=1},
  })


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    range=empty,                      -- __, __, __, __, __ <__, __, __> (__, __) [__/__, ___]
    ammo="Oshasha's Treatise",        -- __,  5,  5,  3, __ <__, __, __> (__, __) [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 50, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 40, 65, 13, __ < 7, __, __> (__, __) [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 40, 65, 12, __ < 6, __, __> (__, __) [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 53, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 150]
    -- neck="Fotia Gorget",           -- __, 10, __, __, __ <__, __, __> (__, __) [__/__, ___]; ftp+0.1
    ear1="Ishvara Earring",           -- __, __, __,  2, __ <__, __, __> (__, __) [__/__, ___]
    ear2="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> (__, __) [__/__, ___]; TP Bonus+250
    ring1="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> (__, __) [__/__, ___]
    ring2="Epaminondas's Ring",       -- __, __, __,  5, __ <__, __, __> (__, __) [__/__, ___]
    back=gear.RDM_WSD_Cape,           -- __, 20, __, 10, __ <__, __, __> (__, __) [10/__, ___]
    -- waist="Fotia Belt",            -- __, 10, __, __, __ <__, __, __> (__, __) [__/__, ___]; ftp+0.1
    -- 179 STR, 292 Acc, 350 Att, 78 WSD, 0 PDL <28 DA, 0 TA, 0 QA> (0 Crit Rate, 0 Crit Dmg) [48 PDT/38 MDT, 674 M.Eva]
  }

  -- 80% DEX. 3 hit. Can crit. Transfers fTP.
  sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
    range=empty,                      -- __, __, __, __, __ <__, __, __> (__, __) [___/___, ___]
    -- ammo="Yetshila +1",            -- __, __, __, __, __ <__, __, __> ( 2,  6) [___/___, ___]
    -- head="Blistering Sallet +1",   -- 41, 53, __, __, __ < 3, __, __> (10, __) [  3/___,  53]
    body=gear.Nyame_B_body,           -- 24, 40, 65, 13, __ < 7, __, __> (__, __) [  9/  9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> (__, __) [  7/  7, 112]
    legs=gear.Nyame_B_legs,           -- __, 40, 65, 12, __ < 6, __, __> (__, __) [  8/  8, 150]
    -- feet="Thereoid Greaves",       -- 28, __, 25, __, __ <__, __, __> ( 4,  5) [___/___,  69]
    -- neck="Fotia Gorget",           -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    -- ear1="Mache Earring +1",       --  8, 10, __, __, __ < 2, __, __> (__, __) [___/___, ___]
    ear2="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> (__, __) [___/___, ___]; TP Bonus+250
    -- ring1="Begrudging Ring",       -- __,  7,  7, __, __ <__, __, __> ( 5, __) [-10/-10, ___]
    ring2="Ephramad's Ring",          -- 10, 20, 20, __, 10 <__, __, __> (__, __) [___/___, ___]
    -- back=gear.RDM_Crit_Cape,       -- 30, 20, __, __, __ <__, __, __> (10, __) [ 10/___, ___]
    -- waist="Fotia Belt",            -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    -- 158 DEX, 254 Acc, 247 Att, 36 WSD, 10 PDL <23 DA, 0 TA, 0 QA> (31 Crit Rate, 11 Crit Dmg) [27 PDT/14 MDT, 523 M.Eva]
  })
  sets.precast.WS['Chant du Cygne'].MaxTP = set_combine(sets.precast.WS['Chant du Cygne'], {
    ear2="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> (__, __) [___/___, ___]
  })

  -- 60% STR. 4 hit. Can crit. Transfers fTP.
  sets.precast.WS['Vorpal Blade'] = {
    range=empty,                      -- __, __, __, __, __ <__, __, __> (__, __) [___/___, ___]
    -- ammo="Yetshila +1",            -- __, __, __, __, __ <__, __, __> ( 2,  6) [___/___, ___]
    -- head="Blistering Sallet +1",   -- 41, 53, __, __, __ < 3, __, __> (10, __) [  3/___,  53]
    body=gear.Nyame_B_body,           -- 45, 40, 65, 13, __ < 7, __, __> (__, __) [  9/  9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 65, 11, __ < 5, __, __> (__, __) [  7/  7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 40, 65, 12, __ < 6, __, __> (__, __) [  8/  8, 150]
    -- feet="Thereoid Greaves",       -- 13, __, 25, __, __ <__, __, __> ( 4,  5) [___/___,  69]
    -- neck="Fotia Gorget",           -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    ear1="Sherida Earring",           --  5, __, __, __, __ < 5, __, __> (__, __) [___/___, ___]
    ear2="Moonshade Earring",         -- __,  4, __, __, __ <__, __, __> (__, __) [___/___, ___]; TP Bonus+250
    -- ring1="Begrudging Ring",       -- __,  7,  7, __, __ <__, __, __> ( 5, __) [-10/-10, ___]
    ring2="Sroda Ring",               -- 15, __, __, __, __ <__, __, __> (__, __) [___/___, ___]
    -- back=gear.RDM_Crit_Cape,       -- __, 20, __, __, __ <__, __, __> (10, __) [ 10/___, ___]
    -- waist="Fotia Belt",            -- __, 10, __, __, __ <__, __, __> (__, __) [___/___, ___]; ftp+0.1
    -- 194 STR, 224 Acc, 227 Att, 36 WSD, 0 PDL <26 DA, 0 TA, 0 QA> (31 Crit Rate, 11 Crit Dmg) [27 PDT/14 MDT, 523 M.Eva]

    -- ear2="Lethargy Earring +2",    -- 15, __, __, __, __ < 8, __, __> (__, __) [___/___, ___]
    -- back=gear.RDM_STR_Crit_Cape,   -- 30, 20, __, __, __ <__, __, __> (10, __) [ 10/___, ___]
  }
  sets.precast.WS['Vorpal Blade'].MaxTP = set_combine(sets.precast.WS['Vorpal Blade'], {
    ear2="Odnowa Earring +1",         --  3, 10, __, __, __ <__, __, __> (__, __) [  3/  5, ___]
  })

  -- 50% STR/50% MND. 2 hit. Scales well with WSD, not multihit.
  sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    range=empty,                      -- __, __, __, __, __, __ <__, __, __> (__, __) [__/__, ___]
    ammo="Oshasha's Treatise",        -- __, __,  5,  5,  3, __ <__, __, __> (__, __) [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 26, 50, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 123]
    body=gear.Nyame_B_body,           -- 45, 37, 40, 65, 13, __ < 7, __, __> (__, __) [ 9/ 9, 139]
    hands=gear.Nyame_B_hands,         -- 17, 40, 40, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- 58, 32, 40, 65, 12, __ < 6, __, __> (__, __) [ 8/ 8, 150]
    feet=gear.Nyame_B_feet,           -- 23, 26, 53, 65, 11, __ < 5, __, __> (__, __) [ 7/ 7, 150]
    -- neck="Duelist's Torque +2",    -- __, 15, __, __, __, __ <__, __, __> (__, __) [__/__, ___]
    ear1="Ishvara Earring",           -- __, __, __, __,  2, __ <__, __, __> (__, __) [__/__, ___]
    ear2="Moonshade Earring",         -- __, __,  4, __, __, __ <__, __, __> (__, __) [__/__, ___]; TP Bonus+250
    ring1="Ephramad's Ring",          -- 10, __, 20, 20, __, 10 <__, __, __> (__, __) [__/__, ___]
    ring2="Epaminondas's Ring",       -- __, __, __, __,  5, __ <__, __, __> (__, __) [__/__, ___]
    back=gear.RDM_WSD_Cape,           -- __, 30, 20, __, 10, __ <__, __, __> (__, __) [10/__, ___]
    waist="Sailfi Belt +1",           -- 15, __, __, 15, __, __ < 5,  2, __> (__, __) [__/__, ___]
    -- 194 STR, 206 MND, 272 Acc, 365 Att, 78 WSD, 10 PDL <33 DA, 2 TA, 0 QA> [48 PDT/38 MDT, 674 M.Eva]
  })
  sets.precast.WS['Savage Blade'].MaxTP = set_combine(sets.precast.WS['Savage Blade'], {
    ear2="Sherida Earring",           --  5, __, __, __, __, __ < 5, __, __> (__, __) [___/___, ___]
  })
  
  -- 70% MND/ 30% STR. 2 hit.
  sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {})
  sets.precast.WS['Black Halo'].MaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP,{})

  -- 50% MND / 30% STR. 3 hit.
  sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS['Savage Blade'],{})
  sets.precast.WS['Death Blossom'].MaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP,{})

  -- 85% MND. 5 hit.
  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Savage Blade'],{})
  sets.precast.WS['Requiescat'].MaxTP = set_combine(sets.precast.WS['Savage Blade'].MaxTP,{})

  -- 50% MND/30% STR. Dark elemental. dStat=INT. Focus on M.Dmg, WSC (stat) where 1M.Dmg==2MND==5STR
  sets.precast.WS['Sanguine Blade'] = {
    range=empty,                      -- __, __, __, __, __, __, __ [__/__, ___]
    ammo="Ghastly Tathlum +1",        -- __, __, 11, __, __, __, 21 [__/__, ___]
    head="Pixie Hairpin +1",          -- __, __, 27, __, __, __, __ [__/__, ___]; Dark MAB+28
    body="Lethargy Sayon +3",         -- 34, 45, 47, 64, __, 54, 34 [14/14, 136]
    hands="Lethargy Gantherots +2",   -- 11, 45, 28, 52, __, 47, 22 [10/10,  77]
    legs="Bunzi's Pants",             -- 25, 38, 51, 55, __, 30, 60 [ 9/ 9, 150]
    feet="Lethargy Houseaux +2",      -- 17, 27, 25, 50,  8, 45, 20 [__/__, 147]
    neck="Sibyl Scarf",               -- __, __, 10, __, __, 10, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  8,  8, 10, __,  8, __ [__/__, ___]
    ear2="Regal Earring",             -- __, 10, 10, __, __,  7, __ [__/__, ___]
    ring1="Archon Ring",              -- __, __, __,  5, __, __, __ [__/__, ___]; Dark MAB+5
    ring2="Freke Ring",               -- __, __, 10, __, __,  8, __ [__/__, ___]
    back=gear.RDM_MAB_Cape,           -- __, __, 30, 20, __, 10, 20 [10/__, ___]
    waist="Refoccilation Stone",      -- __, __, __,  4, __, 10, __ [__/__, ___]
    -- 87 STR, 173 MND, 257 INT, 260 M.Acc, 8 WSD, 229 MAB, 177 M.Dmg [43 PDT/33 MDT, 510 M.Eva]

    -- hands="Lethargy Gantherots +3",-- 16, 50, 33, 62, __, 52, 32 [11/11,  87]
    -- feet="Lethargy Houseaux +3",   -- 22, 32, 30, 60, 12, 50, 30 [__/__, 157]
    -- 97 STR, 183 MND, 267 INT, 280 M.Acc, 12 WSD, 239 MAB, 197 M.Dmg [44 PDT/34 MDT, 530 M.Eva]
  }

  --Seraph blade is commonly used on single targets with Frazzle III landed.
  --Because this WS is a low base dmg, it's dmg profile is closer to low tier magic dmg spells
  -- Base Magical WS Damage = floor(((152 + floor((WeaponLevel - 99) × 2.45) + WSC) × fTP) + dSTAT + MDMG Stat)
  -- Total Dmg = Base Magical WS Damage × (MAB / MDB) × WSD × WSD Boost JT × Weather+Day Bonus × Affinity × Weapon Skill Potency Bonus
  --      × Augmented Weapon Skill Potency Bonus × Staff × Potency Multipliers × Resist × Resistance Rank Reduction × TMDA
  --Priority: ftp >> MD == 0.4*(STR+MND) > MAB > WSD > Ele Aff.
  -- 40% STR/40% MND. Light elemental. No dSTAT. 
  sets.precast.WS['Seraph Blade'] = {
    range=empty,                      -- __, __, __, __, __, __ [__/__, ___]
    ammo="Ghastly Tathlum +1",        -- __, __, __, __, __, 21 [__/__, ___]
    head=gear.Nyame_B_head,           -- 26, 26, 40, 11, 30, __ [ 7/ 7, 123]
    body="Lethargy Sayon +3",         -- 34, 45, 64, __, 54, 34 [14/14, 136]
    hands="Lethargy Gantherots +2",   -- 11, 45, 52, __, 47, 22 [10/10,  77]
    legs="Bunzi's Pants",             -- 25, 38, 55, __, 30, 60 [ 9/ 9, 150]
    feet="Lethargy Houseaux +2",      -- 17, 27, 50,  8, 45, 20 [__/__, 147]
    neck="Baetyl Pendant",            -- __, __, __, __, 13, __ [__/__, ___]
    ear1="Regal Earring",             -- __, 10, __, __,  7, __ [__/__, ___]
    ear2="Moonshade earring",         -- __, __, __, __, __, __ [__/__, ___]; TP Bonus +250
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __, __ [__/__, ___]
    ring2="Freke Ring",               -- __, __, __, __,  8, __ [__/__, ___]
    back=gear.RDM_WSD_Cape,           -- __, 30, __, 10, __, __ [10/__, ___]
    waist="Skrymir Cord",             -- __, __,  5, __,  5, 30 [__/__, ___]
    -- 113 STR, 221 MND, 266 M.Acc, 34 WSD, 239 MAB, 187 M.Dmg [50 PDT/40 MDT, 633 M.Eva]
    
    -- hands="Lethargy Gantherots +3",-- 16, 50, 62, __, 52, 32 [11/11,  87]
    -- feet="Lethargy Houseaux +3",   -- 22, 32, 60, 12, 50, 30 [__/__, 157]
    -- waist="Skrymir Cord +1",       -- __, __,  7, __,  7, 35 [__/__, ___]
    -- 123 STR, 231 MND, 288 M.Acc, 38 WSD, 251 MAB, 212 M.Dmg [51 PDT/41 MDT, 653 M.Eva]
  }
  sets.precast.WS['Seraph Blade'].MaxTP = set_combine(sets.precast.WS['Seraph Blade'], {
    ear2="Malignance Earring",        -- __,  8, 10, __,  8, __ [__/__, ___]
  })

  --Because this WS is a low base dmg, it's dmg profile is closer to low tier magic dmg spells
  --Priority: ftp >> MD == 0.4*(DEX/INT) > MAB > WSD > Ele Aff.
  -- 40% DEX/40% INT. Wind elemental. dStat=INT.
  sets.precast.WS['Aeolian Edge'] = {
    range=empty,                      -- __, __, __, __, __, __ [__/__, ___]
    ammo="Ghastly Tathlum +1",        -- __, 11, __, __, __, 21 [__/__, ___]
    head="Lethargy Chappel +2",       -- 24, 33, 51, __, 51, 21 [ 9/ 9, 115]
    body="Lethargy Sayon +3",         -- 34, 47, 64, __, 54, 34 [14/14, 136]
    hands="Lethargy Gantherots +2",   -- 38, 28, 52, __, 47, 22 [10/10,  77]
    legs="Bunzi's Pants",             -- __, 51, 55, __, 30, 60 [ 9/ 9, 150]
    feet="Lethargy Houseaux +2",      -- 25, 25, 50,  8, 45, 20 [__/__, 147]
    neck="Sibyl Scarf",               -- __, 10, __, __, 10, __ [__/__, ___]
    ear1="Malignance Earring",        -- __,  8, 10, __,  8, __ [__/__, ___]
    ear2="Moonshade earring",         -- __, __, __, __, __, __ [__/__, ___]; TP Bonus +250
    ring1="Epaminondas's Ring",       -- __, __, __,  5, __, __ [__/__, ___]
    ring2="Freke Ring",               -- __, 10, __, __,  8, __ [__/__, ___]
    back=gear.RDM_MAB_Cape,           -- __, 30, 20, __, 10, 20 [10/__, ___]
    waist="Skrymir Cord",             -- __, __,  5, __,  5, 30 [__/__, ___]
    -- 121 DEX, 253 INT, 307 M.Acc, 13 WSD, 268 MAB, 228 M.Dmg [52 PDT/42 MDT, 625 M.Eva]

    -- head="Lethargy Chappel +3",    -- 29, 38, 61, __, 56, 31 [10/10, 125]
    -- hands="Lethargy Gantherots +3",-- 43, 33, 62, __, 52, 32 [11/11,  87]
    -- feet="Lethargy Houseaux +3",   -- 30, 30, 60, 12, 50, 30 [__/__, 157]
    -- waist="Skrymir Cord +1",       -- __, __,  7, __,  7, 35 [__/__, ___]
    -- 136 DEX, 268 INT, 339 M.Acc, 17 WSD, 285 MAB, 263 M.Dmg [54 PDT/44 MDT, 655 M.Eva]
  }
  sets.precast.WS['Aeolian Edge'].MaxTP = set_combine(sets.precast.WS['Aeolian Edge'], {
    ear2="Regal Earring",             -- __, 10, __, __,  7, __ [__/__, ___]
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.FastRecast = set_combine(sets.precast.FC,{})
  sets.midcast.Trust = set_combine(sets.precast.FC,{})

  -- Prioritize: CPII > CP > Heal Skill, MND, VIT (to power cap) > SIRD > -DT > Enmity (to -40)
  -- Cap at 700 power; Power = floor(MND÷2) + floor(VIT÷4) + Healing Magic Skill
  -- Mithra RDM/WHM M30 MND = 134
  -- Mithra RDM/WHM M30 VIT = 123
  -- Mithra RDM/WHM M30 Healing Magic Skill = 414
  sets.midcast.CureNormal = {
    main="Eremite's Wand +1",         -- __, __, ___,   2, ___, 25, __/__, __
    sub="Genmei Shield",              -- __, __, ___, ___, ___, __, 10/__, __
    range=empty,                      -- __, __, ___, ___, ___, __, __/__, __
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body=gear.Kaykaus_C_body,         --  4, __, ___,  33,  20, 12, __/__, __
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +1",         -- __, 10,  13,  29,  12, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Meili Earring",             -- __, __,  10, ___, ___, __, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Sanctuary Obi +1",         -- __, __, ___, ___, ___, 10, __/__,  4
    -- Kaykaus set bonus              --  6, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 10 CPII, 53 CP, 468 Heal Skill, 299 MND, 202 VIT, 116 SIRD, 42PDT/27MDT, 15 -Enmity
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 10 CPII, 55 CP, 472 Heal Skill, 309 MND, 212 VIT, 116 SIRD, 42PDT/27MDT, 15 -Enmity
    -- 679 Power
  }
  sets.midcast.CureNormalWeaponLock = {
    range=empty,                      -- __, __, ___, ___, ___, __, __/__, __
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +1",         -- __, 10,  13,  29,  12, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Meili Earring",             -- __, __,  10, ___, ___, __, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Sanctuary Obi +1",         -- __, __, ___, ___, ___, 10, __/__,  4
    -- Kaykaus set bonus              --  4, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 4 CPII, 53 CP, 468 Heal Skill, 303 MND, 213 VIT, 104 SIRD, 37PDT/32MDT, 28 -Enmity
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 4 CPII, 55 CP, 472 Heal Skill, 313 MND, 223 VIT, 104 SIRD, 37PDT/32MDT, 28 -Enmity
    -- 683 Power
  }
  
  sets.midcast.CureWeather = {
    main="Chatoyant Staff",           -- __, 10, ___,   5,   5, __, __/__, __
    sub="Mensch Strap +1",            -- __, __, ___, ___, ___, __,  5/__, __
    range=empty,                      -- __, __, ___, ___, ___, __, __/__, __
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +1",         -- __, 10,  13,  29,  12, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Magnetic Earring",          -- __, __, ___, ___, ___,  8, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Hachirin-no-Obi",          -- __, __, ___, ___, ___, __, __/__, __; Weather bonus
    -- Kaykaus set bonus              --  4, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 4 CPII, 63 CP, 458 Heal Skill, 308 MND, 218 VIT, 102 SIRD, 42PDT/32MDT, 24 -Enmity
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 4 CPII, 65 CP, 462 Heal Skill, 318 MND, 228 VIT, 102 SIRD, 42PDT/32MDT, 24 -Enmity
    -- 673 Power
  }
  sets.midcast.CureWeatherWeaponLock = {
    range=empty,                      -- __, __, ___, ___, ___, __, __/__, __
    ammo="Staunch Tathlum +1",        -- __, __, ___, ___, ___, 11,  3/ 3, __
    head=gear.Kaykaus_C_head,         -- __, 11,  16,  19,  14, 12, __/ 3, __
    body="Rosette Jaseran +1",        -- __, __, ___,  39,  31, 25,  5/ 5, 13
    hands=gear.Chironic_SIRD_hands,   -- __, __, ___,  38,  20, 31, __/__, __; Can add more DT or Enmity
    legs="Atrophy Tights +1",         -- __, 10,  13,  29,  12, __, __/__, __
    feet=gear.Kaykaus_D_feet,         -- __, 17, ___,  19,  10, __, __/__,  6
    neck="Loricate Torque +1",        -- __, __, ___, ___, ___,  5,  6/ 6, __
    ear1="Magnetic Earring",          -- __, __, ___, ___, ___,  8, __/__, __
    ear2="Odnowa Earring +1",         -- __, __, ___, ___,   3, __,  3/ 5, __
    ring1="Menelaus's Ring",          -- __,  5,  15, ___, ___, __, __/__, __
    ring2="Defending Ring",           -- __, __, ___, ___, ___, __, 10/10, __
    back=gear.RDM_Cure_Cape,          -- __, 10, ___,  30, ___, __, 10/__, __
    waist="Hachirin-no-Obi",          -- __, __, ___, ___, ___, __, __/__, __; Weather bonus
    -- Kaykaus set bonus              --  4, __, ___, ___, ___, __, __/__, __
    -- Base Stats                     -- __, __, 414, 129, 123, __, __/__, __
    -- Merit points                   -- __, __, ___, ___, ___, 10, __/__,  5
    -- 4 CPII, 53 CP, 458 Heal Skill, 303 MND, 213 VIT, 102 SIRD, 37PDT/32MDT, 24 -Enmity
    
    -- legs="Atrophy Tights +3",      -- __, 12,  17,  39,  22, __, __/__, __
    -- 4 CPII, 55 CP, 462 Heal Skill, 313 MND, 223 VIT, 102 SIRD, 37PDT/32MDT, 24 -Enmity
    -- 673 Power
  }

  -- Removal rate = Base Rate * (1+(y/100))
  -- Base rate = (10+(Healing Skill / 30)); y = Cursna+ stat from gear
  -- Mithra RDM M30 Healing Magic Skill = 414
  sets.midcast.Cursna = {
    main="Prelatic Pole",         -- 10, __, __
    sub="Curatio Grip",           --  3, __, __
    range=empty,                  -- __, __, __
    ammo="Incantor Stone",        -- __, __,  2
    head=gear.Vanya_B_head,       -- 20, __, __
    body=gear.Vanya_B_body,       -- 20, __, __
    hands="Hieros Mittens",       -- __, 10, __
    legs=gear.Vanya_B_legs,       -- 20, __, __
    feet=gear.Vanya_B_feet,       -- 40,  5, __
    neck="Debilis Medallion",     -- __, 15, __
    ear1="Malignance Earring",    -- __, __,  4
    ear2="Meili Earring",         -- 10, __, __
    ring1="Haoma's Ring",         --  8, 15, __
    ring2="Menelaus's Ring",      -- 15, 20,-10
    back="Oretania's Cape +1",    -- __,  5, __
    waist="Embla Sash",           -- __, __,  5
    -- Base stats                   414, __, __
    -- 560 Healing skill, 70 Cursna+, 1 FC; Cursna Rate = 48.73%

    -- body="Vitiation Tabard +3",-- 23, __, 15
    -- 563 Healing skill, 70 Cursna+, 16 FC; Cursna Rate = 48.90%
  }

  -- Blink used as defensive while in combat. Focus on DT, MEVA, and Duration.
  sets.midcast.Blink = {
    range=empty,                      -- __, __, __ [__/__, ___]
    ammo="Staunch tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- __, __, 10 [ 7/ 7, 123]
    -- body="Vitiation Tabard +3",    -- 15, __, 15 [__/__, 100]
    hands=gear.Nyame_B_hands,         -- __, __, __ [ 7/ 7, 112]
    legs="Bunzi's Pants",             -- __, __, __ [ 9/ 9, 150]
    feet="Lethargy Houseaux +2",      -- 35, __, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- 25, __, __ [__/__, ___]
    ear1="Malignance Earring",        -- __, __,  4 [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,       -- __, 20, __ [__/__, ___]
    waist="Flume Belt +1",            -- __, __, __ [ 4/__, ___]
    -- Traits/Gifts/Merits            -- __, __, 38 [__/__, ___]
    -- 75 Enh. Duration, 20 Aug Enh Duration, 67 FC [50 PDT/40 MDT, 632 M.Eva]
    
    -- feet="Lethargy Houseaux +3",   -- 40, __, __ [__/__, 157]
    -- 80 Enh. Duration, 20 Aug Enh Duration, 67 FC [50 PDT/40 MDT, 642 M.Eva]
  }

  sets.midcast.EnhancingDuration = {
    main=gear.Colada_ENH,             -- __,  4, __,  4 [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __, __ [__/__, ___]
    range=empty,                      -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __, 10, __, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __, __ [__/__,  80]
    hands="Atrophy Gloves +3",        -- __, 20, __, __ [__/__,  57]
    legs=gear.Telchine_ENH_legs,      -- __, 10, __, __ [__/__, 128]
    feet="Lethargy Houseaux +2",      -- 30, 35, __, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- __, 25, __, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7, __,  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,       --  9, __, 20, __ [__/__, ___]
    waist="Embla Sash",               -- __, 10, __,  5 [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, __, 38 [__/__, ___]
    -- 507 Enh skill, 141 Enh duration, 20 Aug Enh Duration, 54 FC [23 PDT/17 MDT, 487 M.Eva]
    
    -- body="Vitiation Tabard +3",    -- 23, 15, __, 15 [__/__, 100]
    -- feet="Lethargy Houseaux +3",   -- 35, 40, __, __ [__/__, 157]
    -- back=gear.RDM_Adoulin_Cape,    -- 10, __, 20, __ [__/__, ___]
    -- 524 Enh skill, 151 Enh duration, 20 Aug Enh Duration, 69 FC [23 PDT/17 MDT, 517 M.Eva]
  }

  sets.midcast.SkillEnhancing = {
    main="Pukulatmuj +1",             -- 11, __, __, __ [__/__, ___]
    sub="Forfend +1",                 -- 10, __, __, __ [ 4/__, ___]
    range=empty,                      -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, __ [ 3/ 3, ___]
    head="Befouled Crown",            -- 16, __, __, __ [__/__,  75]
    body=gear.Telchine_ENH_body,      -- 12, 10, __, __ [__/__,  80]
    hands="Vitiation Gloves +1",      -- 20, __, __, __ [__/__,  37]
    legs="Atrophy Tights +1",         -- 17, __, __, __ [__/__, 107]
    feet="Lethargy Houseaux +2",      -- 30, 35, __, __ [__/__, 147]
    neck="Incanter's Torque",         -- 10, __, __, __ [__/__, ___]
    ear1="Mimir Earring",             -- 10, __, __, __ [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,       --  9, __, 20, __ [__/__, ___]
    waist="Olympus Sash",             --  5, __, __, __ [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, __, 38 [__/__, ___]
    -- 606 Enh skill, 45 Enh duration, 20 Aug Enh Duration, 38 FC [27 PDT/17 MDT, 446 M.Eva]
    
    -- body="Vitiation Tabard +3",    -- 23, 15, __, 15 [__/__, 100]
    -- hands="Vitiation Gloves +3",   -- 24, __, __, __ [__/__,  57]
    -- legs="Atrophy Tights +3",      -- 21, __, __, __ [__/__, 127]
    -- feet="Lethargy Houseaux +3",   -- 35, 40, __, __ [__/__, 157]
    -- back=gear.RDM_Adoulin_Cape,    -- 10, __, 20, __ [__/__, ___]
    -- 631 Enh skill, 55 Enh duration, 20 Aug Enh Duration, 53 FC [27 PDT/17 MDT, 516 M.Eva]
  }

  -- Regen not affected by Enh Magic Skill
  -- Regen % pieces apply to base value (no LA bonus), floored, then +1.
  -- floor[(Base Regen) + sum(floor(Base Regen x %Regen bonuses)+1) x Embolden)] + LA bonus + Regen Potency from Armor + Morgelai and Musa bonus.
  -- Regen II base potency = 12 hp/tick
  sets.midcast.Regen = {
    main="Bolelabunga",               --  1, __, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __ [__/__, ___]
    range=empty,                      -- __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ [ 3/ 3, ___]
    head=gear.Telchine_ENH_head,      -- __,  9, __ [__/__,  75]
    body=gear.Telchine_Regen_body,    --  3, __, 10 [__/__,  80]
    hands=gear.Telchine_ENH_hands,    -- __, 10, __ [__/__,  61]
    legs=gear.Telchine_Regen_legs,    --  3, __, __ [__/__, 107]
    feet=gear.Telchine_ENH_feet,      -- __, 10, __ [__/__, 107]
    neck="Duelist's Torque +2",       -- __, 25, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7, __ [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __ [10/10, ___]
    back=gear.RDM_ENH_Cape,           -- __, 20, __ [10/__, ___]
    waist="Embla Sash",               -- __, 10,  5 [__/__, ___]
    -- Regen II Base Potency             12, __, __ [__/__, ___]
    -- 19 Regen Potency, 101 Enh Duration %, 15 Regen Duration [33 PDT/17 MDT, 430 M.Eva]

    -- head=gear.Telchine_Regen_head, --  3, __, __ [__/__,  75]
    -- hands=gear.Telchine_Regen_hands,-- 3, __, __ [__/__,  37]
    -- feet="Bunzi's Sabots",         -- 10, __, __ [ 6/ 6, 150]; R28
    -- 35 Regen Potency, 72 Enh Duration %, 15 Regen Duration [39 PDT/23 MDT, 449 M.Eva]
  }

  sets.midcast.RefreshOthers = {
    main=gear.Colada_ENH,             -- __,  4, __, __ [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __, __ [__/__, ___]
    range=empty,                      -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, __ [ 3/ 3, ___]
    head="Amalric Coif +1",           --  2, __, __, __ [__/__,  86]
    body="Atrophy Tabard +2",         --  1, __, __, __ [__/__,  90]
    hands="Atrophy Gloves +3",        -- __, 20, __, __ [__/__,  57]
    legs="Lethargy Fuseau +2",        --  4, __, __, __ [__/__, 162]
    feet="Lethargy Houseaux +2",      -- __, 35, __, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- __, 25, __, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7, __, __ [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,       -- __, __, 20, __ [__/__, ___]
    waist="Embla Sash",               -- __, 10, __, __ [__/__, ___]
    -- Refresh III potency            --  9, __, __, __ [__/__, ___]
    -- 16 Ref Potency, 111 Enh Duration%, 20 Aug Enh Duration, 0 Ref Duration [23 PDT/17 MDT, 542 M.Eva]
    
    -- body="Atrophy Tabard +3",      --  2, __, __, __ [__/__, 100]
    -- legs="Lethargy Fuseau +3",     --  4, __, __, __ [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- __, 40, __, __ [__/__, 157]
    -- 17 Ref Potency, 116 Enh Duration%, 20 Aug Enh Duration, 0 Ref Duration [23 PDT/17 MDT, 562 M.Eva]
  }
  sets.midcast.RefreshSelf = set_combine(sets.midcast.RefreshOthers, {
    waist="Gishdubar Sash",           -- __, __, __, 20 [__/__, ___]
    -- 17 Ref Potency, 106 Enh Duration%, 20 Aug Enh Duration, 20 Ref Duration [23 PDT/17 MDT, 562 M.Eva]
  })
  -- Empy set effect adds enh duration under Composure only on non-self targets
  sets.midcast.RefreshOthersComp = set_combine(sets.midcast.RefreshOthers, {})

  -- Stoneskin caps at a really low skill cap. At 99, you're capped with zero skill gear.
  -- Stoneskin caps at 350. +Stoneskin gear has no limit. Current max is 475
  -- Focus on DT, M.Eva, and FC for survivability while in combat
  sets.midcast.Stoneskin = {
    main=gear.Colada_ENH,             -- __,  4, __,  4 [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __, __ [__/__, ___]
    range=empty,                      -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, __ [ 3/ 3, ___]
    head="Bunzi's Hat",               -- __, __, __, 10 [ 7/ 7, 123]
    body="Lethargy Sayon +3",         -- __, __, __, __ [14/14, 136]
    hands=gear.Nyame_B_hands,         -- __, __, __, __ [ 7/ 7, 112]
    legs=gear.Nyame_B_legs,           -- __, __, __, __ [ 8/ 8, 150]
    feet="Lethargy Houseaux +2",      -- __, 35, __, __ [__/__, 147]
    neck="Nodens Gorget",             -- 30, __, __, __ [__/__, ___]
    ear1="Earthcry Earring",          -- 10, __, __, __ [__/__, ___]
    ear2="Lethargy Earring",          -- __,  7, __,  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,       -- __, __, 20, __ [__/__, ___]
    waist="Siegel Sash",              -- 20, __, __, __ [__/__, ___]
    -- Traits/Gifts/Merits            --350, __, __, 38 [__/__, ___]
    -- 410 Stoneskin+, 56 Enh Duration%, 20 Aug Enh Duration, 59 FC [56 PDT/48 MDT, 668 M.Eva]
    
    -- hands="Stone Mufflers",        -- 30, __, __, __ [__/__, ___]
    -- legs="Shedir Seraweels",       -- 35, __, __, __ [__/__, ___]
    -- feet="Lethargy Houseaux +3",   -- __, 40, __, __ [__/__, 157]
    -- 475 Stoneskin+, 61 Enh Duration%, 20 Aug Enh Duration, 59 FC [41 PDT/33 MDT, 416 M.Eva]
  }

  -- Skill caps at 500 Enhancing Magic skill for a total of Phalanx+35.
  sets.midcast.PhalanxSelf = {
    -- main="Sakpata's Sword",            --  5, __, __, __ [10/10, ___]
    sub="Ammurapi Shield",                -- __, __, __, 10 [__/__, ___]
    range=empty,                          -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",            -- __, __, __, __ [ 3/ 3, ___]
    head=gear.Merl_Phalanx_head,          --  5, __, __, __ [__/__,  86]
    body=gear.Merl_Phalanx_body,          --  3, __, __, __ [ 2/__,  91]
    hands="Atrophy Gloves +3",            -- __, __, __, 20 [__/__,  57]
    legs=gear.Telchine_ENH_legs,          -- __, __, __, 10 [__/__, 128]
    feet=gear.Merl_Phalanx_feet,          --  4, __, __, __ [__/__, 118]
    neck="Incanter's Torque",             -- __, 10, __, __ [__/__, ___]
    ear1="Mimir Earring",                 -- __, 10, __, __ [__/__, ___]
    ear2="Odnowa Earring +1",             -- __, __, __, __ [ 3/ 5, ___]
    ring1="Gelatinous Ring +1",           -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",               -- __, __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,           -- __, __, 19, __ [__/__, ___]
    waist="Olympus Sash",                 -- __,  5, __, __ [__/__, ___]
    -- Traits/Gifts/Merits                -- __,456, __, __ [__/__, ___]
    -- Master Levels                      -- __, __, __, __ [__/__, ___]
    -- 17 Phalanx+, 481 Enh Skill, 19 Aug Enh Duration, 40 Enh duration [35 PDT/27 MDT, 480 M.Eva]
    -- 51 Phalanx total
    
    -- main="Sakpata's Sword",            --  5, __, __, __ [10/10, ___]
    -- sub="Ammurapi Shield",             -- __, __, __, 10 [__/__, ___]
    -- range=empty,                       -- __, __, __, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",         -- __, __, __, __ [ 3/ 3, ___]
    -- head=gear.Merl_Phalanx_head,       --  5, __, __, __ [__/__,  86]
    -- body=gear.Merl_Phalanx_body,       --  5, __, __, __ [ 2/__,  91]
    -- hands=gear.Chironic_Phalanx_hands, --  5, 15, __, __ [__/__,  48]
    -- legs=gear.Merl_Phalanx_legs,       --  5, __, __, __ [__/__, 118]
    -- feet=gear.Chironic_Phalanx_feet,   --  5, __, __, __ [ 2/__, 118]
    -- neck="Incanter's Torque",          -- __, 10, __, __ [__/__, ___]
    -- ear1="Mimir Earring",              -- __, 10, __, __ [__/__, ___]
    -- ear2="Odnowa Earring +1",          -- __, __, __, __ [ 3/ 5, ___]
    -- ring1="Gelatinous Ring +1",        -- __, __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",            -- __, __, __, __ [10/10, ___]
    -- back=gear.RDM_Adoulin_Cape,        -- __, __, 20, __ [__/__, ___]
    -- waist="Olympus Sash",              -- __,  5, __, __ [__/__, ___]
    -- Traits/Gifts/Merits                -- __,456, __, __ [__/__, ___]
    -- Master Levels                      -- __,  4, __, __ [__/__, ___]
    -- 30 Phalanx+, 500 Enh Skill, 20 Aug Enh Duration, 10 Enh duration [37 PDT/27 MDT, 461 M.Eva]
    -- 65 Phalanx total
    
    -- main="Sakpata's Sword",            --  5, __, __, __ [10/10, ___]
    -- sub="Ammurapi Shield",             -- __, __, __, 10 [__/__, ___]
    -- range=empty,                       -- __, __, __, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",         -- __, __, __, __ [ 3/ 3, ___]
    -- head=gear.Merl_Phalanx_head,       --  5, __, __, __ [__/__,  86]
    -- body=gear.Merl_Phalanx_body,       --  5, __, __, __ [ 2/__,  91]
    -- hands=gear.Chironic_Phalanx_hands, --  5, 15, __, __ [__/__,  48]
    -- legs=gear.Merl_Phalanx_legs,       --  5, __, __, __ [__/__, 118]
    -- feet=gear.Chironic_Phalanx_feet,   --  5, __, __, __ [ 2/__, 118]
    -- neck="Duelist's Torque +2",        -- __, __, __, 25 [__/__, ___]
    -- ear2="Lethargy Earring +2",        -- __, __, __,  9 [__/__, ___]
    -- ear2="Odnowa Earring +1",          -- __, __, __, __ [ 3/ 5, ___]
    -- ring1="Gelatinous Ring +1",        -- __, __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",            -- __, __, __, __ [10/10, ___]
    -- back=gear.RDM_Adoulin_Cape,        -- __, __, 20, __ [__/__, ___]
    -- waist="Embla Sash",                -- __, __, __, 10 [__/__, ___]
    -- Traits/Gifts/Merits                -- __,456, __, __ [__/__, ___]
    -- Master Levels                      -- __, 29, __, __ [__/__, ___]
    -- 30 Phalanx+, 500 Enh Skill, 20 Aug Enh Duration, 54 Enh duration [37 PDT/27 MDT, 461 M.Eva]
    -- 65 Phalanx total
  }
  -- Skill caps at 500 Enhancing Magic skill for a total of Phalanx+35.
  sets.midcast.PhalanxOthers = set_combine(sets.midcast.EnhancingDuration,{})

  -- Needs 500 enhancing magic skill.
  sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
    main="Eremite's Wand +1",         -- __, __, __, __, 25 [__/__, ___]
    sub="Genmei Shield",              -- __, __, __, __, __ [10/__, ___]
    range=empty,                      -- __, __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, __, 11 [ 3/ 3, ___]
    head="Amalric Coif +1",           --  2, __, __, __, __ [__/__,  86]
    body="Rosette Jaseran +1",        -- __, __, __, __, 25 [ 5/ 5,  80]
    hands="Regal Cuffs",              --  2, __, __, __, __ [__/__,  53]
    -- legs="Shedir Seraweels",       --  1, 15, __, __, __ [__/__, ___]
    feet="Lethargy Houseaux +2",      -- __, 30, 35, __, __ [__/__, 147]
    neck="Loricate Torque +1",        -- __, __, __, __,  5 [ 6/ 6, ___]
    ear1="Halasz Earring",            -- __, __, __, __,  5 [__/__, ___]
    ear2="Odnowa Earring +1",         -- __, __, __, __, __ [ 3/ 5, ___]
    ring1="Freke Ring",               -- __, __, __, __, 10 [__/__, ___]
    ring2="Defending Ring",           -- __, __, __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,       -- __,  9, __, 20, __ [__/__, ___]
    waist="Emphatikos Rope",          --  1, __, __, __, 12 [__/__, ___]
    -- Traits/Gifts/Merits            -- __,456, __, __, 10 [__/__, ___]
    -- 6 Aquaveil+, 510 Enh skill, 35 Enh duration, 20 Aug Enh Duration, 103 SIRD [37 PDT/29 MDT, 366 M.Eva]
    
    -- main="Eremite's Wand +1",      -- __, __, __, __, 25 [__/__, ___]
    -- sub="Genmei Shield",           -- __, __, __, __, __ [10/__, ___]
    -- range=empty,                   -- __, __, __, __, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, __, __, __, 11 [ 3/ 3, ___]
    -- head="Amalric Coif +1",        --  2, __, __, __, __ [__/__,  86]
    -- body="Rosette Jaseran +1",     -- __, __, __, __, 25 [ 5/ 5,  80]
    -- hands="Regal Cuffs",           --  2, __, __, __, __ [__/__,  53]
    -- legs="Shedir Seraweels",       --  1, 15, __, __, __ [__/__, ___]
    -- feet="Lethargy Houseaux +3",   -- __, 35, 40, __, __ [__/__, 157]
    -- neck="Loricate Torque +1",     -- __, __, __, __,  5 [ 6/ 6, ___]
    -- ear1="Magnetic Earring",       -- __, __, __, __,  8 [__/__, ___]
    -- ear2="Odnowa Earring +1",      -- __, __, __, __, __ [ 3/ 5, ___]
    -- ring1="Freke Ring",            -- __, __, __, __, 10 [__/__, ___]
    -- ring2="Defending Ring",        -- __, __, __, __, __ [10/10, ___]
    -- back=gear.RDM_Adoulin_Cape,    -- __, 10, __, 20, __ [__/__, ___]
    -- waist="Emphatikos Rope",       --  1, __, __, __, 12 [__/__, ___]
    -- Traits/Gifts/Merits            -- __,456, __, __, 10 [__/__, ___]
    -- 6 Aquaveil+, 516 Enh skill, 40 Enh duration, 20 Aug Enh Duration, 106 SIRD [37 PDT/29 MDT, 376 M.Eva]
  })

  sets.midcast.GainSpell = {
    hands="Vitiation Gloves +1"
    -- hands="Vitiation Gloves +3"
  }
  sets.midcast.SpikesSpell = {
    legs="Vitiation Tights +1"
    -- legs="Vitiation Tights +3" -- No real need to upgrade past +1
  }

  sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
    ring1="Sheltered Ring"
  })
  sets.midcast.Protectra = set_combine(sets.midcast.Protect,{})
  sets.midcast.Shell = set_combine(sets.midcast.Protect,{})
  sets.midcast.Shellra = set_combine(sets.midcast.Shell,{})

  -- General enhancing set for buffing others under Composure if no more specific set is defined
  sets.midcast.ComposureOther = {
    main=gear.Colada_ENH,             -- __,  4, __,  4 [__/__, ___]
    sub="Ammurapi Shield",            -- __, 10, __, __ [__/__, ___]
    range=empty,                      -- __, __, __, __ [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __, __ [ 3/ 3, ___]
    head="Lethargy Chappel +2",       -- __, __, __, __ [ 9/ 9, 115]
    body="Lethargy Sayon +3",         -- __, __, __, __ [14/14, 136]
    hands="Atrophy Gloves +3",        -- __, 20, __, __ [__/__,  57]
    legs="Lethargy Fuseau +2",        -- __, __, __, __ [__/__, 152]
    feet="Lethargy Houseaux +2",      -- 30, 35, __, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- __, 25, __, __ [__/__, ___]
    ear1="Odnowa Earring +1",         -- __, __, __, __ [ 3/ 5, ___]
    ear2="Lethargy Earring",          -- __,  7, __,  7 [__/__, ___]
    ring1="Gelatinous Ring +1",       -- __, __, __, __ [ 7/-1, ___]
    ring2="Defending Ring",           -- __, __, __, __ [10/10, ___]
    back=gear.RDM_Adoulin_Cape,       --  9, __, 20, __ [__/__, ___]
    waist="Embla Sash",               -- __, 10, __,  5 [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, __, 38 [__/__, ___]
    -- Empy set bonuses                  __, 35, __, __ [__/__, ___]
    -- 495 Enh skill, 146 Enh duration, 20 Aug Enh Duration, 54 FC [46 PDT/40 MDT, 607 M.Eva]
    
    -- main=gear.Colada_ENH,          -- __,  4, __,  4 [__/__, ___]
    -- sub="Ammurapi Shield",         -- __, 10, __, __ [__/__, ___]
    -- range=empty,                   -- __, __, __, __ [__/__, ___]
    -- ammo="Staunch Tathlum +1",     -- __, __, __, __ [ 3/ 3, ___]
    -- head="Lethargy Chappel +3",    -- __, __, __, __ [10/10, 125]
    -- body="Lethargy Sayon +3",      -- __, __, __, __ [14/14, 136]
    -- hands="Atrophy Gloves +3",     -- __, 20, __, __ [__/__,  57]
    -- legs="Lethargy Fuseau +3",     -- __, __, __, __ [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- 35, 40, __, __ [__/__, 157]
    -- neck="Duelist's Torque +2",    -- __, 25, __, __ [__/__, ___]
    -- ear1="Odnowa Earring +1",      -- __, __, __, __ [ 3/ 5, ___]
    -- ear2="Lethargy Earring",       -- __,  7, __,  7 [__/__, ___]
    -- ring1="Gelatinous Ring +1",    -- __, __, __, __ [ 7/-1, ___]
    -- ring2="Defending Ring",        -- __, __, __, __ [10/10, ___]
    -- back=gear.RDM_Adoulin_Cape,    -- 10, __, 20, __ [__/__, ___]
    -- waist="Embla Sash",            -- __, 10, __,  5 [__/__, ___]
    -- Traits/Gifts/Merits            --456, __, __, 38 [__/__, ___]
    -- Empy set bonuses                  __, 35, __, __ [__/__, ___]
    -- 501 Enh skill, 151 Enh duration, 20 Aug Enh Duration, 54 FC [47 PDT/41 MDT, 637 M.Eva]
  }

  -- Skill max is 625 is the highest needed.
  -- Distract III (610), Frazzle III (625), Poison II (no cap)
  sets.midcast.SkillEnfeebles = {
    main="Contemplator +1",           -- 228, 70, 22, __ (__, __, __, 20) [__/__, ___]
    sub="Enki Strap",                 -- ___, 10, 10, __ (__, __, __, __) [__/__,  10]
    range=empty,                      -- ___, __, __, __ (__, __, __, __) [__/__, ___]
    ammo="Regal Gem",                 -- ___, 15,  7, __ (__, 10, __, __) [__/__, ___]
    head="Vitiation Chapeau +1",      -- ___, __, 32, __ (__, __, __, 22) [__/__,  75]; Enhances enf. duration
    body="Atrophy Tabard +2",         -- ___, 45, 38, __ (__, __, __, 19) [__/__,  90]
    hands="Lethargy Gantherots +2",   -- ___, 52, 45, __ (__, __, __, 24) [10/10,  77]
    legs=gear.Chironic_MAcc_legs,     -- ___, 57, 29, __ ( 1, __, __, 13) [__/__, 118]
    feet="Vitiation Boots +3",        -- ___, 43, 32, __ (__, 10, __, 16) [__/__, 127]; Immunobreak+
    neck="Duelist's Torque +2",       -- ___, 30, 15, __ (__, 10, 25, __) [__/__, ___]
    ear1="Snotra Earring",            -- ___, 10,  8, __ (__, __, 10, __) [__/__, ___]
    ear2="Regal Earring",             -- ___, __, 10, __ (__, __, __, __) [__/__, ___]
    ring1="Kishar Ring",              -- ___,  5, __,  4 (__, __, 10, __) [__/__, ___]
    ring2="Stikini Ring +1",          -- ___, 11,  8, __ (__, __, __,  8) [__/__, ___]
    back=gear.RDM_MND_Enf_Cape,       -- ___, 20, 30, 10 (__, 10, __, __) [10/__, ___]
    waist="Obstinate Sash",           -- ___, 15,  5, __ (__, __,  5, 15) [__/__, ___]
    -- AF set effect                          15
    -- Traits/Gifts                                   38             476
    -- 228 M.Acc skill, 398 M.Acc, 291 MND, 52 FC (1 Immunobreak, 40 Enf. Effect, 50 Enf. Duration, 613 Enf. Skill) [20 PDT/10 MDT, 497 M.Eva]
    
    -- head="Vitiation Chapeau +3",   -- ___, 37, 42, __ (__, __, __, 26) [__/__,  95]; Enhances enf. duration
    -- body="Atrophy Tabard +3",      -- ___, 55, 43, __ (__, __, __, 21) [__/__, 100]
    -- hands="Lethargy Gantherots +3",-- ___, 62, 50, __ (__, __, __, 29) [11/11,  87]
    -- legs=gear.Chironic_MAcc_legs,  -- ___, 60, 29, __ ( 1, __, __, 13) [__/__, 118]
    -- 228 M.Acc skill, 458 M.Acc, 311 MND, 52 FC (1 Immunobreak, 40 Enf. Effect, 50 Enf. Duration, 624 Enf. Skill) [20 PDT/10 MDT, 517 M.Eva]
  }
  sets.midcast.SkillEnfeeblesDW = set_combine(sets.midcast.SkillEnfeebles, {
  })

  -- General enfeebles
  sets.midcast.MNDEnfeebles = { --Max MND but balance macc for landing
    main="Daybreak",                  -- 242, 40, 30, __ (__, __, __, __) [__/__,  30]
    sub="Ammurapi Shield",            -- ___, 38, 13, __ (__, __, __, __) [__/__, ___]
    range=empty,                      -- ___, __, __, __ (__, __, __, __) [__/__, ___]
    ammo="Regal Gem",                 -- ___, 15,  7, __ (__, 10, __, __) [__/__, ___]
    head="Vitiation Chapeau +1",      -- ___, __, 32, __ (__, __, __, 22) [__/__,  75]; Enhances enf. duration
    body="Lethargy Sayon +3",         -- ___, 64, 45, __ (__, 18, __, __) [14/14, 136]
    hands="Lethargy Gantherots +2",   -- ___, 52, 45, __ (__, __, __, 24) [10/10,  77]
    legs=gear.Chironic_MAcc_legs,     -- ___, 57, 29, __ ( 1, __, __, 13) [__/__, 118]
    feet="Vitiation Boots +3",        -- ___, 43, 32, __ (__, 10, __, 16) [__/__, 127]; Immunobreak+
    neck="Duelist's Torque +2",       -- ___, 30, 15, __ (__, 10, 25, __) [__/__, ___]
    ear1="Snotra Earring",            -- ___, 10,  8, __ (__, __, 10, __) [__/__, ___]
    ear2="Malignance Earring",        -- ___, 10,  8,  4 (__, __, __, __) [__/__, ___]
    ring1="Stikini Ring +1",          -- ___, 11,  8, __ (__, __, __,  8) [__/__, ___]
    ring2="Stikini Ring +1",          -- ___, 11,  8, __ (__, __, __,  8) [__/__, ___]
    back=gear.RDM_MND_Enf_Cape,       -- ___, 20, 30, 10 (__, 10, __, __) [10/__, ___]
    waist="Obstinate Sash",           -- ___, 15,  5, __ (__, __,  5, 15) [__/__, ___]
    -- Empy set effect                   ___, __, __, __ (__, __, 10, __) [__/__, ___]
    -- Traits/Gifts/Merits            --              38
    -- 242 M.Acc skill, 416 M.Acc, 315 MND, 52 FC (1 Immunobreak, 58 Enf. Effect, 50 Enf. Duration, 106 Enf. Skill) [34 PDT/24 MDT, 563 M.Eva]
    
    -- head="Vitiation Chapeau +3",   -- ___, 37, 42, __ (__, __, __, 26) [__/__,  95]; Enhances enf. duration
    -- hands="Lethargy Gantherots +3",-- ___, 62, 50, __ (__, __, __, 29) [11/11,  87]
    -- legs=gear.Chironic_MAcc_legs,  -- ___, 60, 29, __ ( 1, __, __, 13) [__/__, 118]
    -- 242 M.Acc skill, 466 M.Acc, 330 MND, 52 FC (1 Immunobreak, 58 Enf. Effect, 50 Enf. Duration, 115 Enf. Skill) [35 PDT/25 MDT, 593 M.Eva]
  }
  sets.midcast.MNDEnfeeblesDW = set_combine(sets.midcast.MNDEnfeebles, {
    main="Daybreak",                  -- 242, 40, 30, __ (__, __, __, __) [__/__,  30]
    sub="Maxentius",                  -- 232, 40, 15, __ (__, __, __, __) [__/__, ___]
  })

  -- Used when casting mode is 'Resistant'
  sets.midcast.MNDEnfeeblesAcc = {
    -- main="Crocea Mors",            -- 255, 50, __, 20 (__, __, __, __) [__/__, ___]
    sub="Ammurapi Shield",            -- ___, 38, 13, __ (__, __, __, __) [__/__, ___]
    range="Ullr",                     -- ___, 40, __, __ (__, __, __, __) [__/__, ___]
    ammo=empty,                       -- ___, __, __, __ (__, __, __, __) [__/__, ___]
    head="Vitiation Chapeau +1",      -- ___, __, 32, __ (__, __, __, 22) [__/__,  75]; Enhances enf. duration
    body="Atrophy Tabard +2",         -- ___, 45, 38, __ (__, __, __, 19) [__/__,  90]
    hands="Lethargy Gantherots +2",   -- ___, 52, 45, __ (__, __, __, 24) [10/10,  77]
    legs=gear.Chironic_MAcc_legs,     -- ___, 57, 29, __ ( 1, __, __, 13) [__/__, 118]
    feet="Vitiation Boots +3",        -- ___, 43, 32, __ (__, 10, __, 16) [__/__, 127]; Immunobreak+
    neck="Duelist's Torque +2",       -- ___, 30, 15, __ (__, 10, 25, __) [__/__, ___]
    ear1="Snotra Earring",            -- ___, 10,  8, __ (__, __, 10, __) [__/__, ___]
    ear2="Malignance Earring",        -- ___, 10,  8,  4 (__, __, __, __) [__/__, ___]
    ring1="Stikini Ring +1",          -- ___, 11,  8, __ (__, __, __,  8) [__/__, ___]
    ring2="Stikini Ring +1",          -- ___, 11,  8, __ (__, __, __,  8) [__/__, ___]
    back=gear.RDM_MND_Enf_Cape,       -- ___, 20, 30, 10 (__, 10, __, __) [10/__, ___]
    waist="Obstinate Sash",           -- ___, 15,  5, __ (__, __,  5, 15) [__/__, ___]
    -- Empy set effect                   ___, __, __, __ (__, __, __, __) [__/__, ___]
    -- Traits/Gifts/Merits                            38
    -- 255 M.Acc skill, 432 M.Acc, 271 MND, 72 FC (1 Immunobreak, 20 Enf. Effect, 40 Enf. Duration, 125 Enf. Skill) [20 PDT/10 MDT, 487 M.Eva]
    
    -- head="Vitiation Chapeau +3",   -- ___, 37, 42, __ (__, __, __, 26) [__/__,  95]; Enhances enf. duration
    -- body="Atrophy Tabard +3",      -- ___, 55, 43, __ (__, __, __, 21) [__/__, 100]
    -- hands="Lethargy Gantherots +3",-- ___, 62, 50, __ (__, __, __, 29) [11/11,  87]
    -- legs=gear.Chironic_MAcc_legs,  -- ___, 60, 29, __ ( 1, __, __, 13) [__/__, 118]
    -- 255 M.Acc skill, 492 M.Acc, 291 MND, 72 FC (1 Immunobreak, 30 Enf. Effect, 40 Enf. Duration, 136 Enf. Skill) [21 PDT/11 MDT, 527 M.Eva]
  }
  sets.midcast.MNDEnfeeblesAccDW = set_combine(sets.midcast.MNDEnfeeblesAcc, {
    -- main="Crocea Mors",            -- 255, 50, __, 20 (__, __, __, __) [__/__, ___]
    sub="Daybreak",                   -- 242, 40, 30, __ (__, __, __, __) [__/__,  30]
  })

  -- Spells that have 100% accuracy. Focus on duration.
  sets.midcast.MNDEnfeeblesDuration = {
    main="Daybreak",                  -- 242, 40, 30, __ (__, __, __, __) [__/__,  30]
    sub="Genmei Shield",              -- ___, __, __, __ (__, __, __, __) [10/__, ___]
    range=empty,                      -- ___, __, __, __ (__, __, __, __) [__/__, ___]
    ammo="Regal Gem",                 -- ___, 15,  7, __ (__, 10, __, __) [__/__, ___]
    head="Vitiation Chapeau +1",      -- ___, __, 32, __ (__, __, __, 22) [__/__,  75]; Enhances enf. duration
    body="Lethargy Sayon +3",         -- ___, 64, 45, __ (__, 18, __, __) [14/14, 136]
    hands="Regal Cuffs",              -- ___, 45, 40, __ (__, __, 20, __) [__/__,  53]
    legs="Lethargy Fuseau +2",        -- ___, 53, 38, __ (__, __, __, __) [__/__, 152]
    feet="Lethargy Houseaux +2",      -- ___, 50, 27, __ (__, __, __, __) [__/__, 147]
    neck="Duelist's Torque +2",       -- ___, 30, 15, __ (__, 10, 25, __) [__/__, ___]
    ear1="Snotra Earring",            -- ___, 10,  8, __ (__, __, 10, __) [__/__, ___]
    ear2="Odnowa Earring +1",         -- ___, __, __, __ (__, __, __, __) [ 3/ 5, ___]
    ring1="Kishar Ring",              -- ___,  5, __,  4 (__, __, 10, __) [__/__, ___]
    ring2="Defending Ring",           -- ___, __, __, __ (__, __, __, __) [10/10, ___]
    back=gear.RDM_MND_Enf_Cape,       -- ___, 20, 30, 10 (__, 10, __, __) [10/__, ___]
    waist="Obstinate Sash",           -- ___, 15,  5, __ (__, __,  5, 15) [__/__, ___]
    -- Empy set effect                   ___, __, __, __ (__, __, 20, __) [__/__, ___]
    -- Traits/Gifts/Merits                            38
    -- 242 M.Acc skill, 347 M.Acc, 277 MND, 52 FC (0 Immunobreak, 48 Enf. Effect, 90 Enf. Duration, 37 Enf. Skill) [47 PDT/29 MDT, 593 M.Eva]
    
    -- head="Vitiation Chapeau +3",   -- ___, 37, 42, __ (__, __, __, 26) [__/__,  95]; Enhances enf. duration
    -- legs="Lethargy Fuseau +3",     -- ___, 63, 43, __ (__, __, __, __) [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- ___, 60, 32, __ (__, __, __, __) [__/__, 157]
    -- 242 M.Acc skill, 404 M.Acc, 297 MND, 52 FC (0 Immunobreak, 48 Enf. Effect, 90 Enf. Duration, 41 Enf. Skill) [47 PDT/29 MDT, 633 M.Eva]
  }
  sets.midcast.MNDEnfeeblesDurationDW = set_combine(sets.midcast.MNDEnfeeblesDuration, {})

  -- General enfeebles
  sets.midcast.INTEnfeebles = {
    main="Contemplator +1",           -- 228, 70, 12, __ (__, __, __, 20) [__/__, ___]
    sub="Enki Strap",                 -- ___, 10, 10, __ (__, __, __, __) [__/__,  10]
    range=empty,                      -- ___, __, __, __ (__, __, __, __) [__/__, ___]
    ammo="Ghastly Tathlum +1",        -- ___, __, 11, __ (__, __, __, __) [__/__, ___]
    head="Vitiation Chapeau +1",      -- ___, __, 19, __ (__, __, __, 22) [__/__,  75]; Enhances enf. duration
    body="Lethargy Sayon +3",         -- ___, 64, 47, __ (__, 18, __, __) [14/14, 136]
    hands="Lethargy Gantherots +2",   -- ___, 52, 28, __ (__, __, __, 24) [10/10,  77]
    legs=gear.Chironic_MAcc_legs,     -- ___, 57, 42, __ ( 1, __, __, 13) [__/__, 118]
    feet="Vitiation Boots +3",        -- ___, 43, 32, __ (__, 10, __, 16) [__/__, 127]; Immunobreak+
    neck="Duelist's Torque +2",       -- ___, 30, 15, __ (__, 10, 25, __) [__/__, ___]
    ear1="Snotra Earring",            -- ___, 10, __, __ (__, __, 10, __) [__/__, ___]
    ear2="Malignance Earring",        -- ___, 10,  8,  4 (__, __, __, __) [__/__, ___]
    ring1="Metamorph Ring +1",        -- ___, 15, 16, __ (__, __, __, __) [__/__, ___]
    ring2="Stikini Ring +1",          -- ___, 11, __, __ (__, __, __,  8) [__/__, ___]
    back=gear.RDM_INT_Enf_Cape,       -- ___, 20, 30, __ (__, 10, __, __) [10/__, ___]
    waist="Obstinate Sash",           -- ___, 15, __, __ (__, __,  5, 15) [__/__, ___]
    -- Empy set effect                   ___, __, __, __ (__, __, 10, __) [__/__, ___]
    -- Traits/Gifts/Merits            --              38
    -- 228 M.Acc skill, 407 M.Acc, 270 INT, 42 FC (1 Immunobreak, 48 Enf. Effect, 50 Enf. Duration, 118 Enf. Skill) [34 PDT/24 MDT, 543 M.Eva]

    -- head="Vitiation Chapeau +3",   -- ___, 37, 29, __ (__, __, __, 26) [__/__,  95]; Enhances enf. duration
    -- hands="Lethargy Gantherots +3",-- ___, 62, 50, __ (__, __, __, 29) [11/11,  87]
    -- legs=gear.Chironic_MAcc_legs,  -- ___, 60, 29, __ ( 1, __, __, 13) [__/__, 118]
    -- 228 M.Acc skill, 457 M.Acc, 289 INT, 42 FC (1 Immunobreak, 48 Enf. Effect, 50 Enf. Duration, 127 Enf. Skill) [35 PDT/25 MDT, 573 M.Eva]
  }
  sets.midcast.INTEnfeeblesDW = set_combine(sets.midcast.INTEnfeebles, {})

  -- Used when casting mode is 'Resistant'
  sets.midcast.INTEnfeeblesAcc = {
    main="Contemplator +1",           -- 228, 70, 12, __ (__, __, __, 20) [__/__, ___]
    sub="Enki Strap",                 -- ___, 10, 10, __ (__, __, __, __) [__/__,  10]
    range="Ullr",                     -- ___, 40, __, __ (__, __, __, __) [__/__, ___]
    ammo=empty,                       -- ___, __, __, __ (__, __, __, __) [__/__, ___]
    head="Vitiation Chapeau +1",      -- ___, __, 19, __ (__, __, __, 22) [__/__,  75]; Enhances enf. duration
    body="Atrophy Tabard +2",         -- ___, 45, 38, __ (__, __, __, 19) [__/__,  90]
    hands="Lethargy Gantherots +2",   -- ___, 52, 28, __ (__, __, __, 24) [10/10,  77]
    legs=gear.Chironic_MAcc_legs,     -- ___, 57, 42, __ ( 1, __, __, 13) [__/__, 118]
    feet="Vitiation Boots +3",        -- ___, 43, 32, __ (__, 10, __, 16) [__/__, 127]; Immunobreak+
    neck="Duelist's Torque +2",       -- ___, 30, 15, __ (__, 10, 25, __) [__/__, ___]
    ear1="Snotra Earring",            -- ___, 10, __, __ (__, __, 10, __) [__/__, ___]
    ear2="Malignance Earring",        -- ___, 10,  8,  4 (__, __, __, __) [__/__, ___]
    ring1="Metamorph Ring +1",        -- ___, 15, 16, __ (__, __, __, __) [__/__, ___]
    ring2="Stikini Ring +1",          -- ___, 11, __, __ (__, __, __,  8) [__/__, ___]
    back=gear.RDM_INT_Enf_Cape,       -- ___, 20, 30, __ (__, 10, __, __) [10/__, ___]
    waist="Obstinate Sash",           -- ___, 15, __, __ (__, __,  5, 15) [__/__, ___]
    -- Empy set effect                   ___, __, __, __ (__, __, __, __) [__/__, ___]
    -- Traits/Gifts/Merits                            38
    -- 228 M.Acc skill, 428 M.Acc, 250 INT, 42 FC (1 Immunobreak, 30 Enf. Effect, 40 Enf. Duration, 137 Enf. Skill) [20 PDT/10 MDT, 497 M.Eva]
    
    -- head="Vitiation Chapeau +3",   -- ___, 37, 29, __ (__, __, __, 26) [__/__,  95]; Enhances enf. duration
    -- body="Atrophy Tabard +3",      -- ___, 55, 43, __ (__, __, __, 21) [__/__, 100]
    -- hands="Lethargy Gantherots +3",-- ___, 62, 33, __ (__, __, __, 29) [11/11,  87]
    -- legs=gear.Chironic_MAcc_legs,  -- ___, 60, 42, __ ( 1, __, __, 13) [__/__, 118]
    -- 228 M.Acc skill, 503 M.Acc, 270 INT, 42 FC (1 Immunobreak, 30 Enf. Effect, 40 Enf. Duration, 148 Enf. Skill) [21 PDT/11 MDT, 537 M.Eva]
  }
  sets.midcast.INTEnfeeblesAccDW = set_combine(sets.midcast.INTEnfeeblesAcc, {})

  -- Spells that have 100% accuracy. Focus on duration.
  -- There currently are no spells that fall into this category, but this set exists anyway!
  sets.midcast.INTEnfeeblesDuration = {
    main="Daybreak",                  -- 242, 40, __, __ (__, __, __, __) [__/__,  30]
    sub="Genmei Shield",              -- ___, __, __, __ (__, __, __, __) [10/__, ___]
    range="Ullr",                     -- ___, 40, __, __ (__, __, __, __) [__/__, ___]
    ammo=empty,                       -- ___, __, __, __ (__, __, __, __) [__/__, ___]
    head="Vitiation Chapeau +1",      -- ___, __, 19, __ (__, __, __, 22) [__/__,  75]; Enhances enf. duration
    body="Lethargy Sayon +3",         -- ___, 64, 47, __ (__, 18, __, __) [14/14, 136]
    hands="Regal Cuffs",              -- ___, 45, 40, __ (__, __, 20, __) [__/__,  53]
    legs="Lethargy Fuseau +2",        -- ___, 53, 43, __ (__, __, __, __) [__/__, 152]
    feet="Lethargy Houseaux +2",      -- ___, 50, 25, __ (__, __, __, __) [__/__, 147]
    neck="Duelist's Torque +2",       -- ___, 30, 15, __ (__, 10, 25, __) [__/__, ___]
    ear1="Snotra Earring",            -- ___, 10, __, __ (__, __, 10, __) [__/__, ___]
    ear2="Odnowa Earring +1",         -- ___, __, __, __ (__, __, __, __) [ 3/ 5, ___]
    ring1="Kishar Ring",              -- ___,  5, __,  4 (__, __, 10, __) [__/__, ___]
    ring2="Defending Ring",           -- ___, __, __, __ (__, __, __, __) [10/10, ___]
    back=gear.RDM_INT_Enf_Cape,       -- ___, 20, 30, __ (__, 10, __, __) [10/__, ___]
    waist="Obstinate Sash",           -- ___, 15, __, __ (__, __,  5, 15) [__/__, ___]
    -- Empy set effect                   ___, __, __, __ (__, __, 20, __) [__/__, ___]
    -- Traits/Gifts/Merits                            38
    -- 242 M.Acc skill, 372 M.Acc, 219 INT, 42 FC (0 Immunobreak, 38 Enf. Effect, 90 Enf. Duration, 37 Enf. Skill) [47 PDT/29 MDT, 593 M.Eva]
    
    -- head="Vitiation Chapeau +3",   -- ___, 37, 29, __ (__, __, __, 26) [__/__,  95]; Enhances enf. duration
    -- legs="Lethargy Fuseau +3",     -- ___, 63, 48, __ (__, __, __, __) [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- ___, 60, 30, __ (__, __, __, __) [__/__, 157]
    -- 242 M.Acc skill, 429 M.Acc, 239 INT, 42 FC (0 Immunobreak, 38 Enf. Effect, 90 Enf. Duration, 41 Enf. Skill) [47 PDT/29 MDT, 633 M.Eva]
  }
  sets.midcast.INTEnfeeblesDurationDW = set_combine(sets.midcast.INTEnfeeblesDuration, {})

  sets.midcast.Dispelga = set_combine(sets.midcast.INTEnfeeblesAcc, {
    main="Daybreak",
    sub={name="Ammurapi Shield", priority=1},
  })

  -- Dark magic options:
  -- M.Acc Skill, Dark skill, M.Acc, INT [PDT/MDT, M.Eva]
    -- main="Rubicundity",            -- 215, 25, 30, 21 [__/__, ___]
    -- head=gear.Amalric_C_head       -- ___, 20, 36, 36 [__/__,  86]
    -- body=gear.Carmine_C_body,      -- ___, 16, 38, 38 [__/ 4,  64]
    -- neck="Erra Pendant",           -- ___, 10, 17, __ [__/__, ___]
    -- ear2="Mani Earring",           -- ___, 10, __, __ [__/__, ___]
    -- ring1="Stikini Ring +1",       -- ___,  8, 11, __ [__/__, ___]
    -- ring1="Evanescence Ring",      -- ___, 10, __, __ [__/__, ___]

  sets.midcast['Dark Magic'] = {
    -- main="Rubicundity",            -- 215, 25, 30, 21 [__/__, ___]
    sub="Ammurapi Shield",            -- ___, __, 38, 13 [__/__, ___]
    range=empty,                      -- ___, __, __, __ [__/__, ___]
    ammo="Pemphredo Tathlum",         -- ___, __,  8,  4 [__/__, ___]
    head=gear.Amalric_C_head,         -- ___, 20, 36, 36 [__/__,  86]
    -- body=gear.Carmine_C_body,      -- ___, 16, 38, 38 [__/ 4,  64]
    hands="Lethargy Gantherots +2",   -- ___, __, 52, 28 [10/10,  77]
    legs="Bunzi's Pants",             -- ___, __, 55, 51 [ 9/ 9, 150]
    feet="Bunzi's Sabots",            -- ___, __, 55, 32 [ 6/ 6, 150]
    neck="Erra Pendant",              -- ___, 10, 17, __ [__/__, ___]
    ear1="Malignance Earring",        -- ___, __, 10,  8 [__/__, ___]
    -- ear2="Mani Earring",           -- ___, 10, __, __ [__/__, ___]
    ring1="Stikini Ring +1",          -- ___,  8, 11, __ [__/__, ___]
    ring2="Evanescence Ring",         -- ___, 10, __, __ [__/__, ___]
    back="Aurist's Cape +1",          -- ___, __, 33, 33 [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15, 23 [__/__, ___]
    -- Traits/Merits/Gifts                   316
    -- 215 M.Acc Skill, 415 Dark skill, 398 M.Acc, 287 INT [25 PDT/29 MDT, 527 M.Eva]

    -- hands="Lethargy Gantherots +3",-- ___, __, 62, 33 [11/11,  87]
    -- 215 M.Acc Skill, 415 Dark skill, 408 M.Acc, 292 INT [26 PDT/30 MDT, 537 M.Eva]
  }

  sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
    feet=gear.Merl_Drain_feet,        --  7 Drain/Aspir potency
    ring2="Evanescence Ring",         -- 10 Drain/Aspir potency
    waist="Fucho-no-obi",             --  8 Drain/Aspir potency
    -- ear2="Hirudinea Earring",      --  3 Drain/Aspir potency
  })
  sets.midcast.Aspir = set_combine(sets.midcast.Drain,{})

  sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

  -- MB options:
  -- M.Acc Skill, Elemental Skill, M.Acc (INT, MAB, M.Dmg, MB, MB2) [PDT/MDT, M.Eva]
    -- main="Bunzi's Rod",            -- 255, __, 55 (15, 65,248, 10, __) [__/__, ___]
    -- head="Bunzi's Hat",            -- ___, __, 55 (34, 30, 60,  7, __) [ 7/ 7, 123]
    -- head=gear.Nyame_B_head,        -- ___, __, 40 (28, 30, __,  5, __) [ 7/ 7, 123]
    -- head="Ea Hat +1",              -- ___, __, 50 (43, 38, __,  7,  7) [__/__, 109]
    -- head="Atrophy Chapeau +3",     -- ___, 17, 54 (37, __, __, 10, __) [__/__,  95]
    -- body="Bunzi's Robe",           -- ___, __, 55 (48, 30, 60, 10, __) [10/10, 139]
    -- body=gear.Nyame_B_body,        -- ___, __, 40 (42, 30, __,  7, __) [ 9/ 9, 139]
    -- body="Ea Houppelande +1",      -- ___, __, 52 (48, 44, __,  9,  9) [__/__, 128]
    -- hands="Bunzi's Gloves",        -- ___, __, 55 (34, 30, 60,  8,  6) [ 8/ 8, 112]
    -- hands=gear.Nyame_B_hands,      -- ___, __, 40 (28, 30, __,  5, __) [ 7/ 7, 112]
    -- hands="Ea Cuffs +1",           -- ___, __, 49 (40, 35, __,  6,  6) [__/__, 101]
    -- hands=gear.Amalric_D_hands,    -- ___, 14, 20 (36, 53, __, __,  6) [__/__,  48]
    -- legs="Bunzi's Pants",          -- ___, __, 55 (51, 30, 60,  9, __) [ 9/ 9, 150]
    -- legs=gear.Nyame_B_legs,        -- ___, __, 40 (44, 30, __,  6, __) [ 8/ 8, 150]
    -- legs="Ea Slops +1",            -- ___, __, 51 (48, 41, __,  8,  8) [__/__, 147]
    -- legs="Lethargy Fuseau +3",     -- ___, __, 63 (48, 58, 33, 15, __) [__/__, 162]
    -- feet="Bunzi's Sabots",         -- ___, __, 55 (32, 30, 60,  6, __) [ 6/ 6, 150]
    -- feet=gear.Nyame_B_feet,        -- ___, __, 40 (25, 30, __,  5, __) [ 7/ 7, 150]
    -- feet="Ea Pigaches +1",         -- ___, __, 48 ( 5, 32, __,  5,  5) [__/__, 147]
    -- neck="Warder's Charm +1",      -- ___, __, __ (__, __, __, 10, __) [__/__, ___]
    -- neck="Mizu. Kubikazari",       -- ___, __, __ ( 4,  8, __, 10, __) [__/__, ___]
    -- ring1="Locus Ring",            -- ___, __, __ (__, __, __,  5, __) [__/__, ___]
    -- ring1="Mujin Band",            -- ___, __, __ (__, __, __, __,  5) [__/__, ___]

  sets.midcast['Elemental Magic'] = {
    main="Bunzi's Rod",               -- 255, __, 55 (15, 65,248, 10, __) [__/__, ___]
    sub="Ammurapi Shield",            -- ___, __, 38 (13, 38, __, __, __) [__/__, ___]
    range=empty,                      -- ___, __, __ (__, __, __, __, __) [__/__, ___]
    ammo="Pemphredo Tathlum",         -- ___, __,  8 ( 4,  4, __, __, __) [__/__, ___]
    head="Lethargy Chappel +2",       -- ___, __, 51 (33, 51, 21, __, __) [ 9/ 9, 115]
    body="Lethargy Sayon +3",         -- ___, __, 64 (47, 54, 34, __, __) [14/14, 136]
    hands="Lethargy Gantherots +2",   -- ___, __, 52 (28, 47, 22, __, __) [10/10,  77]
    legs="Lethargy Fuseau +2",        -- ___, __, 53 (43, 53, 23, 10, __) [__/__, 152]
    feet="Lethargy Houseaux +2",      -- ___, __, 50 (25, 45, 20, __, __) [__/__, 147]
    neck="Sibyl Scarf",               -- ___, __, __ (10, 10, __, __, __) [__/__, ___]
    ear1="Malignance Earring",        -- ___, __, 10 ( 8,  8, __, __, __) [__/__, ___]
    ear2="Regal Earring",             -- ___, __, __ (10, __, __, __, __) [__/__, ___]
    ring1="Freke Ring",               -- ___, __, __ (10,  8, __, __, __) [__/__, ___]
    ring2="Metamorph Ring +1",        -- ___, __, 15 (16, __, __, __, __) [__/__, ___]
    back=gear.RDM_MAB_Cape,           -- ___, __, 20 (30, 10, __, __, __) [10/__, ___]
    waist="Refoccilation Stone",      -- ___, __,  4 (__, 10, __, __, __) [__/__, ___]
    -- 255 M.Acc Skill, 0 Elemental Skill, 420 M.Acc (292 INT, 403 MAB, 368 M.Dmg, 20 MB, 0 MB2) [43 PDT/33 MDT, 627 M.Eva]
    
    -- head="Lethargy Chappel +3",    -- ___, __, 61 (38, 56, 31, __, __) [10/10, 125]
    -- hands="Lethargy Gantherots +3",-- ___, __, 62 (33, 52, 32, __, __) [11/11,  87]
    -- legs="Lethargy Fuseau +3",     -- ___, __, 63 (48, 58, 33, 15, __) [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- ___, __, 60 (30, 50, 30, __, __) [__/__, 157]
    -- 255 M.Acc Skill, 0 Elemental Skill, 460 M.Acc (312 INT, 419 MAB, 408 M.Dmg, 25 MB, 0 MB2) [45 PDT/35 MDT, 667 M.Eva]
  }
  sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
    range="Ullr",                     -- ___, __, 40 (__, __, __, __, __) [__/__, ___]
    ammo=empty,                       -- ___, __, __ (__, __, __, __, __) [__/__, ___]
    body="Seidr Cotehardie",          -- ___, __, 13 (__,  7, __, __, __) [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15 (23, __, __, __, __) [__/__, ___]
  })
  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    ammo="Ghastly Tathlum +1",        -- ___, __, __ (11, __, 21, __, __) [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15 (23, __, __, __, __) [__/__, ___]
  })

  sets.midcast['Elemental Magic'].MB = {
    main="Bunzi's Rod",               -- 255, __, 55 (15, 65,248, 10, __) [__/__, ___]
    sub="Ammurapi Shield",            -- ___, __, 38 (13, 38, __, __, __) [__/__, ___]
    range=empty,                      -- ___, __, __ (__, __, __, __, __) [__/__, ___]
    ammo="Pemphredo Tathlum",         -- ___, __,  8 ( 4,  4, __, __, __) [__/__, ___]
    head="Lethargy Chappel +2",       -- ___, __, 51 (33, 51, 21, __, __) [ 9/ 9, 115]
    body="Lethargy Sayon +3",         -- ___, __, 64 (47, 54, 34, __, __) [14/14, 136]
    hands="Bunzi's Gloves",           -- ___, __, 55 (34, 30, 60,  8,  6) [ 8/ 8, 112]
    legs="Lethargy Fuseau +2",        -- ___, __, 53 (43, 53, 23, 10, __) [__/__, 152]
    feet="Lethargy Houseaux +2",      -- ___, __, 50 (25, 45, 20, __, __) [__/__, 147]
    neck="Sibyl Scarf",               -- ___, __, __ (10, 10, __, __, __) [__/__, ___]
    ear1="Malignance Earring",        -- ___, __, 10 ( 8,  8, __, __, __) [__/__, ___]
    ear2="Regal Earring",             -- ___, __, __ (10, __, __, __, __) [__/__, ___]
    ring1="Freke Ring",               -- ___, __, __ (10,  8, __, __, __) [__/__, ___]
    ring2="Mujin Band",               -- ___, __, __ (__, __, __, __,  5) [__/__, ___]
    back=gear.RDM_MAB_Cape,           -- ___, __, 20 (30, 10, __, __, __) [10/__, ___]
    waist="Refoccilation Stone",      -- ___, __,  4 (__, 10, __, __, __) [__/__, ___]
    -- 255 M.Acc Skill, 0 Elemental Skill, 408 M.Acc (282 INT, 386 MAB, 406 M.Dmg, 28 MB, 11 MB2) [31 PDT/21 MDT, 662 M.Eva]
    
    -- head="Ea Hat +1",              -- ___, __, 50 (43, 38, __,  7,  7) [__/__, 109]
    -- body="Ea Houppelande +1",      -- ___, __, 52 (48, 44, __,  9,  9) [__/__, 128]
    -- legs="Ea Slops +1",            -- ___, __, 51 (48, 41, __,  8,  8) [__/__, 147]
    -- feet="Lethargy Houseaux +3",   -- ___, __, 60 (30, 50, 30, __, __) [__/__, 157]
    -- 255 M.Acc Skill, 0 Elemental Skill, 403 M.Acc (303 INT, 403 MAB, 338 M.Dmg, 42 MB, 35 MB2) [18 PDT/8 MDT, 653 M.Eva]
  }
  sets.midcast['Elemental Magic'].Seidr.MB = set_combine(sets.midcast['Elemental Magic'], {
    ammo="Ghastly Tathlum +1",        -- ___, __, __ (11, __, 21, __, __) [__/__, ___]
    body="Seidr Cotehardie",          -- ___, __, 13 (__,  7, __, __, __) [__/__, ___]
    ring2="Metamorph Ring +1",        -- ___, __, 15 (16, __, __, __, __) [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15 (23, __, __, __, __) [__/__, ___]
  })
  sets.midcast['Elemental Magic'].Resistant.MB = set_combine(sets.midcast['Elemental Magic'], {
    ammo="Ghastly Tathlum +1",        -- ___, __, __ (11, __, 21, __, __) [__/__, ___]
    ring2="Metamorph Ring +1",        -- ___, __, 15 (16, __, __, __, __) [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15 (23, __, __, __, __) [__/__, ___]
  })
  -- Combined on top of the other sets if dual wield available and in casting weapon mode
  sets.midcast['Elemental Magic'].DW = {
    main="Bunzi's Rod",               -- 255, __, 55 (15, 65,248, 10, __) [__/__, ___]
    sub="Daybreak",                   -- ___, __, 40 (__, 40, __, __, __) [__/__,  30]
  }

  sets.midcast.Impact = {
    -- main="Crocea Mors",            -- 255, __, 50, __, 20 [__/__, ___]
    sub="Ammurapi Shield",            -- ___, __, 38, 13, __ [__/__, ___]
    range="Ullr",                     -- ___, __, 40, __, __ [__/__, ___]
    ammo=empty,                       -- ___, __, __, __, __ [__/__, ___]
    head=empty,                       -- ___, __, __, __, __ [__/__, ___]
    body="Crepuscular Cloak",         -- ___, __, 85, 80, __ [__/__, 231]
    hands="Lethargy Gantherots +2",   -- ___, __, 52, 28, __ [10/10,  77]
    legs="Bunzi Pants",               -- ___, __, 55, 51, __ [ 9/ 9, 150]
    feet="Bunzi's Sabots",            -- ___, __, 55, 32, __ [ 6/ 6, 150]
    neck="Duelist's Torque +2",       -- ___, __, 30, 15, __ [__/__, ___]
    ear1="Malignance Earring",        -- ___, __, 10,  8,  4 [__/__, ___]
    ear2="Regal Earring",             -- ___, __, __, 10, __ [__/__, ___]
    ring1="Metamorph Ring +1",        -- ___, __, 15, 16, __ [__/__, ___]
    ring2="Stikini Ring +1",          -- ___,  8, 11, __, __ [__/__, ___]
    back="Aurist's Cape +1",          -- ___, __, 33, 33, __ [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15, 23, __ [__/__, ___]
    -- Empy set effect                   ___, __, __, __, __ [__/__, ___]
    -- Traits/Gifts/Merits            --                  38
    -- 255 M.Acc skill, 8 Elemental Skill, 489 M.Acc, 309 INT, 62 FC [25 PDT/25 MDT, 608 M.Eva]

    -- hands="Lethargy Gantherots +3",-- ___, __, 62, 50, __ [11/11,  87]
    -- 255 M.Acc skill, 8 Elemental Skill, 499 M.Acc, 314 INT, 62 FC [26 PDT/26 MDT, 618 M.Eva]
  }

  -- For spells like Burn, Choke, etc.
  sets.midcast.ElementalEnfeeble = {
    -- main="Crocea Mors",            -- 255, __, 50, __, 20 [__/__, ___]
    sub="Ammurapi Shield",            -- ___, __, 38, 13, __ [__/__, ___]
    range="Ullr",                     -- ___, __, 40, __, __ [__/__, ___]
    ammo=empty,                       -- ___, __, __, __, __ [__/__, ___]
    head="Lethargy Chappel +2",       -- ___, __, 51, 33, __ [ 9/ 9, 115]
    body="Lethargy Sayon +3",         -- ___, __, 64, 47, __ [14/14, 136]
    hands="Lethargy Gantherots +2",   -- ___, __, 52, 28, __ [10/10,  77]
    legs="Lethargy Fuseau +2",        -- ___, __, 53, 43, __ [__/__, 152]
    feet="Lethargy Houseaux +2",      -- ___, __, 50, 25, __ [__/__, 147]
    neck="Duelist's Torque +2",       -- ___, __, 30, 15, __ [__/__, ___]
    ear1="Malignance Earring",        -- ___, __, 10,  8,  4 [__/__, ___]
    ear2="Regal Earring",             -- ___, __, __, 10, __ [__/__, ___]
    ring1="Metamorph Ring +1",        -- ___, __, 15, 16, __ [__/__, ___]
    ring2="Stikini Ring +1",          -- ___,  8, 11, __, __ [__/__, ___]
    back="Aurist's Cape +1",          -- ___, __, 33, 33, __ [__/__, ___]
    waist="Acuity Belt +1",           -- ___, __, 15, 23, __ [__/__, ___]
    -- Empy set effect                   ___, __, __, __, __ [__/__, ___]
    -- Traits/Gifts/Merits            --                  38
    -- 255 M.Acc skill, 8 Elemental Skill, 512 M.Acc, 294 INT, 62 FC [33 PDT/33 MDT, 627 M.Eva]

    -- head="Lethargy Chappel +3",    -- ___, __, 61, 38, __ [10/10, 125]
    -- hands="Lethargy Gantherots +3",-- ___, __, 62, 50, __ [11/11,  87]
    -- legs="Lethargy Fuseau +3",     -- ___, __, 63, 48, __ [__/__, 162]
    -- feet="Lethargy Houseaux +3",   -- ___, __, 60, 30, __ [__/__, 157]
    -- 255 M.Acc skill, 8 Elemental Skill, 552 M.Acc, 331 INT, 62 FC [35 PDT/35 MDT, 667 M.Eva]
  }

  sets.buff.Saboteur = {
    hands="Lethargy Gantherots +2",
    -- hands="Lethargy Gantherots +3",
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Defense Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.HeavyDef = { -- Not counting weapons in totals because will not always be equippable (battle mode)
    main="Mpaca's Staff",             -- __/__, ___ [ 2]
    sub="Enki Strap",                 -- __/__,  10 [__]
    range=empty,                      -- __/__, ___ [__]
    ammo="Staunch Tathlum +1",        --  3/ 3, ___ [__]; Resist Status+11
    head="Bunzi's Hat",               --  7/ 7, 123 [__]
    body="Shamash Robe",              -- 10/__, 106 [ 3]; Resist Silence+90
    hands=gear.Nyame_B_hands,         --  7/ 7, 112 [__]
    legs=gear.Nyame_B_legs,           --  8/ 8, 150 [__]
    feet=gear.Nyame_B_feet,           --  7/ 7, 150 [__]
    neck="Loricate Torque +1",        --  6/ 6, ___ [__]; DEF+60
    ear1="Arete Del Luna +1",         -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Wuji Ring",                -- __/__, ___ [__]; Resists Charm/Sleep
    ring2="Defending Ring",           -- 10/10, ___ [__]
    back=gear.RDM_INT_Enf_Cape,       -- 10/__, ___ [__]
    waist="Carrier's Sash",           -- __/__, ___ [__]; Ele Resist+15
    -- 68 PDT/51 MDT, 641 M.Eva [3 Refresh]
    
    -- main="Sakpata's Sword",        -- 10/10, ___ [ 3]; R30
    -- sub="Sacro Bulwark",           -- 10/10, ___ [__]
    -- head="Lethargy Chappel +3",    -- 10/10, 125 [__]
    -- ring2="Shadow Ring",           -- __/__, ___ [__]; Occ. annuls magic dmg
    -- back="Shadow Mantle",          -- __/__, ___ [__]; Occ. annuls physical dmg
    -- 51 PDT/44 MDT, 643 M.Eva [3 Refresh]
  }

  sets.defense.PDT = set_combine(sets.HeavyDef, {})
  sets.defense.MDT = set_combine(sets.HeavyDef, {})


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- Technically, Prime sword Caliburnus has highest refresh
  
  -- Used when your weapons are locked "battle mode"
  sets.passive_refresh = {
    range=empty,                      -- __/__, ___ [__]
    ammo="Homiliary",                 -- __/__, ___ [ 1]
    head="Vitiation Chapeau +1",      -- __/__,  75 [ 2]
    body="Shamash Robe",              -- 10/__, 106 [ 3]; Resist Silence+90
    hands="Lethargy Gantherots +2",   -- 10/10,  77 [__]
    legs="Bunzi's Pants",             --  9/ 9, 150 [__]
    feet="Volte Gaiters",             -- __/__, 142 [ 1]
    neck="Sibyl Scarf",               -- __/__, ___ [ 1]
    ear1="Arete Del Luna +1",         -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",          -- __/__, ___ [ 1]
    ring2="Defending Ring",           -- 10/10, ___ [__]
    back=gear.RDM_INT_Enf_Cape,       -- 10/__, ___ [__]
    waist="Carrier's Sash",           -- __/__, ___ [__]; Ele Resist
    -- 49 PDT / 32 MDT, 550 M.Eva [9 Refresh]
    
    -- head="Vitiation Chapeau +3",   -- __/__,  95 [ 3]
    -- hands="Lethargy Gantherots +3",-- 11/11,  87 [__]
    -- 50 PDT / 33 MDT, 580 M.Eva [10 Refresh]
  }
  -- Used when your weapons are unlocked but cannot dual wield (sub SCH)
  sets.passive_refresh.Single = {
    main="Mpaca's Staff",             -- __/__, ___ [ 2]
    sub="Enki Strap",                 -- __/__,  10 [__]
    range=empty,                      -- __/__, ___ [__]
    ammo="Homiliary",                 -- __/__, ___ [ 1]
    head="Vitiation Chapeau +1",      -- __/__,  75 [ 2]
    body="Shamash Robe",              -- 10/__, 106 [ 3]; Resist Silence+90
    hands="Lethargy Gantherots +2",   -- 10/10,  77 [__]
    legs="Bunzi's Pants",             --  9/ 9, 150 [__]
    feet="Volte Gaiters",             -- __/__, 142 [ 1]
    neck="Sibyl Scarf",               -- __/__, ___ [ 1]
    ear1="Arete Del Luna +1",         -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",          -- __/__, ___ [ 1]
    ring2="Defending Ring",           -- 10/10, ___ [__]
    back=gear.RDM_INT_Enf_Cape,       -- 10/__, ___ [__]
    waist="Carrier's Sash",           -- __/__, ___ [__]; Ele Resist
    -- 49 PDT / 32 MDT, 560 M.Eva [11 Refresh]
    
    -- main="Sakpata's Sword",        -- 10/10, ___ [ 3]; R30
    -- sub="Sacro Bulwark",           -- 10/10, ___ [__]
    -- head="Vitiation Chapeau +3",   -- __/__,  95 [ 3]
    -- hands="Volte Gloves",          -- __/__,  96 [ 1]
    -- ring2="Stikini Ring +1",       -- __/__, ___ [ 1]
    -- 49 PDT / 32 MDT, 589 M.Eva [15 Refresh]
  }
  -- Used when weapons are unlocked and you can dual wield
  sets.passive_refresh.Dual = {
    main="Bolelabunga",               -- __/__, ___ [ 1]
    sub="Daybreak",                   -- __/__,  30 [ 1]
    range=empty,                      -- __/__, ___ [__]
    ammo="Homiliary",                 -- __/__, ___ [ 1]
    head="Vitiation Chapeau +1",      -- __/__,  75 [ 2]
    body="Shamash Robe",              -- 10/__, 106 [ 3]; Resist Silence+90
    hands="Lethargy Gantherots +2",   -- 10/10,  77 [__]
    legs="Bunzi's Pants",             --  9/ 9, 150 [__]
    feet="Volte Gaiters",             -- __/__, 142 [ 1]
    neck="Sibyl Scarf",               -- __/__, ___ [ 1]
    ear1="Arete Del Luna +1",         -- __/__, ___ [__]; Resists
    ear2="Etiolation Earring",        -- __/ 3, ___ [__]; Resist Silence+15
    ring1="Stikini Ring +1",          -- __/__, ___ [ 1]
    ring2="Defending Ring",           -- 10/10, ___ [__]
    back=gear.RDM_INT_Enf_Cape,       -- 10/__, ___ [__]
    waist="Carrier's Sash",           -- __/__, ___ [__]; Ele Resist
    -- 49 PDT / 32 MDT, 580 M.Eva [11 Refresh]
    
    -- main="Sakpata's Sword",        -- 10/10, ___ [ 3]; R30
    -- sub="Daybreak",                -- __/__,  30 [ 1]
    -- head="Vitiation Chapeau +3",   -- __/__,  95 [ 3]
    -- hands="Volte Gloves",          -- __/__,  96 [ 1]
    -- 49 PDT / 32 MDT, 619 M.Eva [15 Refresh]
  }
  sets.passive_refresh.sub50 = {
    waist="Fucho-no-Obi",             -- __/__, ___ [ 1]
  }

  sets.idle = set_combine(sets.HeavyDef, {})
  sets.idle.Refresh = set_combine(sets.idle, sets.passive_refresh)
  sets.idle.Refresh.MpSub50 = set_combine(sets.idle, sets.passive_refresh, sets.passive_refresh.sub50)

  sets.idle.Gyve = set_combine(sets.idle, {
    -- body="Gyve Doublet",
  })
  sets.idle.Gyve.Refresh = set_combine(sets.idle, sets.passive_refresh, {
    -- body="Gyve Doublet",
  })
  sets.idle.Gyve.Refresh.MpSub50 = set_combine(sets.idle, sets.passive_refresh, sets.passive_refresh.sub50, {
    -- body="Gyve Doublet",
  })

  sets.idle.RefreshSingle = set_combine(sets.idle, sets.passive_refresh.Single)
  sets.idle.RefreshSingle.MpSub50 = set_combine(sets.idle, sets.passive_refresh.Single, sets.passive_refresh.sub50)

  sets.idle.Gyve.RefreshSingle = set_combine(sets.idle, sets.passive_refresh.Single, {
    -- body="Gyve Doublet",
  })
  sets.idle.Gyve.RefreshSingle.MpSub50 = set_combine(sets.idle, sets.passive_refresh.Single, sets.passive_refresh.sub50, {
    -- body="Gyve Doublet",
  })

  sets.idle.RefreshDual = set_combine(sets.idle, sets.passive_refresh.Dual)
  sets.idle.RefreshDual.MpSub50 = set_combine(sets.idle, sets.passive_refresh.Dual, sets.passive_refresh.sub50)

  sets.idle.Gyve.RefreshDual = set_combine(sets.idle, sets.passive_refresh.Dual, {
    -- body="Gyve Doublet",
  })
  sets.idle.Gyve.RefreshDual.MpSub50 = set_combine(sets.idle, sets.passive_refresh.Dual, sets.passive_refresh.sub50, {
    -- body="Gyve Doublet",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Engaged Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  -- No DW (0 needed from gear)
  sets.engaged = {
    range=empty,                      -- __, __, __ <__, __, __> [__/__, ___]
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Anu Torque",                -- __,  7, __ <__, __, __> [__/__, ___]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RDM_STP_Cape,           -- __, 10, 30 <__, __, __> [10/__, ___]
    waist="Sailfi Belt +1",           -- __, __, __ < 5,  2, __> [__/__, ___]
    -- 0 DW, 83 STP, 275 Acc <16 DA, 5 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  }
  sets.engaged.MidAcc = set_combine(sets.engaged, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    ear2="Cessance Earring",          -- __,  3,  6 < 3, __, __> [__/__, ___]
    -- waist="Kentarch Belt +1",      -- __,  5, 14 < 3, __, __> [__/__, ___]
    -- 0 DW, 80 STP, 315 Acc <13 DA, 3 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  })
  sets.engaged.HighAcc = set_combine(sets.engaged, {
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    ear2="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 0 DW, 81 STP, 345 Acc <1 DA, 0 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  })

  -- Low DW (11 needed from gear)
  sets.engaged.LowDW = {
    range=empty,                      -- __, __, __ <__, __, __> [__/__, ___]
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Anu Torque",                -- __,  7, __ <__, __, __> [__/__, ___]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ear2="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RDM_STP_Cape,           -- __, 10, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 11 DW, 82 STP, 285 Acc <6 DA, 3 TA, 3 QA> [52 PDT/42 MDT, 682 M.Eva]
  }
  sets.engaged.LowDW.MidAcc = set_combine(sets.engaged.LowDW, {
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- neck="Lissome Necklace",       -- __,  4,  8 < 1, __, __> [__/__, ___]
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 11 DW, 73 STP, 323 Acc <5 DA, 3 TA, 3 QA> [52 PDT/42 MDT, 682 M.Eva]
  })
  sets.engaged.LowDW.HighAcc = set_combine(sets.engaged.LowDW.MidAcc, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    ear2="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
    waist="Olseni Belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 10 DW, 71 STP, 345 Acc <1 DA, 0 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  })

  -- Mid DW (18 needed from gear)
  sets.engaged.MidDW = {
    range=empty,                      -- __, __, __ <__, __, __> [__/__, ___]
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    neck="Anu Torque",                -- __,  7, __ <__, __, __> [__/__, ___]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___]
    ring1="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 17 DW, 77 STP, 285 Acc <11 DA, 3 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  }
  sets.engaged.MidDW.MidAcc = set_combine(sets.engaged.MidDW.MidAcc, {
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    -- neck="Lissome Necklace",       -- __,  4,  8 < 1, __, __> [__/__, ___]
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 17 DW, 68 STP, 323 Acc <10 DA, 3 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  })
  sets.engaged.MidDW.HighAcc = set_combine(sets.engaged.MidDW.HighAcc, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    ear2="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    -- 17 DW, 72 STP, 335 Acc <1 DA, 0 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  })

  -- High DW (31 needed from gear)
  sets.engaged.HighDW = {
    range=empty,                      -- __, __, __ <__, __, __> [__/__, ___]
    ammo="Staunch Tathlum +1",        -- __, __, __ <__, __, __> [ 3/ 3, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Malignance Gloves",        -- __, 12, 50 <__, __, __> [ 5/ 5, 112]
    legs="Malignance Tights",         -- __, 10, 50 <__, __, __> [ 7/ 7, 150]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Anu Torque",                -- __,  7, __ <__, __, __> [__/__, ___]
    ear1="Dedition Earring",          -- __,  8,-10 <__, __, __> [__/__, ___]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 31 DW, 66 STP, 271 Acc <0 DA, 0 TA, 3 QA> [51 PDT/41 MDT, 593 M.Eva]
  }
  sets.engaged.HighDW.MidAcc = set_combine(sets.engaged.HighDW, {
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    -- 31 DW, 60 STP, 291 Acc <1 DA, 0 TA, 3 QA> [51 PDT/41 MDT, 593 M.Eva]
  })
  sets.engaged.HighDW.HighAcc = set_combine(sets.engaged.HighDW.MidAcc, {
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    ear2="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    waist="Olseni belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 10 DW, 71 STP, 345 Acc <1 DA, 0 TA, 3 QA> [52 PDT/42 MDT, 674 M.Eva]
  })

  -- Super DW (42 needed from gear)
  sets.engaged.SuperDW = {
    range=empty,                      -- __, __, __ <__, __, __> [__/__, ___]
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Bunzi's Gloves",           -- __, __, 55 < 8, __, __> [ 8/ 8, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 41 DW, 32 STP, 291 Acc <11 DA, 0 TA, 3 QA> [50 PDT/40 MDT, 531 M.Eva]
  }
  sets.engaged.SuperDW.MidAcc = set_combine(sets.engaged.SuperDW, {
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    -- 32 DW, 42 STP, 325 Acc <8 DA, 0 TA, 3 QA> [48 PDT/38 MDT, 612 M.Eva]
  })
  sets.engaged.SuperDW.HighAcc = set_combine(sets.engaged.SuperDW.MidAcc, {
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    ear2="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    waist="Olseni belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 16 DW, 49 STP, 355 Acc <9 DA, 0 TA, 3 QA> [48 PDT/38 MDT, 610 M.Eva]
  })

  -- Max DW (49 needed from gear)
  sets.engaged.MaxDW = {
    range=empty,                      -- __, __, __ <__, __, __> [__/__, ___]
    ammo="Coiste Bodhar",             -- __,  3, __ < 3, __, __> [__/__, ___]
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123]
    body="Malignance Tabard",         -- __, 11, 50 <__, __, __> [ 9/ 9, 139]
    hands="Bunzi's Gloves",           -- __, __, 55 < 8, __, __> [ 8/ 8, 112]
    legs=gear.Carmine_D_legs,         --  6, __, 55 <__, __, __> [__/__,  80]
    feet=gear.Taeon_DW_feet,          --  9, __, 26 <__, __, __> [__/__,  69]
    neck="Loricate Torque +1",        -- __, __, __ <__, __, __> [ 6/ 6, ___]
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    ring1="Chirich Ring +1",          -- __,  6, 10 <__, __, __> [__/__, ___]
    ring2="Defending Ring",           -- __, __, __ <__, __, __> [10/10, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
    waist="Reiki Yotai",              --  7,  4, 10 <__, __, __> [__/__, ___]
    -- 41 DW, 32 STP, 291 Acc <11 DA, 0 TA, 3 QA> [50 PDT/40 MDT, 531 M.Eva]
  }
  sets.engaged.MaxDW.MidAcc = set_combine(sets.engaged.MaxDW, {
    -- ammo="Voluspa Tathlum",        -- __, __, 10 <__, __, __> [__/__, ___]
    feet="Malignance Boots",          -- __,  9, 50 <__, __, __> [ 4/ 4, 150]
    -- neck="Combatant's Torque",     -- __,  4, __ <__, __, __> [__/__, ___]; Combat skills+15
    -- 32 DW, 42 STP, 325 Acc <8 DA, 0 TA, 3 QA> [48 PDT/38 MDT, 612 M.Eva]
  })
  sets.engaged.MaxDW.HighAcc = set_combine(sets.engaged.MaxDW.MidAcc, {
    -- ear1="Telos Earring",          -- __,  5, 10 < 1, __, __> [__/__, ___]
    ear2="Dignitary's Earring",       -- __,  3, 10 <__, __, __> [__/__, ___]
    waist="Olseni belt",              -- __,  3, 20 <__, __, __> [__/__, ___]
    -- 16 DW, 49 STP, 355 Acc <9 DA, 0 TA, 3 QA> [48 PDT/38 MDT, 610 M.Eva]
  })

  --------------- En-Spell ---------------

  -- Consider Vitiation Tights if you use enspell merits
  sets.engaged.Enspell = set_combine(sets.engaged, {
    -- main="Crocea Mors",            -- __, __, 50 <__, __, __> [__/__, ___] (50, x6, __)
    -- sub="Gleti's Knife",           -- __, __, 55 <__,  6, __> [__/__, ___] (55, __, __); R30
    range="Ullr",                     -- __, __, __ <__, __, __> [__/__, ___] (40, __, __)
    ammo=empty,                       -- __, __, __ <__, __, __> [__/__, ___] (__, __, __)
    head="Bunzi's Hat",               -- __,  8, 55 <__, __,  3> [ 7/ 7, 123] (55, __, __); R30
    body="Lethargy Sayon +3",         -- __, __, 64 <__, __, __> [14/14, 136] (64, __, __)
    -- hands="Ayanmo Manopolas +2",   -- __, __, 43 <__, __, __> [ 3/ 3,  37] (43, 17, __)
    legs=gear.Nyame_B_legs,           -- __, __, 40 < 6, __, __> [ 8/ 8, 150] (40, __, __); R30
    feet=gear.Nyame_B_feet,           -- __, __, 53 < 5, __, __> [ 7/ 7, 150] (40, __, __); R30
    neck="Duelist's Torque +2",       -- __, __, __ <__, __, __> [__/__, ___] (30, __, __)
    -- ear1="Lycopodium Earring",     -- __, __, __ <__, __, __> [__/__, ___] ( 1,  2, __)
    ear2="Sherida Earring",           -- __,  5, __ < 5, __, __> [__/__, ___] (__, __, __)
    -- ring1="Hetairoi Ring",         -- __, __, __ <__,  2, __> [__/__, ___] (__, __, __)
    ring2="Epona's Ring",             -- __, __, __ < 3,  3, __> [__/__, ___] (__, __, __)
    back=gear.RDM_STP_Cape,           -- __, 10, 30 <__, __, __> [10/__, ___] (__, __, __)
    waist="Sailfi Belt +1",           -- __, __, __ < 5,  2, __> [__/__, ___] (__, __, __)
    -- Traits/merits/gifts            -- __, __, __ <__, __, __> [__/__, ___] (90,  7, 36)
    -- 0 DW, 23 STP, 390 Acc <24 DA, 13 TA, 3 QA> [49 PDT/39 MDT, 596 M.Eva] (508 M.Acc, 26 Enspell Dmg, 36 Enh Skill)

    -- ear2="Lethargy Earring +2",    -- __, __, 20 < 8, __, __> [__/__, ___] (20, __, __)
    -- waist="Orpheus's Sash",        -- __, __, __ <__, __, __> [__/__, ___] (__, __, __); Dmg+15%
  })
  -- Low DW (11 needed from gear)
  sets.engaged.LowDW.Enspell = set_combine(sets.engaged.Enspell, {
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
  })
  -- Mid DW (18 needed from gear)
  sets.engaged.MidDW.Enspell = set_combine(sets.engaged.Enspell, {
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
  })
  -- High DW (31 needed from gear)
  sets.engaged.HighDW.Enspell = set_combine(sets.engaged.Enspell, {
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
  })
  -- Super DW (42 needed from gear)
  sets.engaged.SuperDW.Enspell = set_combine(sets.engaged.Enspell, {
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
  })
  -- Max DW (49 needed from gear)
  sets.engaged.MaxDW.Enspell = set_combine(sets.engaged.Enspell, {
    ear1="Eabani Earring",            --  4, __, __ <__, __, __> [__/__,   8]
    ear2="Suppanomimi",               --  5, __, __ <__, __, __> [__/__, ___]
    back=gear.RDM_DW_Cape,            -- 10, __, 30 <__, __, __> [10/__, ___]
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.buff.Doom = {
    neck="Nicander's Necklace",     --20
    ring1="Eshmun's Ring",          --20
    waist="Gishdubar Sash",         --10
  }

  sets.Obi = {
    waist="Hachirin-no-Obi"
  }

  sets.TreasureHunter = {
    ammo="Perfect Lucky Egg",
    body=gear.Merl_TH_body,   -- 2
    waist="Chaac Belt",
  }

  sets.Kiting = {
    ring1="Shneddick Ring",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }

  --Weapon sets
  sets.WeaponSet = {}
  sets.WeaponSet['Savage Blade'] = {
    main="Naegling",
    sub="Ammurapi Shield",
  }
  sets.WeaponSet['Savage Blade'].DW = {
    main="Naegling",
    sub="Tauret",
    -- sub="Thibron",
  }
  sets.WeaponSet['Seraph Blade'] = {
    main="Naegling",
    sub="Culminus",
    -- main="Crocea Mors",
  }
  sets.WeaponSet['Seraph Blade'].DW = {
    main="Naegling",
    sub="Daybreak",
    -- main="Crocea Mors",
  }
  sets.WeaponSet['Black Halo'] = {
    main="Maxentius",
    sub="Ammurapi Shield",
  }
  sets.WeaponSet['Black Halo'].DW = {
    main="Maxentius",
    sub="Naegling",
    -- sub="Thibron",
  }
  sets.WeaponSet['Asuran Fists'] = {
    -- main="Karambit",
  }
  sets.WeaponSet['Enspell'] = {
    main="Naegling",
    sub="Ammurapi Shield",
    -- main="Crocea Mors",
  }
  sets.WeaponSet['Enspell'].DW = {
    main="Naegling",
    sub="Tauret",
    -- main="Crocea Mors",
    -- sub="Gleti's Knife",
  }
  sets.WeaponSet['Cleaving'] = {
    main="Tauret",
    sub="Culminus",
  }
  sets.WeaponSet['Cleaving'].DW = {
    main="Tauret",
    sub="Bunzi's Rod",
  }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell, action, spellMap, eventArgs)
  -- If missing a target, or targeting an invalid target, switch target to <me>, <stpc>, or <stnpc> as appropriate
  if spell.action_type == 'Magic' and (
    (spell.target.raw == '<t>' and not spell.target.type)
    or (spell.target.type == 'MONSTER' and not spell.targets.Enemy)
    or (spell.target.type == 'SELF' and not spell.targets.Self)
    or (spell.target.type == 'PLAYER' and not (spell.targets.Player or spell.targets.Ally or spell.targets.Party))
    or (spell.target.hpp and spell.target.hpp > 0 and spell.targets.Corpse)
    or (spell.target.hpp and spell.target.hpp == 0 and not spell.targets.Corpse)
  ) then
    local new_target
    if spell.targets.Enemy then
      new_target = '<stnpc>'
    end
    if spell.targets.Self then
      new_target = '<me>'
    end
    if spell.targets.Party or spell.targets.Corpse then
      new_target = '<stpc>'
    end
    -- Cancel current spell and reissue command with new target
    send_command('@input /ma "'..spell.english..'" '..new_target)
    eventArgs.cancel = true
  end
end

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  refine_various_spells(spell, action, spellMap, eventArgs)

  if spell.english == 'Addendum: White' and not state.Buff['Light Arts'] then
    send_command('input /ja "Light Arts" <me>')
    eventArgs.cancel = true
  elseif spell.english == 'Addendum: Dark' and not state.Buff['Dark Arts'] then
    send_command('input /ja "Dark Arts" <me>')
    eventArgs.cancel = true
  elseif spellMap == 'Utsusemi' then
    if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
      cancel_spell()
      add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
      eventArgs.handled = true
      return
    elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
      send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
    end
  elseif spell.english == 'Stun' and buffactive['Chainspell'] then
    equip(sets.midcast.Stun)
    eventArgs.handled = true
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  -- Always put this last in job_post_precast
  if in_battle_mode() and spell.english ~= 'Dispelga' then
    -- Prevent swapping main/sub weapons
    equip({main="", sub=""})
    silibs.prevent_ammo_tp_loss()
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
    local selected_set
    if spellMap == 'Cure' or spellMap == 'Curaga' then
      if (world.weather_element == 'Light' and not (get_weather_intensity() < 2 and world.day_element == 'Dark'))
          or (world.day_element == 'Light' and not world.weather_element == 'Dark') then
        selected_set = 'CureWeather'
      else
        selected_set = 'CureNormal' --Can't call it Cure as gs checks for sets.midcast.Cure before calling job_get_spell_map
      end
      
      if in_battle_mode() then
        selected_set = selected_set..'WeaponLock'
      end
    elseif spell.skill == 'Enfeebling Magic' then
      if enfeebling_skill_spells:contains(spell.english) then
        selected_set = 'SkillEnfeebles'
      else
        -- Get stat mapping
        local stat = enfeebling_stat_map[spell.english]
        if stat then
          if state.Buff.Stymie
              or enfeebling_duration_spells:contains(spell.english)
              or (spell.english:startswith('Sleep') and state.SleepMode.value == 'MaxDuration') then
                selected_set = stat..'EnfeeblesDuration'
          elseif not state.Buff.Stymie and (state.CastingMode.value == 'Resistant' or enfeebling_default_acc_spells:contains(spell.english)) then
            selected_set = stat..'EnfeeblesAcc'
          else
            selected_set = stat..'Enfeebles'
          end
        else
          selected_set = 'MNDEnfeebles'
        end
      end
      
      --Handle DW gear sets for enfeebling
      if silibs.can_dual_wield() and not in_battle_mode() then
        if spell.skill == 'Enfeebling Magic' and sets.midcast[selected_set..'DW'] then
          selected_set = selected_set..'DW'
        end
      end
    elseif spell.skill == 'Enhancing Magic' then
      if enhancing_skill_spells:contains(spell.english) then
        selected_set = 'SkillEnhancing'
      elseif spell.english:startswith('Gain') then
        selected_set = 'GainSpell'
      elseif spell.english:contains('Spikes') then
        selected_set = 'SpikesSpell'
      elseif spell.english == 'Phalanx' or spell.english == 'Phalanx II' then
        if spell.target.type == 'SELF' then
          selected_set = 'PhalanxSelf'
        else
          if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and state.Buff.Composure then
            selected_set = 'ComposureOther'
          else
            selected_set = 'PhalanxOthers'
          end
        end
      elseif spellMap == 'Refresh' then
        if spell.target.type == 'SELF' then
          selected_set = 'RefreshSelf'
        else
          if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and state.Buff.Composure then
            selected_set = 'RefreshOthersComp'
          else
            selected_set = 'RefreshOthers' --Can't call it Refresh as gs checks for sets.midcast.Refresh before calling job_get_spell_map
          end
        end
      else
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and state.Buff.Composure then
          selected_set = 'ComposureOther'
        else
          selected_set = 'EnhancingDuration'
        end
      end
    elseif spell.skill == 'Elemental Magic' then
      -- Add magic burst set if exists
      if state.MagicBurst.value and (
        spellMap ~= 'ElementalEnfeeble'
        and spell.english ~= 'Impact'
        and spell.english ~= 'Meteor'
      ) then
        local customEquipSet = select_specific_set(sets.midcast, spell, spellMap)
        -- Add optional casting mode
        if customEquipSet[state.CastingMode.current] then
          customEquipSet = customEquipSet[state.CastingMode.current]
        end
  
        if customEquipSet['MB'] then
          equip(customEquipSet['MB'])
          eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
        end
      end
    end

    if selected_set and sets.midcast[selected_set] then
      equip(sets.midcast[selected_set])
      eventArgs.handled=true -- Prevents Mote lib from overwriting the equipSet
    end
  end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
  -- print("Spell: "..spell.english)
  -- print("Target: "..spell.target.type)
  if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
    equip(sets.buff.Saboteur)
  elseif spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' and spell.english ~= 'Impact'
      and silibs.can_dual_wield() and not in_battle_mode() then
    equip(sets.midcast['Elemental Magic'].DW)
  end
  
  -- Always put this last in job_post_midcast
  if in_battle_mode() and spell.english ~= 'Dispelga' then
    -- Prevent swapping main/sub weapons
    equip({main="", sub=""})
    silibs.prevent_ammo_tp_loss()
  end
  
  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
  last_midcast_set = set_combine(gearswap.equip_list, {})
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if not spell.interrupted then
    if in_battle_mode() and spell.english == 'Dispelga' then
      equip(select_weapons())
    elseif spell.skill == 'Enfeebling Magic' then
      set_enfeeble_timer(spell)
    elseif spell.english == 'Light Arts' then
      state.Buff['Light Arts'] = true
      state.Buff['Dark Arts'] = false
      state.Buff['Addendum: White'] = false
      state.Buff['Addendum: Black'] = false
    elseif spell.english == 'Dark Arts' then
      state.Buff['Light Arts'] = false
      state.Buff['Dark Arts'] = true
      state.Buff['Addendum: White'] = false
      state.Buff['Addendum: Black'] = false
    elseif spell.english == 'Addendum: White' then
      state.Buff['Light Arts'] = false
      state.Buff['Dark Arts'] = false
      state.Buff['Addendum: White'] = true
      state.Buff['Addendum: Black'] = false
    elseif spell.english == 'Addendum: Black' then
      state.Buff['Light Arts'] = false
      state.Buff['Dark Arts'] = false
      state.Buff['Addendum: White'] = false
      state.Buff['Addendum: Black'] = true
    elseif spell.english == 'Composure' then
      state.Buff.Composure = true
    elseif spell.english == 'Saboteur' then
      state.Buff.Saboteur = true
    elseif spell.english == 'Stymie' then
      state.Buff.Stymie = true
    end
  end
    
  if in_battle_mode() then
    equip(sets.WeaponSet[state.WeaponSet.current])
  end
end

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
function job_buff_change(buff, gain)
  if buff == "doom" and gain then
    equip(sets.buff.Doom)
  end
end

-- Handle notifications of general user state change.
-- Called by mote-selfcommands
function job_state_change(stateField, newValue, oldValue)
    -- print(stateField.." is now ",newValue)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
  silibs.update_combat_form()
end

function update_idle_groups()
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')
                        or classes.CustomIdleGroups:contains('RefreshSingle')
                        or classes.CustomIdleGroups:contains('RefreshDual')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
    if (isRegening==true and player.hpp < 100) or (isRegening==false and player.hpp < 85) then
      classes.CustomIdleGroups:append('Regen')
    end
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if (isRefreshing==true and player.mpp < 100) or (isRefreshing==false and player.mpp < 85) then
        local weapon_mode = ''
        if not in_battle_mode() then
          weapon_mode = (silibs.can_dual_wield() and 'Dual') or 'Single'
        end
        classes.CustomIdleGroups:append('Refresh'..weapon_mode)
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

function refine_various_spells(spell, action, spellMap, eventArgs)
  -- If casting Phalanx II on self, switch it to Phalanx. This will allow Accessions to work and there
  -- is no functional difference between the spell potencies.
  if spell.english == 'Phalanx II' and ((spell.target.raw == '<t>' and not spell.target.type) or spell.target.type == 'SELF') then
    send_command('@input /ma "Phalanx" <me>')
    eventArgs.cancel = true
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

  if in_battle_mode() then
    idleSet = set_combine(idleSet, select_weapons())
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

  if in_battle_mode() then
    meleeSet = set_combine(meleeSet, select_weapons())
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

  if in_battle_mode() then
    defenseSet = set_combine(defenseSet, select_weapons())
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

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

  if cmdParams[1] == 'scholar' then
    handle_strategems(cmdParams)
    eventArgs.handled = true
  elseif cmdParams[1] == 'elemental' then
    silibs.handle_elemental(cmdParams, state.ElementalMode.value)
    eventArgs.handled = true
  elseif cmdParams[1] == 'barelement' then
    send_command('@input /ma '..state.BarElement.value..' <me>')
  elseif cmdParams[1] == 'barstatus' then
    send_command('@input /ma '..state.BarStatus.value..' <me>')
  elseif cmdParams[1] == 'gainspell' then
    send_command('@input /ma '..state.GainSpell.value..' <me>')
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
  elseif cmdParams[1] == 'toyweapon' then
    if cmdParams[2] == 'cycle' then
      cycle_toy_weapons('forward')
    elseif cmdParams[2] == 'cycleback' then
      cycle_toy_weapons('back')
    elseif cmdParams[2] == 'reset' then
      cycle_toy_weapons('reset')
    end
  elseif cmdParams[1] == 'bind' then
    set_main_keybinds()
    set_sub_keybinds()
    print('Set keybinds!')
  elseif cmdParams[1] == 'test' then
    test()
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
    if state.Buff['Light Arts'] then
      send_command('input /ja "Addendum: White" <me>')
    elseif state.Buff['Addendum: White'] then
      add_to_chat(122,'Error: Addendum: White is already active.')
    else
      send_command('input /ja "Light Arts" <me>')
    end
  elseif strategem == 'dark' then
    if state.Buff['Dark Arts'] then
      send_command('input /ja "Addendum: Black" <me>')
    elseif state.Buff['Addendum: Black'] then
      add_to_chat(122,'Error: Addendum: Black is already active.')
    else
      send_command('input /ja "Dark Arts" <me>')
    end
  elseif state.Buff['Light Arts'] or state.Buff['Addendum: White'] then
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
  elseif state.Buff['Dark Arts'] or state.Buff['Addendum: Black'] then
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

function cycle_weapons(cycle_dir)
  if cycle_dir == 'forward' then
    state.WeaponSet:cycle()
  elseif cycle_dir == 'back' then
    state.WeaponSet:cycleback()
  elseif cycle_dir == 'reset' then
    state.WeaponSet:reset()
  end

  add_to_chat(141, 'Weapon Set to '..string.char(31,1)..state.WeaponSet.current)
  equip(select_weapons())
end

function cycle_toy_weapons(cycle_dir)
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

function select_weapons()
  if state.ToyWeapons.current ~= 'None' then
    return sets.ToyWeapon[state.ToyWeapons.current]
  else
    if silibs.can_dual_wield() and sets.WeaponSet[state.WeaponSet.current] and sets.WeaponSet[state.WeaponSet.current].DW then
      return sets.WeaponSet[state.WeaponSet.current].DW
    elseif sets.WeaponSet[state.WeaponSet.current] then
      return sets.WeaponSet[state.WeaponSet.current]
    end
  end
  return {}
end

function in_battle_mode()
  return state.WeaponSet.current ~= 'Casting' or state.ToyWeapons.current ~= 'None'
end

function get_enfeebling_duration(spell, set)
  local base, gear_mult, aug_mult, empy_mult, empy_count = spell.duration, 1, 1, 1, 0

  -- Reduce set to names only
  for k,v in pairs(set) do
    set[k] = (type(v)=='table' and v.name) or (type(v)=='string' and v) or nil
    if set[k] == 'empty' then set[k] = nil end
  end

  -- Saboteur bonus
  if state.Buff.Saboteur then
    if set.hands and saboteur_bonus_gear[set.hands] then
      base = base * saboteur_bonus_gear[set.hands][state.NM.value and 'nm' or 'normal']
    else
      if state.NM.value then
        base = base * 1.25
      else
        base = base * 2.00
      end
    end
  end

  -- Merit Points Duration Bonus
  base = base + (player.merits.enfeebling_magic_duration * 6)

  -- Job Points Duration Bonus
  base = base + (player.job_points.rdm.enfeebling_magic_duration)

  -- Stymie bonus
  if state.Buff.Stymie then
    base = base + player.job_points.rdm.stymie_effect
  end

  -- Relic head bonus
  if set.head and set.head:startswith('Vitiation') then
    base = base + (player.merits.enfeebling_magic_duration * 3)
  end

  -- Calculate gear multipliers
  for k,v in pairs(set) do
    local stats = enfeebling_dur_gear[v]
    if stats then
      gear_mult = gear_mult + stats.base
      aug_mult = aug_mult + stats.aug
    end

    -- Check if empy gear
    if (k == 'head' or k == 'body' or k == 'hands' or k == 'legs' or k == 'feet')
      and (v:startswith('Lethargy') or v:startswith('Estoquer'))
    then
      empy_count = empy_count + 1
    end
  end

  if state.Buff.Composure then
    empy_mult = empy_duration_mult[empy_count]
  end

  -- For debugging:
  -- add_to_chat(1, spell.english..' Set: '..inspect(set, {depth=2}))
  -- add_to_chat(1, spell.english
  --     ..' Base: ' ..base
  --     ..' Gear: '..gear_mult
  --     ..' Aug: '..aug_mult
  --     ..' Empy: '..empy_mult)

  local totalDuration = math.floor(base * gear_mult * aug_mult * empy_mult)
  return totalDuration
end

function set_enfeeble_timer(spell)
  -- Create the custom timer
  if enf_timer_spells:contains(spell.english) then
    local totalDuration = get_enfeebling_duration(spell, last_midcast_set)
    -- add_to_chat(1, spell.english..' duration: '..totalDuration)
    send_command('@timers c "'..spell.english..' ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00'..spell.id..'.png')
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
  set_macro_page(1, 8)
end

function set_main_keybinds()
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c interact')
  send_command('bind @w gs c toggle RearmingLock')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')
  send_command('bind !delete gs c weaponset reset')

  send_command('bind ^home gs c toyweapon cycle')
  send_command('bind ^end gs c toyweapon cycleback')
  send_command('bind !end gs c toyweapon reset')

  send_command('bind ^pageup gs c cycleback ElementalMode')
  send_command('bind ^pagedown gs c cycle ElementalMode')
  send_command('bind !pagedown gs c reset ElementalMode')

  send_command('bind ^` gs c cycle treasuremode')
  send_command('bind @c gs c toggle CP')
  send_command('bind !` gs c toggle MagicBurst')
  send_command('bind @s gs c cycle SleepMode')
  send_command('bind @n gs c toggle NM')

  send_command('bind ~` input /ja "Composure" <me>')

  send_command('bind !z input /ma "Temper II" <me>')
  send_command('bind !x gs c elemental enspell')
  send_command('bind !q gs c elemental tier3')
  send_command('bind !w gs c elemental tier')
  send_command('bind !e input /ma "Haste II" <stpc>')
  send_command('bind !r input /ma "Dispel" <t>')
  send_command('bind !u input /ma Blink <me>')
  send_command('bind !i input /ma Stoneskin <me>')
  send_command('bind !o input /ma "Phalanx II" <stpc>')
  send_command('bind !p input /ma "Aquaveil" <me>')
  send_command('bind !; input /ma "Regen II" <stpc>')
  send_command('bind !\' input /ma "Refresh III" <stpc>')
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
  end
end

function unbind_keybinds()
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')

  send_command('unbind ^insert')
  send_command('unbind ^delete')
  send_command('unbind !delete')

  send_command('unbind ^home')
  send_command('unbind ^end')
  send_command('unbind !end')

  send_command('unbind ^pageup')
  send_command('unbind ^pagedown')
  send_command('unbind !pagedown')

  send_command('unbind ^`')
  send_command('unbind @c')
  send_command('unbind !`')
  send_command('unbind @s')
  send_command('unbind @n')

  send_command('unbind ~`')

  send_command('unbind !z')
  send_command('unbind !x')
  send_command('unbind !q')
  send_command('unbind !w')
  send_command('unbind !e')
  send_command('unbind !r')
  send_command('unbind !u')
  send_command('unbind !i')
  send_command('unbind !o')
  send_command('unbind !p')
  send_command('unbind !;')
  send_command('unbind !\'')
  
  send_command('unbind !c')
  send_command('unbind !/')
  send_command('unbind ^-')
  send_command('unbind ^=')
  send_command('unbind ^[')
  send_command('unbind ^\\\\')
  send_command('unbind ![')
  send_command('unbind !\\\\')
end

function test()
end
