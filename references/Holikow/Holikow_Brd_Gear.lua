function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','TH')
    state.CastingMode:options('Normal','ENM')
	state.HybridMode:options('Normal','TH')
    state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Aeneas','DualWeapons','DualNaegling','DualTauret','DualNukeWeapons')

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
	send_command('bind ^f1 input //gs c autows Savage Blade')
	send_command("bind ^f2 input //gs c autows Rudra's storm")
	send_command('bind ^f3 input //gs c autows Aeolian Edge')
	send_command('bind ^f5 gs c toggle AutoWSMode')
	
	send_command('bind ^f6 input //htmb Wyrm God phantom gem')
	send_command('bind ^f7 input //sw hp Mhaura')
	
	send_command('bind ^f8 input //gs disable main; wait 1; input //gs disable sub')
	send_command('bind @f8 input //gs enable main; wait 1; input //gs enable sub')
	
	send_command('bind ^` input /ma "Chocobo Mazurka" <me>')
	send_command('bind !` input /ma "Utsusemi: Ni" <me>;/ma "Utsusemi: Ichi" <me>')
	send_command('bind ^f10 gs c toggle CastingMode')
	send_command('bind ^f11 gs c cycle HybridMode')
	send_command('bind ` gs c toggle Kiting')
	send_command('bind ^f12 gs c useitem ring2 Warp Ring')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Blurred Knife +1"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Blurred Knife +1"}
	sets.weapons.DualTauret = {main="Tauret",sub="Blurred Knife +1"}
	sets.weapons.DualNukeWeapons = {main="Malevolence",sub="Malevolence"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
	main="Kali",sub="Genmei Shield",
	head="Bunzi's hat", body="Inyanga Jubbah +2",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +2",feet="Navon Crackows",
    neck="Voltsurge Torque",waist="Witful belt",
    left_ear="Etiolation Earring",right_ear="Loquac. Earring",
    left_ring="Kishar Ring",right_ring="Naji's Loop",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}
	
	sets.precast.FC.Utsusemi = {
	head="Bunzi's hat", body="Inyanga Jubbah +2",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +2",feet="Navon Crackows",
    neck="Voltsurge Torque",waist="Witful belt",
    left_ear="Etiolation Earring",right_ear="Loquac. Earring",
    left_ring="Kishar Ring",right_ring="Naji's Loop",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}
	
	sets.precast.FC.BardSong = 
	{main="Kali",sub="Genmei Shield",
	head="Fili Calot +1", body="Inyanga Jubbah +2",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
    legs="Aya. Cosciales +2",feet="Bihu Slippers",
    neck="Voltsurge Torque",waist="Witful belt",
    left_ear="Etiolation Earring",right_ear="Loquac. Earring",
    left_ring="Kishar Ring",right_ring="Lebeche Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})
	sets.precast.FC.Lullaby = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.Lullaby.ENM = {}
	sets.precast.FC['Horde Lullaby'] = set_combine(sets.precast.FC.BardSong,{range="Daurdabla"})
	sets.precast.FC['Horde Lullaby'].ENM = {}
	--sets.precast.FC['Horde Lullaby'].AoE = {range="Daurdabla"}
	sets.precast.FC['Horde Lullaby II'] = set_combine(sets.precast.FC.BardSong,{range="Daurdabla"})
	sets.precast.FC['Horde Lullaby II'].ENM = {}
	--sets.precast.FC['Horde Lullaby II'].AoE = {range="Daurdabla"}
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
	head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Bard's charm +1", waist="",
	ring1="Karieyh Ring +1",ring2="Ilabrat Ring",ear1="Moonshade earring",ear2="Ishvara Earring",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%',}},}	
		
	sets.precast.WS['Savage Blade'] = {
	range={ name="Linos", augments={'Attack+14','Weapon skill damage +3%','STR+8',}},
	head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Bard charm +1",waist={ name="Sailfi Belt +1", augments={'Path: A',}},
	ring1="Karieyh Ring +1",ring2="Rufescent ring",ear1="Moonshade earring",ear2="Ishvara Earring",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%',}},}	
	
	sets.precast.WS['Aeolian Edge'] = {
	--head={ name="Nyame Helm", augments={'Path: B',}},
	head={ name="Chironic Hat", augments={'"Mag.Atk.Bns."+15','Rng.Atk.+5','"Treasure Hunter"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    --hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	hands={ name="Chironic Gloves", augments={'MND+9','"Rapid Shot"+2','"Treasure Hunter"+1','Accuracy+8 Attack+8','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Sanctity necklace",waist="Chaac Belt",
	ring1="Stikini Ring +1",ring2="Stikini Ring +1",ear1="Friomisi Earring",ear2="Moonshade earring",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%',}},	}	
	
	sets.precast.WS['Mordant Rime'] = {
	head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Bard charm +1",waist="Eschan Stone",
	ring1="Stikini Ring +1",ring2="Stikini Ring +1",ear1="Regal earring",ear2="Ishvara Earring",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%',}},	}
	
	sets.precast.WS["Rudra's Storm"] = {
	head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs="Jokushu Haidate",
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Bard charm +1",waist="Grunfeld Rope", left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
    left_ring="Ilabrat Ring",right_ring="Karieyh Ring +1",
	back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+8','Weapon skill damage +10%',}},	}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	-- Midcast Sets
	sets.TreasureHunter = {    
	head={ name="Chironic Hat", augments={'"Mag.Atk.Bns."+15','Rng.Atk.+5','"Treasure Hunter"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
	hands={ name="Chironic Gloves", augments={'MND+9','"Rapid Shot"+2','"Treasure Hunter"+1','Accuracy+8 Attack+8','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
	waist="Chaac belt",}
	


	-- General set for recast times.
	sets.midcast.FastRecast = {}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Lullaby = {range="Marsyas", hands="Brioso cuffs +2"}
	
	--sets.midcast.Lullaby.Resistant = {range=""}
	
	sets.midcast.Lullaby.ENM = {main="Mafic Cudgel", sub="Genmei Shield",
    head="Halitus Helm", body="Emet Harness +1",hands="Bunzi's Gloves",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},waist="Sulla Belt",
    left_ear="Cryptic Earring",right_ear="Odnowa Earring +1",left_ring="Supershear Ring",right_ring="Pernicious Ring",
    back="Reiki Cloak",}
	
	--sets.midcast["Army's paeon"] = {range="Daurdabla"}
	--sets.midcast["Army's paeon II"] = {range="Daurdabla"}
	
	sets.midcast['Horde Lullaby'] = set_combine(sets.midcast.SongDebuff,{range="Daurdabla",head="Brioso Roundlet +3",hands="Brioso cuffs +2",body="Brioso Justau. +2",legs="Inyanga Shalwar +2"})
	--
	sets.midcast['Horde Lullaby'].Resistant = {range=""}
	
	sets.midcast['Horde Lullaby'].ENM = sets.midcast.Lullaby.ENM
	
	sets.midcast['Horde Lullaby II'] = {range="Daurdabla",head="Brioso Roundlet +3",hands="Brioso cuffs +2",body="Brioso Justau. +2",legs="Inyanga Shalwar +2"}
	--sets.midcast['Horde Lullaby II'].Resistant = {range=""}
	
	sets.midcast['Horde Lullaby II'].ENM = sets.midcast.Lullaby.ENM
	
	sets.midcast.Madrigal = {head="Fili Calot +1",ear1="Kuwunga earring",back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}
	sets.midcast.Paeon = {range="Daurdabla",head="Fili Calot +1",body="Inyanga Jubbah +2",
    hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},legs="Aya. Cosciales +2",
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +9',}}, neck="Voltsurge Torque",
    waist="Embla Sash", left_ear="Etiolation Earring",
    right_ear="Ethereal Earring", left_ring="Kishar Ring",
    right_ring="Lebeche Ring",back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +1"}
	sets.midcast.Minne = {ear1="Darkside earring",legs="Mou. Seraweels +1"}
	sets.midcast.Etude = {head="Mousai Turban +1"}
	sets.midcast.Carol = {hands="Mousai Gages +1"}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Magic Finale'] = {range="Blurred Harp +1"}
	sets.midcast.Mazurka = {range="Marsyas"}
	sets.midcast["Adventurer's Dirge"] = {}
	sets.midcast["Foe Sirvente"] = {}
	
	sets.midcast["Earth Threnody II"] = {   
	main="Carnwenhan",range="Gjallarhorn",
    sub="Ammurapi Shield",
    head="Brioso Roundlet +3",body="Mou. Manteel +1",
    hands="Inyan. Dastanas +2",legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +3",neck="Mnbw. Whistle +1",
    waist={ name="Obstin. Sash", augments={'Path: A',}},
    left_ear="Regal Earring",right_ear="Crep. Earring",
    left_ring="Stikini Ring +1",right_ring="Stikini Ring +1",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {main ="Carnwenhan", sub="Genmei Shield",range="Gjallarhorn",
		head="Fili Calot +1",neck="Mnbw. Whistle +1",ear1="Tuisto Earring",ear2="Odnowa Earring +1",
		body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Moonlight Ring",ring2="Defending Ring",
		back="Moonlight Cape",waist="Flume belt",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3"}
		
	--sets.midcast.SongEffect.DW = {main="Kali",sub="Kali" }

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {main="Carnwenhan",sub="Ammurapi Shield",range="Gjallarhorn",
		head="Brioso Roundlet +3",neck="Mnbw. Whistle +1",ear1="Regal Earring",ear2="Crep. Earring",
		body="Fili Hongreline +1",hands="Inyan. Dastanas +2",
		ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		waist="Obstinate sash",legs="Inyanga Shalwar +2",feet="Brioso Slippers +3",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}
		
	sets.midcast.SongDebuff.DW = {main="Kali",sub="Kali"}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {}

	-- Song-specific recast reduction
	sets.midcast.ENM = {main="Daybreak",
    sub="Genmei Shield",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Bunzi's Gloves",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Sulla Belt",
    left_ear="Cryptic Earring",
    right_ear="Friomisi Earring",
    left_ring="Supershear Ring",
    right_ring="Pernicious Ring",
    back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},}
		
	sets.midcast.SongDebuff.DW = {}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Daybreak",sub="Ammurapi shield",ammo="Pemphredo Tathlum",
        head="Vanya hood",neck="Nodens gorget",ear1="Calamitous Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring",ring2="Menelaus's Ring",
        back="Tempered Cape +1",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Voltsurge Torque",ear1="Andoaa Earring",ear2="Calamitous Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Intarabus's Cape",waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
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
	sets.resting = {}
	
	sets.idle = {
	
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
    hands={ name="Nyame Gauntlets", augments={'Path: B',}},
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet="Fili Cothurnes +1", neck="Loricate Torque +1", 
    left_ring="Karieyh Ring +1",right_ring="Defending Ring",
	Waist="Flume Belt",back="Moonlight Cape"}
		
	sets.idle.NoRefresh = {}

	sets.idle.DT = {}
	
	-- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.Kiting = {ear1="Tuisto Earring",ear2="Odnowa Earring +1",feet="Fili Cothurnes +1"}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {
	main="Naegling",sub="Genmei Shield",
	range={ name="Linos", augments={'Accuracy+13','"Dbl.Atk."+2','Quadruple Attack +3',}},	
	head={ name="Nyame Helm", augments={'Path: B',}},neck="Bard's charm +1",ear1="Cessance Earring",ear2="Telos Earring",
	body="Ayanmo Corazza +2",hands="Bunzi's gloves",ring1="Chirich ring +1",ring2="Chirich ring +1",
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},legs="Nyame Flanchard",feet="Nyame Sollerets",
	back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','"Dbl.Atk."+10','Damage taken-5%',}},}
		
	sets.engaged.SB = {}
	
	sets.engaged.DW = {	range={ name="Linos", augments={'Accuracy+13','"Dbl.Atk."+2','Quadruple Attack +3',}},	
	head="Bunzi's hat",neck="Bard's charm +1",ear1="Cessance Earring",ear2="Telos Earring",
	body="Ayanmo Corazza +2",hands="Bunzi's gloves",ring1="Moonlight Ring",ring2="Moonlight ring",
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},legs="Nyame Flanchard",feet="Nyame Sollerets",
	back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','"Dbl.Atk."+10','Damage taken-5%',}},}
	
	sets.engaged.TH = {
	range={ name="Linos", augments={'Accuracy+13','"Dbl.Atk."+2','Quadruple Attack +3',}},	
	head={ name="Chironic Hat", augments={'"Mag.Atk.Bns."+15','Rng.Atk.+5','"Treasure Hunter"+1','Accuracy+9 Attack+9','Mag. Acc.+4 "Mag.Atk.Bns."+4',}},
	neck="Bard's charm +1",ear1="Cessance Earring",ear2="Telos Earring",
	body="Ayanmo Corazza +2",ring1="Moonlight Ring",ring2="Moonlight ring",
	hands={ name="Chironic Gloves", augments={'MND+9','"Rapid Shot"+2','"Treasure Hunter"+1','Accuracy+8 Attack+8','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},legs="Nyame Flanchard",feet="Nyame Sollerets",
	back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','"Dbl.Atk."+10','Damage taken-5%',}},}
	
	sets.engaged.SB = {
	range={ name="Linos", augments={'Accuracy+13','"Dbl.Atk."+2','Quadruple Attack +3',}},	
	head={ name="Nyame Helm", augments={'Path: B',}},neck="Bard's charm +1",ear1="Cessance Earring",ear2="Telos Earring",
	body="Ayanmo Corazza +2",hands="Bunzi's gloves",ring1="Chirich ring +1",ring2="Chirich ring +1",
	waist={ name="Sailfi Belt +1", augments={'Path: A',}},legs="Nyame Flanchard",feet="Nyame Sollerets",
	back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+6','"Dbl.Atk."+10','Damage taken-5%',}},}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 15)
end

function select_default_macro_book()
	if player.sub_job == 'MNK' then
		set_macro_page(7, 15)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 15)
	elseif player.sub_job == 'WAR' then
		set_macro_page(2, 15)
	else
		set_macro_page(3, 15)
	end
end

function user_job_lockstyle()
	if state.Weapons.value == 'Malignance pole' then
		windower.chat.input('/lockstyleset 9')
	else
		windower.chat.input('/lockstyleset 9')
	end
end