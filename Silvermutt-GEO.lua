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
    send_command('gs org')
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
  
  elemental_ws = S{"Black Halo", "Cataclysm"}

  state.OffenseMode:options('Normal')
  state.CastingMode:options('Normal', 'Resistant', 'Proc')
  state.IdleMode:options('Normal','PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')

  state.WeaponSet = M{['description']='Weapon Set', 'Casting', 'Nehushtan',}
  state.CP = M(false, "Capacity Points Mode")
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')
	state.MagicBurstMode = M{['description'] = 'Magic Burst Mode', 'Off', 'Single', 'Lock'}
	state.ElementalMode = M{['description'] = 'Elemental Mode', 'Fire','Ice','Wind','Earth','Lightning','Water'}

	state.Buff.Entrust = buffactive.Entrust or false
	state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false

  LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
      'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
      'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}

	autoindi = 'Torpor'
	autoentrust = 'Fury'
	autoentrustee = '<p1>'
	autogeo = 'Frailty'
	last_indi = nil
	last_geo = nil
	blazelocked = false
	used_ecliptic = false

	state.ShowDistance = M(true, 'Show Geomancy Buff/Debuff distance')
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

  send_command('bind ^insert gs c weaponset cycle')
  send_command('bind ^delete gs c weaponset cycleback')

  send_command('bind @c gs c toggle CP')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
  
  send_command('bind ^- gs c cycleback ElementalMode')
  send_command('bind ^= gs c cycle ElementalMode')

	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
end

