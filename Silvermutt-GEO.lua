-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
  -- Load and initialize Mote library
  mote_include_version = 2
  include('Mote-Include.lua') -- Executes job_setup, user_setup,
  include('Sel-Mappings.lua')
  coroutine.schedule(function()
    send_command('gs reorg')
  end, 1)
  coroutine.schedule(function()
    send_command('gs c weaponset current')
  end, 2)
end

-- Executes on first load and main job change
function job_setup()
  silibs.enable_cancel_on_blocking_status()
  silibs.enable_weapon_rearm()
  silibs.enable_auto_lockstyle(10)
  silibs.enable_premade_commands()

  state.OffenseMode:options('Safe', 'Normal')
  state.CastingMode:options('Normal', 'Resistant', 'Proc')
  state.IdleMode:options('Normal','HeavyDef')

  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Idris', 'Maxentius', 'Staff'}
  state.CP = M(false, "Capacity Points Mode")
	state.RecoverMode = M('Always', '60%', '35%', 'Never')
	state.MagicBurstMode = M{['description'] = 'Magic Burst Mode', 'Off', 'Single', 'Lock'}
	state.ElementalMode = M{['description'] = 'Elemental Mode', 'Fire','Ice','Wind','Earth','Lightning','Water'}

	state.Buff.Entrust = buffactive.Entrust or false
	state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false

  LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
      'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
      'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}

	autoentrust = 'Fury'
	blazelocked = false
	used_ecliptic = false

	state.AutoEntrust = M(false, 'AutoEntrust Mode')
	state.CombatEntrustOnly = M(false, 'Combat Entrust Only Mode')
	state.AutoGeoAbilities = M(false, 'Use Geo Abilities Automatically')
	state.UseCustomTimers = M(true, 'Use Custom Timers')

  indi_timer = ''
  indi_duration = 180

  send_command('bind !a gs c test')
  send_command('bind !s gs c faceaway')
  send_command('bind !d gs c usekey')
  send_command('bind @w gs c toggle RearmingLock')
  send_command('bind ^u gs c toggle ShowLuopanUi')
  
  send_command('bind !q gs c elemental tier1')
  send_command('bind !w gs c elemental tier4')
  send_command('bind !e gs c elemental tier5')
  send_command('bind !r gs c elemental ara2')

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind @c gs c toggle CP')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @q gs c cycle RecoverMode')

  send_command('bind ^- gs c cycleback ElementalMode')
  send_command('bind ^= gs c cycle ElementalMode')

	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  silibs.user_setup_hook()
  include('Global-Binds.lua') -- Additional local binds

  if player.sub_job == 'WHM' or player.sub_job == 'RDM' then
    -- send_command('bind !e input /ma "Haste" <stpc>')
  end
  if player.sub_job == 'RDM' then
    send_command('bind !\' input /ma "Refresh" <stpc>')
  end

  select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
  send_command('unbind !a')
  send_command('unbind !s')
  send_command('unbind !d')
  send_command('unbind @w')
  send_command('unbind ^u')

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind @c')
	send_command('unbind @`')
	send_command('unbind @q')

  send_command('unbind !e')
  send_command('unbind !\'')

  send_command('unbind ^-')
  send_command('unbind ^=')

	send_command('unbind !`')
	send_command('unbind ^backspace')
	send_command('unbind !backspace')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
  sets.org.job = {}

  sets.TreasureHunter = {
    waist="Chaac Belt", --1
  }
  sets.TreasureHunter.RA = sets.TreasureHunter

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {
    body="Bagua Tunic +1",
  }
	sets.precast.JA['Life Cycle'] = {
    body="Geomancy Tunic +1",
    back=gear.GEO_Idle_Cape,
    -- body="Geomancy Tunic +3",
  }
	sets.precast.JA['Radial Arcana'] = {
    feet="Bagua Sandals +1",
  }
	sets.precast.JA['Mending Halation'] = {
    legs="Bagua Pants +1",
  }
	sets.precast.JA['Full Circle'] = {
    head="Azimuth Hood +1",
    hands="Bagua Mitaines +1",
  }
  sets.precast.JA['Concentric Pulse'] = {
    head="Bagua Galero +1",
  }

	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}

	-- Fast cast sets for spells
	sets.precast.FC = {
    range="Dunna",                  --  3
    ammo=empty,
    head=gear.Merl_FC_head,         -- 13
    hands=gear.Merl_FC_hands,       --  5
    legs="Geomancy Pants +2",       -- 13
    neck="Orunmila's Torque",       --  5
    ear1="Loquac. Earring",         --  2
    ear2="Malignance Earring",      --  4
    ring1="Kishar Ring",            --  4
    ring2="Prolix Ring",            --  2
    back=gear.GEO_FC_Cape,          -- 10
    -- Ideal:
    -- range="Dunna",               --  3
    -- ammo=empty,
    -- head=gear.Merl_FC_head,      -- 15
    -- body=gear.Merl_FC_body,      -- 13
    -- hands=gear.Merl_FC_hands,    --  7
    -- legs="Geomancy Pants +3",    -- 15
    -- feet=gear.Merl_FC_feet,      -- 12
    -- back=gear.GEO_FC_Cape,       -- 10
    -- waist="Shinjutsu-no-Obi +1", --  5
    -- 80 FC
  } -- 61 FC

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {
    range="Dunna",
    ammo=empty,
  })

  sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
    hands="Bagua Mitaines +1",
    ear2="Malignance Earring",
  })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	sets.precast.FC.Curaga = sets.precast.FC.Cure

	sets.Self_Healing = {
    ring2="Asklepian Ring",
    waist="Gishdubar Sash",
  }
	sets.Cure_Received = {
    ring2="Asklepian Ring",
    waist="Gishdubar Sash",
  }
	sets.Self_Refresh = {
    back="Grapevine Cape",
    waist="Gishdubar Sash",
    -- feet="Inspirited Boots",
  }

  sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    waist="Siegel Sash",
  })

  sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.Impact = {
		-- head=empty,
		-- body="Twilight Cloak",
  }

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",
    sub="Genmei Shield",
  })

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }
  
  -- Physical damage. 2 hit. Damage varies with TP.
  -- 70% MND / 30% STR; 3.0-9.75fTP
  -- TP Bonus > WSD > MND > STR
	sets.precast.WS['Black Halo'] = {
    -- Assume Idris                 -- ___, __, __, __, __/__ [25]
    -- Assume Genmei Shield         -- ___, __, __, __, 10/__ [__]
    -- Assume Dunna                 -- ___, __, __, __, __/__ [ 5]
    head=gear.Nyame_B_head,         -- ___, 26, 26, 10,  7/ 7 [__]
    body=gear.Nyame_B_body,         -- ___, 37, 35, 12,  9/ 9 [__]
    hands=gear.Nyame_B_hands,       -- ___, 40, 17, 10,  7/ 7 [__]
    legs=gear.Nyame_B_legs,         -- ___, 32, 43, 11,  8/ 8 [__]
    feet=gear.Nyame_B_feet,         -- ___, 26, 23, 10,  7/ 7 [__]
    neck="Fotia Gorget",            -- fTP Bonus
    ear1="Regal Earring",           -- ___, 10, __, __, __/__ [__]
    ear2="Moonshade Earring",       -- 250, __, __, __, __/__ [__]
    ring1="Metamorph Ring +1",      -- ___, 16, __, __, __/__ [__]
    ring2="Epaminondas's Ring",     -- ___, __, __,  5, __/__ [__]
    back=gear.GEO_Idle_Cape,        -- ___, __, __, __, __/__ [__]
    waist="Fotia Belt",             -- fTP Bonus
  } -- 250 TP Bonus, 187 MND, 144 STR, 58 WSD, 48PDT/38MDT [30PetDT]
  sets.precast.WS['Black Halo'].MaxTP = set_combine(sets.precast.WS['Black Halo'], {
    ear2="Ishvara Earring",         -- ___, __, __,  2, __/__ [__]
  })
  sets.precast.WS['Black Halo'].Safe = set_combine(sets.precast.WS['Black Halo'], {
    hands="Geomancy Mitaines +2",   -- ___, 38, 11, __,  2/__ [12]
    ring2="Defending Ring",         -- ___, __, __, __, 10/10 [__]
    -- hands="Geomancy Mitaines +3",-- ___, 43, 16, __,  3/__ [13]
    -- 250 TP Bonus, 190 MND, 143 STR, 35 WSD, 54PDT/44MDT [43PetDT]
  })-- 250 TP Bonus, 185 MND, 138 STR, 35 WSD, 53PDT/43MDT [42PetDT]

  -- Physical damage. 1 hit. Damage varies with TP.
  -- 50% MND / 50% STR; 3.5-12fTP
  -- TP Bonus > WSD > MND = STR
  sets.precast.WS['Judgment'] = sets.precast.WS['Black Halo']
  sets.precast.WS['Judgment'].MaxTP = sets.precast.WS['Black Halo'].MaxTP
  sets.precast.WS['Judgment'].Safe = sets.precast.WS['Black Halo'].Safe

  -- Physical damage. 1 hit. Attack varies with TP.
  -- 50% MND / 50% INT; 1.5-4.75fTP
  -- WSD > MND > INT
	sets.precast.WS['Exudiation'] = set_combine(sets.precast.WS['Black Halo'], {
    ear2="Ishvara Earring",
  })
  sets.precast.WS['Exudiation'].MaxTP = sets.precast.WS['Exudiation']
  sets.precast.WS['Exudiation'].Safe = set_combine(sets.precast.WS['Black Halo'].Safe, {
    ear2="Ishvara Earring",
  })

  -- Physical. 6 Hits. 30% STR / 30% MND
  -- fTP Replicating WS. Can crit. Crit rate varies with TP. 1.125 fTP
  -- TP Bonus > Fotia > Crit Dmg > Crit Rate, MND = STR > WSD
  sets.precast.WS['Hexa Strike'] = {
    -- Assume Idris                 -- ___, __, __, __, __, __, __/__ [25]
    -- Assume Genmei Shield         -- ___, __, __, __, __, __, 10/__ [__]
    -- Assume Dunna                 -- ___, __, __, __, __, __, __/__ [ 5]
    head=gear.Nyame_B_head,         -- ___, __, __, 26, 26, 10,  7/ 7 [__]
    body=gear.Nyame_B_body,         -- ___, __, __, 37, 35, 12,  9/ 9 [__]
    hands=gear.Nyame_B_hands,       -- ___, __, __, 40, 17, 10,  7/ 7 [__]
    legs=gear.Nyame_B_legs,         -- ___, __, __, 32, 43, 11,  8/ 8 [__]
    feet=gear.Nyame_B_feet,         -- ___, __, __, 26, 23, 10,  7/ 7 [__]
    neck="Fotia Gorget",            -- fTP Bonus
    ear1="Regal Earring",           -- ___, __, __, 10, __, __, __/__ [__]
    ear2="Moonshade Earring",       -- 250, __, __, __, __, __, __/__ [__]
    ring1="Metamorph Ring +1",      -- ___, __, __, 16, __, __, __/__ [__]
    ring2="Epaminondas's Ring",     -- ___, __, __, __, __,  5, __/__ [__]
    back=gear.GEO_Idle_Cape,        -- ___, __, __, __, __, __, __/__ [__]
    waist="Fotia Belt",             -- fTP Bonus
  } -- 250 TP Bonus, 0 Crit Dmg,  0 Crit Rate, 187 MND, 144 STR, 58 WSD, 48PDT/38MDT [30PetDT]
  sets.precast.WS['Hexa Strike'].MaxTP = set_combine(sets.precast.WS['Hexa Strike'], {
    ear2="Malignance Earring",
  })
	sets.precast.WS['Hexa Strike'].Safe = set_combine(sets.precast.WS['Hexa Strike'], {
    hands="Geomancy Mitaines +2",   -- ___, 38, 11, __,  2/__ [12]
    ring2="Defending Ring",         -- ___, __, __, __, 10/10 [__]
    -- hands="Geomancy Mitaines +3",-- ___, 43, 16, __,  3/__ [13]
    -- 250 TP Bonus, 0 Crit Dmg,  0 Crit Rate, 190 MND, 143 STR, 35 WSD, 54PDT/42MDT [43PetDT]
  })-- 250 TP Bonus, 0 Crit Dmg,  0 Crit Rate, 185 MND, 138 STR, 35 WSD, 53PDT/41MDT [42PetDT]

  -- Magical (light). dStat=INT. 50% STR / 50% MND
  -- Light MAB > MAB > M.Dmg > MND > STR > WSD
	sets.precast.WS['Flash Nova'] = {
    -- Assume Idris                 -- __, 40,217, __, __, __, __/__ [25]
    -- Assume Genmei Shield         -- __, __, __, __, __, __, 10/__ [__]
    -- Assume Dunna                 -- __, __, __, __, __, __, __/__ [ 5]
    head="Agwu's Cap",              -- __, 35, 20, 26, 26, __, __/__ [__]
    body=gear.Nyame_B_body,         -- __, 30, __, 37, 35, 12,  9/ 9 [__]
    hands="Jhakri Cuffs +2",        -- __, 40, __, 35, 18,  7, __/__ [__]
    legs="Agwu's Slops",            -- __, 55, 20, 32, 43, __,  7/ 7 [__]
    feet=gear.Nyame_B_feet,         -- __, 30, __, 26, 23, 10,  7/ 7 [__]
    neck="Baetyl Pendant",          -- __, 13, __, __, __, __, __/__ [__]
    ear1="Regal Earring",           -- __,  7, __, 10, __, __, __/__ [__]
    ear2="Malignance Earring",      -- __,  8, __,  8, __, __, __/__ [__]
    ring1="Weatherspoon Ring",      -- 10, __, __, __, __, __, __/__ [__]
    ring2="Shiva Ring +1",          -- __,  3, __, __, __, __, __/__ [__]
    back="Argochampsa Mantle",      -- __, 12, __, __, __, __, __/__ [__]
    waist="Skrymir Cord",           -- __,  5, 30, __, __, __, __/__ [__]
    -- head="Agwu's Cap",           -- __, 58, 33, 26, 26, __, __/__ [__]; R25
    -- body="Agwu's Robe",          -- __, 58, 20, 37, 33, __, __/__ [__]; R25
    -- hands="Agwu's Gages",        -- __, 58, 20, 40, 14, __, __/__ [__]; R25
    -- legs="Agwu's Slops",         -- __, 58, 20, 32, 43, __,  9/ 9 [__]; R25
    -- feet="Agwu's Pigaches",      -- __, 58, 20, 26, 21, __, __/__ [__]; R25
    -- back=gear.GEO_Nuke_Cape,     -- __, 10, 20, __, __, __, 10/__ [__]
    -- waist="Skrymir Cord +1",     -- __,  7, 35, __, __, __, __/__ [__]
    -- 10 Light MAB, 378 MAB, 385 M.Dmg, 179 MND, 137 STR, 0 WSD, 29PDT/9MDT [30PetDT]
  } -- 10 Light MAB, 278 MAB, 287 M.Dmg, 174 MND, 145 STR, 29 WSD, 33PDT/23MDT [30PetDT]
  sets.precast.WS['Flash Nova'].MaxTP = sets.precast.WS['Flash Nova']
	sets.precast.WS['Flash Nova'].Safe = {
    -- Assume Idris                 -- __, 40,217, __, __, __, __/__ [25]
    -- Assume Genmei Shield         -- __, __, __, __, __, __, 10/__ [__]
    -- Assume Dunna                 -- __, __, __, __, __, __, __/__ [ 5]
    head="Agwu's Cap",              -- __, 35, 20, 26, 26, __, __/__ [__]
    body=gear.Nyame_B_body,         -- __, 30, __, 37, 35, 12,  9/ 9 [__]
    hands="Geomancy Mitaines +2",   -- __, __, __, 38, 11, __,  2/__ [12]
    legs="Agwu's Slops",            -- __, 55, 20, 32, 43, __,  7/ 7 [__]
    feet=gear.Nyame_B_feet,         -- __, 30, __, 26, 23, 10,  7/ 7 [__]
    neck="Baetyl Pendant",          -- __, 13, __, __, __, __, __/__ [__]
    ear1="Regal Earring",           -- __,  7, __, 10, __, __, __/__ [__]
    ear2="Malignance Earring",      -- __,  8, __,  8, __, __, __/__ [__]
    ring1="Weatherspoon Ring",      -- 10, __, __, __, __, __, __/__ [__]
    ring2="Defending Ring",         -- __, __, __, __, __, __, 10/10 [__]
    back="Argochampsa Mantle",      -- __, 12, __, __, __, __, __/__ [__]
    waist="Skrymir Cord",           -- __,  5, 30, __, __, __, __/__ [__]
    -- head="Agwu's Cap",           -- __, 58, 33, 26, 26, __, __/__ [__]; R25
    -- body="Shamash Robe",         -- __, 45, __, 40, 30, __, 10/10 [__]
    -- hands="Geomancy Mitaines +3",-- __, __, __, 43, 16, __,  3/__ [13]
    -- legs="Agwu's Slops",         -- __, 58, 20, 32, 43, __,  9/ 9 [__]; R25
    -- feet="Agwu's Pigaches",      -- __, 58, 20, 26, 21, __, __/__ [__]; R25
    -- back=gear.GEO_Nuke_Cape,     -- __, 10, 20, __, __, __, 10/__ [__]
    -- waist="Skrymir Cord +1",     -- __,  7, 35, __, __, __, __/__ [__]
    -- 10 Light MAB, 304 MAB, 345 M.Dmg, 185 MND, 136 STR, 0 WSD, 52PDT/19MDT [43PetDT]
  } -- 10 Light MAB, 235 MAB, 287 M.Dmg, 177 MND, 138 STR, 22 WSD, 45PDT/33MDT [42PetDT]

  -- Magical (light). dStat=INT. 40% STR / 40% MND
  -- Damage varies with TP. 2.125-6.125 fTP
  -- TP Bonus > Fotia > Light MAB > MAB > M.Dmg > MND > STR > WSD
	sets.precast.WS['Seraph Strike'] = set_combine(sets.precast.WS['Flash Nova'], {
    neck="Fotia Neck",              -- __, __, __, __, __, __, __/__ [__]; FTP bonus
    ear2="Moonshade Earring",       -- __, __, __, __, __, __, __/__ [__]; TP bonus
    waist="Fotia Belt",             -- __, __, __, __, __, __, __/__ [__]; FTP bonus
  })
  sets.precast.WS['Seraph Strike'].MaxTP = set_combine(sets.precast.WS['Seraph Strike'].MaxTP, {
    ear2="Malignance Earring",      -- __,  8, __,  8, __, __, __/__ [__]
  })
  sets.precast.WS['Seraph Strike'].Safe = set_combine(sets.precast.WS['Flash Nova'].Safe, {
    neck="Fotia Neck",              -- __, __, __, __, __, __, __/__ [__]; FTP bonus
    ear2="Moonshade Earring",       -- __, __, __, __, __, __, __/__ [__]; TP bonus
    waist="Fotia Belt",             -- __, __, __, __, __, __, __/__ [__]; FTP bonus
  })

  -- Cataclysm: 30% STR/30% INT, 2.75-5.0 fTP, 1 hit (aoe-magical)
  -- Dark MAB > MAB > M.Dmg > INT > STR > WSD
  sets.precast.WS['Cataclysm'] = {
    -- Assume Malignance Pole       -- __, __, __, 15
    -- Assume Tzacab Grip           -- __, __, __, __
    -- Assume Dunna                 -- __, __, __, __
    head="Pixie Hairpin +1",        -- 28, __, __, __
    body=gear.Nyame_B_body,         -- __, 30, __, 12
    hands="Jhakri Cuffs +2",        -- __, 40, __,  7
    legs=gear.Nyame_B_legs,         -- __, 30, __, 11
    feet=gear.Nyame_B_feet,         -- __, 30, __, 10
    neck="Fotia Neck",              -- __, __, __, __; FTP bonus
    ear1="Regal Earring",           -- __,  7, __, __
    ear2="Moonshade Earring",       -- __, __, __, __; TP bonus
    ring1="Archon Ring",            --  5, __, __, __
    ring2="Epaminondas's Ring",     -- __, __, __,  5
    back="Argochampsa Mantle",      -- __, 12, __, __
    waist="Skrymir Cord",           -- __,  5, 30, __
    -- body="Agwu's Robe",          -- __, 58, 20, __; R25
    -- hands="Agwu's Gages",        -- __, 58, 20, __; R25
    -- legs="Agwu's Slops",         -- __, 58, 20, __; R25
    -- feet="Agwu's Pigaches",      -- __, 58, 20, __; R25
    -- back=gear.GEO_Nuke_Cape,     -- __, 10, 20, __
    -- waist="Skrymir Cord +1",     -- __,  7, 35, __
    -- 33 Dark MAB, 229 MAB, 115 M.Dmg, 12 WSD
  } -- 33 Dark MAB, 157 MAB, 30 M.Dmg, 45 WSD
  sets.precast.WS['Cataclysm'].MaxTP = set_combine(sets.precast.WS['Cataclysm'], {
    ear2="Malignance Earring", -- __,  8, __, __
  })

	--------------------------------------
	-- Midcast sets
	--------------------------------------

  sets.midcast.FastRecast = sets.precast.FC

  -- Initializes trusts at iLvl 119
  sets.midcast.Trust = {
    head=gear.Nyame_B_head,
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
  }

  -- Master GEO with full merits = 850 geo skill base (cap at 900)
  -- Lv 99 GEO = 43 Conserve MP base (cap at 100)
	sets.midcast.Geomancy = {
    main="Idris",                   -- 10, __, __
    sub="Genmei Shield",            -- __, __, __
    range="Dunna",                  -- __, 18, __
    ammo=empty,
    head="Azimuth Hood +1",         -- __, 15, __
    body="Geomancy Tunic +1",
    hands="Azimuth Gloves +1",      -- __, __, __; Set bonus
    legs=gear.Vanya_C_legs,         -- __, __, 12
    feet="Azimuth Gaiters +1",      -- __, __, __; Set bonus
    neck="Bagua Charm +1",          --  6, __, __; Luopan Duration +20%
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Stikini Ring +1",        -- __,  8, __
    ring2="Defending Ring",
    back=gear.GEO_Adoulin_Cape,     -- __, 15, __
    waist="Sekhmet Corset",
    -- body="Vedic Coat",           -- __, __, 10
    -- neck="Bagua Charm +2",       -- __, __, __; Luopan Duration +25%
    -- ear1="Mendicant's Earring",  -- __, __,  2
    -- ear2="Calamitous Earring",   -- __, __,  4
    -- ring2="Mephitas's Ring +1",  -- __, __, 15
    -- waist="Shinjutsu-no-Obi +1", -- __, __, 15
    -- Base stats                   -- __,850, 43
    -- 10 Geomancy, 906 geo skill, 101 Conserve MP
	} -- 10 Geomancy, 906 geo skill, 55 Conserve MP

	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = {
    main="Idris",                   -- 10, __, __, __, __
    sub="Genmei Shield",            -- __, __, __, __, __
    range="Dunna",                  -- __, 18, __, __, __
    ammo=empty,
    head="Azimuth Hood +1",         -- __, 15, __, __, __
    body="Geomancy Tunic +1",       -- __, __, __, __, __
    hands="Azimuth Gloves +1",      -- __, __, __, __, __; Set bonus: save MP
    legs="Bagua Pants +1",          -- __, __, __, 15, __
    feet="Azimuth Gaiters +1",      -- __, __, __, 20, __; Set bonus: save MP
    neck="Incanter's Torque",       -- __, 10, __, __, __; Save MP
    ear1="Eabani Earring",          -- __, __, __, __, __
    ear2="Halasz Earring",          -- __, __, __, __, __
    ring1="Stikini Ring +1",        -- __,  8, __, __, __
    ring2="Defending Ring",         -- __, __, __, __, __
    back=gear.GEO_Adoulin_Cape,     -- __, 15, __, __, 17
    waist="Gishdubar Sash",         -- __, __, __, __, __
    -- head=gear.Vanya_C_head,      -- __, __, 12, __, __
    -- body="Vedic Coat",           -- __, __, 10, __, __
    -- legs="Bagua Pants +3",       -- __, __, __, 21, __
    -- ear1="Mendicant's Earring",  -- __, __,  2, __, __
    -- ear2="Calamitous Earring",   -- __, __,  4, __, __
    -- ring2="Mephitas's Ring +1",  -- __, __, 15, __, __
    -- back=gear.GEO_Adoulin_Cape,  -- __, 15, __, __, 20
    -- waist="Shinjutsu-no-Obi +1", -- __, __, 15, __, __
    -- Base stats                   -- __,850, 43, __, __
    -- 10 Geomancy, 901 geo skill, 101 Conserve MP, 41 Indi Duration, 20 Indi Duration %
  }

	-- Geomancy and skill have no effect on Entrust.
	sets.buff.Entrust = set_combine(sets.midcast.Geomancy.Indi, {
    main="Solstice",                -- __,  5,  6, 15, __
    sub="Genmei Shield",            -- __, __, __, __, __
    ear1="Odnowa Earring +1",       -- __, __, __, __, __; DT
    ear2="Etiolation Earring",      -- __, __, __, __, __; DT
    ring1="Defending Ring",         -- __, __, __, __, __; DT
  }) -- 0 Geomancy, 898 geo skill, 101 Conserve MP, 56 Indi Duration, 20 Indi Duration %

  sets.midcast.Cure = {
    main="Daybreak",
    sub=empty,
    legs="Geomancy Pants +2",
    ring1="Stikini Ring +1",
    ring2="Lebeche Ring",
    -- sub="Ammurapi Shield",
    -- range=empty,
    -- ammo="Esper Stone +1",
    -- head=gear.Vanya_B_head,
    -- body=gear.Vanya_B_body,
    -- hands=gear.Vanya_B_hands,
    -- legs=gear.Vanya_B_legs,
    -- feet=gear.Vanya_B_feet,
    -- neck="Incanter's Torque",
    -- ear1="Mendicant's Earring",
    -- ear2="Meili Earring",
    -- back="Tempered Cape +1",
    -- waist="Luminary Sash",
  }

  sets.midcast.LightWeatherCure = {
    main="Daybreak",
    sub=empty,
    legs="Geomancy Pants +2",
    ring1="Stikini Ring +1",
    waist="Hachirin-no-Obi",
    -- main="Chatoyant Staff",
    -- sub="Khonsu",
    -- range=empty,
    -- ammo="Esper Stone +1",
    -- head=gear.Vanya_B_head,
    -- body="Annointed Kalasiris",
    -- hands=gear.Vanya_B_hands,
    -- legs=gear.Vanya_B_legs,
    -- feet=gear.Vanya_B_feet,
    -- neck="Nodens Gorget",
    -- ear1="Mendicant's Earring",
    -- ear2="Meili Earring",
    -- ring2="Menelaus's Ring",
    -- back="Twilight Cape",
    -- waist="Hachirin-no-Obi",
  }

  --Cureset for if it's not light weather but is light day.
  sets.midcast.LightDayCure = sets.midcast.LightWeatherCure

  sets.midcast.Curaga = set_combine(sets.midcast.Cure, {})

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {})

	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
    -- main=gear.Grioavolr_FC,
    -- sub="Clemency Grip",
  })

  sets.midcast['Elemental Magic'] = {
    main="Daybreak",
    sub=empty,
    range=empty,
    ammo="Pemphredo Tathlum", --4
    head=empty,
    body="Cohort Cloak +1", --100
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Baetyl Pendant", --13
    ear1="Malignance Earring", --8
    ear2="Regal Earring", --7
    ring1="Metamorph Ring +1",
    ring2="Shiva Ring +1", --3
    back="Argochampsa Mantle", --12
    waist="Eschan Stone", --7
    -- sub="Ammurapi Shield",
    -- head="Bagua Galero +3",
    -- body=gear.Amalric_A_body,
    -- hands=gear.Amalric_D_hands,
    -- legs=gear.Amalric_A_legs,
    -- feet=gear.Amalric_D_feet,
    -- neck="Sanctity Necklace",
    -- ring1="Freke Ring",
    -- back=gear.GEO_Nuke_Cape,
    -- waist="Sacro Cord",
  }
  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})
  sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast['Elemental Magic'], {})
  sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {})
  sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {})

  sets.midcast['Dark Magic'] = {
    ammo="Pemphredo Tathlum",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
  }

  sets.midcast.Drain = {
    range=empty,
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    body=gear.Nyame_B_body,
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Erra Pendant",
    ear1="Malignance Earring",
    ear2="Digni. Earring",
    ring1="Archon Ring",
    waist="Fucho-no-obi",
    -- main="Rubicundicity",
    -- sub="Ammurapi Shield",
    -- head="Bagua Galero +3",
    -- ring2="Evanescence Ring",
    -- back=gear.GEO_Nuke_Cape,
  }

  sets.midcast.Aspir = sets.midcast.Drain

	sets.midcast.Stun = {
    range="Dunna",
    ammo=empty,
    legs="Geomancy Pants +2",
    neck="Bagua Charm +1",
    ear1="Regal Earring",
    ear2="Malignance Earring",
    ring1="Stikini Ring +1",
    ring2="Weatherspoon Ring",
    back=gear.GEO_FC_Cape,
    -- main="Mpaca's Staff",
    -- sub="Khonsu",
    -- head=gear.Amalric_D_head,
    -- body="Zendik Robe",
    -- hands="Agwu's Gages",
    -- legs="Geomancy Pants +3",
    -- feet="Volte Gaiters",
    -- neck="Bagua Charm +2",
    -- ring1="Stikini Ring +1",
    -- waist="Witful Belt",
  }
	sets.midcast.Stun.Resistant = set_combine(sets.midcast.Stun, {})

	sets.midcast.Impact = {
    main="Daybreak",
    sub=empty,
    ammo="Pemphredo Tathlum",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
    -- sub="Ammurapi Shield",
		-- body="Twilight Cloak",
    -- hands="Regal Cuffs",
  }

	sets.midcast.Dispel = {
    main="Daybreak",
    sub=empty,
    ammo="Pemphredo Tathlum",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
    -- sub="Ammurapi Shield",
  }

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {
    main="Daybreak",
    sub=empty,
    -- sub="Ammurapi Shield",
  })

	sets.midcast['Enfeebling Magic'] = {
    main="Daybreak",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head=empty,
    body="Cohort Cloak +1",
    hands="Geomancy Mitaines +2",
    legs="Geomancy Pants +2",
    feet="Geomancy Sandals +2",
    neck="Bagua Charm +1",
    ear1="Regal Earring",
    ear2="Malignance Earring",
    ring1="Stikini Ring +1",
    ring2="Metamorph Ring +1",
    -- sub="Ammurapi Shield",
    -- hands="Geomancy Mitaines +3",
    -- legs="Geomancy Pants +3",
    -- feet="Geomancy Sandals +3",
    -- neck="Bagua Charm +2",
    -- back="Aurist's Cape +1",
    -- waist="Acuity Belt +1",
  }
	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {})

  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {
  })
  sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
  })

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
  })
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
  })

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
  })
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
  })

	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)

	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {
    ring1="Stikini Ring +1",
  })

	sets.midcast['Enhancing Magic'] = {}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    waist="Siegel Sash",
    -- legs="Shedir Seraweels",
    -- neck="Nodens Gorget",
    -- ear2="Earthcry Earring",
  })

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
    -- head="Amalric Coif +1",
  })

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
    -- main="Vadose Rod",
    -- sub="Genmei Shield",
    -- head="Amalric Coif +1",
    -- hands="Regal Cuffs",
    -- legs="Shedir Seraweels",
    -- waist="Emphatikos Rope",
  })

	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {
    -- legs="Shedir Seraweels",
  })

	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
    ear2="Malignance Earring",
    waist="Sekhmet Corset",
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
  })
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
    ear2="Malignance Earring",
    waist="Sekhmet Corset",
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
  })
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {
    ear2="Malignance Earring",
    waist="Sekhmet Corset",
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
  })
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
    ear2="Malignance Earring",
    waist="Sekhmet Corset",
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
  })


	--------------------------------------
	-- Defense sets
	--------------------------------------

	-- Defense sets
	sets.defense.PDT = {
    main="Malignance Pole",         -- 20/20, ___, __/__, __
    sub="Khonsu",                   --  6/ 6, ___, __/__, __
    range="Dunna",                  -- __/__, ___, __/__, __
    ammo=empty,                     -- __/__, ___, __/__, __
    head=gear.Nyame_B_head,         --  7/ 7, 123, __/__, __
    body=gear.Nyame_B_body,         --  9/ 9, 139, __/__, __
    hands=gear.Nyame_B_hands,       --  7/ 7, 112, __/__, __
    legs=gear.Nyame_B_legs,         --  8/ 8, 150, __/__, __
    feet=gear.Nyame_B_feet,         --  7/ 7, 150, __/__, __
    neck="Loricate Torque +1",      --  6/ 6, ___, __/__, __
    ear1="Hearty Earring",          --  2/__, ___, __/__, __; Resist All Status+5
    ear2="Etiolation Earring",      -- __/ 3, ___, __/__, __; Resist Silence+15
    ring1="Defending Ring",         -- 10/10, ___, __/__, __
    ring2="Stikini Ring +1",        -- __/__, ___, __/__, __; Refresh
    back=gear.GEO_Idle_Cape,        -- __/__,  30, __/__, 15
    waist="Carrier's Sash",         -- __/__, ___, __/__, __; Ele resist+15
    -- body="Shamash Robe",         -- 10/__, 106, __/__, __; Resist Silence+90
  } -- 82 PDT / 83 MDT, 704 Meva, 0 Pet PDT / 0 Pet MDT, 15 Pet Regen
	sets.defense.MDT = sets.defense.PDT

	--------------------------------------
	-- Idle/resting/etc sets
	--------------------------------------

  -- Overlaid when MP is needed and defense is not
  sets.passive_refresh = {
		head="Befouled Crown",
		body="Jhakri Robe +2",
    ring1="Stikini Ring +1",
    -- main="Mpaca's Staff", --2
    -- sub="Oneiros Grip", --1; when mp<70%
    -- body="Shamash Robe",
    -- hands="Bagua Mitaines +3", --2
    -- neck="Chrys. Torque",
    -- ring2="Stikini Ring +1",
  }
	sets.passive_refresh_sub50 = set_combine(sets.passive_refresh, {
    waist="Fucho-no-obi",
  })

	-- Resting sets
	sets.resting = {
    main="Iridal Staff",
    sub="Khonsu",
		head="Befouled Crown",
		body="Jhakri Robe +2",
    ear2="Ethereal Earring",
    ring1="Defending Ring",
  }

	-- Idle sets

	sets.idle = sets.defense.PDT

  -- When you need to be safe (disables move speed gear)
	sets.idle.HeavyDef = sets.defense.PDT

	-- When Luopan is present, but not expecting to take much dmg
  -- Maximize Pet Regen
	sets.idle.Pet = {
    main="Idris",                   -- __/__, ___, [25, __]
    sub="Genmei Shield",            -- 10/__, ___, [__, __]
    range="Dunna",                  -- __/__, ___, [ 5, __]
    ammo=empty,                     -- __/__, ___, [__, __]
    head="Azimuth Hood +1",         -- __/__,  86, [__,  3]
    body=gear.Nyame_B_body,         --  9/ 9, 139, [__, __]
    hands="Geomancy Mitaines +2",   --  2/__,  47, [12, __]
    legs=gear.Nyame_B_legs,         --  8/ 8, 150, [__, __]
    feet="Bagua Sandals +1",        -- __/__, 107, [__,  3]
    neck="Bagua Charm +1",          -- __/__, ___, [__, __]; Absorb Dmg+8
    ear1="Genmei Earring",          --  2/__, ___, [__, __]
    ear2="Etiolation Earring",      -- __/ 3, ___, [__, __]; Resist Silence+15
    ring1="Defending Ring",         -- 10/10, ___, [__, __]
    ring2="Gelatinous Ring +1",     --  7/-1, ___, [__, __]
    back=gear.GEO_Idle_Cape,        -- __/__,  30, [__, 15]
    waist="Carrier's Sash",         -- __/__, ___, [__, __]; Ele resist+15
    -- body="Shamash Robe",         -- 10/__, 106, [__, __]; Resist Silence+90
    -- hands="Geomancy Mitaines +3",--  3/__,  57, [13, __]
    -- feet="Bagua Sandals +3",     -- __/__, 127, [__,  5]
    -- neck="Bagua Charm +2",       -- __/__, ___, [__, __]; Absorb Dmg+10
    -- 50 PDT / 20 MDT, 526 Meva, [43 Pet DT, 23 Pet Regen]
  } -- 48 PDT / 29 MDT, 559 Meva, [42 Pet DT, 21 Pet Regen]

	-- When Luopan is present, and you are expecting to take dmg
	sets.idle.HeavyDef.Pet = sets.idle.Pet

  -- Handle refresh
  sets.idle.Refresh = set_combine(sets.idle, sets.passive_refresh)
  sets.idle.RefreshSub50 = set_combine(sets.idle, sets.passive_refresh_sub50)

  -- Ignore refresh sets if not "Normal" IdleMode
  sets.idle.HeavyDef.Refresh = set_combine(sets.idle.HeavyDef)
  sets.idle.Pet.Refresh = set_combine(sets.idle.Pet)
  sets.idle.HeavyDef.Pet.Refresh = set_combine(sets.idle.HeavyDef.Pet)
  sets.idle.HeavyDef.RefreshSub50 = set_combine(sets.idle.HeavyDef)
  sets.idle.Pet.RefreshSub50 = set_combine(sets.idle.Pet)
  sets.idle.HeavyDef.Pet.RefreshSub50 = set_combine(sets.idle.HeavyDef.Pet)

	sets.idle.Weak = sets.defense.PDT


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

  -- Need 38 pet DT to cap
	-- Normal melee group, used when not club or staff
	sets.engaged = {
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands=gear.Nyame_B_hands,       --  7/ 7 [__, __], 40, __,  4
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Bagua Charm +1",          -- __/__ [__, __], __, __, __; Luopan absorb dmg
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Petrov Ring",            -- __/__ [__, __], __,  5,  1
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Gazu Bracelet +1",    -- __/__ [__, __], 96, __, __
    -- ring2="Chirich Ring +1",     -- __/__ [__, __], 10,  6, __
    -- 23PDT/23MDT [9 Pet DT, 15 Pet Regen], 317 Acc, 32 Store TP, 17 DA
  } -- 30PDT/30MDT [5 Pet DT, 15 Pet Regen], 251 Acc, 31 Store TP, 22 DA
	sets.engaged.Safe = {
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands="Geomancy Mitaines +2",   --  2/__ [12, __], __, __, __
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Bagua Charm +1",          -- __/__ [__, __], __, __, __; Luopan absorb dmg
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Petrov Ring",            -- __/__ [__, __], __,  5,  1
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Geomancy Mitaines +3",--  3/__ [13, __], __, __, __
    -- ear1="Hypaspist Earring",    -- -5/__ [ 5,  1], __, __, __
    -- ear2="Handler's Earring +1", -- __/__ [ 4, __], __, __, __
    -- ring2="Thurandaut Ring +1"   -- __/__ [ 4, __], __, __, __
    -- 21PDT/23MDT [31 Pet DT, 16 Pet Regen], 195 Acc, 18 Store TP, 13 DA
  } -- 25PDT/23MDT [17 Pet DT, 15 Pet Regen], 211 Acc, 31 Store TP, 18 DA

  -- Used for all staves
	sets.engaged.Staff = {
    -- Malignance Pole              -- 20/20 [__, __], 40, __, __
    -- Tzacab Grip                  -- __/__ [__, __], 10, __, __
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands=gear.Nyame_B_hands,       --  7/ 7 [__, __], 40, __,  4
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Carnal Torque",           -- __/__ [__, __], __, __, __; Staff skill
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Petrov Ring",            -- __/__ [__, __], __,  5,  1
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Gazu Bracelet +1",    -- __/__ [__, __], 96, __, __
    -- ring2="Chirich Ring +1",     -- __/__ [__, __], 10,  6, __
    -- 43PDT/43MDT [5 Pet DT, 15 Pet Regen], 367 Acc, 32 Store TP, 17 DA
  } -- 50PDT/50MDT [5 Pet DT, 15 Pet Regen], 301 Acc, 31 Store TP, 22 DA
	sets.engaged.Staff.Safe = {
    -- Malignance Pole              -- 20/20 [__, __], 40, __, __
    -- Tzacab Grip                  -- __/__ [__, __], 10, __, __
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands="Geomancy Mitaines +2",   --  2/__ [12, __], __, __, __
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Carnal Torque",           -- __/__ [__, __], __, __, __; Staff skill
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Petrov Ring",            -- __/__ [__, __], __,  5,  1
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Geomancy Mitaines +3",--  3/__ [13, __], __, __, __
    -- ear1="Hypaspist Earring",    -- -5/__ [ 5,  1], __, __, __
    -- ear2="Handler's Earring +1", -- __/__ [ 4, __], __, __, __
    -- ring1="Defending Ring",      -- 10/10 [__, __], __, __, __
    -- ring2="Thurandaut Ring +1"   -- __/__ [ 4, __], __, __, __
    -- 51PDT/53MDT [31 Pet DT, 16 Pet Regen], 235 Acc, 12 Store TP, 13 DA
  } -- 45PDT/43MDT [17 Pet DT, 15 Pet Regen], 261 Acc, 31 Store TP, 18 DA

  -- Used for all clubs except Idris
	sets.engaged.Club = {
    -- Assume Maxentius             -- __/__ [__, __], 40, __, __
    -- Genmei Shield                -- 10/__ [__, __], 15, __, __
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands=gear.Nyame_B_hands,       --  7/ 7 [__, __], 40, __,  4
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Acantha Torque",          -- __/__ [__, __], __, __, __; Club skill
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Petrov Ring",            -- __/__ [__, __], __,  5,  1
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Gazu Bracelet +1",    -- __/__ [__, __], 96, __, __
    -- ring2="Chirich Ring +1",     -- __/__ [__, __], 10,  6, __
    -- 33PDT/23MDT [5 Pet DT, 15 Pet Regen], 372 Acc, 32 Store TP, 17 DA
  } -- 40PDT/30MDT [5 Pet DT, 15 Pet Regen], 306 Acc, 31 Store TP, 22 DA
	sets.engaged.Club.Safe = {
    -- Assume Maxentius             -- __/__ [__, __], 40, __, __
    -- Genmei Shield                -- 10/__ [__, __], 15, __, __
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands="Geomancy Mitaines +2",   --  2/__ [12, __], __, __, __
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Loricate Torque +1",      --  6/ 6 [__, __], __, __, __
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Defending Ring",         -- 10/10 [__, __], __, __, __
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Geomancy Mitaines +3",--  3/__ [13, __], __, __, __
    -- ear1="Hypaspist Earring",    -- -5/__ [ 5,  1], __, __, __
    -- ear2="Handler's Earring +1", -- __/__ [ 4, __], __, __, __
    -- ring1="Thurandaut Ring +1"   -- __/__ [ 4, __], __, __, __
    -- 47PDT/39MDT [31 Pet DT, 16 Pet Regen], 240 Acc, 12 Store TP, 13 DA
  } -- 51PDT/39MDT [17 Pet DT, 15 Pet Regen], 266 Acc, 26 Store TP, 17 DA

  -- Used for Idris only
	sets.engaged.Idris = {
    -- Idris                        -- __/__ [25, __], 30, __, __
    -- Genmei Shield                -- 10/__ [__, __], 15, __, __
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands=gear.Nyame_B_hands,       --  7/ 7 [__, __], 40, __,  4
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Bagua Charm +1",          -- __/__ [__, __], __, __, __; Luopan dmg absorb
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Petrov Ring",            -- __/__ [__, __], __,  5,  1
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Gazu Bracelet +1",    -- __/__ [__, __], 96, __, __
    -- neck="Acantha Torque",       -- __/__ [__, __], __, __, __; Club skill
    -- ring2="Chirich Ring +1",     -- __/__ [__, __], 10,  6, __
    -- 33PDT/23MDT [30 Pet DT, 15 Pet Regen], 362 Acc, 32 Store TP, 17 DA
  } -- 40PDT/30MDT [30 Pet DT, 15 Pet Regen], 296 Acc, 31 Store TP, 22 DA
  sets.engaged.Idris.Safe = {
    -- Idris                        -- __/__ [25, __], 30, __, __
    -- Genmei Shield                -- 10/__ [__, __], 15, __, __
    -- Dunna                        -- __/__ [ 5, __], __, __, __
		head=gear.Nyame_B_head,         --  7/ 7 [__, __], 40, __,  4
		body=gear.Nyame_B_body,         --  9/ 9 [__, __], 40, __,  5
    hands="Geomancy Mitaines +2",   --  2/__ [12, __], __, __, __
    legs="Jhakri Slops +2",         -- __/__ [__, __], 45,  9, __
    feet=gear.Nyame_B_feet,         --  7/ 7 [__, __], 40, __,  4
    neck="Loricate Torque +1",      --  6/ 6 [__, __], __, __, __
    ear1="Telos Earring",           -- __/__ [__, __], 10,  5,  1
    ear2="Cessance Earring",        -- __/__ [__, __],  6,  3,  3
    ring1="Chirich Ring +1",        -- __/__ [__, __], 10,  6, __
    ring2="Defending Ring",         -- 10/10 [__, __], __, __, __
    back=gear.GEO_Idle_Cape,        -- __/__ [__, 15], __, __, __
    waist="Olseni Belt",            -- __/__ [__, __], 20,  3, __
    -- hands="Geomancy Mitaines +3",--  3/__ [13, __], __, __, __
    -- 52PDT/39MDT [43 Pet DT, 15 Pet Regen], 256 Acc, 26 Store TP, 17 DA
  } -- 51PDT/39MDT [42 Pet DT, 15 Pet Regen], 256 Acc, 26 Store TP, 17 DA


	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	-- Gear that converts elemental damage done to recover MP.
	sets.RecoverMP = {
    head=gear.Nyame_B_head,
    body="Seidr Cotehardie",
  }

	-- Gear for Magic Burst mode.
  sets.MagicBurst = {
    main="Iridal Staff",
    sub="Alber Strap",
    feet="Jhakri Pigaches +2",
    -- main="Bunzi's Rod",
    -- sub="Ammurapi Shield",
    -- range=empty,
    -- ammo="Ghastly Tathlum +1",
    -- head="Ea Hat +1",
    -- body="Ea Houppelande +1",
    -- legs="Ea Slops +1",
    -- neck="Mizukage-no-Kubikazari",
    -- ring2="Mujin Band",
  }
	sets.ResistantMagicBurst = sets.MagicBurst

	sets.buff.Sublimation = {
    waist="Embla Sash"
  }
  sets.buff.DTSublimation = {
    waist="Embla Sash"
  }


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

  sets.Kiting = {
    feet="Herald's Gaiters",
    -- feet="Geomancy Sandals +3",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.CP = {
    back=gear.CP_Cape,
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Idris'] = {
    main="Idris",
    sub="Genmei Shield",
    range="Dunna",
  }
  sets.WeaponSet['Maxentius'] = {
    main="Maxentius",
    sub="Genmei Shield",
    range="Dunna",
  }
  sets.WeaponSet['Staff'] = {
    main="Malignance Pole",
    sub="Tzacab Grip",
    range="Dunna",
  }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function filtered_action(spell)
end

function job_pretarget(spell, action, spellMap, eventArgs)
  if spell.type == 'Geomancy' then
		if spell.english:startswith('Indi') then
			if state.Buff.Entrust then
				if spell.target.type == 'SELF' then
					add_to_chat(204, 'Entrust active - You can\'t entrust yourself.')
					eventArgs.cancel = true
				end
			elseif spell.target.type ~= 'SELF' then
				if state.AutoEntrust.value and ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC')) and spell.target.in_party then
					local spell_recasts = windower.ffxi.get_spell_recasts()
					local abil_recasts = windower.ffxi.get_ability_recasts()
					eventArgs.cancel = true

					if spell_recasts[spell.recast_id] > 1.5 then
						add_to_chat(123,'Abort: ['..spell.english..'] waiting on recast. ('..seconds_to_clock(spell_recasts[spell.recast_id]/60)..')')
					elseif abil_recasts[93] > 0 then
						add_to_chat(123,'Abort: [Entrust] waiting on recast. ('..seconds_to_clock(abil_recasts[93])..')')
					else
						send_command('@input /ja "Entrust" <me>; wait 1.1; input /ma "'..spell.name..'" '..spell.target.name)
					end
				elseif spell.target.raw == '<t>' then
					change_target('<me>')
				end
			end
		elseif spell.english:startswith('Geo') then
			if set.contains(spell.targets, 'Enemy') then
				if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) then
					eventArgs.cancel = true
				end
			elseif not ((spell.target.type == 'PLAYER' and not spell.target.charmed and spell.target.in_party) or (spell.target.type == 'NPC' and spell.target.in_party) or (spell.target.raw == '<stpt>' or spell.target.raw == '<stal>' or spell.target.raw == '<st>')) then
				change_target('<me>')
			end
		end
	end
