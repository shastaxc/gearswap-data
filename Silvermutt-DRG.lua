-- Original: Motenten/Arislan || Modified: Silvermutt

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
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_outranged_ws()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(12)
  silibs.enable_premade_commands()
  silibs.enable_th()

  state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
  state.WeaponskillMode:options('Normal', 'Acc')
  state.HybridMode:options('Normal', 'LightDef')
  state.IdleMode:options('Normal', 'LightDef')
  state.AttCapped = M(true, "Attack Capped")
  state.CP = M(false, "Capacity Points Mode")
  
  state.ToyWeapons = M{['description']='Toy Weapons','None','Dagger',
      'Sword','Club','Staff','Polearm','GreatSword','Scythe'}
  
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
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

  wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
      'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
  wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  state.WeaponSet = M{['description']='Weapon Set', 'Shining One', 'Naegling', 'Staff'}

  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Hasso" <me>')
  end

  if player.sub_job == 'WAR' then
    send_command('bind !w input /ja "Defender" <me>')
    send_command('bind ^numpad/ input /ja "Berserk" <me>')
    send_command('bind ^numpad* input /ja "Warcry" <me>')
    send_command('bind ^numpad- input /ja "Aggressor" <me>')
  elseif player.sub_job == 'SAM' then
    send_command('bind !w input /ja "Third Eye" <me>')
    send_command('bind ^numpad/ input /ja "Meditate" <me>')
    send_command('bind ^numpad* input /ja "Sekkanoki" <me>')
    send_command('bind ^numpad- input /ja "Hasso" <me>')
  end

  send_command('bind !` input /ja "Call Wyvern" <me>')
  send_command('bind !q input /ja "Spirit Link" <me>')
  send_command('bind ^q input /ja "Steady Wing" <me>')
  send_command('bind !e input /ja "Ancient Circle" <me>')
  send_command('bind !r input /ja "Dragon Breaker" <me>')

  update_melee_groups()
  select_default_macro_book()
end

