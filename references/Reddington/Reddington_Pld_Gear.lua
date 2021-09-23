function user_job_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal','Acc')
    state.HybridMode:options('Tank','DDTank','BreathTank','Dawn','NoShellTank','Normal')
    state.WeaponskillMode:options('Match','Normal', 'Acc')
    state.CastingMode:options('Normal','SIRD')
	state.Passive:options('None','AbsorbMP')
    state.PhysicalDefenseMode:options('PDT','PDT_HP','Tank')
    state.MagicalDefenseMode:options('BDT','MDT_HP','AegisMDT','AegisNoShellMDT','OchainMDT','OchainNoShellMDT','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA','MEVA_HP','Death','Charm')
	state.IdleMode:options('Normal','Tank','KiteTank','PDT','MDT','Refresh','Reraise')
	state.Weapons:options('None','Aegis','Ochain','SequenceBlurred')
	
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode','None','MP','Twilight'}
	
	gear.fastcast_jse_back = {name="Rudianos's Mantle",augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}
	gear.enmity_jse_back = {name="Rudianos's Mantle",augments={'HP+60','Eva.+20 /Mag. Eva.+20','HP+20','Enmity+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind ^pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind @f10 gs c toggle TankAutoDefense')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {ammo="Staunch Tathlum +1",
    head= {name="Loess Barbuta +1", augments={'Path: A',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Cryptic Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+10 /Mag. Eva.+10','Enmity+10','Damage taken-5%',}},
}
		
    sets.Enmity.SIRD = {  ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonbeam Necklace",
    waist="Rumination Sash",
    left_ear="Knightly Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
    sets.Enmity.DT = {ammo="Staunch Tathlum +1",
    head= {name="Loess Barbuta +1", augments={'Path: A',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Thureous Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+10 /Mag. Eva.+10','Enmity+10','Damage taken-5%',}},
}
		
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +3"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {body="Cab. Surcoat +1"}) --head="Rev. Coronet +1",
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		head="Sulevia's Mask +2",neck="Phalaina Locket",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Rev. Surcoat +3",hands="Cab. Gauntlets +1",ring1="Stikini Ring +1",ring2="Rufescent Ring",
		back=gear.enmity_jse_back,waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +2"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +2"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Carmine Mask",
		body="Rev. Surcoat +3",ring1="Asklepian Ring",ring2="Valseur's Ring",
		waist="Chaac Belt",legs="Sulev. Cuisses +2"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Aurgelmir Orb +1",
        head="Founder's Corona",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Tartarus Platemail",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Aurgelmir Orb +1",
        head="Founder's Corona",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC =  { 
	ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, priority=1,
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, priority=1,
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, priority=1,
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, priority=1,
    neck="Moonlight Necklace",
    waist="Rumination Sash",
    left_ear="Knightly Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}}, priority=1,
    left_ring="Defending Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}}, priority=1,
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
    sets.precast.FC.DT = {
	ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace",
    waist="Rumination Sash",
    left_ear="Knightly Earring",
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
    left_ring="Moonbeam Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Staunch Tathlum +1",
    head= {name="Loess Barbuta +1", augments={'Path: A',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},
    waist="Creed Baudrier",
    left_ear="Cryptic Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Moonlight Ring",
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+10 /Mag. Eva.+10','Enmity+10','Damage taken-5%',}},
}
		
    sets.precast.WS.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Tuisto Earring",
        body="Rev. Surcoat +3",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Moonlight Ring",
        back="Moonlight Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

    sets.precast.WS.Acc = {ammo="Hasty Pinion +1",
        head="Ynglinga Sallet",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body=gear.valorous_wsd_body,hands="Sulev. Gauntlets +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Sulev. Leggings +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Mache Earring +1",ear2="Moonshade Earring"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Mache Earring +1",ear2="Telos Earring"})
	
	sets.precast.WS['Flat Blade'] = {ammo="Aurgelmir Orb +1",
        head="Founder's Corona",neck="Voltsurge Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Leyline Gloves",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}

	sets.precast.WS['Flat Blade'].Acc = {ammo="Aurgelmir Orb +1",
        head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}

    sets.precast.WS['Sanguine Blade']={
        head={ name="Nyame Helm", augments={'Path: B',}},
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
        body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		ring1="Metamor. Ring +1",
		ring2="Archon Ring",
        back="Toro Cape",
		waist="Fotia Belt",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		}

	sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Atonement'] = {ammo="Paeapua",
		head="Loess Barbuta +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body=gear.valorous_wsd_body,hands=gear.odyssean_wsd_hands,ring1="Defending Ring",ring2="Moonlight Ring",
		back=gear.enmity_jse_back,waist="Fotia Belt",legs="Flamma Dirs +2",feet="Eschite Greaves"}

    sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Acc = sets.precast.WS['Atonement']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
	sets.midcast.FastRecast.DT = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
    sets.midcast.Cure.SIRD = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
    sets.midcast.Cure.DT = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
    sets.midcast.Reprisal = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}

	sets.Self_Healing = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
	sets.Self_Healing.SIRD = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
	sets.Self_Healing.DT = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}
		
    sets.midcast['Enhancing Magic'].SIRD = {
    main="Sakpata's Sword",
    sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs={ name="Founder's Hose", augments={'MND+5','Mag. Acc.+5','Attack+7','Breath dmg. taken -2%',}},
    feet={ name="Odyssean Greaves", augments={'Pet: "Mag.Atk.Bns."+23','Pet: Attack+19 Pet: Rng.Atk.+19','"Refresh"+1',}},
    neck="Moonlight Necklace", priority=1,
    waist="Rumination Sash",
    back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down-10%',}},
}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
	
	sets.midcast.Phalanx = {
    main="Sakpata's Sword",
	sub="Priwen",
    ammo="Staunch Tathlum +1",
    head={ name="Yorium Barbuta", augments={'Phalanx +3',}},
    body={ name="Yorium Cuirass", augments={'Phalanx +3',}},
    hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    legs="Sakpata's Cuisses",
    feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    neck="Moonlight Necklace",
    waist="Flume Belt",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Defending Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Weard Mantle", augments={'VIT+1','DEX+1','Phalanx +4',}},
}
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})	

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {}

    -- Idle sets
    sets.idle = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Creed Baudrier", 
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
    sets.idle.PDT = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
    sets.idle.MDT = {
    main="Sakpata's Sword",
	sub="Aegis",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.idle.Refresh = {}

	sets.idle.Tank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.idle.KiteTank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Carmine Cuisses +1",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
    sets.idle.Reraise = {sub="Ochain",ammo="Staunch Tathlum +1",
		head="Twilight Helm",ear1="Etiolation Earring",ear2="Thureous Earring",
		body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}
		
    sets.idle.Weak = {main="Mafic Cudgel",sub="Ochain",ammo="Staunch Tathlum +1",
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
		body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}
		
	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {}
	sets.passive.AbsorbMP = {
	"Flume Belt"
	}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Aegis = {main="Sakpata's Sword",sub="Aegis"}
	sets.weapons.SequenceBlurred = {}
	sets.weapons.Ochain = {main="Sakpata's Sword",sub="Ochain"}
	sets.weapons.DualWeapons = {}
    
    sets.defense.PDT = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
    sets.defense.PDT_HP = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
    sets.defense.MDT_HP = {
    main="Sakpata's Sword",
	sub="Aegis",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

    sets.defense.MEVA_HP = {
    main="Sakpata's Sword",
	sub="Aegis",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
    sets.defense.PDT_Reraise = {ammo="Staunch Tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
        body="Twilight Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Moonlight Cape",waist="Flume Belt",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}
		
    sets.defense.MDT_Reraise = {main="Mafic Cudgel",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonlight Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs=gear.odyssean_fc_legs,feet="Cab. Leggings +1"}

	sets.defense.BDT = {main="Mafic Cudgel",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Asklepian Belt",legs="Sulev. Cuisses +2",feet="Amm Greaves"}
		
	sets.defense.Tank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.defense.MEVA = {
    main="Sakpata's Sword",
	sub="Aegis",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.defense.Death = {ammo="Staunch Tathlum +1",
        head="Founder's Corona",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Warden's Ring",ring2="Shadow Ring",
        back=gear.fastcast_jse_back,waist="Asklepian Belt",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}
		
	sets.defense.Charm = {ammo="Staunch Tathlum +1",
        head="Founder's Corona",neck="Unmoving Collar +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
        back="Solemnity Cape",waist="Asklepian Belt",legs="Souv. Diechlings +1",feet="Odyssean Greaves"}
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		}
		
    sets.defense.OchainNoShellMDT = {sub="Ochain",ammo="Staunch Tathlum +1",
		}
		
    sets.defense.AegisMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		}
		
    sets.defense.AegisNoShellMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		}		

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

    sets.engaged.Acc = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}

    sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

	sets.engaged.Tank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.engaged.Dawn = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.engaged.BreathTank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.engaged.DDTank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.engaged.Acc.DDTank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
	sets.engaged.NoShellTank = {
    main="Sakpata's Sword",
	sub="Ochain",
    ammo="Staunch Tathlum +1",
    head="Sakpata's Helm",
    body="Sakpata's Plate",
    hands="Sakpata's Gauntlets",
    legs="Sakpata's Cuisses",
    feet="Sakpata's Leggings",
    neck={ name="Unmoving Collar +1", augments={'Path: A',}},  priority=1,
    waist="Gishdubar Sash",
    left_ear="Tuisto Earring",  priority=1,
    right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},  priority=1,
    left_ring="Moonbeam Ring",  priority=1,
    right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},  priority=1,
    back={ name="Rudianos's Mantle", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(6, 2)
    elseif player.sub_job == 'RUN' then
        set_macro_page(6, 2)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 2)
    elseif player.sub_job == 'BLU' then
        set_macro_page(6, 2)
    elseif player.sub_job == 'DNC' then
        set_macro_page(6, 2)
    else
        set_macro_page(6, 2) --War/Etc
    end
end