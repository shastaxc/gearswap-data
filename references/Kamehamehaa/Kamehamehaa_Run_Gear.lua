function user_job_setup()

	state.OffenseMode:options('Normal','Acc','Tank')
	state.WeaponskillMode:options('Match','Normal','Acc','Tank')
	state.CastingMode:options('Normal','SIRD')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal','Tank')
	state.Weapons:options('None','Lionheart','Aettir')

	state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP'}

	gear.enmity_jse_back = {name="Moonlight cape",augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
	gear.stp_jse_back = {name="Moonlight cape",augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10',}}
	gear.da_jse_back = {name="Moonlight cape",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.fc_back = { name="Moonlight cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Spell interruption rate down-10%',}}

	-- Additional local binds
	send_command('bind @f9 gs c cycle Weapons')
	send_command('bind @f10 gs c cycle OffenseMode')
	send_command('bind @f11 gs c toggle DefenseMode')
	send_command('bind @w gs c useitem ring1 "Warp Ring"')

	select_default_macro_book()
end

function init_gear_sets()

  sets.Enmity ={ 
    ammo="Staunch tathlum +1",
    head="Rune. Bandeau +3",
    body="Emet harness +1",
    hands="Nyame gauntlets",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Cryptic earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  }

  sets.Enmity.SIRD = {}

  sets.Enmity.DT = {}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Item sets.

	-- Precast sets to enhance JAs
  sets.precast.JA['Vallation'] = set_combine(sets.Enmity,{body="Runeist's Coat +3",legs="Futhark Trousers +3"})
  sets.precast.JA['Valiance'] = sets.precast.JA['Vallation'] 
  sets.precast.JA['Pflug'] = set_combine(sets.Enmity,{feet="Runeist's Boots +3"})
  sets.precast.JA['Battuta'] = set_combine(sets.Enmity,{head="Fu. Bandeau +3"})
  sets.precast.JA['Liement'] = set_combine(sets.Enmity,{body="Futhark Coat +1"})
  sets.precast.JA['Gambit'] = set_combine(sets.Enmity,{hands="Runeist's Mitons +3"})
  sets.precast.JA['Rayke'] = set_combine(sets.Enmity,{feet="Futhark Boots +1"})
  sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity,{body="Futhark Coat +1"})
  sets.precast.JA['Swordplay'] = set_combine(sets.Enmity,{hands="Futhark Mitons +3"})
  sets.precast.JA['Embolden'] = set_combine(sets.Enmity,{})
  sets.precast.JA['One For All'] = set_combine(sets.Enmity,{})
  sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Last Resort'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

  sets.precast.JA['Vallation'].DT = set_combine(sets.Enmity.DT,{body="Runeist's Coat +3", legs="Futhark Trousers +3"})
  sets.precast.JA['Valiance'].DT = sets.precast.JA['Vallation'].DT
  sets.precast.JA['Pflug'].DT = set_combine(sets.Enmity.DT,{feet="Runeist's Boots +3"})
  sets.precast.JA['Battuta'].DT = set_combine(sets.Enmity.DT,{head="Fu. Bandeau +3"})
  sets.precast.JA['Liement'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +1"})
  sets.precast.JA['Gambit'].DT = set_combine(sets.Enmity.DT,{hands="Runeist's Mitons +3"})
  sets.precast.JA['Rayke'].DT = set_combine(sets.Enmity.DT,{feet="Futhark Boots +1"})
  sets.precast.JA['Elemental Sforzo'].DT = set_combine(sets.Enmity.DT,{body="Futhark Coat +1"})
  sets.precast.JA['Swordplay'].DT = set_combine(sets.Enmity.DT,{hands="Futhark Mitons +3"})
  sets.precast.JA['Embolden'].DT = set_combine(sets.Enmity.DT,{})
  sets.precast.JA['One For All'].DT = set_combine(sets.Enmity.DT,{})
  sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Last Resort'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Animated Flourish'].DT = set_combine(sets.Enmity.DT, {})

  sets.precast.JA['Lunge'] = {
    ammo="Seeth. Bomblet +1",
    head=gear.herculean_nuke_head,
    body="Nyame mail",
    hands="Carmine Fin. Ga. +1",
    neck="Baetyl Pendant",
    ear1="Friomisi Earring",
    ring1="Shiva Ring +1",
    back="Toro Cape",
    waist="Eschan Stone",
  }

	sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']

	-- Gear for specific elemental nukes.
	sets.element.Dark = {head="Pixie Hairpin +1",ring2="Defending ring"}

	-- Pulse sets, different stats for different rune modes, stat aligned.
  sets.precast.JA['Vivacious Pulse'] = {head="Erilaz Galea +1",neck="Incanter's Torque",legs="Rune. Trousers +3"}
  sets.precast.JA['Vivacious Pulse']['Ignis'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Gelus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Flabra'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tellus'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Sulpor'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Unda'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Lux'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	sets.precast.JA['Vivacious Pulse']['Tenebrae'] = set_combine(sets.precast.JA['Vivacious Pulse'], {})
	
	
  -- Waltz set (chr and vit)
  sets.precast.Waltz = {
    ammo="Yamarang",
    head="Rune. Bandeau +3",
    legs="Dashing Subligar",
    neck="Unmoving Collar +1",
    ear1="Enchntr. Earring +1",
    ear2="Handler's Earring +1",
    ring1="Defending Ring",
    ring2="Valseur's Ring",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Chaac Belt",
  }

  -- Don't need any special gear for Healing Waltz.
  sets.precast.Waltz['Healing Waltz'] = {}

  sets.precast.Step = {}

	sets.precast.JA['Violent Flourish'] = {}

	-- Fast cast sets for spells
  sets.precast.FC = {
    ammo="Staunch Tathlum +1",
    head="Rune. Bandeau +3",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +2",
    feet="Carmine Greaves +1",
    neck="Orunmila's torque",
    ear1="Loquac. earring",
    ring1="Weather. Ring",
    ring2="Gelatinous ring +1",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10',}},
    waist="Siegel sash",
  }

	sets.precast.FC.DT = {
    ammo="Staunch Tathlum +1",
    head="Nyame helm",neck="Futhark torque +1",ear1="Ethereal earring",ear2="Odnowa earring +1",
    body="Nyame mail",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Rune. Trousers +3",
    feet="Carmine Greaves +1",
		ring1="Weather. Ring",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume belt +1",
  }

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
    hands="Regal gauntlets",
    legs="Futhark Trousers +3",
    waist="Siegel Sash",
  })

  sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
    body="Passion jacket",
    hands="Regal gauntlets",
    neck='Magoraga Beads',
    ear1= "Halasz earring",
    ring1="Evanescence ring",
    ring2="Defending ring",
	  back="Shadow mantle",
  })


	sets.precast.FC.Cure = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {
    ammo="Knobkierrie",
    head="Nyame helm",
    body="Nyame mail",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Ayanmo gambieras +2",
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Sherida Earring",
    ring1="Ilabrat ring",
    ring2="Ifrit ring +1",
    back="Evasionist's cape",
    waist="Fotia Belt",
  }
	sets.precast.WS.Acc = {}
	sets.precast.WS.Tank = {}


  sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{
    ammo="Knobkierrie",
    head="Nyame helm",
    body="Nyame mail",
    hands="Meg. Gloves +2",
    legs="Meg. Chausses +2",
    feet="Ayanmo gambieras +2",
    neck="Fotia Gorget",
    ear1="Moonshade Earring",
    ear2="Sherida Earring",
    ring1="Ilabrat ring",
    ring2="Ifrit ring +1",
    back="Evasionist's cape",
    waist="Fotia Belt",
  })
  sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc,{})
  sets.precast.WS['Resolution'].Tank = set_combine(sets.precast.WS.Tank,{})

  sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,{})
  sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS.Acc,{
    head="Lilitu Headpiece",
    legs=gear.herculean_wsd_legs,
    feet=gear.herculean_wsd_feet
  })
  sets.precast.WS['Dimidiation'].Tank = set_combine(sets.precast.WS.Tank,{})

  sets.precast.WS['Ground Strike'] = set_combine(sets.precast.WS,{})
  sets.precast.WS['Ground Strike'].Acc = set_combine(sets.precast.WS.Acc,{})
  sets.precast.WS['Ground Strike'].Tank = set_combine(sets.precast.WS.Tank,{})


	--------------------------------------
	-- Midcast sets
	--------------------------------------

  sets.midcast.FastRecast = {
    ammo="Staunch tathlum +1",
    head="Rune. Bandeau +3",
    body={ name="Herculean Vest", augments={'VIT+13','Attack+22','"Treasure Hunter"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    hands="Futhark mitons +3",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Cryptic earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  }

	sets.midcast.FastRecast.DT = {
    ammo="Staunch Tathlum +1",
    head="Rune. bandeau +3",
    body="Nyame mail",
		hands="Nyame gauntlets",
    legs="Rune. Trousers +3",
    feet="Carmine Greaves +1",
    neck="Futhark torque +1",
    ear1="Cryptic earring",
    ear2="Odnowa earring +1",
		ring1="Moonlight ring",
    ring2="Gelatinous ring +1",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  }

	sets.midcast.FastRecast.SIRD = {}

  sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast,{
    head="Erilaz Galea +1",
    hands="Regal gauntlets",
    legs="Futhark Trousers +3",
    feet="Carmine greaves +1",
    neck="Incanter's Torque",
    ear1="Andoaa Earring",
    ear2="Odnowa earring +1",
    back="Merciful cape",
    waist="Olympus sash",
  })
 
 sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'],{
    main="Deacon Sword",
    head="Fu. Bandeau +3",
    body="Taeon tabard",
    hands="Taeon gloves",
    legs="Taeon tights",
    feet="Taeon boots",
    neck="Incanter's torque",
    back="Merciful cape",
    waist="Olympus sash",
  })
	
  sets.midcast['Regen'] = set_combine(sets.midcast['Enhancing Magic'],{
    head="Rune. Bandeau +3",
    hands="Regal Gauntlets",
    legs="Futhark Trousers +3",
  })
	
	sets.midcast['Refresh'] = set_combine(sets.midcast['Enhancing Magic'],{head="Erilaz Galea +1"}) 
    
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {ear2="Earthcry Earring",waist="Siegel Sash"})
	
	sets.midcast.Flash = set_combine(sets.Enmity, {
    ammo="Staunch tathlum +1",
    head="Rune. Bandeau +3",
    body="Emet harness +1",
    hands="Futhark mitons +1",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Cryptic earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  })
	
	sets.midcast.Flash.DT = set_combine(sets.Enmity.DT, {	
    ammo="Staunch Tathlum +1",
    head="Nyame helm",
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
	  back ={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  })
	
	sets.midcast.Foil = set_combine(sets.Enmity, {
    ammo="Staunch tathlum +1",
    head="Rune. Bandeau +3",
    body="Emet harness +1",
    hands="Futhark mitons +1",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Cryptic earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  })
	
	sets.midcast.Foil.DT = set_combine(sets.Enmity.DT, {
    ammo="Staunch Tathlum +1",
    head="Nyame helm",
    body="Nyame mail",
    hands="Futhark mitons +1",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
	  back ={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  })
    
	sets.midcast.Stun = set_combine(sets.Enmity, {})
	
	sets.midcast.Stun.DT = set_combine(sets.Enmity.DT, {})
	
	sets.midcast.Jettatura = set_combine(sets.Enmity, {
    ammo="Staunch tathlum +1",
    head="Rune. Bandeau +3",
    body="Emet harness +1",
    hands="Futhark mitons +1",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Cryptic earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  })
	
	sets.midcast.Jettatura.DT = set_combine(sets.Enmity.DT, {
    ammo="Staunch Tathlum +1",
    head="Nyame helm",
    body="Nyame mail",
    hands="Nyame gauntlets",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
	  back ={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  })
	
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	
	sets.midcast['Blue Magic'].DT = set_combine(sets.Enmity.SIRDT, {
    ammo="Staunch Tathlum +1",
    head="Nyame helm",
    body="Nyame mail",
    hands="Futhark mitons +1",
    legs="Eri. leg guards +1",
    feet="Erilaz greaves +1",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2="Odnowa earring +1",
    ring1="Begrudging ring",
    ring2="Gelatinous ring +1",
	  back ={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  })
	
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})

  sets.midcast.Cure = {
    ammo="Staunch Tathlum +1",
    body="Runeist's coat +3",
    legs="Carmine Cuisses +1",
    feet="Skaoi Boots",
    neck="Phalaina locket",
    ear1="Mendi. Earring",
    ring1="Lebeche Ring",
    back="Solemnity cape",
    waist="Luminary Sash",
  }
		
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {
    ammo="Staunch Tathlum +1",
    legs="Carmine Cuisses +1",
    feet="Skaoi Boots",
    neck="Phalaina locket",
    ear1="Mendi. Earring",
    ring1="Lebeche ring",
    back="Solemnity cape",
    waist="Luminary Sash",
  })
		
	sets.Self_Healing = {ring1="Kunaji Ring",waist="Gishdubar Sash"}
	
	sets.Cure_Received = {ring1="Kunaji Ring",waist="Gishdubar Sash"}
	
	sets.Self_Refresh = {waist="Gishdubar Sash"}
	
	sets.Phalanx_Received = {
    main="Deacon Sword",
    head="Fu. bandeau +3",
    body="Taeon tabard",
    hands="Taeon gloves",
    legs="Taeon tights",
    feet="Taeon boots",
    neck="Incanter's torque",
    back="merciful cape",
    waist="olympus sash",
  }

  sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.resting = {}

  sets.idle = {
    ammo="Homiliary",
    head="turms cap +1",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
    ring1="Moonlight ring",
    ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  }
			
	sets.idle.Tank = {
    ammo="Staunch Tathlum +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
    ring1="Moonlight ring",
    ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  }

	sets.idle.Weak = {
    ammo="Staunch Tathlum +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
    ring1="Shadow Ring",
    ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  }

	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.DayIdle = {}
	sets.NightIdle = {}

  -- Extra defense sets.  Apply these on top of melee or defense sets.
  sets.Knockback = {}
  sets.MP = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.None = {main="Deacon sword"} 
	sets.weapons.Lionheart = {main="Lionheart",sub="Utu Grip"}
	sets.weapons.Aettir = {main="Aettir",sub="Utu Grip",}
	sets.weapons.DualWeapons = {}
	
	-- Defense Sets
	
	sets.defense.PDT = {
    ammo="Staunch Tathlum +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Futhark torque +1",
    ear1="Ethereal Earring",
    ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
    ring1="Moonlight ring",
    ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}},
    waist="Flume Belt +1",
  }

	sets.defense.MDT = {
    ammo="Staunch Tathlum +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Warder's Charm +1",
    ear1="Etiolation Earring",
    ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
    ring1="Shadow Ring",
    ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back="Reiki Cloak",
    waist="Carrier's Sash",
  }

	sets.defense.MEVA = {
    ammo="Staunch Tathlum +1",
    head="Nyame Helm",
    body="Nyame Mail",
    hands="Nyame Gauntlets",
    legs="Nyame Flanchard",
    feet="Nyame Sollerets",
    neck="Warder's Charm +1",
    ear1="Etiolation Earring",
    ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
    ring1="Shadow Ring",
    ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back="Reiki Cloak",
    waist="Carrier's Sash",
  }

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Brutal Earring"}
	sets.AccMaxTP = {ear1="Telos Earring"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

  sets.engaged = {
    ammo="Yamarang",       
    head="Turms cap +1",
    body="Ayanmo corazza +2",
    hands="Adhemar wristbands +1",
    legs="Meg. Chausses +2",
    feet="Carmine greaves +1",
    neck="Lissome necklace",
    ear1="Cessance earring",
    ear2="Sherida earring",
    ring1="Epona's ring",
	  ring2="Niqmaddu ring",
    back="Evasionist's cape",
    waist="Ioskeha belt +1",
  }

	sets.engaged.Acc = {
    ammo="Yamarang",
    head="Adhemar bonnet +1",
    body="Ayanmo Corazza +2",
    hands="Adhemar Wrist. +1",
    legs="Meg. Chausses +2",
    feet="Ayanmo gambieras +2",
    neck="Lissome necklace",
    ear1="Telos earring",
    ear2="Sherida Earring",
    ring1="Niqmaddu ring",
    ring2="Gelatinous ring +1",
    back="Evasionist's cape",
    waist="Ioskeha belt +1",
  }

  sets.engaged.Tank = {
    ammo="Staunch Tathlum +1", --3/3
    head="Turms cap +1", --0
    body="Nyame mail", --9/9
    hands="Nyame gauntlets", --7/7
    legs="Rune. Trousers +3", --5/0
    feet="Erilaz Greaves +1", --5/0
    neck="Futhark torque +1", --6/6
    ear1="Ethereal Earring",
    ear2="Odnowa earring +1", --3/5
    ring1="Chirich ring +1",
    ring2="Gelatinous ring +1", --7/-1
    back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Evasion+10','Enmity+10','Phys. dmg. taken-10%',}}, --10/0
    waist="Flume Belt +1", --4/0
  }--59 PDT/29 MDT


	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.buff.Battuta = {hands="Turms Mittens +1"}
	sets.buff.Embolden = {back="Evasionist's Cape"}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'SCH' then
		set_macro_page(5, 19)
	elseif player.sub_job == 'BLU' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'WAR' then
		set_macro_page(1, 3)
	elseif player.sub_job == 'SAM' then
		set_macro_page(8, 19)
	elseif player.sub_job == 'DRK' then
		set_macro_page(9, 19)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 3)
	else
		set_macro_page(5, 19)
	end
end

--Job Specific Trust Overwrite
function check_trust()
	if not moving then
		if state.AutoTrustMode.value and not data.areas.cities:contains(world.area) and (buffactive['Elvorseal'] or buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[980] < spell_latency and not have_trust("Yoran-Oran") then
					windower.send_command('input /ma "Yoran-Oran (UC)" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[952] < spell_latency and not have_trust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[979] < spell_latency and not have_trust("Selh'teus") then
					windower.send_command('input /ma "Selh\'teus" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[967] < spell_latency and not have_trust("Qultada") then
					windower.send_command('input /ma "Qultada" <me>')
					tickdelay = os.clock() + 3
					return true
				elseif spell_recasts[914] < spell_latency and not have_trust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = os.clock() + 3
					return true
				else
					return false
				end
			end
		end
	end
	return false
end

function user_job_lockstyle()
	if state.Weapons.value == 'Aettir' then
		windower.chat.input('/lockstyleset 034')
	else
		windower.chat.input('/lockstyleset 033')
	end
end