end

function job_precast(spell, action, spellMap, eventArgs)
  silibs.precast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------

	if spell.english:startswith('Geo-') and pet.isvalid then
		eventArgs.cancel = true
		windower.chat.input('/ja "Full Circle" <me>')
		windower.chat.input:schedule(1.3,'/ma "'..spell.english..'" '..spell.target.raw..'')
	end

	if spell.action_type ~= 'Magic' and buffactive.Bolster and (spell.english == 'Blaze of Glory' or spell.english == 'Ecliptic Attrition') then
		eventArgs.cancel = true
		add_to_chat(123,'Abort: Bolster maxes the strength of bubbles.')
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
  -- Handle belts for elemental WS
  if spell.type == 'WeaponSkill' then
    -- Use safe set depending on OffenseMode setting
    if state.OffenseMode.value == 'Safe' and sets.precast.WS[spell.name] and sets.precast.WS[spell.name].Safe then
      equip(sets.precast.WS[spell.name].Safe)
    end
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
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  -- Always put this last in job_post_precast
  if in_battle_mode() then
    equip(sets.WeaponSet[state.WeaponSet.current])
  end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_precast_hook(spell, action, spellMap, eventArgs)
end

function job_midcast(spell, action, spellMap, eventArgs)
  silibs.midcast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and spell.english ~= 'Impact' then
		if state.MagicBurstMode.value ~= 'Off' then
			if state.CastingMode.value:contains('Resistant') and sets.ResistantMagicBurst then
				equip(sets.ResistantMagicBurst)
			else
				equip(sets.MagicBurst)
			end
		end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Normal' then
				if spell.element == world.day_element then
					if item_available('Zodiac Ring') then
						sets.ZodiacRing = {ring2="Zodiac Ring"}
						equip(sets.ZodiacRing)
					end
				end
			end
		end

		if spell.element and sets.element and sets.element[spell.element] then
			equip(sets.element[spell.element])
		end

		if state.RecoverMode.value ~= 'Never' and (state.RecoverMode.value == 'Always' or tonumber(state.RecoverMode.value:sub(1, -2)) > player.mpp) then
			if state.MagicBurstMode.value ~= 'Off' then
				if state.CastingMode.value:contains('Resistant') and sets.ResistantRecoverBurst then
					equip(sets.ResistantRecoverBurst)
				elseif sets.RecoverBurst then
					equip(sets.RecoverBurst)
				elseif sets.RecoverMP then
					equip(sets.RecoverMP)
				end
			elseif sets.RecoverMP then
				equip(sets.RecoverMP)
			end
		end

    elseif spell.skill == 'Geomancy' then
		if spell.english:startswith('Geo-') then
			if state.Buff['Blaze of Glory'] and sets.buff['Blaze of Glory'] then
				equip(sets.buff['Blaze of Glory'])
				disable('head')
				blazelocked = true
			end
		elseif state.Buff.Entrust and spell.english:startswith('Indi-') then
			if player.equipment.main ~= 'Solstice' and item_available('Solstice') then
				equip({main="Solstice"})
			end
      if sets.buff.Entrust then
        equip(sets.buff.Entrust)
      end
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

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  -- Always put this last in job_post_midcast
  if in_battle_mode() and not spell.type == 'Geomancy' then
    equip(sets.WeaponSet[state.WeaponSet.current])
  end

  ----------- Non-silibs content goes above this line -----------
  silibs.post_midcast_hook(spell, action, spellMap, eventArgs)