-- Executes on first load, main job change, **and sub job change**
function user_setup()
  include('Global-Binds.lua') -- Additional local binds
  
  if player.sub_job == 'WHM' or player.sub_job == 'RDM' then
    send_command('bind !e input /ma "Haste" <stpc>')
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

  send_command('unbind ^insert')
  send_command('unbind ^delete')

  send_command('unbind @c')
	send_command('unbind @`')
	send_command('unbind @f10')

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

  sets.TreasureHunter = {
    waist="Chaac Belt", --1
  }

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {
    body="Bagua Tunic +1",
  }
	sets.precast.JA['Life Cycle'] = {
    body="Geomancy Tunic +1",
    -- back=gear.GEO_Idle_Cape,
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
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Relic hat for Blaze of Glory HP increase.
	sets.buff['Blaze of Glory'] = {}
	
	-- Fast cast sets for spells
	sets.precast.FC = {
    range="Dunna",
    ammo=empty,
    head="Agwu's Cap",
    legs="Geomancy Pants +1",
    ear1="Loquac. Earring",
    ear2="Malignance Earring",
    ring1="Kishar Ring",
    ring2="Prolix Ring",
    -- main=gear.Grioavolr_FC,
    -- sub="Clerisy Strap +1",
    -- ammo="Impatiens",
		-- head="Vanya Hood",
		-- body="Zendik Robe",
    -- hands="Volte Gloves",
    -- feet="Regal Pumps +1",
    -- neck="Voltsurge Torque",
		-- back="Perimede Cape",
    -- waist="Embla Sash",
  }

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {
    range="Dunna",
    ammo=empty,
  })
	
  sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
    hands="Bagua Mitaines +1",
    ear2="Malignance Earring",
  })

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
    -- main="Serenity",
    -- sub="Clerisy Strap +1",
    -- feet="Vanya Clogs",
    -- back="Pahtli Cape",
  })
		
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.Self_Healing = {
    ring2="Asklepian Ring",
    waist="Gishdubar Sash",
    -- neck="Phalaina Locket",
    -- ring1="Kunaji Ring",
  }
	sets.Cure_Received = {
    ring2="Asklepian Ring",
    waist="Gishdubar Sash",
    -- neck="Phalaina Locket",
    -- ring1="Kunaji Ring",
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
    legs="Geomancy Pants +1",
    ear2="Malignance Earring",
    ring1="Kishar Ring",
		-- head=empty,
		-- body="Twilight Cloak",
    -- hands="Volte Gloves",
    -- feet="Regal Pumps +1",
    -- neck="Voltsurge Torque",
    -- ear1="Enchntr. Earring +1",
		-- back="Lifestream Cape",
    -- waist="Witful Belt",
  }

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
    main="Daybreak",
    -- sub="Genmei Shield",
  })
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

  sets.midcast.FastRecast = {
    range="Dunna",
    ammo=empty,
    legs="Geomancy Pants +1",
    ear2="Malignance Earring",
    ring1="Kishar Ring",
    ring2="Prolix Ring",
    -- main=gear.Grioavolr_FC,
    -- sub="Clerisy Strap +1",
		-- head="Amalric Coif +1",
		-- body="Zendik Robe",
    -- hands="Volte Gloves",
    -- feet="Regal Pumps +1",
    -- neck="Voltsurge Torque",
    -- ear1="Enchntr. Earring +1",
		-- back="Lifestream Cape",
    -- waist="Witful Belt",
  }

	sets.midcast.Geomancy = {
    range="Dunna",
    ammo=empty,
    head="Azimuth Hood +1",
    body="Geomancy Tunic +1",
    hands="Geomancy Mitaines +1",
    legs="Geomancy Pants +1",
    feet="Bagua Sandals +1",
    waist="Gishdubar Sash",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    -- main="Solstice",
    -- sub="Genmei Shield",
    -- hands="Geomancy Mitaines +2",
    -- neck="Bagua Charm +2",
    -- ring2="Stikini Ring",
    -- back="Lifestream Cape",
	}

	--Extra Indi duration as long as you can keep your 900 skill cap.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
    legs="Bagua Pants +1",
    -- feet="Azimuth Gaiters +1",
    -- back=gear.GEO_Idle_Cape,
  })
		
  sets.midcast.Cure = {
    main="Daybreak",
    sub=empty,
    legs="Geomancy Pants +1",
    -- sub="Sors Shield",
    -- ammo="Hasty Pinion +1",
    -- head="Vanya Hood",
    -- body="Zendik Robe",
    -- hands="Weath. Cuffs +1",
    -- feet="Vanya Clogs",
    -- neck="Nodens Gorget",
    -- ear1="Gifted Earring",
    -- ear2="Etiolation Earring",
    -- ring1="Janniston Ring",
    -- ring2="Menelaus's Ring",
    -- back="Tempered Cape +1",
    -- waist="Witful Belt",
  }
  
  sets.midcast.LightWeatherCure = {
    main="Daybreak",
    sub=empty,
    legs="Geomancy Pants +1",
    waist="Hachirin-no-Obi",
    -- sub="Sors Shield",
    -- ammo="Hasty Pinion +1",
    -- head="Amalric Coif +1",
    -- body="Vrikodara Jupon",
    -- hands="Telchine Gloves",
    -- feet="Vanya Clogs",
    -- neck="Phalaina Locket",
    -- ear1="Gifted Earring",
    -- ear2="Etiolation Earring",
    -- ring1="Janniston Ring",
    -- ring2="Menelaus's Ring",
    -- back="Twilight Cape",
  }
  
  --Cureset for if it's not light weather but is light day.
  sets.midcast.LightDayCure = {
    main="Daybreak",
    sub=empty,
    legs="Geomancy Pants +1",
    ring2="Lebeche Ring",
    waist="Hachirin-no-Obi",
    -- sub="Sors Shield",
    -- ammo="Hasty Pinion +1",
    -- head="Amalric Coif +1",
    -- body="Zendik Robe",
    -- hands="Telchine Gloves",
    -- feet="Vanya Clogs",
    -- neck="Incanter's Torque",
    -- ear1="Gifted Earring",
    -- ear2="Etiolation Earring",
    -- ring1="Janniston Ring",
    -- back="Twilight Cape",
  }

  sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
    main="Daybreak",
    sub=empty,
    -- sub="Sors Shield",
  })

	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {
    -- hands="Hieros Mittens",
    -- feet="Vanya Clogs",
    -- neck="Debilis Medallion",
    -- ring1="Haoma's Ring",
    -- ring2="Menelaus's Ring",
		-- back="Oretan. Cape +1",
    -- waist="Witful Belt",
  })
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {
    -- main=gear.Grioavolr_FC,
    -- sub="Clemency Grip",
  })
	
  sets.midcast['Elemental Magic'] = {
    main="Daybreak",
    sub=empty,
    ammo="Pemphredo Tathlum", --4
    head=empty,
    body="Cohort Cloak +1", --100
    hands="Jhakri Cuffs +2",
    legs="Jhakri Slops +2",
    feet="Jhakri Pigaches +2",
    neck="Baetyl Pendant", --13
    ear1="Malignance Earring", --8
    ear2="Friomisi Earring", --10
    ring1="Shiva Ring +1", --3
    ring2="Metamorph Ring +1",
    back="Argochampsa Mantle", --12
    waist="Eschan Stone", --7
    -- sub="Ammurapi Shield",
    -- neck="Saevus Pendant +1",
    -- ring2="Freke Ring",
    -- back=gear.GEO_Nuke_Cape,
  }
  sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
    -- main="Daybreak",
    -- sub="Ammurapi Shield",
    -- ammo="Pemphredo Tathlum",
    -- head=gear.Merl_MB_head,
    -- body=gear.Merl_MB_body,
    -- hands="Mallquis Cuffs +2",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_MB_feet,
    -- neck="Sanctity Necklace",
    -- ear1="Regal Earring",
    -- ear2="Malignance Earring",
    -- ring1="Shiva Ring +1",
    -- ring2="Freke Ring",
    -- back=gear.GEO_Nuke_Cape,
    -- waist="Yamabuki-no-Obi",
  })
  sets.midcast['Elemental Magic'].Proc = set_combine(sets.midcast['Elemental Magic'], {
    -- main=empty,
    -- sub=empty,
    -- ammo="Impatiens",
    -- head="Nahtirah Hat",
    -- body="Seidr Cotehardie",
    -- hands="Hagondes Cuffs +1",
    -- legs="Assid. Pants +1",
    -- feet="Regal Pumps +1",
    -- neck="Loricate Torque +1",
    -- ear1="Gifted Earring",
    -- ear2="Loquac. Earring",
    -- ring1="Kishar Ring",
    -- ring2="Prolix Ring",
    -- back="Swith Cape +1",
    -- waist="Witful Belt",
  })
  sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
    -- main="Daybreak",
    -- sub="Ammurapi Shield",
    -- ammo="Pemphredo Tathlum",
    -- head=gear.Merl_MB_head,
    -- body=gear.Merl_MB_body,
    -- hands="Amalric Gages +1",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_MB_feet,
    -- neck="Baetyl Pendant",
    -- ear1="Regal Earring",
    -- ear2="Malignance Earring",
    -- ring1="Metamor. Ring +1",
    -- ring2="Freke Ring",
    -- back=gear.GEO_Nuke_Cape,
    -- waist=sets.ElementalObi,
  })
  sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {
    -- main="Daybreak",
    -- sub="Ammurapi Shield",
    -- ammo="Pemphredo Tathlum",
    -- head=gear.Merl_MB_head,
    -- body=gear.Merl_MB_body,
    -- hands="Amalric Gages +1",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_MB_feet,
    -- neck="Sanctity Necklace",
    -- ear1="Regal Earring",
    -- ear2="Malignance Earring",
    -- ring1="Metamor. Ring +1",
    -- ring2="Freke Ring",
    -- back=gear.GEO_Nuke_Cape,
    -- waist="Yamabuki-no-Obi",
  })

  sets.midcast['Dark Magic'] = {
    ammo="Pemphredo Tathlum",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
    -- main="Rubicundity",
    -- sub="Ammurapi Shield",
    -- head=gear.Merl_MB_head,
    -- body=gear.Merl_MB_body,
    -- hands="Amalric Gages +1",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_Aspir_feet,
    -- ear1="Regal Earring",
    -- ring2="Stikini Ring +1",
    -- back=gear.GEO_Nuke_Cape,
    -- waist="Yamabuki-no-Obi",
  }
  
  sets.midcast.Drain = {
    ammo="Pemphredo Tathlum",
    head="Pixie Hairpin +1",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Archon Ring",
    waist="Fucho-no-obi",
    -- main="Rubicundity",
    -- sub="Ammurapi Shield",
    -- body=gear.Merl_MB_body,
    -- hands="Amalric Gages +1",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_Aspir_feet,
    -- ear1="Regal Earring",
    -- ring2="Evanescence Ring",
    -- back=gear.GEO_Nuke_Cape,
  }
  
  sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
    -- main=gear.Grioavolr_FC,
    -- sub="Clerisy Strap +1",
    -- ammo="Hasty Pinion +1",
		-- head="Amalric Coif +1",
		-- body="Zendik Robe",
    -- hands="Volte Gloves",
    -- legs="Psycloth Lappas",
    -- feet="Regal Pumps +1",
    -- neck="Voltsurge Torque",
    -- ear1="Enchntr. Earring +1",
    -- ring2="Stikini Ring +1",
		-- back="Lifestream Cape",
    -- waist="Witful Belt",
  }
	sets.midcast.Stun.Resistant = {
    main="Daybreak",
    sub=empty,
    ammo="Pemphredo Tathlum",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
    -- sub="Ammurapi Shield",
		-- head="Amalric Coif +1",
		-- body="Zendik Robe",
    -- hands="Amalric Gages +1",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_Aspir_feet,
    -- ear1="Regal Earring",
    -- ring2="Stikini Ring +1",
		-- back=gear.GEO_Nuke_Cape,
    -- waist="Acuity Belt +1",
  }
		
	sets.midcast.Impact = {
    main="Daybreak",
    sub=empty,
    ammo="Pemphredo Tathlum",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
    -- sub="Ammurapi Shield",
		-- head=empty,
		-- body="Twilight Cloak",
    -- hands="Regal Cuffs",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_MB_feet,
    -- ear1="Regal Earring",
    -- ring2="Stikini Ring +1",
		-- back=gear.GEO_Nuke_Cape,
    -- waist="Acuity Belt +1",
  }
		
	sets.midcast.Dispel = {
    main="Daybreak",
    sub=empty,
    ammo="Pemphredo Tathlum",
    neck="Erra Pendant",
    ear2="Malignance Earring",
    ring1="Metamor. Ring +1",
    -- sub="Ammurapi Shield",
		-- head="Amalric Coif +1",
		-- body="Zendik Robe",
    -- hands="Amalric Gages +1",
    -- legs="Merlinic Shalwar",
    -- feet=gear.Merl_Aspir_feet,
    -- ear1="Regal Earring",
    -- ring2="Stikini Ring +1",
		-- back=gear.GEO_Nuke_Cape,
    -- waist="Acuity Belt +1",
  }

	sets.midcast.Dispelga = set_combine(sets.midcast.Dispel, {
    main="Daybreak",
    sub=empty,
    -- sub="Ammurapi Shield",
  })
		
	sets.midcast['Enfeebling Magic'] = {
    main="Daybreak",
    sub=empty,
    range=empty,
    ammo="Hydrocera",
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines +1",
    ear1="Loquac. Earring",
    ear2="Malignance Earring",
    ring1="Metamorph Ring +1",
    -- sub="Ammurapi Shield",
    -- head="Mallquis Chapeau +1",
    -- hands="Geomancy Mitaines +2",
    -- legs="Mallquis Trews +1",
    -- feet="Mallquis Clogs +1",
    -- neck="Bagua Charm +2",
    -- ring2="Stikini Ring",
    -- back="Aurist's Cape +1",
    -- waist="Isa Belt",
  }
	sets.midcast['Enfeebling Magic'].Resistant = {
    main="Daybreak",
    sub=empty,
    ammo="Pemphredo Tathlum",
		head="Befouled Crown",
    neck="Erra Pendant",
    ear2="Digni. Earring",
    ring1="Metamor. Ring +1",
    -- sub="Ammurapi Shield",
		-- body=gear.Merl_MB_body,
    -- hands="Regal Cuffs",
    -- legs="Psycloth Lappas",
    -- feet="Skaoi Boots",
    -- ear1="Regal Earring",
    -- ring2="Stikini Ring +1",
		-- back=gear.GEO_Nuke_Cape,
    -- waist="Luminary Sash",
  }
		
  sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {
    ear2="Malignance Earring",
    -- head="Amalric Coif +1",
    -- waist="Acuity Belt +1",
  })
  sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
    ear2="Malignance Earring",
    -- head="Amalric Coif +1",
    -- waist="Acuity Belt +1",
  })
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
    ear2="Malignance Earring",
    -- head="Amalric Coif +1",
    -- waist="Acuity Belt +1",
  })
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
    ear2="Malignance Earring",
    -- head="Amalric Coif +1",
    -- waist="Acuity Belt +1",
  })
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {
    range=empty,
    -- ring1="Stikini Ring +1",
  })
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
    range=empty,
    -- ring1="Stikini Ring +1",
  })
	
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {
    ring1="Stikini Ring +1",
  })
		
	sets.midcast['Enhancing Magic'] = {
    -- main=gear.Gada_ENH,
    -- sub="Ammurapi Shield",
    -- ammo="Hasty Pinion +1",
		-- head="Telchine Cap",
		-- body="Telchine Chas.",
    -- hands="Telchine Gloves",
    -- legs="Telchine Braconi",
    -- feet="Telchine Pigaches",
    -- neck="Incanter's Torque",
    -- ear1="Andoaa Earring",
    -- ear2="Gifted Earring",
    -- ring1="Stikini Ring +1",
    -- ring2="Stikini Ring +1",
		-- back="Perimede Cape",
    -- waist="Embla Sash",
  }

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
    -- legs="Shedir Seraweels",
    -- neck="Nodens Gorget",
    -- ear2="Earthcry Earring",
    waist="Siegel Sash",
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
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
    -- waist="Sekhmet Corset",
  })
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {
    ear2="Malignance Earring",
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
    -- waist="Sekhmet Corset",
  })
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {
    ear2="Malignance Earring",
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
    -- waist="Sekhmet Corset",
  })
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {
    ear2="Malignance Earring",
    -- ear1="Gifted Earring",
    -- ring2="Sheltered Ring",
    -- waist="Sekhmet Corset",
  })

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = {
    main="Iridal Staff",
    sub=empty,
		head="Befouled Crown",
		body="Jhakri Robe +2",
    ear2="Ethereal Earring",
    ring1="Defending Ring",
    -- main="Chatoyant Staff",
    -- sub="Oneiros Grip",
    -- hands=gear.Merl_Refresh_hands,
    -- legs="Assid. Pants +1",
    -- feet=gear.Merl_Refresh_feet,
    -- neck="Chrys. Torque",
    -- ear1="Etiolation Earring",
    -- ring2="Dark Ring",
		-- back="Umbra Cape",
  }

	-- Idle sets

	sets.idle = {
    main="Malignance Pole",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines +1",
    legs=gear.Nyame_B_legs,
    feet="Bagua Sandals +1",
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Infused Earring",
    ring1="Chirich Ring +1",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- sub="Achaq Grip",
    -- hands="Geomancy Mitaines +2",
    -- legs="Assid. Pants +1",
    -- ring2="Stikini Ring",
    -- waist="Isa Belt",
	}

	sets.idle.PDT = {
    main="Malignance Pole",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- sub="Umbra Strap",
		-- head="Hagondes Hat +1",
    -- hands="Hagondes Cuffs +1",
    -- legs="Hagondes Pants +1",
    -- feet="Mallquis Clogs +2",
    -- ring2="Shadow Ring",
		-- back="Shadow Mantle",
    -- waist="Flax Sash",
  }

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {
    main="Malignance Pole",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines +1",
    legs=gear.Nyame_B_legs,
    feet="Bagua Sandals +1",
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- main="Solstice",
    -- sub="Genmei Shield",
    -- hands="Geomancy Mitaines +2",
    -- legs="Assid. Pants +1",
    -- neck="Bagua Charm +2",
    -- ear1="Handler's Earring",
    -- ear2="Handler's Earring +1",
    -- ring2="Stikini Ring",
		-- back="Lifestream Cape",
    -- waist="Isa Belt",
  }

	sets.idle.PDT.Pet = {
    main="Malignance Pole",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands="Geomancy Mitaines +1",
    legs=gear.Nyame_B_legs,
    feet="Bagua Sandals +1",
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- sub="Umbra Strap",
    -- hands="Geomancy Mitaines +2",
    -- legs="Hagondes Pants +1",
    -- ear1="Handler's Earring",
    -- ear2="Handler's Earring +1",
    -- ring2="Dark Ring",
		-- back=gear.GEO_Idle_Cape,
    -- waist="Isa Belt",
  }

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	sets.idle.Weak = {
    main="Malignance Pole",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- main="Bolelabunga",
    -- sub="Genmei Shield",
    -- hands=gear.Merl_Refresh_hands,
    -- legs="Assid. Pants +1",
    -- feet="Azimuth Gaiters +1",
    -- ear1="Etiolation Earring",
    -- ring2="Dark Ring",
		-- back="Umbra Cape",
    -- waist="Flax Sash",
  }

	-- Defense sets
	sets.defense.PDT = {
    main="Malignance Pole",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head="Befouled Crown",
    body="Jhakri Robe +2",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- sub="Umbra Strap",
		-- head="Hagondes Hat +1",
    -- hands="Hagondes Cuffs +1",
    -- legs="Hagondes Pants +1",
    -- feet="Azimuth Gaiters +1",
    -- ear1="Etiolation Earring",
    -- ear2="Handler's Earring +1",
    -- ring2="Dark Ring",
		-- back="Umbra Cape",
    -- waist="Flax Sash",
  }

	sets.defense.MDT = {
    main="Malignance Pole",
    sub=empty,
    range="Dunna",
    ammo=empty,
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- sub="Umbra Strap",
    -- hands="Hagondes Cuffs +1",
    -- legs="Hagondes Pants +1",
    -- feet="Azimuth Gaiters +1",
    -- ear1="Etiolation Earring",
    -- ear2="Handler's Earring +1",
    -- ring2="Dark Ring",
		-- back="Umbra Cape",
    -- waist="Flax Sash",
  }
		
  sets.defense.MEVA = {
    main="Malignance Pole",
    sub=empty,
    range=empty,
    ammo="Staunch Tathlum +1",
    head="Azimuth Hood +1",
    body="Jhakri Robe +2",
    hands=gear.Nyame_B_hands,
    legs=gear.Nyame_B_legs,
    feet=gear.Nyame_B_feet,
    neck="Loricate Torque +1",
    ear1="Eabani Earring",
    ear2="Halasz Earring",
    ring1="Defending Ring",
    ring2="Archon Ring",
    back="Moonlight Cape",
    waist="Carrier's Sash",
    -- sub="Enki Strap",
    -- hands="Telchine Gloves",
    -- legs="Telchine Braconi",
    -- feet="Azimuth Gaiters +1",
    -- neck="Warder's Charm +1",
    -- ear1="Etiolation Earring",
    -- ear2="Sanare Earring",
    -- ring1="Vengeful Ring",
    -- ring2="Purity Ring",
    -- back=gear.GEO_Idle_Cape,
    -- waist="Luminary Sash",
  }
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.latent_refresh = {
    waist="Fucho-no-obi",
  }
	sets.latent_refresh_grip = {
    -- sub="Oneiros Grip"
  }
	sets.TPEat = {
    -- neck="Chrys. Torque"
  }
	

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		head="Befouled Crown",
		body="Jhakri Robe +2",
    ear1="Cessance Earring",
    ear2="Brutal Earring",
    -- ammo="Hasty Pinion +1",
    -- hands="Gazu Bracelet +1",
    -- legs="Assid. Pants +1",
    -- feet="Battlecast Gaiters",
    -- neck="Asperity Necklace",
    -- ring1="Ramuh Ring +1",
    -- ring2="Ramuh Ring +1",
		-- back="Kayapa Cape",
    -- waist="Witful Belt",
  }
		

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {
    -- body="Seidr Cotehardie",
  }
	
	-- Gear for Magic Burst mode.
  sets.MagicBurst = {
    main="Iridal Staff",
    sub="Alber Strap",
    feet="Jhakri Pigaches +2",
    -- main=gear.Grioavolr_MB,
    -- head="Ea Hat",
    -- body="Ea Houppelande",
    -- legs="Ea Slops",
    -- neck="Mizu. Kubikazari",
    -- ring1="Mujin Band",
  }
	sets.ResistantMagicBurst = {
    main="Iridal Staff",
    sub="Alber Strap",
    feet="Jhakri Pigaches +2",
    -- main=gear.Grioavolr_MB,
    -- sub="Enki Strap",
    -- head="Ea Hat",
    -- body="Ea Houppelande",
    -- legs="Ea Slops",
    -- neck="Mizu. Kubikazari",
    -- ring1="Mujin Band",
  }
	
	sets.buff.Sublimation = {
    -- waist="Embla Sash"
  }
  sets.buff.DTSublimation = {
    -- waist="Embla Sash"
  }


  ------------------------------------------------------------------------------------------------
  ---------------------------------------- Special Sets ------------------------------------------
  ------------------------------------------------------------------------------------------------

  sets.ElementalObi = {waist="Hachirin-no-Obi",}

  sets.buff.Doom = {
    neck="Nicander's Necklace", --20
    ring2="Eshmun's Ring", --20
    waist="Gishdubar Sash", --10
  }

  sets.Kiting = {
    feet="Herald's Gaiters",
  }
  sets.Kiting.Adoulin = {
    body="Councilor's Garb",
  }
  sets.CP = {
    back=gear.CP_Cape,
  }

  sets.WeaponSet = {}
  sets.WeaponSet['Nehushtan'] = {
    -- main='Nehushtan',
    -- sub='Genmei Shield'
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

	if spell.action_type == 'Magic' then
    if state.CastingMode.value == 'Proc' then
        classes.CustomClass = 'Proc'
    end
	elseif buffactive.Bolster and (spell.english == 'Blaze of Glory' or spell.english == 'Ecliptic Attrition') then
		eventArgs.cancel = true
		add_to_chat(123,'Abort: Bolster maxes the strength of bubbles.')
  end
end

function job_post_precast(spell, action, spellMap, eventArgs)
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
			if sets.midcast.Geomancy.main == 'Idris' and item_available('Solstice') then
				equip({main="Solstice"})
			end
		end
  end

  -- If slot is locked, keep current equipment on
  if locked_neck then equip({ neck=player.equipment.neck }) end
  if locked_ear1 then equip({ ear1=player.equipment.ear1 }) end
  if locked_ear2 then equip({ ear2=player.equipment.ear2 }) end
  if locked_ring1 then equip({ ring1=player.equipment.ring1 }) end
  if locked_ring2 then equip({ ring2=player.equipment.ring2 }) end

  -- Always put this last in job_post_midcast
  if in_battle_mode() then
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
      if spell.target.type == 'SELF' then
        last_indi = string.sub(spell.english,6)
      end
      if not classes.CustomIdleGroups:contains('Indi') then
        classes.CustomIdleGroups:append('Indi')
      end
			if state.UseCustomTimers.value then
				send_command('@timers d "'..spell.target.name..': '..indi_timer..'"')
				indi_timer = spell.english
				send_command('@timers c "'..spell.target.name..': '..indi_timer..'" '..indi_duration..' down spells/00136.png')
			end
		elseif spell.english:startswith('Geo-') or spell.english == "Mending Halation" or spell.english == "Radial Arcana" then
			eventArgs.handled = true
			if spell.english:startswith('Geo-') then
				last_geo = string.sub(spell.english,5)
			end
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

	if not player.indi then
    classes.CustomIdleGroups:clear()
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
  if player.indi and not classes.CustomIdleGroups:contains('Indi') then
    classes.CustomIdleGroups:append('Indi')
    if not midaction () then
      handle_equipping_gear(player.status)
    end
  elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
    classes.CustomIdleGroups:clear()
    if not midaction () then
      handle_equipping_gear(player.status)
    end
  end
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

  if buffactive['Sublimation: Activated'] then
    if (state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere')) and sets.buff.Sublimation then
      idleSet = set_combine(idleSet, sets.buff.Sublimation)
    elseif state.IdleMode.value:contains('DT') and sets.buff.DTSublimation then
      idleSet = set_combine(idleSet, sets.buff.DTSublimation)
    end
  end

  if state.IdleMode.value == 'Normal' or state.IdleMode.value:contains('Sphere') then
    if player.mpp < 51 then
      if sets.latent_refresh then
        idleSet = set_combine(idleSet, sets.latent_refresh)
      end
      
      if not in_battle_mode() and idleSet.main then
        local main_table = get_item_table(idleSet.main)

        if main_table and main_table.skill == 12 and sets.latent_refresh_grip then
          idleSet = set_combine(idleSet, sets.latent_refresh_grip)
        end
        
        if player.tp > 10 and sets.TPEat then
          idleSet = set_combine(idleSet, sets.TPEat)
        end
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
  
  if in_battle_mode() then
    idleSet = set_combine(idleSet, sets.WeaponSet[state.WeaponSet.current])
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
    meleeSet = set_combine(meleeSet, sets.WeaponSet[state.WeaponSet.current])
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
    if player.indi then
      classes.CustomIdleGroups:append('Indi')
    end
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

	if cmdParams[1] == 'autoindi' and cmdParams[2] then
		autoindi = cmdParams[2]:ucfirst()
		add_to_chat(122,'Your Auto Indi- spell is set to '..autoindi..'.')
		if state.DisplayMode.value then update_job_states()	end
	elseif cmdParams[1] == 'autogeo' and cmdParams[2] then
		autogeo = cmdParams[2]:ucfirst()
		add_to_chat(122,'Your Auto Geo- spell is set to '..autogeo..'.')
		if state.DisplayMode.value then update_job_states()	end
	elseif cmdParams[1] == 'autoentrust' and cmdParams[2] then
		autoentrust = cmdParams[2]:ucfirst()
		add_to_chat(122,'Your Auto Entrust Indi- spell is set to '..autoentrust..'.')
		if state.DisplayMode.value then update_job_states()	end
	elseif cmdParams[1]:contains('trustee') and cmdParams[2] then
		autoentrustee = cmdParams[2]:ucfirst()
		add_to_chat(122,'Your Auto Entrustee target is set to '..autoentrustee..'.')
		if state.DisplayMode.value then update_job_states()	end
	elseif cmdParams[1] == 'elemental' then
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

function job_tick()
	if check_geo() then return true end
	if check_buff() then return true end
	if check_buffup() then return true end
	return false
end

function check_geo()
	if state.AutoBuffMode.value ~= 'Off' and not data.areas.cities:contains(world.area) then
		if not pet.isvalid then
			used_ecliptic = false
		end
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if autoindi ~= 'None' and ((not player.indi) or last_indi ~= autoindi) then
			windower.chat.input('/ma "Indi-'..autoindi..'" <me>')
			tickdelay = os.clock() + 2.1
			return true
		elseif autoentrust ~= 'None' and abil_recasts[93] < latency and (player.in_combat or state.CombatEntrustOnly.value == false) then
			send_command('@input /ja "Entrust" <me>; wait 1.1; input /ma "Indi-'..autoentrust..'" '..autoentrustee)
			tickdelay = os.clock() + 3.5
			return true
		elseif pet.isvalid then
			local pet = windower.ffxi.get_mob_by_target("pet")
			if pet.distance:sqrt() > 50 then --If pet is greater than detectable.
				windower.chat.input('/ja "Full Circle" <me>')
				tickdelay = os.clock() + 1.1
				return true
			elseif state.AutoGeoAbilities.value and abil_recasts[244] < latency and not used_ecliptic and not buffactive.Bolster then
				windower.chat.input('/ja "Ecliptic Attrition" <me>;')
				used_ecliptic = true
				return true
			else
				return false
			end
		elseif autogeo ~= 'None' and (windower.ffxi.get_mob_by_target('bt') or data.spells.geo_buffs:contains(autogeo)) then
			if player.in_combat and state.AutoGeoAbilities.value and abil_recasts[247] < latency and not buffactive.Bolster then
				windower.chat.input('/ja "Blaze of Glory" <me>;')
				tickdelay = os.clock() + 1.1
				return true
			else
				windower.chat.input('/ma "Geo-'..autogeo..'" <bt>')
				tickdelay = os.clock() + 3.1
				return true
			end
		end
	end
	return false
end

--Luopan Distance Tracking
debuff_list = S{'Gravity','Paralysis','Slow','Languor','Vex','Torpor','Slip','Malaise','Fade','Frailty','Wilt','Poison'}
ignore_list = S{'SlipperySilas','HareFamiliar','SheepFamiliar','FlowerpotBill','TigerFamiliar','FlytrapFamiliar','LizardFamiliar','MayflyFamiliar','EftFamiliar','BeetleFamiliar','AntlionFamiliar','CrabFamiliar','MiteFamiliar','KeenearedSteffi','LullabyMelodia','FlowerpotBen','SaberSiravarde','FunguarFamiliar','ShellbusterOrob','ColdbloodComo','CourierCarrie','Homunculus','VoraciousAudrey','AmbusherAllie','PanzerGalahad','LifedrinkerLars','ChopsueyChucky','AmigoSabotender','NurseryNazuna','CraftyClyvonne','PrestoJulio','SwiftSieghard','MailbusterCetas','AudaciousAnna','TurbidToloi','LuckyLulush','DipperYuly','FlowerpotMerle','DapperMac','DiscreetLouise','FatsoFargann','FaithfulFalcorr','BugeyedBroncha','BloodclawShasra','GorefangHobs','GooeyGerard','CrudeRaphie','DroopyDortwin','SunburstMalfik','WarlikePatrick','ScissorlegXerin','RhymingShizuna','AttentiveIbuki','AmiableRoche','HeraldHenry','BrainyWaluis','SuspiciousAlice','HeadbreakerKen','RedolentCandi','CaringKiyomaro','HurlerPercival','AnklebiterJedd','BlackbeardRandy','FleetReinhard','GenerousArthur','ThreestarLynn','BraveHeroGlenn','SharpwitHermes','AlluringHoney','CursedAnnabelle','SwoopingZhivago','BouncingBertha','MosquitoFamilia','Ifrit','Shiva','Garuda','Fenrir','Carbuncle','Ramuh','Leviathan','CaitSith','Diabolos','Titan','Atomos','WaterSpirit','FireSpirit','EarthSpirit','ThunderSpirit','AirSpirit','LightSpirit','DarkSpirit','IceSpirit', 'Azure','Cerulean','Rygor','Firewing','Delphyne','Ember','Rover','Max','Buster','Duke','Oscar','Maggie','Jessie','Lady','Hien','Raiden','Lumiere','Eisenzahn','Pfeil','Wuffi','George','Donryu','Qiqiru','Karav-Marav','Oboro','Darug Borug','Mikan','Vhiki','Sasavi','Tatang','Nanaja','Khocha','Nanaja','Khocha','Dino','Chomper','Huffy','Pouncer','Fido','Lucy','Jake','Rocky','Rex','Rusty','Himmelskralle','Gizmo','Spike','Sylvester','Milo','Tom','Toby','Felix','Komet','Bo','Molly','Unryu','Daisy','Baron','Ginger','Muffin','Lumineux','Quatrevents','Toryu','Tataba','Etoilazuree','Grisnuage','Belorage','Centonnerre','Nouvellune','Missy','Amedeo','Tranchevent','Soufflefeu','Etoile','Tonnerre','Nuage','Foudre','Hyuh','Orage','Lune','Astre','Waffenzahn','Soleil','Courageux','Koffla-Paffla','Venteuse','Lunaire','Tora','Celeste','Galja-Mogalja','Gaboh','Vhyun','Orageuse','Stellaire','Solaire','Wirbelwind','Blutkralle','Bogen','Junker','Flink','Knirps','Bodo','Soryu','Wanaro','Totona','Levian-Movian','Kagero','Joseph','Paparaz','Coco','Ringo','Nonomi','Teter','Gigima','Gogodavi','Rurumo','Tupah','Jyubih','Majha','Luron','Drille','Tournefoux','Chafouin','Plaisantin','Loustic','Histrion','Bobeche','Bougrion','Rouleteau','Allouette','Serenade','Ficelette','Tocadie','Caprice','Foucade','Capillotte','Quenotte','Pacotille','Comedie','Kagekiyo','Toraoh','Genta','Kintoki','Koumei','Pamama','Lobo','Tsukushi','Oniwaka','Kenbishi','Hannya','Mashira','Nadeshiko','E100','Koume','X-32','Poppo','Asuka','Sakura','Tao','Mao','Gadget','Marion','Widget','Quirk','Sprocket','Cogette','Lecter','Coppelia','Sparky','Clank','Calcobrena','Crackle','Ricochet','Josette','Fritz','Skippy','Pino','Mandarin','Jackstraw','Guignol','Moppet','Nutcracker','Erwin','Otto','Gustav','Muffin','Xaver','Toni','Ina','Gerda','Petra','Verena','Rosi','Schatzi','Warashi','Klingel','Clochette','Campanello','Kaiserin','Principessa','Butler','Graf','Caro','Cara','Mademoiselle','Herzog','Tramp','V-1000','Hikozaemon','Nine','Acht','Quattro','Zero','Dreizehn','Seize','Fukusuke','Mataemon','Kansuke','Polichinelle','Tobisuke','Sasuke','Shijimi','Chobi','Aurelie','Magalie','Aurore','Caroline','Andrea','Machinette','Clarine','Armelle','Reinette','Dorlote','Turlupin','Klaxon','Bambino','Potiron','Fustige','Amidon','Machin','Bidulon','Tandem','Prestidige','Purute-Porute','Bito-Rabito','Cocoa','Totomo','Centurion','A7V','Scipio','Sentinel','Pioneer','Seneschal','Ginjin','Amagatsu','Dolly','Fantoccini','Joe','Kikizaru','Whippet','Punchinello','Charlie','Midge','Petrouchka','Schneider','Ushabti','Noel','Yajirobe','Hina','Nora','Shoki','Kobina','Kokeshi','Mame','Bishop','Marvin','Dora','Data','Robin','Robby','Porlo-Moperlo','Paroko-Puronko','Pipima','Gagaja','Mobil','Donzel','Archer','Shooter','Stephen','Mk.IV','Conjurer','Footman','Tokotoko','Sancho','Sarumaro','Picket','Mushroom','Shantotto','Naji','Kupipi','Excenmille','Ayame','NanaaMihgo','Curilla','Volker','Ajido-Marujido','Trion','Zeid','Lion','Tenzen','MihliAliapoh','Valaineral','Joachim','NajaSalaheem','Prishe','Ulmia','ShikareeZ','Cherukiki','IronEater','Gessho','Gadalar','Rainemard','Ingrid','LehkoHabhoka','Nashmeira','Zazarg','Ovjang','Mnejing','Sakura','Luzaf','Najelith','Aldo','Moogle','Fablinix','Maat','D.Shantotto','StarSibyl','Karaha-Baruha','Cid','Gilgamesh','Areuhat','SemihLafihna','Elivira','Noillurie','LhuMhakaracca','FerreousCoffin','Lilisette','Mumor','UkaTotlihn','Klara','RomaaMihgo','KuyinHathdenna','Rahal','Koru-Moru','Pieuje','InvincibleShld','Apururu','JakohWahcondalo','Flaviria','Babban','Abenzio','Rughadjeen','Kukki-Chebukki','Margret','Chacharoon','LheLhangavo','Arciela','Mayakov','Qultada','Adelheid','Amchuchu','Brygid','Mildaurion','Halver','Rongelouts','Leonoyne','Maximilian','Kayeel-Payeel','Robel-Akbel','Kupofried','Selh\'teus','Yoran-Oran','Sylvie','Abquhbah','Balamor','August','Rosulatia','Teodor','Ullegore','Makki-Chebukki','KingOfHearts','Morimar','Darrcuiln','ArkHM','ArkEV','ArkMR','ArkTT','ArkGK','Iroha','Ygnas','Excenmille','Ayame','Maat','Aldo','NajaSalaheem','Lion','Zeid'}

luopantxt = {}
luopantxt.pos = {}
luopantxt.pos.x = -200
luopantxt.pos.y = 175
luopantxt.text = {}
luopantxt.text.font = 'Arial'
luopantxt.text.size = 12
luopantxt.flags = {}
luopantxt.flags.right = true

luopan = texts.new('${value}', luopantxt)

luopan:bold(true)
luopan:bg_alpha(0)--128
luopan:stroke_width(2)
luopan:stroke_transparency(192)

bt_color = '\\cs(230,118,116)'

frame_count = 0
windower.raw_register_event('prerender', function()
  if frame_count%15 == 0 and windower.ffxi.get_info().logged_in then
    send_command('gs c update')
  end
  frame_count = frame_count + 1

  if windower.ffxi.get_info().logged_in and windower.ffxi.get_player() then
    -- Use frame count to limit execution rate
    -- Every 15 frames (roughly 0.25-0.5 seconds depending on FPS)
    if frame_count%15 == 0 then
      send_command('gs c update')
    end

    -- Increment frame_count but prevent overflows
    if frame_count == MAX_INT then
      frame_count = 0
    else
      frame_count = frame_count + 1
    end
  end

  local s = windower.ffxi.get_mob_by_target('me')
  if windower.ffxi.get_mob_by_target('pet') then
    myluopan = windower.ffxi.get_mob_by_target('pet')
  else
    myluopan = nil
  end
  local luopan_txtbox = ''
  local indi_count = 0
  local geo_count = 0
  local battle_target = windower.ffxi.get_mob_by_target('bt') or false
  if myluopan and last_geo then
    luopan_txtbox = luopan_txtbox..' \\cs(0,255,0)Geo-'..last_geo..':\\cs(255,255,255)\n'
    for i,v in pairs(windower.ffxi.get_mob_array()) do
      local DistanceBetween = ((myluopan.x - v.x)*(myluopan.x-v.x) + (myluopan.y-v.y)*(myluopan.y-v.y)):sqrt()
      if DistanceBetween < (6 + v.model_size) and not (v.status == 2 or v.status == 3) and v.name and v.name ~= '' and v.name ~= "Luopan" and v.valid_target and v.model_size > 0 then
        if debuff_list:contains(last_geo) then
          if v.is_npc and not (v.in_party or ignore_list:contains(v.name)) then
            if battle_target and battle_target.id == v.id then
              luopan_txtbox = luopan_txtbox..' '..bt_color..v.name.." "..string.format("%.2f",DistanceBetween).."\\cs(255,255,255)\n"
            else
              luopan_txtbox = luopan_txtbox..' '..v.name.." "..string.format("%.2f",DistanceBetween).."\n"
            end
            geo_count = geo_count + 1
          end
        elseif v.in_party then
          luopan_txtbox = luopan_txtbox..' '..v.name.." "..string.format("%.2f",DistanceBetween).."\n"
          geo_count = geo_count + 1
        end
      end
    end
  end

  if buffactive['Colure Active'] and last_indi then
    if myluopan then
      luopan_txtbox = luopan_txtbox..'\n'
    end
    luopan_txtbox = luopan_txtbox..' \\cs(0,255,0)Indi-'..last_indi..':\\cs(255,255,255)\n'
    for i,v in pairs(windower.ffxi.get_mob_array()) do
      local DistanceBetween = ((s.x - v.x)*(s.x-v.x) + (s.y-v.y)*(s.y-v.y)):sqrt()
      if DistanceBetween < (6 + v.model_size) and (v.status == 1 or v.status == 0) and v.name and v.name ~= '' and v.name ~= "Luopan" and v.name ~= s.name and v.valid_target and v.model_size > 0 then
        if debuff_list:contains(last_indi) then
          if v.is_npc and not (v.in_party or ignore_list:contains(v.name)) then
            if battle_target and battle_target.id == v.id then
              luopan_txtbox = luopan_txtbox..' '..bt_color..v.name.." "..string.format("%.2f",DistanceBetween).."\\cs(255,255,255)\n"
            else
              luopan_txtbox = luopan_txtbox..' '..v.name.." "..string.format("%.2f",DistanceBetween).."\n"
            end
            indi_count = indi_count + 1
          end
        else
          if v.in_party then
            luopan_txtbox = luopan_txtbox..' '..v.name.." "..string.format("%.2f",DistanceBetween).."\n"
            indi_count = indi_count + 1
          end
        end
      end
    end
  end

  luopan.value = luopan_txtbox
  if state.ShowDistance and state.ShowDistance.value and ((myluopan and geo_count ~= 0) or (buffactive['Colure Active'] and indi_count ~= 0)) then
    luopan:visible(true)
  else
    luopan:visible(false)
  end
end)

function check_buff()
	if state.AutoBuffMode.value ~= 'Off' and not data.areas.cities:contains(world.area) then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		for i in pairs(buff_spell_lists[state.AutoBuffMode.Value]) do
			if not buffactive[buff_spell_lists[state.AutoBuffMode.Value][i].Buff] and (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Always' or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Combat' and (player.in_combat or being_attacked)) or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Engaged' and player.status == 'Engaged') or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'Idle' and player.status == 'Idle') or (buff_spell_lists[state.AutoBuffMode.Value][i].When == 'OutOfCombat' and not (player.in_combat or being_attacked))) and spell_recasts[buff_spell_lists[state.AutoBuffMode.Value][i].SpellID] < spell_latency and silent_can_use(buff_spell_lists[state.AutoBuffMode.Value][i].SpellID) then
				windower.chat.input('/ma "'..buff_spell_lists[state.AutoBuffMode.Value][i].Name..'" <me>')
				tickdelay = os.clock() + 2
				return true
			end
		end
	else
		return false
	end
end

function check_buffup()
	if buffup ~= '' then
		local needsbuff = false
		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) then
				needsbuff = true
				break
			end
		end

		if not needsbuff then
			add_to_chat(217, 'All '..buffup..' buffs are up!')
			buffup = ''
			return false
		end

		local spell_recasts = windower.ffxi.get_spell_recasts()

		for i in pairs(buff_spell_lists[buffup]) do
			if not buffactive[buff_spell_lists[buffup][i].Buff] and silent_can_use(buff_spell_lists[buffup][i].SpellID) and spell_recasts[buff_spell_lists[buffup][i].SpellID] < spell_latency then
				windower.chat.input('/ma "'..buff_spell_lists[buffup][i].Name..'" <me>')
				tickdelay = os.clock() + 2
				return true
			end
		end

		return false
	else
		return false
	end
end

buff_spell_lists = {
	Auto = {
		{Name='Haste',		  Buff='Haste',		  SpellID=57,		When='Always'},
		{Name='Refresh',	  Buff='Refresh',		SpellID=109,	When='Always'},
		{Name='Stoneskin',	Buff='Stoneskin',	SpellID=54,		When='Always'},
	},

	Default = {
		{Name='Haste',		  Buff='Haste',		  SpellID=57,		Reapply=false},
		{Name='Refresh',	  Buff='Refresh',		SpellID=109,	Reapply=false},
		{Name='Aquaveil',	  Buff='Aquaveil',	SpellID=55,		Reapply=false},
		{Name='Stoneskin',	Buff='Stoneskin',	SpellID=54,		Reapply=false},
		{Name='Blink',		  Buff='Blink',		  SpellID=53,		Reapply=false},
		{Name='Regen',		  Buff='Regen',		  SpellID=108,	Reapply=false},
		{Name='Phalanx',	  Buff='Phalanx',		SpellID=106,	Reapply=false},
	},
}

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
  -- Default macro set/book: (set, book)
  set_macro_page(1, 12)
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
