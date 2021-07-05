function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','PDT')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','NoRefresh','DT','Refresh')
	state.Weapons:options('None','DualNaegling','Aeneas')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')

	
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Fusetto +1"}
	sets.weapons.AeneasKC = {main="Aeneas",sub="Kraken Club"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Kraken club"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Fusetto +2",}
	sets.weapons.DualNaeglingKC = {main="Naegling",sub="Kraken Club",}
	sets.weapons.Dual = {main="Aeneas",sub="Ternion Dagger +1"}
	sets.weapons.DualNukeWeapons = {main="Malevolence",sub="Malevolence"}
	sets.weapons.Mewing = {main="Sangoma",sub="Genmei Shield"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+15','Pet: Mag. Acc.+3','Pet: "Mag.Atk.Bns."+30','DMG:+8',}},
    range={ name="Linos", augments={'All Songs+2',}},
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -2%',}},
    legs="Aya. Cosciales +2",
    feet="Telchine Pigaches",
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Weather. Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	sets.precast.FC.BardSong = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+15','Pet: Mag. Acc.+3','Pet: "Mag.Atk.Bns."+30','DMG:+8',}},
    range={ name="Linos", augments={'All Songs+2',}},
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -2%',}},
    legs="Aya. Cosciales +2",
    feet="Coalrake Sabots",
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Weather. Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Terpander"})
	sets.precast.FC.Lullaby = {range="Marsyas"}
	sets.precast.FC.Lullaby.Resistant = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.precast.FC['Horde Lullaby'].AoE = {range="Terpander"}
	sets.precast.FC['Horde Lullaby II'] = {range="Marsyas"}
	sets.precast.FC['Horde Lullaby II'].Resistant = {range="Terpander"}
	sets.precast.FC['Horde Lullaby II'].AoE = {range="Terpander"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = { range={ name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','DEX+8',}},
    head="Nyame Helm",
    body="Nyame Mail",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Chirich Ring +1",
    right_ring="Epaminondas's Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}

sets.precast.WS['Savage Blade'] = { range={ name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','DEX+8',}},
    head="Nyame Helm",
    body="Nyame Mail",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}

sets.precast.WS["Rudra's Storm"] = { range={ name="Linos", augments={'Accuracy+13 Attack+13','Weapon skill damage +3%','DEX+8',}},
    head="Nyame Helm",
    body="Nyame Mail",
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Epaminondas's Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}

sets.precast.WS['Aeolian Edge'] = {ammo="Aurgelmir Orb",
    body={ name="Cohort Cloak +1", augments={'Path: A',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Sanctity Necklace",
    waist="Orpheus's Sash",
    left_ear="Friomisi Earring",
    right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
    left_ring="Stikini Ring",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
	}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring",}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back="Intarabus's Cape",waist="Witful Belt",legs="Aya. Cosciales +2",feet="Gende. Galosh. +1"}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Lullaby = {range="Blurred Harp +1"}
	sets.midcast.Lullaby.Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'] = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'] = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
	sets.midcast.Madrigal = {head="Fili Calot +1"}
	sets.midcast.Paeon = {range="Daurdabla"}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Magic Finale'] = {range="Blurred Harp +1"}
	sets.midcast.Mazurka = {range="Marsyas"}
	sets.midcast['Sage Etude'] = {head="Mousai Turban"}
	sets.midcast['Learned Etude'] = {head="Mousai Turban"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = { main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
    range={ name="Linos", augments={'All Songs+2',}},
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Brioso Cuffs +2",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Moonbow Whistle +1",
    waist="Luminary Sash",
    left_ear="Darkside Earring",
    right_ear="Bragi Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
}
		
	sets.midcast.SongEffect.DW = {main="Kali",sub="Kali"}

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = { main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
    sub="Ammurapi Shield",
    range={ name="Linos", augments={'All Songs+2',}},
    body={ name="Cohort Cloak +1", augments={'Path: A',}},
    hands="Brioso Cuffs +2",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Moonbow Whistle +1",
    waist="Luminary Sash",
    left_ear="Darkside Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
}
		
	sets.midcast.SongDebuff.DW = {main="Kali",sub="Kali"}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = { main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
    sub="Ammurapi Shield",
    range={ name="Linos", augments={'All Songs+2',}},
    body={ name="Cohort Cloak +1", augments={'Path: A',}},
    hands="Brioso Cuffs +2",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",
    neck="Moonbow Whistle +1",
    waist="Luminary Sash",
    left_ear="Darkside Earring",
    right_ear="Regal Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','CHR+10','"Fast Cast"+10',}},
}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {main={ name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: STR+15','Pet: Mag. Acc.+3','Pet: "Mag.Atk.Bns."+30','DMG:+8',}},
    range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
    head="Fili Calot +1",
    body="Inyanga Jubbah +2",
    hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -2%',}},
    legs="Aya. Cosciales +2",
    feet="Coalrake Sabots",
    neck="Voltsurge Torque",
    waist="Aoidos' Belt",
    left_ear="Loquac. Earring",
    right_ear="Etiolation Earring",
    left_ring="Defending Ring",
    right_ring="Kishar Ring",
    back={ name="Intarabus's Cape", augments={'"Fast Cast"+10',}},
}
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {
    main="Daybreak",
    sub="Genmei Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
    body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
    hands={ name="Telchine Gloves", augments={'Accuracy+19','Weapon skill damage +3%',}},
    legs={ name="Telchine Braconi", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +4',}},
    feet={ name="Telchine Pigaches", augments={'"Avatar perpetuation cost" -4','Enh. Mag. eff. dur. +9',}},
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Lempo Earring",
    right_ear="Enervating Earring",
    left_ring="Stikini Ring",
    right_ring="Weather. Ring",
    back="Merciful Cape",
}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {
    main="Daybreak",
    sub="Genmei Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
    body={ name="Telchine Chas.", augments={'Accuracy+19','"Dbl.Atk."+3','Weapon skill damage +3%',}},
    hands={ name="Telchine Gloves", augments={'Accuracy+19','Weapon skill damage +3%',}},
    legs={ name="Telchine Braconi", augments={'Pet: "Regen"+2','Enh. Mag. eff. dur. +4',}},
    feet={ name="Telchine Pigaches", augments={'"Avatar perpetuation cost" -4','Enh. Mag. eff. dur. +9',}},
    neck="Incanter's Torque",
    waist="Olympus Sash",
    left_ear="Andoaa Earring",
    right_ear="Lempo Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Merciful Cape",
}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Dosis Tathlum",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	-- Resting sets
	sets.resting = {
    range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
    head="Fili Calot +1",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Aya. Cosciales +2",
    feet="Fili Cothurnes +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Chirich Ring +1",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
}
	
	sets.idle = {range="Daurdabla",
   head="Nyame Helm",
    body="Nyame Mail",
    hands="Volte Mittens",
    legs="Volte Hose",
    feet="Fili Cothurnes +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
}
		
	sets.idle.NoRefresh = {
    range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
   head="Nyame Helm",
    body="Nyame Mail",
    hands="Volte Mittens",
    legs="Aya. Cosciales +2",
    feet="Fili Cothurnes +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Chirich Ring +1",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}

	sets.idle.DT = {
    
    range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
    head="Fili Calot +1",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Volte Hose",
    feet="Fili Cothurnes +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}

sets.idle.Refresh = {
    sub="Genmei Shield",
    range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
    head="Fili Calot +1",
    body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
    hands="Volte Mittens",
    legs="Assid. Pants +1",
    feet="Fili Cothurnes +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Etiolation Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}
	
	-- Defense sets

	sets.defense.PDT = {
   
    
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Aya. Cosciales +2",
    feet="Fili Cothurnes +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}

	sets.defense.MDT = {
   
    range={ name="Linos", augments={'All Songs+2',}},
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Volte Hose",
    feet="Fili Cothurnes +1",
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Genmei Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
}


	sets.Kiting = {feet="Fili Cothurnes +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
  ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Aya. Cosciales +2",
    feet="Volte Spats",
    neck={ name="Bard's Charm +1", augments={'Path: A',}},
    waist="Sailfi Belt +1",
    left_ear="Brutal Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}
	sets.engaged.Acc = {range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Volte Hose",
    feet="Aya. Gambieras +2",
    neck={ name="Bard's Charm +1", augments={'Path: A',}},
    waist="Olseni Belt",
   left_ear="Eabani Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}
	sets.engaged.DW = {ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Aya. Cosciales +2",
   feet="Volte Spats",
    neck={ name="Bard's Charm +1", augments={'Path: A',}},
    waist="Reiki Yotai",
    left_ear="Eabani Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.engaged.DW.Acc = {range={ name="Linos", augments={'Accuracy+14','"Store TP"+4','Quadruple Attack +3',}},
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Volte Hose",
   feet="Volte Boots",
    neck={ name="Bard's Charm +1", augments={'Path: A',}},
    waist="Olseni Belt",
    left_ear="Eabani Earring",
    right_ear="Telos Earring",
    left_ring="Chirich Ring +1",
    right_ring="Ilabrat Ring",
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
}

sets.engaged.DW.PDT = {ammo={ name="Coiste Bodhar", augments={'Path: A',}},
    head="Aya. Zucchetto +2",
    body="Ashera Harness",
    hands="Volte Mittens",
    legs="Aya. Cosciales +2",
    feet="Volte Spats",
    neck={ name="Loricate Torque +1", augments={'Path: A',}},
    waist="Reiki Yotai",
    left_ear="Eabani Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
end