end

function job_aftercast(spell, action, spellMap, eventArgs)
  silibs.aftercast_hook(spell, action, spellMap, eventArgs)
  ----------- Non-silibs content goes below this line -----------
  if not spell.interrupted then
    if spell.english:startswith('Indi-') then
			if state.UseCustomTimers.value then
				send_command('@timers d "'..spell.target.name..': '..indi_timer..'"')
				indi_timer = spell.english
				send_command('@timers c "'..spell.target.name..': '..indi_timer..'" '..indi_duration..' down spells/00136.png')
			end
		elseif spell.english:startswith('Geo-') or spell.english == "Mending Halation" or spell.english == "Radial Arcana" then
			eventArgs.handled = true
    elseif state.UseCustomTimers.value and spell.english == 'Sleep' or spell.english == 'Sleepga' then
      send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
    elseif state.UseCustomTimers.value and spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
      send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
    elseif spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
      state.MagicBurstMode:reset()
			if state.DisplayMode.value then
        update_job_states()
      end
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
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)
	if  default_spell_map == 'Cure' or default_spell_map == 'Curaga'  then
		if world.weather_element == 'Light' then
      return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
      return 'LightDayCure'
    end
	elseif spell.skill == "Enfeebling Magic" then
		if spell.english:startswith('Dia') then
			return "Dia"
		elseif spell.type == "WhiteMagic" or spell.english:startswith('Frazzle') or spell.english:startswith('Distract') then
			return 'MndEnfeebles'
		else
			return 'IntEnfeebles'
		end
	elseif spell.skill == 'Geomancy' then
		if spell.english:startswith('Indi') then
			return 'Indi'
		end
  elseif spell.skill == 'Elemental Magic' then
    if default_spell_map == 'ElementalEnfeeble' or spell.english:contains('helix') then
      return
    elseif LowTierNukes:contains(spell.english) then
      return 'LowTierNuke'
    else
      return 'HighTierNuke'
    end
	end
