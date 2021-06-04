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
	state.Weapons:options('None','DeaconAegis','SequenceAegis','SequenceBlurred')

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

    sets.Enmity = {main="Excalibur",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Unmoving Collar +1",ear1="Friomisi Earring",ear2="Hermetic Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Apeile Ring +1",ring2="Apeile Ring",
        back=gear.enmity_jse_back,waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Eschite Greaves"}

    sets.Enmity.SIRD = {main="Excalibur",ammo="Staunch Tathlum +1",
		head="Souveran Schaller +1",neck="Loricate Torque +1",ear1="Friomisi Earring",ear2="Hermetic Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back=gear.enmity_jse_back,waist="Rumination Sash",legs="Founder's Hose",feet="Carmine greaves +1"}

    sets.Enmity.DT = {main="Excalibur",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +3"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
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
		head="Sulevia's Mask +2",neck="Phalaina Locket",ear1="Mendi. Earring",ear2="Loquac. Earring",
		body="Souv. Cuirass +1",hands="Cab. Gauntlets +1",ring1="Stikini Ring +1",ring2="Rajas Ring",
		back=gear.enmity_jse_back,waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1"})
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})

	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +1"})
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Carmine Mask +1",
		body="Souv. Cuirass +1",ring1="Asklepian Ring",ring2="Valseur's Ring",
		waist="Chaac Belt",legs="Sulev. Cuisses +2"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {ammo="Staunch Tathlum +1",
        head="Souv Schaller +1",neck="Combatant's Torque",ear1="Mache Earring +1",ear2="Telos Earring",
        body="Souv. Cuirass +1",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}

	sets.precast.JA['Violent Flourish'] = {ammo="Staunch Tathlum +1",
        head="Souv Schaller +1",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}

	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells

    sets.precast.FC = {main="Malignance Sword",ammo="Impatiens",
		head="Carmine Mask +1",neck="Orunmila's Torque",ear1="Etiolation earring",ear2="Loquac. Earring",
		body="Souv. Cuirass +1",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		ring1="Lebeche Ring",ring2="Kishar Ring",
		back=gear.fastcast_jse_back,waist="Flume Belt +1",legs=gear.odyssean_fc_legs,feet="Carmine greaves +1"}

    sets.precast.FC.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",ear1="Mendi. Earring",ear2="Loquac. Earring",body="Jumalik Mail"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
		head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Cessance Earring",
		ear2={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		body="Souv. Cuirass +1",hands="Odyssean gauntlets",ring1="Begrudging ring",ring2="Rajas Ring",
		back="Tantalic cape",waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"}

    sets.precast.WS.DT = {ammo="Ginsen",
        head="Souv. Schaller +1",neck="Fotia Gorget",ear1="Odnowa Earring +1",
        ear2={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

    sets.precast.WS.Acc = {ammo="Ginsen",
        head="Ynglinga Sallet",neck="Fotia Gorget",
        ear1={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		ear2="Telos Earring",
        body=Souv. Cuirass +1,hands="Sulev. Gauntlets +2",ring1="Begrudging ring",ring2="Rajas ring",
        back="Tantalic Cape",waist="Kentarch belt +1",legs="Carmine Cuisses +1",feet="Sulev. Leggings +2"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
  sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",
    ear1="Brutal Earring",
	  ear2="Moonshade Earring",
  })
  sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {
    neck="Fotia Gorget",
    ear1="Mache Earring +1",
	  ear2="Moonshade Earring",
  })

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",
	  ear1="Ishvara Earring",
	  ear2="Moonshade Earring",
  })
  sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {
    neck="Fotia Gorget",
    ear1="Mache Earring +1",
    ear2="Moonshade Earring",
  })

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",
    ear1="Ishvara Earring",
    ear2="Moonshade Earring",
  })
  sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {
    ear1="Mache Earring +1",
    ear2="Telos Earring",
  })

	sets.precast.WS['Flat Blade'] = {ammo="Staunch Tathlum +1",
        head="Souv Schaller +1",neck="Orunmila's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Leyline Gloves",ring1="Defending Ring",ring2="Stikini Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}

	sets.precast.WS['Flat Blade'].Acc = {ammo="Staunch Tathlum +1",
        head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Flamma Korazin +2",hands="Flam. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Ground. Mantle +1",waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"}

    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Jumalik Mail",hands="Founder's Gauntlets",ring1="Metamor. Ring +1",ring2="Archon Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Flamma Dirs +2",feet="Founder's Greaves"}

	sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Atonement'] = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body=Souv. Cuirass +1,hands=gear.odyssean_wsd_hands,ring1="Defending Ring",ring2="Defending ring",
		back=gear.enmity_jse_back,waist="Fotia Belt",legs="Flamma Dirs +2",feet="Eschite Greaves"}

    sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Acc = sets.precast.WS['Atonement']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast /
	--------------------------------------

    sets.midcast.FastRecast = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Orunmila's Torque",ear1="Etiolation earring",ear2="Loquac. Earring",
        body="Souv. Cuirass +1",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		ring1="Defending Ring",ring2="Kishar Ring",
        waist="Flume belt +1",legs="Carmine cuisses +1",feet="Carmine greaves +1"}

	sets.midcast.FastRecast.DT = {ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",/
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Carmine cuisses +1",feet="Souveran Schuhs +1"}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
	sets.midcast.Flash.SIRD = set_combine(sets.Enmity.SIRD, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast.Stun.SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.Enmity.SIRD, {})
	sets.midcast.Cocoon = set_combine(sets.Enmity.SIRD, {})

    sets.midcast.Cure = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Phalaina locket",ear1="Mendi. Earring",ear2="Loquac. Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back="Solemnity Cape",waist="Flume belt +1",legs="Carmine Cuisses +1",feet="Carmine greaves +1"}

    sets.midcast.Cure.SIRD = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souveran Schaller +1",neck="Loricate Torque +1",ear1="Mendi. Earring",ear2="Loquac. Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back="Solemnity Cape",waist="Flume belt +1",legs="Founder's Hose",feet="Carmine greaves +1"}

    sets.midcast.Cure.DT = {sub="Aegis",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

    sets.midcast.Reprisal = {ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Unmoving Collar +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}

	sets.Self_Healing = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Phalaina locket",ear1="Mendi. Earring",ear2="Loquac. Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
		back="Moonlight Cape",waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.Self_Healing.SIRD = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Mendi. Earring",ear2="Loquac. Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Founder's Hose",feet="Carmine greaves +1"}

	sets.Self_Healing.DT = {sub="Aegis",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.Cure_Received = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {ammo="Staunch Tathlum +1",
		head="Carmine Mask +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Mimir Earring",
		body="Shab. Cuirass +1",hands="Leyline Gloves",waist="Siegel sash",ring1="Defending Ring",ring2="Kishar Ring",
		back="Merciful Cape",waist="Olympus Sash",legs="Carmine Cuisses +1",feet="Carmine greaves +1"}

    sets.midcast['Enhancing Magic'].SIRD = {main="Colada",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Etiolation Earring",
		body="Shab. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back="Merciful Cape",waist="Siegel sash",legs="Rev. Leggings +3",feet="Carmine greaves +1"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {main="Deacon Sword",hands="Souv. Handsch. +1",back="Weard Mantle",feet="Souveran Schuhs +1"})
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast['Enhancing Magic'].SIRD, {main="Deacon Sword",hands="Souv. Handsch. +1",back="Weard Mantle",feet="Souveran Schuhs +1"})
	sets.midcast.Phalanx.DT = set_combine(sets.midcast.Phalanx.SIRD, {})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {
	main="Excalibur",
    sub="Aegis",
    ammo="Homiliary",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape",
}

    -- Idle sets
    sets.idle = {
	main="Excalibur",
    sub="Aegis",
    ammo="Homiliary",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape",
	}

    sets.idle.PDT = {
	main="Excalibur",
    sub="Staunch tathlum +1",
    ammo="Homiliary",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Souv. Diechlings +1", augments={'----------------',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape",
	}

    sets.idle.MDT = {
	main="Excalibur",
    sub="Aegis",
    ammo="Staunch tathlum +1",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Souv. Diechlings +1", augments={'----------------',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Odnowa Earring +1",
    right_ear="Ethereal Earring",
    left_ring="Purity Ring",
    right_ring="Shadow Ring",
    back="Moonlight cape",
	}

	sets.idle.Refresh = {
	main="Excalibur",
    sub="Aegis",
    ammo="Homiliary",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Souv. Diechlings +1", augments={'----------------',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape"
	}

	sets.idle.Tank = {
	main="Excalibur",
    sub="Aegis",
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Souv. Diechlings +1", augments={'----------------',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape"
	}

	sets.idle.KiteTank = {
	main="Excalibur",
    sub="Aegis",
    ammo="Staunch tathlum +1",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Souv. Diechlings +1", augments={'----------------',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape"
	legs="Carmine Cuisses +1",
	}

    sets.idle.Reraise = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Cessance earring",
		body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}

    sets.idle.Weak = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Cessance earring",
		body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}

	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {}
	sets.latent_regen = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------

    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Knockback = {}
    sets.MP = {}
	sets.passive.AbsorbMP = {}
    sets.MP_Knockback = {}
    sets.Twilight = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

	-- Weapons sets
	sets.weapons.DeaconAegis = {main="Excalibur",sub="Aegis"}
	sets.weapons.SequenceBlurred = {main="Sequence",sub="Blurred Shield"}
	sets.weapons.SequenceAegis = {main="Sequence",sub="Aegis"}
	sets.weapons.DualWeapons = {main="Sequence",sub="Demersal Degen +1"}

    sets.defense.PDT = {	main="Excalibur",
    sub="Aegis",
    ammo="Homiliary",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Souv. Diechlings +1", augments={'----------------',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape",
	}

    sets.defense.PDT_HP = {}

    sets.defense.MDT_HP = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}

    sets.defense.MEVA_HP = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
        body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Gelatinous Ring +1",ring2="Defending ring",
        back="Moonlight Cape",waist="Flume belt +1",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}

    sets.defense.PDT_Reraise = {ammo="Staunch Tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Cessance earring",
        body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Arke Cosc. +1",feet="Souveran Schuhs +1"}

    sets.defense.MDT_Reraise = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Etiolation Earring",
        body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Defending ring",
		back="Engulfer Cape +1",waist="Flume Belt +1",legs=gear.odyssean_fc_legs,feet="Cab. Leggings +1"}

	sets.defense.BDT = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Souv. Cuirass +1",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Asklepian Belt",legs="Sulev. Cuisses +2",feet="Amm Greaves"}

	sets.defense.Tank = {
	main="Excalibur",
    sub="Aegis",
    ammo="Staunch Tathlum +1",
    head={ name="Souv. Schaller +1", augments={'----------------',}},
    body={ name="Souv. Cuirass +1", augments={'----------------',}},
    hands={ name="Souv. Handsch. +1", augments={'----------------',}},
    legs={ name="Souv. Diechlings +1", augments={'----------------',}},
    feet={ name="Souveran Schuhs +1", augments={'----------------',}},
    neck="Agitator's Collar",
    waist="Flume belt +1",
    left_ear="Genmei Earring",
    right_ear="Ethereal Earring",
    left_ring="Gelatinous Ring +1",
    right_ring="Defending Ring",
    back="Moonlight cape",}

	sets.defense.MEVA = {sub="Aegis",ammo="Staunch Tathlum +1",
        head="Souv Schaller +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Etiolation Earring",
		body="Souv. Cuirass +1",hands="Leyline Gloves",ring1="Shadow ring",ring2="Purity Ring",
        back=gear.fastcast_jse_back,waist="Asklepian Belt",legs=gear.odyssean_fc_legs,feet="Hippo. Socks +1"}

	sets.defense.Death = {ring2="Shadow Ring",
    }

	sets.defense.Charm = {}

		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv Schaller +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight cape",waist="Flume belt +1",legs="Souv. Diechlings +1",feet="Souveran Schubs +1"}

    sets.defense.OchainNoShellMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv Schaller +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight cape",waist="Flax Sash",legs="Sulev. Cuisses +2",feet="Souveran Schubs +1"}

    sets.defense.AegisMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv Schaller +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Souv. Cuirass +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight cape",waist="Asklepian Belt",legs=gear.odyssean_fc_legs,feet="Souveran Schubs +1"}

    sets.defense.AegisNoShellMDT = {sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv Schaller +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight cape",waist="Asklepian Belt",legs="Sulev. Cuisses +2",feet="Souveran Schubs +1"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Agitator's collar",ear1="Cessance Earring",ear2="Brutal Earring",
		body=Souv. Cuirass +1,hands="Sulev. Gauntlets +2",ring1="Flamma Ring",ring2="Petrov Ring",
		back="Bleating Mantle",waist="Kentarch belt +1gg,legs="Sulev. Cuisses +2",feet="Flam. Gambieras +2"}

    sets.engaged.Acc = {}

    sets.engaged.DW = {}

    sets.engaged.DW.Acc = {}

	sets.engaged.Tank = {main="Excalibur",sub="Aegis",ammo="Staunch Tathlum +1",
		head="Souv. Schaller +1",neck="Loricate Torque +1",ear1="Genmei earring",ear2="Cessance earring",
		body="Souv. Cuirass +1",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Gelatinous ring +1",
		back="Moonlight Cape",waist="Flume Belt +1",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.engaged.Dawn = {}

	sets.engaged.BreathTank = {}

	sets.engaged.DDTank = {}

	sets.engaged.Acc.DDTank = {}

	sets.engaged.NoShellTank = {}

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
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
    end
end