function user_unload()
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
  send_command('unbind !w')
  send_command('unbind ^numpad/')
  send_command('unbind ^numpad*')
  send_command('unbind ^numpad-')
  
  send_command('unbind !`')
  send_command('unbind !q')
  send_command('unbind ^q')
  send_command('unbind !e')
  send_command('unbind !r')
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
    hands="Peltast's Vambraces +1",
    -- head="Vishap Armet +3",
    -- feet="Pteroslaver Greaves +3",
    -- ear1="Pratik Earring",
  }

  -- A tic must pass with the HP+ equipment still on before the HP gains are counted for the ability.
  sets.precast.JA['Steady Wing'] = {
    body=gear.Emicho_D_body,
    -- hands="Despair Finger Gauntlets",
    -- legs="Vishap Brais +3",
    -- feet="Pteroslaver Greaves +3",
    -- neck="Chanoix's Gorget",
    -- ear1="Lancer's Earring",
    -- ear2="Anastasi Earring",
    -- back=gear.DRG_Adoulin_Cape,
  }

  sets.precast.JA['Jump'] = {
    ammo="Aurgelmir Orb",
    head="Flamma Zucchetto +2",
    body="Pteroslaver Mail +1",
    hands="Gleti's Gauntlets",
    legs="Pteroslaver Brais +1",
    feet="Flamma Gambieras",
    neck="Anu Torque",
    ear1="Telos Earring",
    ear2="Sherida Earring",
    ring1="Petrov Ring",
    ring2="Niqmaddu Ring",
    back=gear.DRG_STP_Cape,
    waist="Ioskeha Belt +1",
    -- ammo="Aurgelmir Orb +1",
    -- body="Pteroslaver Mail +3",
    -- hands="Vishap Finger Gauntlets +3",
    -- legs="Pteroslaver Brais +3",
    -- feet="Ostro Greaves",
    -- neck="Vim Torque +1",
  }
  sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
  sets.precast.JA['Spirit Jump'] = set_combine(sets.precast.JA['Jump'], {
    feet="Peltast's Schynbalds +1",
  })
  sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {
    legs="Pteroslaver Brais +1",
    -- body="Vishap Mail +3",
    -- hands=gear.Acro_STP_hands,
    -- legs="Pteroslaver Brais +3",
  })
  sets.precast.JA['Super Jump'] = {}

  sets.precast.JA['Angon'] = {
    hands="Pteroslaver Finger Gauntlets +1",
    -- ammo="Angon",
    -- hands="Pteroslaver Finger Gauntlets +3",
    -- ear2="Dragoon's Earring",
  }

  -- Fast cast sets for spells
  sets.precast.FC = {
    hands=gear.Leyline_Gloves, --8
    legs="Ayanmo Cosciales +2", --6
    feet=gear.Carmine_D_feet, --8
    neck="Orunmila's Torque", --5
    ear1="Loquacious Earring", --2
    -- ammo="Sapience Orb", --2
    -- head=gear.Carmine_D_head, --14
    -- body="Sacro Breastplate", --10
    -- ear2="Enchanter's Earring +1", --2
  }


  ------------------------------------------------------------------------------------------------
  ------------------------------------- Weapon Skill Sets ----------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.precast.WS = {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body="Gleti's Cuirass",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Dragoon's Collar +2",
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Epaminondas's Ring",
    back=gear.DRG_WS2_Cape,
    waist="Sailfi Belt +1",
    -- head="Pteroslaver Armet +3",
  }
  sets.precast.WS.MaxTP = set_combine(sets.precast.WS, {
    ear2="Ishvara Earring",
  })
  sets.precast.WS.AttCapped = set_combine(sets.precast.WS, {
    head="Gleti's Mask",
  })
  sets.precast.WS.AttCappedMaxTP = set_combine(sets.precast.WS.AttCapped, {
    ear2="Ishvara Earring",
  })
  
  sets.precast.WS["Savage Blade"] = sets.precast.WS
  sets.precast.WS["Savage Blade"].MaxTP = sets.precast.WS.MaxTP
  sets.precast.WS["Savage Blade"].AttCapped = sets.precast.WS.AttCapped
  sets.precast.WS["Savage Blade"].AttCappedMaxTP = sets.precast.WS.AttCappedMaxTP

  -- 85% STR; 0.75-1.75 fTP; 4 hit physical
  sets.precast.WS["Stardiver"] = {
    ammo="Knobkierrie",
    head="Flamma Zucchetto +2",
    body="Gleti's Cuirass",
    hands="Sulevia's Gauntlets +2",
    legs="Sulevia's Cuisses +2",
    feet=gear.Lustratio_D_feet,
    neck="Fotia Gorget",
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    back=gear.DRG_WS2_Cape,
    waist="Fotia Belt",
    -- ammo="Coiste Bodhar",
    -- head="Pteroslaver Armet +3",
    -- back=gear.DRG_WS1_Cape,
  }
  sets.precast.WS["Stardiver"].MaxTP = set_combine(sets.precast.WS.MaxTP, {
    ear2="Brutal Earring",
    -- ammo="Coiste Bodhar",
    -- back=gear.DRG_WS1_Cape,
  })
  sets.precast.WS["Stardiver"].AttCapped = set_combine(sets.precast.WS.AttCapped, {
    ammo="Crepuscular Pebble",
    head="Flamma Zucchetto +2",
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Flamma Gambieras +2",
    neck="Dragoon's Collar +2",
    -- back=gear.DRG_WS1_Cape,
  })
  sets.precast.WS["Stardiver"].AttCappedMaxTP = set_combine(sets.precast.WS.AttCappedMaxTP, {
    ear2="Brutal Earring",
    -- back=gear.DRG_WS1_Cape,
  })

  -- 60% STR / 60% VIT; 1 hit physical; Ignores 12.5-62.5% defense based on TP
  sets.precast.WS["Camlann's Torment"] = {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Dragoon's Collar +2",
    ear1="Thrud Earring",
    ear2="Ishvara Earring",
    ring1="Epaminondas's Ring",
    ring2="Niqmaddu Ring",
    back=gear.DRG_WS2_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS["Camlann's Torment"].MaxTP = set_combine(sets.precast.WS["Camlann's Torment"], {})
  sets.precast.WS["Camlann's Torment"].AttCapped = set_combine(sets.precast.WS["Camlann's Torment"], {
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    legs="Gleti's Breeches",
  })
  sets.precast.WS["Camlann's Torment"].AttCappedMaxTP = set_combine(sets.precast.WS["Camlann's Torment"].AttCapped, {})

  sets.precast.WS["Sonic Thrust"] = {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    ear1="Thrud Earring",
    ear2="Moonshade Earring",
    ring1="Epaminondas's Ring",
    ring2="Niqmaddu Ring",
    back=gear.DRG_WS2_Cape,
    waist="Fotia Belt",
    -- neck="Dragoon's Collar +2",
  }
  sets.precast.WS["Sonic Thrust"].MaxTP = set_combine(sets.precast.WS["Sonic Thrust"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Sonic Thrust"].AttCapped = set_combine(sets.precast.WS["Sonic Thrust"], {
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    legs="Gleti's Breeches",
  })
  sets.precast.WS["Sonic Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Sonic Thrust"].AttCapped, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS["Impulse Drive"] = {
    ammo="Knobkierrie",
    body="Gleti's Cuirass",
    hands=gear.Nyame_B_hands,
    legs="Sulevia's Cuisses +2",
    feet=gear.Nyame_B_feet,
    ear1="Sherida Earring",
    ear2="Moonshade Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    back=gear.DRG_WS2_Cape,
    waist="Sailfi Belt +1",
    -- head="Pteroslayer Armet +3",
    -- neck="Dragoon's Collar +2",
  }
  sets.precast.WS["Impulse Drive"].MaxTP = set_combine(sets.precast.WS["Impulse Drive"], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS["Impulse Drive"].AttCapped = set_combine(sets.precast.WS["Impulse Drive"], {
    head="Gleti's Mask",
    hands="Gleti's Gauntlets",
    legs="Gleti's Breeches",
    feet="Gleti's Boots",
    ring1="Epaminondas's Ring",
  })
  sets.precast.WS["Impulse Drive"].AttCappedMaxTP = set_combine(sets.precast.WS["Impulse Drive"].AttCapped, {
    ear2="Ishvara Earring",
  })

  sets.precast.WS["Geirskogul"] = {
    ammo="Knobkierrie",
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    neck="Fotia Gorget",
    ear1="Thrud Earring",
    ear2="Sherida Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    back=gear.DRG_WS2_Cape,
    waist="Fotia Belt",
  }
  sets.precast.WS["Geirskogul"].MaxTP = set_combine(sets.precast.WS["Geirskogul"], {})
  sets.precast.WS["Geirskogul"].AttCapped = set_combine(sets.precast.WS["Geirskogul"], {
    head="Gleti's Mask",
    body="Gleti's Cuirass",
    feet="Gleti's Boots",
    ring2="Epaminondas's Ring",
    -- neck="Dragoon's Collar +2",
  })
  sets.precast.WS["Geirskogul"].AttCappedMaxTP = set_combine(sets.precast.WS["Geirskogul"].AttCapped, {})

  sets.precast.WS["Drakesbane"] = {
    ammo="Knobkierrie",
    hands="Gleti's Gauntlets",
    feet="Gleti's Boots",
    ear1="Thrud Earring",
    ear2="Sherida Earring",
    ring1="Regal Ring",
    ring2="Niqmaddu Ring",
    waist="Sailfi Belt +1",
    -- head="Blistering Sallet +1",
    -- body="Hjarrandi Breastplate",
    -- legs="Peltast's Cuissots +1",
    -- back=gear.DRG_WS3_Cape,
  }
  sets.precast.WS["Drakesbane"].MaxTP = set_combine(sets.precast.WS["Drakesbane"], {})
  sets.precast.WS["Drakesbane"].AttCapped = set_combine(sets.precast.WS["Drakesbane"], {
    ammo="Crepuscular Pebble",
    head="Gleti's Mask",
    body="Gleti's Cuirass",
  })
  sets.precast.WS["Drakesbane"].AttCappedMaxTP = set_combine(sets.precast.WS["Drakesbane"].AttCapped, {})

  -- Deals lightning elemental damage. Damage varies with TP. 1.0-3.0 fTP
  sets.precast.WS["Raiden Thrust"] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum", --4
    head=gear.Nyame_B_head, --30
    body=gear.Nyame_B_body,         -- __, 30, __, 10
    hands=gear.Nyame_B_hands, --30
    legs=gear.Nyame_B_legs,         -- __, 30, __,  9
    feet=gear.Nyame_B_feet, --30
    neck="Baetyl Pendant", --13
    ear1="Friomisi Earring",        -- __, 10, __, __
    ear2="Novio Earring", --7
    ring1="Shiva Ring +1",          -- __,  3, __, __
    ring2="Epaminondas's Ring",
    back="Argochampsa Mantle",      -- __, 12, __, __
    waist="Skrymir Cord", --5
    -- back=gear.MNK_MAB_Cape, --10
    -- waist="Skrymir Cord +1",     -- __,  7, 35, __
  })
  sets.precast.WS["Raiden Thrust"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Raiden Thrust"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Raiden Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  sets.precast.WS["Thunder Thrust"] = sets.precast.WS["Raiden Thrust"]
  sets.precast.WS["Thunder Thrust"].MaxTP = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].AttCapped = set_combine(sets.precast.WS["Raiden Thrust"], {})
  sets.precast.WS["Thunder Thrust"].AttCappedMaxTP = set_combine(sets.precast.WS["Raiden Thrust"].AttCapped, {})

  -- Cataclysm: 30% STR/30% INT, 2.75-5.0 fTP, 1 hit (aoe-magical)
  -- Stack MAB > WSD
  sets.precast.WS["Cataclysm"] = set_combine(sets.precast.WS["Raiden Thrust"], {
    ammo="Knobkierrie",             -- __, __, __,  6
    head="Pixie Hairpin +1",        -- 28, __, __, __
    neck="Fotia Gorget",              -- __, __, __, __; FTP bonus
    ear2="Moonshade Earring",       -- __, __, __, __; TP bonus
    ring2="Archon Ring",            --  5, __, __, __
    waist="Skrymir Cord",           -- __,  5, 30, __
    -- ammo="Ghastly Tathlum +1",   -- __, __, 21, __
    -- waist="Skrymir Cord +1",     -- __,  7, 35, __
  })
  sets.precast.WS["Cataclysm"].MaxTP = set_combine(sets.precast.WS["Cataclysm"], {
    ear2="Novio Earring",           -- __,  7, __, __
  })
  sets.precast.WS["Cataclysm"].AttCapped = sets.precast.WS["Cataclysm"]
  sets.precast.WS["Cataclysm"].AttCappedMaxTP = set_combine(sets.precast.WS["Cataclysm"].AttCapped, {
    ear2="Novio Earring",           -- __,  7, __, __
  })

  -- Stuns target.
  sets.precast.WS["Leg Sweep"] = set_combine(sets.precast.WS, {
    ammo="Pemphredo Tathlum",
    head="Flamma Zucchetto +2",
    body="Flamma Korazin +2",
    hands="Flamma Manopolas +2",
    legs="Flamma Dirs +2",
    feet="Flamma Gambieras +2",
    ear1="Dignitary's Earring",
    ring1="Metamorph Ring +1",
    ring2="Weatherspoon Ring",
    -- ring2="Weatherspoon Ring +1",
  })
  sets.precast.WS["Leg Sweep"].MaxTP = set_combine(sets.precast.WS["Leg Sweep"], {})
  sets.precast.WS["Leg Sweep"].AttCapped = set_combine(sets.precast.WS["Leg Sweep"], {})
  sets.precast.WS["Leg Sweep"].AttCappedMaxTP = set_combine(sets.precast.WS["Leg Sweep"].AttCapped, {})


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Midcast Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.midcast.HealingBreath = {
    -- head="Pteroslaver Armet +2",
    -- body=gear.Acro_Breath_body,
    -- hands=gear.Acro_Breath_hands,
    -- legs="Vishap Brais +3",
    -- feet="Pteroslaver Greaves +3",
    -- neck="Dragoon's Collar +2",
    -- ear1="Lancer's Earring",
    -- ear2="Anastasi Earring",
    -- back=gear.DRG_Adoulin_Cape,
  }

  sets.midcast.ElementalBreath = {
    neck="Adad Amulet",
    ear1="Enmerkar Earring",
    waist="Incarnation Sash",
    -- ammo="Voluspa Tathlum",
    -- head="Pteroslaver Armet +3",
    -- body=gear.Acro_Breath_body,
    -- hands=gear.Acro_Breath_hands,
    -- legs=gear.Acro_Breath_legs,
    -- feet=gear.Acro_Breath_feet,
    -- ear2="Dragoon's Earring",
    -- ring1="Cath Palug Ring",
    -- back=gear.DRG_Adoulin_Cape,
  }

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
    head=gear.Nyame_B_head,       -- [ 7/ 7, 123] {__/__}
    body=gear.Nyame_B_body,       -- [ 9/ 9, 139] {__/__}
    hands=gear.Nyame_B_hands,     -- [ 7/ 7, 112] {__/__}
    legs=gear.Nyame_B_legs,       -- [ 8/ 8, 150] {__/__}
    feet=gear.Nyame_B_feet,       -- [ 7/ 7, 150] {__/__}
    neck="Dragoon's Collar +2",-- [__/__, ___] {25/25}
    ear1="Enmerkar Earring",      -- [__/__, ___] { 3/ 3}
    ear2="Odnowa Earring +1",
    ring1="Moonlight Ring",       -- [ 5/ 5, ___] {__/__}
    ring2="Defending Ring",       -- [10/10, ___] {__/__}
    back=gear.DRG_TP_Cape,        -- [10/__, ___] {__/__}
    waist="Carrier's Sash",
    -- ear2="Anastasi Earring",   -- [__/__, ___] { 3/__}
    -- waist="Isa Belt",          -- [__/__, ___] { 3/ 3}
  } -- 66 PDT/56 MDT, 674 MEVA {34 PetPDT/31 PetMDT}

  sets.defense.PDT = sets.HeavyDef
  sets.defense.MDT = sets.HeavyDef


  ------------------------------------------------------------------------------------------------
  ----------------------------------------- Idle Sets --------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.latent_regain = {
    head="Gleti's Mask",        --  2
    body="Gleti's Cuirass",     --  3
    hands="Gleti's Gauntlets",  --  2
    legs="Gleti's Breeches",    --  3
    feet="Gleti's Boots"     --  2
    -- head="Valorous Mask",    --  3
  }
  sets.latent_regen = {
    neck="Bathy Choker +1",         --  3 {__}
    ear1="Infused Earring",         --  1 {__}
    ring1="Chirich Ring +1",        --  2 {__}
    ring2="Chirich Ring +1",        --  2 {__}
    -- head="Crepuscular Helm",        --  3 {__}
    -- body="Sacro Breastplate",       -- 13 {__}
    -- feet="Pteroslaver Greaves +3",  -- __ {10}
  }
  sets.latent_refresh = {
    ring1="Stikini Ring +1",      --  1
    -- body="Chozoron Coselete",  --  2
    -- ring2="Stikini Ring +1",      --  1
  }

  sets.resting = {}

  sets.idle = sets.HeavyDef

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

  sets.idle.Weak = sets.HeavyDef

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
    ammo="Aurgelmir Orb",
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",
    hands="Gleti's Gauntlets",      --  3,  5, 60, 45,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs="Gleti's Breeches",
    feet="Flamma Gambieras +2",     --  2,  6, __, 42, __ < 6, __, __> [__/__,  86] {__/__}
    neck="Anu Torque",
    ear1="Telos Earring",           -- __,  5, 10, 10, __ < 1, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Petrov Ring",            -- __,  5, __, __, __ < 1, __, __> [__/__, ___] {__/__}
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] {__/__}
    back=gear.DRG_TP_Cape,          -- __, __, 20, 30, __ <10, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- ammo="Coiste Bodhar",        -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    -- body="Hjarrandi Breastplate",-- __, 10, 53, 47, 13 <__, __, __> [12/12,  69] {__/__}
    -- legs="Pteroslaver Brais +3", --  5, 10, 64, 39, __ <__, __, __> [__/__,  95] {11/__}
    -- neck="Vim Torque +1",        -- __, 10, __, 15, __ <__, __, __> [__/__, ___] {__/__}
  } -- 22 Haste, 65 STP, 222 Att, 289 Acc, 19 Crit Rate <35 DA, 5 TA, 3 QA> [29 PDT/12 MDT, 378 Meva] {19 PetPDT/0 PetMDT}
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
    -- hands="Gazu Bracelet +1",
  })

  sets.engaged.SamRoll = {
    ammo="Aurgelmir Orb",
    head="Flamma Zucchetto +2",     --  4,  6, __, 44, __ <__,  5, __> [__/__,  53] {__/__}
    body="Gleti's Cuirass",         --  3, __, 60, 45,  8 < 7, __, __> [ 9/__, 102] {__/__}
    hands="Gleti's Gauntlets",      --  3,  5, 60, 45,  6 <__, __, __> [ 7/__,  75] { 8/ 8}
    legs=gear.Nyame_B_legs,         --  5, __, 55, 40, __ < 3, __, __> [ 8/ 8, 150] {__/__}; maybe replace for multihit?
    feet="Flamma Gambieras +2",     --  2,  6, __, 42, __ < 6, __, __> [__/__,  86] {__/__}
    neck="Anu Torque",
    ear1="Brutal Earring",          -- __,  1, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ear2="Sherida Earring",         -- __,  5, __, __, __ < 5, __, __> [__/__, ___] {__/__}
    ring1="Petrov Ring",            -- __,  5, __, __, __ < 1, __, __> [__/__, ___] {__/__}
    ring2="Niqmaddu Ring",          -- __, __, __, __, __ <__, __,  3> [__/__, ___] {__/__}
    back=gear.DRG_TP_Cape,          -- __, __, 20, 30, __ <10, __, __> [10/__, ___] {__/__}
    waist="Ioskeha Belt +1",        --  8, __, __, 17, __ < 9, __, __> [__/__, ___] {__/__}
    -- ammo="Coiste Bodhar",        -- __,  3, 15, __, __ < 3, __, __> [__/__, ___] {__/__}
    -- head="Hjarrandi Helm",       -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    -- neck="Vim Torque +1",        -- __, 10, __, 15, __ <__, __, __> [__/__, ___] {__/__}
  } -- 21 Haste, 42 STP, 255 Att, 275 Acc, 14 Crit Rate <55 DA, 0 TA, 3 QA> [44 PDT/18 MDT, 466 Meva] {8 PetPDT/8 PetMDT}
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
    -- hands="Gazu Bracelet +1",
  })


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Hybrid Sets -------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.engaged.LightDef = set_combine(sets.engaged, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Defending Ring",       -- __, __, __, __, __ <__, __, __> [10/10, ___] {__/__}
    -- head="Hjarrandi Helm",        -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    -- waist="Tempus Belt +1",       -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
  }) -- 25 Haste, 56 STP, 292 Att, 279 Acc, 23 Crit Rate <32 DA, 0 TA, 0 QA> [49 PDT/32 MDT, 378 Meva] {44 PetPDT/33 PetMDT}
  sets.engaged.LowAcc.LightDef = set_combine(sets.engaged.LowAcc, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Defending Ring",       -- __, __, __, __, __ <__, __, __> [10/10, ___] {__/__}
    -- head="Hjarrandi Helm",        -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    -- waist="Tempus Belt +1",       -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
  })
  sets.engaged.MidAcc.LightDef = set_combine(sets.engaged.MidAcc, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Defending Ring",       -- __, __, __, __, __ <__, __, __> [10/10, ___] {__/__}
    -- head="Hjarrandi Helm",        -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    -- waist="Tempus Belt +1",       -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
  })
  sets.engaged.HighAcc.LightDef = set_combine(sets.engaged.HighAcc, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Defending Ring",       -- __, __, __, __, __ <__, __, __> [10/10, ___] {__/__}
    -- head="Hjarrandi Helm",        -- __,  7, 45, 41, __ < 6, __, __> [10/10,  53] {__/__}
    -- waist="Tempus Belt +1",       -- 15, __, __, __, __ <__, __, __> [__/__, ___] {__/__}
  })

  sets.engaged.SamRoll.LightDef = set_combine(sets.engaged.SamRoll, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Moonlight Ring",       -- __,  5,  8, __, __ <__, __, __> [ 5/ 5, ___] {__/__}
  })
  sets.engaged.LowAcc.SamRoll.LightDef = set_combine(sets.engaged.LowAcc.SamRoll, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Moonlight Ring",       -- __,  5,  8, __, __ <__, __, __> [ 5/ 5, ___] {__/__}
  })
  sets.engaged.MidAcc.SamRoll.LightDef = set_combine(sets.engaged.MidAcc.SamRoll, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Moonlight Ring",       -- __,  5,  8, __, __ <__, __, __> [ 5/ 5, ___] {__/__}
  })
  sets.engaged.HighAcc.SamRoll.LightDef = set_combine(sets.engaged.HighAcc.SamRoll, {
    neck="Dragoon's Collar +2",   -- __, __, 25, 25,  4 <__, __, __> [__/__, ___] {25/25}
    ring2="Moonlight Ring",       -- __,  5,  8, __, __ <__, __, __> [ 5/ 5, ___] {__/__}
  })

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
  sets.WeaponSet['Staff'] = {main="Gozuki Mezuki", sub="Utu Grip"}
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

function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
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
  elseif cmdParams[1] == 'test' then
    test()
  end

  gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
  if cmdParams[1] == 'gearinfo' then
    if not midaction() then
      job_update()
    end
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
  set_macro_page(1, 13)
end