end

function customize_idle_set(idleSet)
  -- If not in DT mode put on move speed gear
  if state.IdleMode.current == 'Normal' and state.DefenseMode.value == 'None' and not classes.CustomIdleGroups:contains('Pet') then
    if classes.CustomIdleGroups:contains('Adoulin') then
      idleSet = set_combine(idleSet, sets.Kiting.Adoulin)
    else
      idleSet = set_combine(idleSet, sets.Kiting)
    end
  end

  if state.CP.current == 'on' then
    idleSet = set_combine(idleSet, sets.CP)
  end

  if buffactive['Sublimation: Activated'] then
    if (state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere')) and sets.buff.Sublimation then
      idleSet = set_combine(idleSet, sets.buff.Sublimation)
    elseif state.IdleMode.value:contains('DT') and sets.buff.DTSublimation then
      idleSet = set_combine(idleSet, sets.buff.DTSublimation)
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
    idleSet = set_combine(idleSet, sets.WeaponSet[state.WeaponSet.current])
  end

  return idleSet
end

function customize_melee_set(meleeSet)
  if player.equipment.main == 'Idris' then
    if state.OffenseMode.value == 'Safe' then
      meleeSet = set_combine(meleeSet, sets.engaged.Idris.Safe)
    else
      meleeSet = set_combine(meleeSet, sets.engaged.Idris)
    end
  else
    local _, weapon = res.items:find(function(item)
      return item.en == player.equipment.main
    end)
    if weapon.skill == 12 then
      -- If staff equipped, use staff engaged set
      if state.OffenseMode.value == 'Safe' then
        meleeSet = set_combine(meleeSet, sets.engaged.Staff.Safe)
      else
        meleeSet = set_combine(meleeSet, sets.engaged.Staff)
      end
    elseif weapon.skill == 11 then
      -- If club equipped, use club engaged set
      if state.OffenseMode.value == 'Safe' then
        meleeSet = set_combine(meleeSet, sets.engaged.Club.Safe)
      else
        meleeSet = set_combine(meleeSet, sets.engaged.Club)
      end
    end
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

  if buffactive.Doom then
    meleeSet = set_combine(meleeSet, sets.buff.Doom)
  end

  if in_battle_mode() then
    meleeSet = set_combine(meleeSet, sets.WeaponSet[state.WeaponSet.current])
  end

  return meleeSet
end

function customize_defense_set(defenseSet)
  if player.equipment.main == 'Idris' then
    defenseSet = set_combine(defenseSet, sets.engaged.Idris.Safe)
  else
    local _, weapon = res.items:find(function(item)
      return item.en == player.equipment.main
    end)
    if weapon.skill == 12 then
      -- If staff equipped, use staff engaged set
      defenseSet = set_combine(defenseSet, sets.engaged.Staff.Safe)
    elseif weapon.skill == 11 then
      -- If club equipped, use club engaged set
      defenseSet = set_combine(defenseSet, sets.engaged.Club.Safe)
    end
  end
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
    defenseSet = set_combine(defenseSet, sets.WeaponSet[state.WeaponSet.current])
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

  local c_msg = state.CastingMode.value

  local d_msg = 'None'
  if state.DefenseMode.value ~= 'None' then
    d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
  end

  local i_msg = state.IdleMode.value
  if classes.CustomIdleGroups:contains('Pet') then
    i_msg = i_msg .. '/Pet'
  end

  local msg = ''
  if state.Kiting.value then
    msg = msg .. ' Kiting |'
  end

  add_to_chat(060, 'Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
      ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
      ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
      ..string.char(31,002)..msg)

  eventArgs.handled = true
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
  check_gear()
  update_idle_groups()
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
  handle_equipping_gear(player.status)
end

-- Called by the 'update' self-command.
function update_idle_groups(cmdParams, eventArgs)
  local isRegening = classes.CustomIdleGroups:contains('Regen')
  local isRefreshing = classes.CustomIdleGroups:contains('Refresh')

  classes.CustomIdleGroups:clear()
  if player.status == 'Idle' then
		if pet.isvalid and pet.distance:sqrt() < 50 then
      classes.CustomIdleGroups:append('Pet')
    end
    
    if mp_jobs:contains(player.main_job) or mp_jobs:contains(player.sub_job) then
      if player.mpp < 50 then
        classes.CustomIdleGroups:append('RefreshSub50')
      elseif (isRefreshing==true and player.mpp < 100) or (isRefreshing==false and player.mpp < 85) then
        classes.CustomIdleGroups:append('Refresh')
      end
    end

    if world.zone == 'Eastern Adoulin' or world.zone == 'Western Adoulin' then
      classes.CustomIdleGroups:append('Adoulin')
    end
  end
end

-- Function that watches pet gain and loss.
function job_pet_change(pet, gain)
	if not gain then
		used_ecliptic = false
	end

  if blazelocked then
		enable('head')
		blazelocked = false
	end
end

function job_self_command(cmdParams, eventArgs)
  silibs.self_command(cmdParams, eventArgs)
  ----------- Non-silibs content goes below this line -----------

	if cmdParams[1] == 'elemental' then
		handle_elemental(cmdParams)
		eventArgs.handled = true
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
	end

  if not midaction() then
    job_update()
  end
end

function get_custom_wsmode(spell, action, spellMap)
  local wsmode = ''

  if player.tp > 2900 then
    wsmode = wsmode..'MaxTP'
  end

  return wsmode
end

-- Handling Elemental spells within Gearswap.
-- Format: gs c elemental <nuke, helix, skillchain1, skillchain2, weather>
function handle_elemental(cmdParams)
  -- cmdParams[1] == 'elemental'
  -- cmdParams[2] == ability to use

  if not cmdParams[2] then
    add_to_chat(123,'Error: No elemental command given.')
    return
  end
  local command = cmdParams[2]:lower()

	if command == 'spikes' then
		windower.chat.input('/ma "'..data.elements.spikes_of[state.ElementalMode.value]..' Spikes" <me>')
		return
	elseif command == 'enspell' then
		windower.chat.input('/ma "En'..data.elements.enspell_of[state.ElementalMode.value]..'" <me>')
		return
	--Leave out target, let shortcuts auto-determine it.
	elseif command == 'weather' then
		if player.sub_job == 'RDM' then
			windower.chat.input('/ma "Phalanx" <me>')
		else
			local spell_recasts = windower.ffxi.get_spell_recasts()
			if (player.target.type == 'SELF' or not player.target.in_party) and buffactive[data.elements.storm_of[state.ElementalMode.value]] and not buffactive['Klimaform'] and spell_recasts[287] < spell_latency then
				windower.chat.input('/ma "Klimaform" <me>')
			else
				windower.chat.input('/ma "'..data.elements.storm_of[state.ElementalMode.value]..'"')
			end
		end
		return
	end

	local target = '<t>'
	if cmdParams[3] then
		if tonumber(cmdParams[3]) then
			target = tonumber(cmdParams[3])
		else
			target = table.concat(cmdParams, ' ', 3)
			target = get_closest_mob_id_by_name(target) or '<t>'
		end
	end
  if command == 'nuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()

		if state.ElementalMode.value == 'Light' then
			if spell_recasts[29] < spell_latency and actual_cost(get_spell_table_by_name('Banish II')) < player.mp then
				windower.chat.input('/ma "Banish II" '..target..'')
			elseif spell_recasts[28] < spell_latency and actual_cost(get_spell_table_by_name('Banish')) < player.mp then
				windower.chat.input('/ma "Banish" '..target..'')
			else
				add_to_chat(123,'Abort: Banishes on cooldown or not enough MP.')
			end
		else
			if player.job_points[(res.jobs[player.main_job_id].ens):lower()].jp_spent > 99 and spell_recasts[get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..' V').id] < spell_latency and actual_cost(get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..' V')) < player.mp then
				windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..' V" '..target..'')
			else
				local tiers = {' IV',' III',' II',''}
				for k in ipairs(tiers) do
					if spell_recasts[get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'')) < player.mp then
						windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'" '..target..'')
						return
					end
				end
				add_to_chat(123,'Abort: All '..data.elements.nuke_of[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
			end
		end
	elseif command == 'ninjutsu' then
		windower.chat.input('/ma "'..data.elements.ninjutsu_nuke_of[state.ElementalMode.value]..': Ni" '..target..'')
	elseif command == 'smallnuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()

		local tiers = {' II',''}
		for k in ipairs(tiers) do
			if spell_recasts[get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'')) < player.mp then
				windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..''..tiers[k]..'" '..target..'')
				return
			end
		end
		add_to_chat(123,'Abort: All '..data.elements.nuke_of[state.ElementalMode.value]..' nukes on cooldown or or not enough MP.')
	elseif command:contains('tier') then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local tierlist = {['tier1']='',['tier2']=' II',['tier3']=' III',['tier4']=' IV',['tier5']=' V',['tier6']=' VI'}

		windower.chat.input('/ma "'..data.elements.nuke_of[state.ElementalMode.value]..tierlist[command]..'" '..target..'')
	elseif command:contains('ara') then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		local tierkey = {'ara3','ara2','ara'}
		local tierlist = {['ara3']='ra III',['ara2']='ra II',['ara']='ra'}
		if command == 'ara' then
			for i in ipairs(tierkey) do
				if spell_recasts[get_spell_table_by_name(data.elements.nukera_of[state.ElementalMode.value]..''..tierlist[tierkey[i]]..'').id] < spell_latency and actual_cost(get_spell_table_by_name(data.elements.nukera_of[state.ElementalMode.value]..''..tierlist[tierkey[i]]..'')) < player.mp then
					windower.chat.input('/ma "'..data.elements.nukera_of[state.ElementalMode.value]..''..tierlist[tierkey[i]]..'" '..target..'')
					return
				end
			end
		else
			windower.chat.input('/ma "'..data.elements.nukera_of[state.ElementalMode.value]..tierlist[command]..'" '..target..'')
		end
	elseif command == 'aga' then
		windower.chat.input('/ma "'..data.elements.nukega_of[state.ElementalMode.value]..'ga" '..target..'')
	elseif command == 'helix' then
		windower.chat.input('/ma "'..data.elements.helix_of[state.ElementalMode.value]..'helix" '..target..'')
	elseif command == 'enfeeble' then
		windower.chat.input('/ma "'..data.elements.elemental_enfeeble_of[state.ElementalMode.value]..'" '..target..'')
	elseif command == 'bardsong' then
		windower.chat.input('/ma "'..data.elements.threnody_of[state.ElementalMode.value]..' Threnody" '..target..'')
  else
    add_to_chat(123,'Unrecognized elemental command.')
  end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(2, 12)
end

function seconds_to_clock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00:00";
  else
    hours = string.format("%01.f", math.floor(seconds/3600));
    mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
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
  equip(sets.WeaponSet[state.WeaponSet.current])
end

function in_battle_mode()
  return state.WeaponSet.current ~= 'Casting'
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

function item_name_to_id(name)
  return (player.inventory[name] or player.wardrobe[name] or player.wardrobe2[name] or player.wardrobe3[name] or player.wardrobe4[name] or {id=nil}).id
end

function get_item_table(item)
  if item then
    local item_type = type(item)

    if item_type == 'string' then
      return res.items[item_name_to_id(item)] or nil
    elseif item_type == 'table' then
      return res.items[item_name_to_id(item.name)] or nil
    end
  else
    return nil
  end
end

function item_available(item)
	if player.inventory[item] or player.wardrobe[item] or player.wardrobe2[item] or player.wardrobe3[item] or player.wardrobe4[item] then
		return true
	else
		return false
	end
end
